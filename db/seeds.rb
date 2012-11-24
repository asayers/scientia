# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Note that order is important. Things making reference to Document/Template/Bibliography.find(1) will expect some kind of default.

User.create(username: "root", email: "root@asayers.org", password: "foobar", password_confirmation: "foobar")
Document.create(name: "Default", user_id: 1, body: "See db/seed_data/root/default.md")
Document.create(name: "Welcome", user_id: 1, body: "See db/seed_data/root/welcome.md")
Template.create(name: "Default", user_id: 1, body: "See db/seed_data/root/default.tex")
