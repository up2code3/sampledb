require "rails_helper"

RSpec.describe Sample, type: :model do
    let(:artist) { Artist.create!(name: "Test Artist") }
    let(:user) { User.create!(username: "tester", email: "t@mail.com", password: "password") }
    let(:source) { Track.create!(title: "Original", year: 1990, artist: artist, user: user) }
    let(:derived) { Track.create!(title: "Remix", year: 1995, artist: artist, user: user) }

    it "is valid with valid attributes" do 
        sample = Sample.new(source_track: source, derived_track: derived)
        expect(sample).to be_valid
    end 

    it "is invalid when a track samples itself" do
        sample = Sample.new(source_track: source, derived_track: source)
        expect(sample).not_to be_valid
        expect(sample.errors[:base]).to include("A track cannot sample itself")
    end

    it "is invalid when sampling from the future" do 
        sample = Sample.new(source_track: derived, derived_track: source)
        expect(sample).not_to be_valid
        expect(sample.errors[:base]).to include("A track cannot sample from the future")
    end

    it "returns a readable description" do 
        sample = Sample.new(source_track: source, derived_track: derived)
        expect(sample.description).to eq("Remix samples Original")
    end
end