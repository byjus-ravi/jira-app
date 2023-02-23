class AddDateToSubtask < ActiveRecord::Migration[7.0]
  def change
    add_column :subtasks ,:duedate , :date
  end
end
