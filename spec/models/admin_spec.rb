require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { FactoryGirl.build(:admin) }

  it 'is valid with a name, email, and password' do
    expect(admin).to be_valid
  end

  it 'is not valid when missing a name' do
    new_admin = admin
    new_admin.name = nil
    expect(new_admin).to_not be_valid
  end

  it 'is not valid when missing an email' do
    new_admin = admin
    new_admin.email = nil
    expect(new_admin).to_not be_valid
  end

  it 'is not valid when missing a password' do
    new_admin = admin
    new_admin.password = nil
    expect(new_admin).to_not be_valid
  end

  it 'is not valid when the password and password confirmation do not match' do
    new_admin = admin
    new_admin.password = ''
    expect(new_admin).to_not be_valid
  end
end
