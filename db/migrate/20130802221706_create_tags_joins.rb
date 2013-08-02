class CreateTagsJoins < ActiveRecord::Migration
  def change
    create_table :tags_joins do |t|
      t.integer :tag_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
