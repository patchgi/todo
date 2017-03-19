class CreateChildTask < ActiveRecord::Migration[5.0]
  def change
    create_table :child_tasks do |t|
      t.string :name
      t.time :deadline
      t.string :pid
      t.integer :check ,default: 0
      t.timestamps null: false
    end
  end
end
