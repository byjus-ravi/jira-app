class AddEpicIdToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories ,:epic_id ,:int
  end
end
