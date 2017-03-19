class CreateParentTask < ActiveRecord::Migration[5.0]
  def change
    create_table :parent_tasks do |t|
      t.string :name
      t.integer :total_task, default: 0
      t.integer :completed_task, default: 0
      t.time :deadline
      t.integer :check ,default: 0
      t.timestamps null: false
    end
  end
end
