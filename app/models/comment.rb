class Comment < ApplicationRecord
  acts_as_tree order: "created_at ASC"
  has_one :general
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_comment}
end
