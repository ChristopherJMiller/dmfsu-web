require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryGirl.build(:event) }

  it 'is valid with a valid title, description, location, start time, and end time' do
    expect(event).to be_valid
  end

  it 'is not valid with a missing title' do
    event.title = nil
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing description' do
    event.description = nil
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing location' do
    event.location = nil
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing start time' do
    event.start_time = nil
    expect(event).to_not be_valid
  end

  it 'is not valid with a missing end time' do
    event.end_time = nil
    expect(event).to_not be_valid
  end
end
