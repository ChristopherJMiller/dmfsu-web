require 'rails_helper'

RSpec.describe Announcement, type: :model do
  let(:announcement) { FactoryGirl.build(:announcement) }

  it 'is valid with a valid title and post' do
    expect(announcement).to be_valid
  end

  it 'is not valid when missing a title' do
    new_announcement = announcement
    new_announcement.title = nil
    expect(announcement).to_not be_valid
  end

  it 'is not valid when missing a post body' do
    new_announcement = announcement
    new_announcement.post = nil
    expect(announcement).to_not be_valid
  end

  it 'is not valid when missing an author' do
    new_announcement = announcement
    new_announcement.admin = nil
    expect(announcement).to_not be_valid
  end
end
