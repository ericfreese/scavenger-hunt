class CreateHuntUserJoinTable < ActiveRecord::Migration
  def change
    create_table :hunts_users, :id => false do |t|
      t.integer :hunt_id
      t.integer :user_id
    end
  end
end
