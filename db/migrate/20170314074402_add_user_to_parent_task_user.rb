class AddUserToParentTaskUser < ActiveRecord::Migration[5.0]
  def change
     add_column :parent_tasks, :user, :string
  end
end
