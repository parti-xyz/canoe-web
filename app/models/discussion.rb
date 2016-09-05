class Discussion < ApplicationRecord
  acts_as_readable :on => :stroked_at

  belongs_to :user
  belongs_to :canoe
  has_many :opinions, dependent: :destroy
  has_many :proposal_requests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :consensus_revisions, dependent: :destroy do
    def current
      order(id: :desc).first
    end
  end

  scope :recent, -> { order(stroked_at: :desc) }

  before_create :stroke

  def stroke(at = current_time_from_proper_timezone)
    if self.new_record?
      self.stroked_at = at
    else
      self.update_columns(stroked_at: at)
    end
  end
end
