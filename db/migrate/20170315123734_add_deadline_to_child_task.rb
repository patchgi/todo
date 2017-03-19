class AddDeadlineToChildTask < ActiveRecord::Migration[5.0]
  def change
    add_column :child_tasks, :deadline, :text
  end
end
