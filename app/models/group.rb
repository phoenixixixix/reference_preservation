class Group < ApplicationRecord
  has_many :links, dependent: :nullify

  validates :title, presence: true
end
