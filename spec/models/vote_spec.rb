require 'rails_helper'

describe Vote do
  it { should belong_to(:creator).class_name('User').with_foreign_key('user_id') }
  it { should belong_to(:voteable) }
end