Factory.sequence :name do |n|
  "Name_#{n}"
end

Factory.sequence :email do |n|
  "test_#{n}@eggandjam.com"
end

Factory.define :user do |u|
   u.name                  'test login'
   u.login                 {Factory.next(:name)}
   u.email                 {Factory.next(:email)}
   u.password              'test123'
   u.password_confirmation 'test123'
end


Factory.define :house do |h|
  h.user_id               {(User.find(:first) || Factory(:user)).id}
  h.address_1             "34 Leahy Cls"
  h.address_2             nil
  h.country               "Australia"
  h.state                 "ACT"
  h.post_code             2604 
  h.suburb                "Narrabundah"
  h.lat                   nil
  h.long                  nil
end

Factory.define :organisation_type do |t|
  t.name "NGO"
end

Factory.define :organisation do |o|
  o.name                {Factory.next(:name)}
  o.user_id             {(User.find(:first) || Factory(:user)).id}
  o.organisation_type_id{(OrganisationType.find(:first) || Factory(:organisation_type)).id}
end

Factory.define :bed do |b|
  b.house_id              {(House.find(:first) || Factory(:house)).id}
end

Factory.define :reservation do |r|
  r.start_date          {Time.now}
  r.end_date            {Time.now}
  r.organisation_id     {(Organisation.find(:first) || Factory(:organisation)).id}
  r.bed_id              {(Bed.find(:first) || Factory(:bed)).id}
end

Factory.define :role do |r|
  r.name "organisation"
end

