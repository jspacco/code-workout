# == Schema Information
#
# Table name: exercise_collections
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text
#  user_group_id :integer
#  license_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_exercise_collections_on_license_id     (license_id)
#  index_exercise_collections_on_user_group_id  (user_group_id)
#

class ExerciseCollection < ActiveRecord::Base
  belongs_to :user_group, inverse_of: :exercise_collection
  belongs_to :user
  belongs_to :license
  belongs_to :course_offering, inverse_of: :exercise_collections
  has_many :exercises

  def is_public?
    return self.license.andand.license_policy.andand.is_public
  end

  def owned_by?(user)
    if user.nil?
      false
    else
      self.user == user
    end
  end
end
