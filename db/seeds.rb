# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


houses  = [{  
  :address_1    => "34 Leahy Cls", 
  :address_2    => nil, 
  :country      => "Australia", 
  :state        => "ACT", 
  :post_code    => 2604, 
  :suburb       => "Narrabundah"
}]

# lat = -35.344187
# long = 149.141668

House.create(houses)

admin = User.find_by_login("admin")
if admin
  puts "Admin already exists"
else
  admin = User.create!(
    :login      => "admin",
    :email      => "julian@giuca.com",
    :password   => "test123",
    :password_confirmation => "test123")

    admin.state = "active"
    admin.save!

    if admin
      puts "Admin account created"
    else
      puts "admin account creation failed"
    end
end


admin_role = Role.find_by_title("admin")
admin_role ||= Role.create!(:title => 'admin')

admin.roles << admin_role

organisation = Role.find_by_title("organisation")
organisation ||= Role.create!(:title => 'organisation')

