import openai
import os
from datetime import datetime

print(">>> ChatGPTListener file loaded!")
class ChatGPTListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        self.api_key = os.getenv("OPENAI_API_KEY")
        if not self.api_key:
            print("[ChatGPTListener] ERROR: OpenAI API key not provided.")
            self.enabled = False
            return

        openai.api_key = self.api_key
        self.enabled = True
        self.test_results = []

        # Setup output file
        results_dir = "results"
        os.makedirs(results_dir, exist_ok=True)
        timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
        self.output_file = os.path.join(results_dir, f"chatgpt_summary_{timestamp}.txt")

        print("[ChatGPTListener] Initialized and ready.")
        print(f"[ChatGPTListener] Summary will be written to: {self.output_file}")

    def start_test(self, data, result):
        print(f"[ChatGPTListener] Starting test: {data.name}")

    def end_test(self, data, result):
        if not self.enabled:
            return

        test_summary = f"Test: {data.name}\nStatus: {result.status}\nMessage: {result.message or 'No message'}\n"
        self.test_results.append(test_summary)

        if result.status == "FAIL":
            prompt = f"The test case '{data.name}' failed with the following message:\n{result.message}\nGive suggestions for fixing it."
            advice = self.ask_chatgpt(prompt)
            self.test_results.append(f"ChatGPT Suggestion:\n{advice}\n")

    def close(self):
        if not self.enabled:
            return

        print("[ChatGPTListener] Close method called.")

        summary_prompt = "Summarize the following Robot Framework test results in a concise, clear way:\n\n" + "\n".join(self.test_results)
        summary = self.ask_chatgpt(summary_prompt)

        full_output = "\n\n".join(self.test_results) + "\n\n📋 ChatGPT Summary:\n" + summary

        print(f"[ChatGPTListener] Writing summary to: {self.output_file}")
        with open(self.output_file, "w") as f:
            f.write(full_output)

    def ask_chatgpt(self, prompt):
        try:
            response = openai.ChatCompletion.create(
                model="gpt-4",
                messages=[{"role": "user", "content": prompt}]
            )
            return response.choices[0].message["content"]
        except Exception as e:
            print(f"[ChatGPTListener] Error contacting ChatGPT: {e}")
            return "⚠️ ChatGPT error: Could not generate response."
