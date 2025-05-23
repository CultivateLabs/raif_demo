# frozen_string_literal: true

# This migration comes from raif (originally 20250502155330)
class AddStatusIndexesToRaifTasks < ActiveRecord::Migration[8.0]
  def change
    add_index :raif_tasks, :completed_at
    add_index :raif_tasks, :failed_at
    add_index :raif_tasks, :started_at

    # Index for type + status combinations which will be common in the admin interface
    add_index :raif_tasks, [:type, :completed_at]
    add_index :raif_tasks, [:type, :failed_at]
    add_index :raif_tasks, [:type, :started_at]
  end
end
