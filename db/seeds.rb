# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
#

admin_role = Role.find_or_create_by_name("admin")
basic_role = Role.find_or_create_by_name("basic_user")

u = User.find_or_create_by_email("admin@graphreviewer.com", :password => "password", :password_confirmation => "password")
u.roles = [admin_role]
u.save

u = User.find_or_create_by_email("basicuser@graphreviewer.com", :password => "password", :password_confirmation => "password")
u.roles = [basic_role]
u.save
