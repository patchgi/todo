class AddParentNameToChildTask < ActiveRecord::Migration[5.0]
  def change
      add_column :child_tasks, :p_name, :string
  end
end
