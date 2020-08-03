class ChangeUsernameToUniqueProfile < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :username, :string, unique: true
  end
end
