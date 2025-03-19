# frozen_string_literal: true

module Raif
  module Tasks
    class GenerateDocumentSummary < Raif::ApplicationTask
      # Set the response format for the task. Options are :html, :text, or :json.
      llm_response_format :json

      # Define any attributes that are needed for the task.
      # You can then pass them when running the task and they will be available in build_prompt:
      # Raif::Tasks::GenerateDocumentSummary.run(your_attribute: "some value")
      # attr_accessor :your_attribute

      def build_prompt
        # Implement the LLM prompt for this task.
        raise NotImplementedError, "Implement #build_prompt in #{self.class}"
      end

      # Optional: Override build_system_prompt if you need custom system instructions.
      # The default implementation, which you'll get if you call super, will use Raif.config.task_system_prompt_intro
      # and append the system_prompt_language_preference if the task's requested_language_key is set.
      # def build_system_prompt
      #   super + "\nAdditional system instructions..."
      # end
    end
  end
end
