require 'rails_helper'

RSpec.describe User, type: :model do
  it 'returns the username' do
    user = User.create(username: 'Tristan')

    expect(user.username).to eq  'Tristan'
  end
end
