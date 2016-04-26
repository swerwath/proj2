# Welcome to [Wisp](http://wisp.herokuapp.com), Silicon Valley's Hottest Startup
## Isabel Zhang, Scott Werwath, Tom Cheng
## NOTE: Images currently don't work on our Heroku site, since our AWS account has hit its Free Usage limit and we don't like spending money

### Concept
Wisp is a club management app that will make managing a club much simpler. The website allows users to make a club and within a club, different teams. Team leads will be able to make announcements to team members and have a working equipment list to see whether or not the equipment is checked-out. Watch the demo [here](https://www.youtube.com/watch?v=iQdunC-BqB8)

### Models and Description:

- announcement
  - has title and content
  - Also has the option to email_blast if desired.
  - Belongs_to team and user
  - Has_many comments


- club_officer
  - belongs_to user and club
  - Used to denote general club_officer

- club_president
  - belongs to user and club

- club
  - has name and description
  - has_many :teams, club_officers, club_officers
  - has_many :officers, :through => :club_officers, :source => :user
  - has_many :presidents, :through => :club_presidents, :source => :user

- comment
  - has content
  - belongs_to user and announcement

- equipment
  - has name, condition and user_id
  - belongs_to user and team

- team_join_request
  - belongs_to user and team

- team_leader
  - belongs_to user and team

- team
  - has name, description, and boolean (for whether or not it's a public team that everyone can join)
  - belongs_to club
  - has_many announcements, equipment
  - has_and_belongs_to_many users
  - has_many team_leaders
  - has_many team_join_requests
  - has_many :leaders, :through => :team_leaders, :source => :user

- user
  - has email and name (as the main fields)
  - has_many :team_leaders, club_officers, club_presidents, equipment, comments, announcements, team_join_requests
  - has_many :led_teams, :through => :team_leaders, :source => :team
  - has_many :officerships, :through => :club_officers, :source => :club
  - has_many :presidentships, :through => :club_presidents, :source => :club
  - has_and_belongs_to_many :teams

### Features
- Users can log in
- Users can make clubs
- Team leads can make an announcement and request to have the announcement emailed to their team members
- Officers of clubs can make a new team within their club
- For certain text, users can utilize Markdown
- Users can comment on announcements
- Members can request to be on a team and get approval from that team lead to be on it
- Team leads can change the name and description of their team
- Team leads can also add anyone from the same club onto their team and kick anyone off of their team
- Users can return and checkout equipment
- Team leads can add additional equipment onto equipment list
- Users can change password, leave a team, and cancel their account

### Division of Labor
- Isabel: JavaScript sidebar, mockups, frontend
- Scott: All the models and relations, bootstrap, team profile pictures and cover photos
- Tom: Mailgun API, mockups, video script and readme

