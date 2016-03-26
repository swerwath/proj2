# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Make Clubs
%w(Service Sports CS).each do |name|
  c = Club.create name: name, description: name+" Club", closed: false
  t = Team.create name: "general", description: "General discussion for "+name, leader_id: c.id
  t.club = c
  t.save
end

%w(John Cathy Will Jill).each do |name|
  u = User.create name: name, email: name+"@gmail.com", password: 'password'
  t = Team.find_by_id(u.id)
  u.teams.append(t)
end
