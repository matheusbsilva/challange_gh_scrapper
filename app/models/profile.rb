class Profile < ApplicationRecord
  validates :username, presence: true
  validates :num_followers, presence: true
  validates :num_following, presence: true
  validates :num_stars, presence: true
  validates :num_contributions_last_year, presence: true
  validates :profile_img, presence: true
  validates :profile_url, presence: true
  validates :fullname, presence: true
end
