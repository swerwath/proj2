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
  t = Team.create name: "general", description: "General discussion for "+name, leader_id: c.id, closed: false
  t2 = Team.create name: "fundraising", description: "Fundraising is fun(d)!", leader_id: c.id, closed: false
  t.club = c
  t2.club = c
  t.save
  t2.save
end

%w(John Cathy Will Jill).each do |name|
  u = User.create name: name, email: name+"@gmail.com", password: 'password'
  t = Team.find_by_id(u.id)
  t2 = Team.find_by_id(u.id + 1)
  u.teams.append(t)
  u.teams.append(t2)
end
