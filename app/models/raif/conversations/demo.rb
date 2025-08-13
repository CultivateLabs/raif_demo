# frozen_string_literal: true

module Raif
  module Conversations
    class Demo < Raif::ApplicationConversation
      # Set the response format for the conversation. Options are :html, :text, or :json.
      # If you set this to something other than :text, make sure to include instructions to the model in your system prompt
      llm_response_format :text

      # If you want to always include a certain set of model tools with this conversation type,
      # uncomment this callback to populate the available_model_tools attribute with your desired model tools.
      before_create -> {
        self.available_model_tools = []

        if llm.supports_provider_managed_tool?("Raif::ModelTools::ProviderManaged::WebSearch")
          available_model_tools << "Raif::ModelTools::ProviderManaged::WebSearch"
        end

        available_model_tools
      }

      # Override the methods below to customize the system prompt for this conversation type.
      def system_prompt_intro
        <<~PROMPT
          You are a helpful assistant who is discussing Raif, a Ruby on Rails engine for building AI-powered applications.

          If needed, you can view the docs at https://docs.raif.ai
        PROMPT
      end

      # def build_system_prompt
      #   <<~PROMPT
      #     #{system_prompt_intro}
      #     #{system_prompt_language_preference}
      #   PROMPT
      # end

      # Override this method to set the initial message shown to the user.
      def initial_chat_message
        "Hello, I'm a helpful assistant who is discussing Raif, a Ruby on Rails engine for building AI-powered applications."
      end

      # This method will be called when receing a model response to a Raif::ConversationEntry
      # By default, it just passes the model response message through, but you can override
      # for custom response message processing
      # def process_model_response_message(message:, entry:)
      #   message
      # end
    end
  end
end
