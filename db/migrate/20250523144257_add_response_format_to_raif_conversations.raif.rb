# frozen_string_literal: true

# This migration comes from raif (originally 20250421202149)
class AddResponseFormatToRaifConversations < ActiveRecord::Migration[8.0]
  def change
    add_column :raif_conversations, :response_format, :integer, default: 0, null: false
  end
end
