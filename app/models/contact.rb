class Contact < ApplicationRecord
  has_many :change, dependent: :destroy
  validates_presence_of :name, :surname, :email, :tel
  validates :email, uniqueness: true

  # tel regex from https://regexr.com/3c53v
  validates_format_of :tel, :with => /\A\+*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.0-9]*$\z/

  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
