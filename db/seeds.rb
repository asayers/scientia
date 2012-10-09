# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Note that order is important. Things making reference to Document/Template/Bibliography.find(1) will expect some kind of default.

User.create(username: "root", email: "alex.sayers@bnc.ox.ac.uk", password: "foobar", password_confirmation: "foobar")
Document.create(name: "Default", user_id: 1, body: "See public/nit/default.md")
Document.create(name: "Welcome", user_id: 1, body: "See public/init/welcome.md")
Template.create(name: "Default", user_id: 1, body: "See public/init/default.tex")
Bibliography.create(name: "Default", user_id: 1, body: "See public/init/default.bib")
Document.all.each { |d| d.regenerate }
Template.all.each { |t| t.regenerate }
