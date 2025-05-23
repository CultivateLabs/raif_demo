# frozen_string_literal: true

# This migration comes from raif (originally 20250424232946)
class AddCreatedAtIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :raif_model_completions, :created_at
    add_index :raif_tasks, :created_at
    add_index :raif_conversations, :created_at
    add_index :raif_conversation_entries, :created_at
    add_index :raif_agents, :created_at
  end
end
