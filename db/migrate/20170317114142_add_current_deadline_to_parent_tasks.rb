class AddCurrentDeadlineToParentTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :parent_tasks, :current_deadline, :string,default: ""
  end
end
