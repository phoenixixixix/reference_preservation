class Group < ApplicationRecord
  has_many :links

  validates :title, presence: true
end
