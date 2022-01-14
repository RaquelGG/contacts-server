require 'rails_helper'

RSpec.describe Change, type: :model do
  it { should belong_to(:contact) }

end
