require 'rails_helper'

describe Category do
  it { should have_many(:post_categories) }
  it { should have_many(:posts).through(:post_categories) }
  it { should validate_presence_of(:name) }
end