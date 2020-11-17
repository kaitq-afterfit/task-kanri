class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
    add_index :assignments, [:user_id, :task_id], unique: true
  end
end
