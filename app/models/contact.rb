class Contact < ApplicationRecord
  has_many :change, dependent: :destroy
  validates_presence_of :name, :surname, :email, :tel
  validates :email, uniqueness: true
end
