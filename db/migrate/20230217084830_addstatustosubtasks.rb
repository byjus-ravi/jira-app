class Addstatustosubtasks < ActiveRecord::Migration[7.0]
  def change
    add_column :subtasks, :status, :integer , default:0
  end
end
