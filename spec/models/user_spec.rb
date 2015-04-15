require 'rails_helper'

describe User do
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:votes) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }

  let(:test_user)  { User.create(username:"test_user",  password:"password", phone: "4045551212")} 
  let(:test_admin) { User.create(username:"test_admin", password:"password", role: "admin")}
  let(:test_moderator) { User.create(username:"test_moderator", password:"password", role:"moderator")}

  it "returns false if user is not admin" do
    expect(test_user.admin?).to eq(false)
  end
  it "returns true  if user is admin" do
    expect(test_admin.admin?).to eq(true)
  end
  it "returns false if user is not a moderator" do 
    expect(test_user.moderator?).to eq(false)
  end
  it "returns true  if user is a moderator" do
    expect(test_moderator.moderator?).to eq(true)
  end
  it "returns false if user did not activate two_factor_auth" do
    expect(test_admin.two_factor_auth?).to eq(false)
  end
  it "returns true  if user did activate two_factor_auth" do
    expect(test_user.two_factor_auth?).to eq(true)
  end
  it "generates a pin" do
    test_user.generate_pin!
    expect(test_user.pin).to be > 0
  end
  it "removes pin" do
    test_user.generate_pin!
    test_user.remove_pin!
    expect(test_user.pin).to eq(nil)
  end
end