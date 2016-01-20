class CreateListitems < ActiveRecord::Migration
  def change
    create_table :listitems do |t|
      t.string :ingavedatum
      t.string :einddatum
      t.string :prioriteit
      t.string :beschrijving
      t.string :status

      t.timestamps null: false
    end
  end
end
