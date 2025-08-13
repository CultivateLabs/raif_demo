# frozen_string_literal: true

class Raif::Tasks::DocumentSummarization < Raif::ApplicationTask
  llm_response_format :html # :html, :text, or :json
  llm_temperature 0.8 # optional, defaults to 0.7
  llm_response_allowed_tags %w[p b i div strong] # optional, defaults to Rails::HTML5::SafeListSanitizer.allowed_tags
  llm_response_allowed_attributes %w[style] # optional, defaults to Rails::HTML5::SafeListSanitizer.allowed_attributes

  # task_run_arg defines arguments for your task
  # e.g. Raif::Tasks::DocumentSummarization.run(document: document, creator: user)
  # They can then be used by your task to build the prompt, system prompt, etc.
  task_run_arg :document

  def build_system_prompt
    sp = "You are an assistant with expertise in summarizing detailed articles into clear and concise language."
    sp += system_prompt_language_preference if requested_language_key.present?
    sp
  end

  def build_prompt
    <<~PROMPT
      Consider the following information:

      Text:
      ```
      #{document.content}
      ```

      Your task is to read the provided article and associated information, and summarize the article concisely and clearly in approximately 1 paragraph. Your summary should include all of the key points, views, and arguments of the text, and should only include facts referenced in the text directly. Do not add any inferences, speculations, or analysis of your own, and do not exaggerate or overstate facts. If you quote directly from the article, include quotation marks.

      Format your response using basic HTML tags.
    PROMPT
  end
end
