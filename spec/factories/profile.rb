FactoryBot.define do
  factory :profile do
    username { 'foo' }
    num_followers { 7800 }
    num_following { 0 }
    num_stars { 22 }
    num_contributions_last_year { 600 }
    profile_img { 'https://foo' }

    factory :full_profile do
      organization { 'Foo' }
      location { 'São Paulo, Brasil' }
    end

    factory :unique_profile do
      username { 'bar' }
      organization { 'Fuzzbar' }
      location { 'Distrito Federal, Brasil' }
    end
  end
end
