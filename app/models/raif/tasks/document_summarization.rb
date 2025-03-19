# frozen_string_literal: true

module Raif
  module Tasks
    class DocumentSummarization < Raif::ApplicationTask
      llm_response_format :html # options are :html, :text, :json

      # Any attr_accessor you define can be included as an argument when calling `run`.
      # E.g. Raif::Tasks::DocumentSummarization.run(document: document, creator: user)
      attr_accessor :document

      def build_system_prompt
        "You are an assistant with expertise in summarizing detailed articles into clear and concise language."
      end

      def build_prompt
        <<~PROMPT
          Consider the following document:

          ```
          #{document.content}
          ```

          Your task is to read the provided article and associated information, and summarize the article concisely and clearly in approximately 1 paragraph. Your summary should include all of the key points, views, and arguments of the text, and should only include facts referenced in the text directly. Do not add any inferences, speculations, or analysis of your own, and do not exaggerate or overstate facts. If you quote directly from the article, include quotation marks. If the text does not appear to represent the title, please return the text "Unable to generate summary" and nothing else.
        PROMPT
      end
    end
  end
end
