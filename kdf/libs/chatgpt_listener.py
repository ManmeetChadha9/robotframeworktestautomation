# chatgpt_listener.py

import os
from datetime import datetime
from openai import OpenAI, OpenAIError
from robot.api import logger



class ChatGPTListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        self.api_key = os.getenv("OPENAI_API_KEY")
        if not self.api_key:
            logger.info("[ChatGPTListener] ERROR: OpenAI API key not provided.")
            self.enabled = False
            return

        # Initialize OpenAI client (new SDK style)
        self.client = OpenAI(api_key=self.api_key)
        self.enabled = True
        self.test_results = []

        # Setup tag filtering logic
        chatgpt_tags_env = os.getenv("CHATGPT_TAGS")
        self.chatgpt_tags = None
        if chatgpt_tags_env:
            self.chatgpt_tags = set(tag.strip().lower() for tag in chatgpt_tags_env.split(","))
            logger.info(f"[ChatGPTListener] ChatGPT will trigger only for tests tagged with: {self.chatgpt_tags}")
        else:
            logger.info("[ChatGPTListener] CHATGPT_TAGS not set. ChatGPT will trigger for all failed tests.")

        # Setup output file
        results_dir = "results"
        os.makedirs(results_dir, exist_ok=True)
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        self.output_file = os.path.join(results_dir, f"chatgpt_summary_{timestamp}.txt")

        logger.info("[ChatGPTListener] Initialized and ready.")
        logger.info(f"[ChatGPTListener] Summary will be written to: {self.output_file}")

    def start_test(self, data, result):
        logger.info(f"[ChatGPTListener] Starting test: {data.name}")

    def end_test(self, data, result):
        if not self.enabled:
            return

        logger.info(f"[ChatGPTListener] Ending test: {data.name}")
        test_summary = f"Test: {data.name}\nStatus: {result.status}\nMessage: {result.message or 'No message'}\n"
        self.test_results.append(test_summary)

        test_tags = set(tag.lower() for tag in data.tags)
        if result.status == "FAIL" and (
                self.chatgpt_tags is None or self.chatgpt_tags.intersection(test_tags)
        ):
            prompt = f"The test case '{data.name}' failed with the following message:\n{result.message}\nGive suggestions for fixing it."
            advice = self.ask_chatgpt(prompt)
            self.test_results.append(f"ChatGPT Suggestion:\n{advice}\n")




    def close(self):
        if not self.enabled:
            return

        try:
            from robot.api import logger
            logger.info("[ChatGPTListener] Close method called.")

            # Build summary prompt for ChatGPT
            summary_prompt = (
                    "Summarize the following Robot Framework test results in a concise, clear way:\n\n"
                    + "\n".join(self.test_results)
            )

            # Get AI summary
            summary = self.ask_chatgpt(summary_prompt)

            # Combine test logs and AI-generated summary
            full_output = "\n\n".join(self.test_results) + "\n\n📋 ChatGPT Summary:\n" + summary

            # Write to output file
            with open(self.output_file, "w", encoding="utf-8") as f:
                f.write(full_output)

            logger.info(f"[ChatGPTListener] Summary written to: {self.output_file}")

        except Exception as e:
            logger.error(f"[ChatGPTListener] Error in close(): {e}")

    def ask_chatgpt(self, prompt):
        try:
            response = self.client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[{"role": "user", "content": prompt}]
            )
            return response.choices[0].message.content
        except OpenAIError as e:
            logger.info(f"[ChatGPTListener] Error contacting ChatGPT: {e}")
            return "⚠️ ChatGPT error: Could not generate response."
