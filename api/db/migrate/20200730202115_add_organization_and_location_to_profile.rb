class AddOrganizationAndLocationToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :organization, :string
    add_column :profiles, :location, :string
  end
end
