class RemoveDeadlineFromChildTask < ActiveRecord::Migration[5.0]
  def change
    remove_column :child_tasks, :deadline, :time
  end
end
