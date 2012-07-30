# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#puts 'SETTING UP DEFAULT USER LOGIN'
User.delete_all
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
#puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
#puts 'New user created: ' << user2.name
user.add_role :admin
user2.add_role :admin_group

District.delete_all
Municipality.delete_all
Region.delete_all
Country.delete_all
country = Country.create! :name => 'España'
region = country.regions.create! :name => 'Madrid'
municipality = region.municipalities.create! :name => 'Madrid'
district = municipality.districts.create! :name => 'Vicálvaro'
district2 = municipality.districts.create! :name => 'Rivas-Vaciamadrid'

#100.times {|i| User.create! :name => "User #{i+3}", :email => "user#{i+3}@example.com", :password => 'please', :password_confirmation => 'please', :confirmed_at => (Time.now + i.day).utc, :created_at => (Time.now + i.day).utc  }
#Role.create(name: 'betatester')
