class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :lesson
  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true
  validates :content, presence: true

end
