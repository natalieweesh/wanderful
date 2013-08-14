class AddAttachmentActivityPhotoToActivities < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.attachment :activity_photo
    end
  end

  def self.down
    drop_attached_file :activities, :activity_photo
  end
end
