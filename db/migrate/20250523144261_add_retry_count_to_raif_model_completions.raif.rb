# frozen_string_literal: true

# This migration comes from raif (originally 20250507155314)
class AddRetryCountToRaifModelCompletions < ActiveRecord::Migration[7.1]
  def change
    add_column :raif_model_completions, :retry_count, :integer, default: 0, null: false
  end
end
