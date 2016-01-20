class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string "ingaveDatum"
      t.string "eindDatum"
      t.integer "prioriteit"
      t.text "beschrijving"
      t.integer "todolist_id"
      t.timestamps null: false
    end
  end
end
