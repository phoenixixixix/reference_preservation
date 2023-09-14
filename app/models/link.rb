class Link < ApplicationRecord
  belongs_to :group, optional: true

  validates :title, :url, presence: true
end
