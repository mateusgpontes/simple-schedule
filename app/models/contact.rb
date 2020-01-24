class Contact < ApplicationRecord
  belongs_to :user
  validades :name, :user, presence: true
end