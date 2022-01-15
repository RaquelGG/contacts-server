require "rails_helper"

RSpec.describe Change, type: :model do
  it { should belong_to(:contact) }
  it { should validate_presence_of(:contact_id) }
end
