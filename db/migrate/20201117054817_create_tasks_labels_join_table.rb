class CreateTasksLabelsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tasks, :labels do |t|
      t.index :task_id
      t.index :label_id
    end
  end
end
