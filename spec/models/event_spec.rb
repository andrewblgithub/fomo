require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:group) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:expires_at) }
end
