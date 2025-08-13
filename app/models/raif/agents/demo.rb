# frozen_string_literal: true

module Raif
  module Agents
    class Demo < Raif::ApplicationAgent
      def populate_default_model_tools
        self.available_model_tools = [
          Raif::ModelTools::WikipediaSearch,
          Raif::ModelTools::FetchUrl
        ]
      end
    end
  end
end
