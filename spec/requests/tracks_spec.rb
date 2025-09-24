require 'rails_helper'

RSpec.describe "Tracks", type: :request do
let!(:user) { User.create!(email: "twhite@example.com", username: "Twhite") }
 let!(:artist) { Artist.create!(name: "Test Artist") }

  describe "POST /tracks" do
    it "createsa a new track" do
      expect{
        post tracks_path, params: {
          track: { title: "New Song", year: 2024, artist_id: artist.id}
        }
      }.to change(Track, :count).by(1)

      new_track = Track.last
      expect(new_track.title).to eq("New Song")
      expect(new_track.artist).to eq(artist)
      expect(response).to redirect_to(track_path(new_track))
    end
end

  describe "PATCH /tracks/:id" do
    let!(:track) { Track.create!(title: "Old Song", year: 2020, user: user, artist: artist)}

    it "updates an exsisting track" do 
      patch track_path(track), params: {
        track: {key: "C minor"} 
      }
      expect(response).to redirect_to(track_path(track))

      track.reload
      expect(track.key).to eq("C minor")
    end
  end
end