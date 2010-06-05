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
          
Houses.create(houses)