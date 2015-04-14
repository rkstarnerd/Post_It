require 'rails_helper'

describe PostCategory do
  it { should belong_to(:post) }
  it { should belong_to (:category) }
end