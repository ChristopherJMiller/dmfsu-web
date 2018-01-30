require 'rails_helper'

RSpec.describe Announcement, type: :model do
  let(:announcement) { FactoryGirl.build(:announcement) }

  it 'is valid with a valid title and post' do
    expect(announcement).to be_valid
  end

  it 'is not valid when missing a title' do
    announcement.title = nil
    expect(announcement).to_not be_valid
  end

  it 'is not valid when missing a post body' do
    announcement.post = nil
    expect(announcement).to_not be_valid
  end

  it 'is not valid when missing an author' do
    announcement.admin = nil
    expect(announcement).to_not be_valid
  end
end
