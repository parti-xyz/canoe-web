class Opinion < ApplicationRecord
  include SimpleTrackable

  belongs_to :user
  belongs_to :discussion, counter_cache: true
  has_one :canoe, through: :discussion
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true

  def model_for_show
    discussion
  end

  def updated?
    self.created_at != self.updated_at
  end
end
