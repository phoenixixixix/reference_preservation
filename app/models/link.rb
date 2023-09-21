class Link < ApplicationRecord
  belongs_to :group, optional: true

  validates :title, :url, presence: true

  scope :by_group, ->(group) { where(group: group) }
end
