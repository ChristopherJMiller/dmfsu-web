require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { FactoryGirl.build(:admin) }

  it 'is valid with a name, email, and password' do
    expect(admin).to be_valid
  end

  it 'is not valid when missing a name' do
    admin.name = nil
    expect(admin).to_not be_valid
  end

  it 'is not valid when missing an email' do
    admin.email = nil
    expect(admin).to_not be_valid
  end

  it 'is not valid when missing a password' do
    admin.password = nil
    expect(admin).to_not be_valid
  end

  it 'is not valid when the password and password confirmation do not match' do
    admin.password = ''
    expect(admin).to_not be_valid
  end
end
