class AddTeamToSubtask < ActiveRecord::Migration[7.0]
  def change
    add_column :subtasks ,:team ,:string
    add_column :subtasks ,:priority ,:integer
  end
end
