# == Schema Information
#
# Table name: course_exercises
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  exercise_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  course_exercises_course_id_fk    (course_id)
#  course_exercises_exercise_id_fk  (exercise_id)
#

require 'rails_helper'

RSpec.describe CourseExercise, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end