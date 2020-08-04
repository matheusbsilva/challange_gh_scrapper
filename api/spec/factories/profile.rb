FactoryBot.define do
  factory :profile do
    username { 'foo' }
    fullname { 'Foo' }
    num_followers { 7800 }
    num_following { 0 }
    num_stars { 22 }
    num_contributions_last_year { 600 }
    profile_img { 'https://github.com/avatar/foo' }
    profile_url { 'https://github.com/foo' }

    factory :full_profile do
      organization { 'Foo' }
      location { 'São Paulo, Brasil' }
    end

    factory :unique_profile do
      username { 'bar' }
      profile_url { 'https://github.com/bar' }
      fullname { 'Barfuzz' }
      organization { 'Fuzzbar' }
      location { 'Distrito Federal, Brasil' }
    end
  end
end
