# frozen_string_literal: true

# This migration comes from raif (originally 20250603202013)
class AddStreamResponseToRaifModelCompletions < ActiveRecord::Migration[7.1]
  def change
    add_column :raif_model_completions, :stream_response, :boolean, default: false, null: false
  end
end
