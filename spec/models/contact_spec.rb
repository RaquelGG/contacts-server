require "rails_helper"

RSpec.describe Contact, type: :model do
  it { should have_many(:change).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:tel) }
  #it { should validate_uniqueness_of(:email) }
end
