class CreateItinerariesJoins < ActiveRecord::Migration
  def change
    create_table :itineraries_joins do |t|
      t.integer :itinerary_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
