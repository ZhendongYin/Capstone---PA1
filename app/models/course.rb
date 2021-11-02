class Course < ApplicationRecord
  serialize :requirements, Array

  has_and_belongs_to_many :subject
  has_many :enrollments
  has_many :users, through: :enrollments
end
