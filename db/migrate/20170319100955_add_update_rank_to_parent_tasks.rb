class AddUpdateRankToParentTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :parent_tasks, :update_rank, :integer,default: 0
  end
end
