class Post < ApplicationRecord
  validates :title, :body, :published_on, presence: true

  scope :newest_first, -> { order(published_on: :desc, id: :desc) }
end
