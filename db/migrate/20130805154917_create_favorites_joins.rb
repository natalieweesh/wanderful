class CreateFavoritesJoins < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :itinerary_id

      t.timestamps
    end
  end
end
