class AddFullnameAndProfileUrlToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :fullname, :string
    add_column :profiles, :profile_url, :string
  end
end
