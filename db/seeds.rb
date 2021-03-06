# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)



admin = User.find_by_login("admin")
if admin
  puts "Admin already exists"
else
  admin = User.create!(
    :login      => "admin",
    :email      => "julian@eggandjam.com",
    :password   => "test123",
    :password_confirmation => "test123")

    admin.state = "active"
    admin.save!

  volunteer_1 = User.create!(
    :login        => "ksmith",
    :name         => "Kevin Smith",
    :phone_number => "123 456",
    :email        => "ksmith@eggandjam.com",
    :password     => "test123",
    :password_confirmation => "test123")

    volunteer_1.state = "active"
    volunteer_1.save!

  volunteer_2 = User.create!(
    :login        => "janedoe",
    :name         => "Jane Doe",
    :phone_number => "123 456",
    :email        => "janedoe@eggandjam.com",
    :password     => "test123",
    :password_confirmation => "test123")

    volunteer_2.state = "active"
    volunteer_2.save!

  bp_rep = User.create!(
    :name         => "John Doe",
    :phone_number => "123 4567",
    :login        => "bp_rep",
    :email        => "bp_rep@eggandjam.com",
    :password     => "test123",
    :password_confirmation => "test123")

    bp_rep.state = "active"
    bp_rep.save!

  red_cross_rep = User.create!(
    :name         => "Mary Jane",
    :phone_number => "123 4567",
    :login        => "red_cross_rep",
    :email        => "red_cross_rep@eggandjam.com",
    :password     => "test123",
    :password_confirmation => "test123")

    red_cross_rep.state = "active"
    red_cross_rep.save!

    if admin
      puts "Admin account created"
    else
      puts "admin account creation failed"
    end
end

houses  = [{  
  :address_1    => "34 Leahy Cls", 
  :address_2    => nil, 
  :country      => "Australia", 
  :state        => "ACT", 
  :post_code    => 2604, 
  :suburb       => "Narrabundah"
},
  {
  :address_1    => "200 Cleveland Street", 
  :address_2    => nil, 
  :country      => "Australia", 
  :state        => "NSW", 
  :post_code    => 2010, 
  :suburb       => "Surry Hills"
}]

# lat = -35.344187
# long = 149.141668

for_profit = OrganisationType.create!(:name => "for profit")
not_for_profit = OrganisationType.create!(:name => "not for profit")

house = volunteer_1.houses.create(houses)

5.times {
  a = house.first.beds.create!
  a.organisation_types << for_profit
  a.organisation_types << not_for_profit

  a = house.last.beds.create!
  a.organisation_types << not_for_profit
}


houses  = [{  
  :address_1    => "35 Riccarton Road",
  :address_2    => nil, 
  :country      => "New Zealand", 
  :state        => "Christchurch", 
  :post_code    => 8011, 
  :suburb       => "Riccarton"
}]

house = volunteer_2.houses.create(houses)

3.times {
  a = house.first.beds.create!
  a.organisation_types << not_for_profit
}

bp = Organisation.find_by_name("BP")
if bp
  puts "BP already exists"
else
  bp = bp_rep.organisations.create!(:name => "BP", :active => true)
  bp.organisation_type = for_profit
  bp.save!

  rc = red_cross_rep.organisations.create!(:name => "Red Cross", :active => true)
  rc.organisation_type = not_for_profit
  rc.save!
end


admin_role = Role.find_by_title("admin")
admin_role ||= Role.create!(:title => 'admin')

admin.roles << admin_role

organisation = Role.find_by_title("organisation")
organisation ||= Role.create!(:title => 'organisation')

bp_rep.roles << organisation
red_cross_rep.roles << organisation
