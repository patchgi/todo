class RemoveDeadlineToParentTaskDeadline < ActiveRecord::Migration[5.0]
  def change
    remove_column :parent_tasks, :deadline, :time
  end
end
