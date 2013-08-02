class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :description
      t.string :venue
      t.string :neighborhood
      t.integer :user_id

      t.timestamps
    end
  end
end
