require 'rails_helper'

RSpec.describe User do
  it 'returns the username' do
    user = described_class.create(username: 'Tristan')

    expect(user.username).to eq 'Tristan'
  end
end
