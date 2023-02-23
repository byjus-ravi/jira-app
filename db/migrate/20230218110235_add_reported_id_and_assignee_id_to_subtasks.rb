class AddReportedIdAndAssigneeIdToSubtasks < ActiveRecord::Migration[7.0]
  def change
    add_column :subtasks ,:reporter_id , :integer
    add_column :subtasks ,:assignee_id , :integer
  end
end
