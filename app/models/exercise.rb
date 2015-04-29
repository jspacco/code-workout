# == Schema Information
#
# Table name: exercises
#
#  id                 :integer          not null, primary key
#  question_type      :integer          not null
#  current_version_id :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  versions           :integer          not null
#  exercise_family_id :integer
#
# Indexes
#
#  index_exercises_on_current_version_id  (current_version_id)
#  index_exercises_on_exercise_family_id  (exercise_family_id)
#

class Exercise < ActiveRecord::Base

  #~ Relationships ............................................................

  has_many :exercise_versions, inverse_of: :exercise, dependent: :destroy
  has_many :course_exercises, inverse_of: :exercise
  has_many :courses, through: :course_exercises
  has_many :exercise_workouts, inverse_of: :exercise,
    dependent: :destroy
  has_many :workouts, through: :exercise_workouts
  belongs_to :exercise_family, inverse_of: :exercises
  has_many :exercise_owners, inverse_of: :exercise
  has_many :users, through: :exercise_owners
  belongs_to :current_version, class_name: 'ExerciseVersion'


  #~ Hooks ....................................................................

  before_validation :set_defaults


  #~ Validation ...............................................................

  validates :versions, presence: true, numericality: { greater_than: 0 }
  validates :question_type, presence: true, numericality: { greater_than: 0 }

  # This one might be needed, but might break the create path for
  # exercises, so I'm leaving it out for now:
  # validates :current_version, presence: true

  Q_MC     = 1
  Q_CODING = 2
  Q_BLANKS = 3

  TYPE_NAMES = {
    Q_MC     => 'Multiple Choice Question',
    Q_CODING => 'Coding Question',
    Q_BLANKS => 'Fill in the blanks'
  }


  #~ Public instance methods ..................................................

  def type_name
    TYPE_NAMES[self.question_type]
  end


  def is_mcq?
    self.question_type == Q_MC
  end


  def is_coding?
    self.question_type == Q_CODING
  end


  def is_fill_in_the_blanks?
    self.question_type == Q_BLANKS
  end


  #~ Private instance methods .................................................
  private

  def set_defaults
    self.question_type ||= Q_MC
  end


end
