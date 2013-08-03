class CreateItineraries < ActiveRecord::Migration
  def change
    create_table :itineraries do |t|
      t.string :description
      t.integer :time_it_takes
      t.integer :user_id
      
      t.timestamps 
    end
  end
end
