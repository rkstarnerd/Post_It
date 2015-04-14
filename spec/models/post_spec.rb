require 'rails_helper'

describe Post do
  it { should belong_to(:creator) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:post_categories) }
  it { should have_many(:categories).through(:post_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

end