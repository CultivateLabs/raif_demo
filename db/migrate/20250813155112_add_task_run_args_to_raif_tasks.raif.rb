# frozen_string_literal: true

# This migration comes from raif (originally 20250804013843)
class AddTaskRunArgsToRaifTasks < ActiveRecord::Migration[7.1]
  def change
    json_column_type = if connection.adapter_name.downcase.include?("postgresql")
      :jsonb
    else
      :json
    end

    add_column :raif_tasks, :task_run_args, json_column_type
  end
end
