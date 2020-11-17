class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :due_date
      t.string :description
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tasks, [:user_id, :status, :due_date]
  end
end
