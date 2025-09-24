require 'rails_helper'

RSpec.describe "Tracks" do
  let!(:user)   { User.create!(email: "twhite@example.com", username: "Twhite") }
  let!(:artist) { Artist.create!(name: "Test Artist") }

  describe "POST /tracks" do
   it "creates a new track" do
     expect {
       post tracks_path, params: { track: { title: "New Song", year: 2024, artist_id: artist.id } }
     }.to change(Track, :count).by(1)
   end

   it "redirects to the new track page" do
     post tracks_path, params: { track: { title: "New Song", year: 2024, artist_id: artist.id } }
     expect(response).to redirect_to(track_path(Track.last))
   end

   it "saves the correct title" do
     post tracks_path, params: { track: { title: "New Song", year: 2024, artist_id: artist.id } }
     expect(Track.last.title).to eq("New Song")
   end

   it "saves the correct artist" do
     post tracks_path, params: { track: { title: "New Song", year: 2024, artist_id: artist.id } }
     expect(Track.last.artist).to eq(artist)
   end
 end

  describe "PATCH /tracks/:id" do
     let!(:track) { Track.create!(title: "Old Song", year: 2020, user: user, artist: artist) }

     it "redirects after update" do
       patch track_path(track), params: { track: { key: "C minor" } }
       expect(response).to redirect_to(track_path(track))
     end

     it "updates the key" do
       patch track_path(track), params: { track: { key: "C minor" } }
       track.reload
       expect(track.key).to eq("C minor")
     end
   end
end
