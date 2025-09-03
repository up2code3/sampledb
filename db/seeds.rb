# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Clear existing Data
SampleSegment.delete_all
Sample.delete_all
Comment.delete_all
Track.delete_all
Artist.delete_all
User.delete_all

# create user
user_twhite = User.create!(
  email: "Twhite@mail.com",
  username: "Twhite"
)


# create artist 
artist_bob_james   = Artist.create!(name: "Bob James")
artist_slick_rick  = Artist.create!(name: "Slick Rick")
artist_ghostface   = Artist.create!(name: "Ghostface Killah")

# create tracks 
track_nautilus = Track.create!(
  title: "Nautilus",
  year: 1974,
  bpm: 99,
  artist: artist_bob_james,
  user: user_twhite
)
track_childrens_story = Track.create!(
  title: "Children’s Story",
  year: 1988,
  bpm: 103,
  artist: artist_slick_rick,
  user: user_twhite
)
track_daytona_500 = Track.create!(
  title: "Daytona 500",
  year: 1996,
  bpm: 98,
  artist: artist_ghostface,
  user: user_twhite
)

# create samples 
sample1 = Sample.create!(
  derived_track: track_childrens_story,
  source_track: track_nautilus
)
sample2 = Sample.create!(
  derived_track: track_daytona_500,
  source_track: track_nautilus
)

# create sample segments 
sample1.sample_segments.create!(start_time: 7)
sample2.sample_segments.create!(start_time: 40)

# create comments
Comment.create!(
  body: "did rza produce daytona 500",
  user: user_twhite,
  track: track_daytona_500
)
Comment.create!(
  body: "who was slick ricks producer",
  user: user_twhite,
  track: track_childrens_story
)
Comment.create!(
  body: "intersting that slick ricks version is faster than the original",
  user: user_twhite,
  track: track_childrens_story
)

# succes message
puts "Seeded: 
 #{User.count} users,
 #{Artist.count} artists,
 #{Track.count} tracks,
 #{Sample.count} samples,
 #{SampleSegment.count} segments,
 #{Comment.count} comments."