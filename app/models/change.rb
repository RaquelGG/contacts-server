class Change < ApplicationRecord
  belongs_to :contact
  validates_presence_of :contact_id
end
