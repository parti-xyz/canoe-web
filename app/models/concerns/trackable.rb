require 'active_support/concern'

module Trackable
  extend ActiveSupport::Concern

  included do
    has_many :activities, as: :trackable, dependent: :destroy
    after_create :stroke_discussion
    after_destroy :stroke_discussion
  end

  def track(actor)
    action = "#{actor.controller_name}/#{actor.action_name}"
    activities.build(user: self.user, discussion: self.discussion, action: action)
  end

  def stroke_discussion
    self.discussion.stroke(self.discussion.activities.newest.created_at)
  end
end