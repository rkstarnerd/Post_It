require 'rails_helper'

describe Comment do
  it { should belong_to(:creator) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user_id) }
end
