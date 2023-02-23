class CreateEpics < ActiveRecord::Migration[7.0]
  def change
    create_table :epics do |t|
      t.string :name
      t.text :summary

      t.timestamps
    end
  end
end
