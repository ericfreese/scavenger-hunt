class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :hunt

      t.timestamps
    end
    add_index :teams, :hunt_id
  end
end
