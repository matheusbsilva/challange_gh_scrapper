class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :username
      t.integer :num_followers
      t.integer :num_following
      t.integer :num_stars
      t.integer :num_contributions_last_year
      t.string :profile_img

      t.timestamps
    end
  end
end
