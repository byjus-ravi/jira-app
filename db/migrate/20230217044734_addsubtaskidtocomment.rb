class Addsubtaskidtocomment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :subtask_id, :integer
  end
end
