Factory.sequence :name do |n|
  "Name_#{n}"
end

Factory.define :user do |u|
   u.name                  'test login'
   u.login                 'test_login'
   u.email                 'test@eggandjam.com'
   u.password              'test123'
   u.password_confirmation 'test123'
end

Factory.define :house do |h|
  h.user_id               {(User.find(:first) || Factory(:user)).id}
  h.address_1             "123 Fake St"
  h.address_2             "Suite 2A"
  h.country               "Australia"
  h.post_code             "2010"
  h.suburb                "Surry Hills"
  h.lat                   "1"
  h.long                  "2"
end

Factory.define :organisation do |o|
  o.name                {Factory.sequence(:name)}
  o.user_id             {(User.find(:first) || Factory(:user)).id}
end

Factory.define :bed do |b|
  b.house_id              {(House.find(:first) || Factory(:house)).id}
end

