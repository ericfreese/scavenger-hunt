class CreateClues < ActiveRecord::Migration
  def change
    create_table :clues do |t|
      t.string :name
      t.text :description
      t.references :hunt

      t.timestamps
    end
    add_index :clues, :hunt_id
  end
end
