class Contact < ApplicationRecord
    has_many :change, dependent: :destroy

    validates_presence_of :mame, :surname, :email, :tel
end
