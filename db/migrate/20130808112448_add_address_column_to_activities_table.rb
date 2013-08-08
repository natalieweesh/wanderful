class AddAddressColumnToActivitiesTable < ActiveRecord::Migration
  def change
    add_column :activities, :address, :string
  end
end
