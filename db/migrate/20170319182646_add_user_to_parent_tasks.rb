class AddUserToParentTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :child_tasks, :user, :integer
  end
end
