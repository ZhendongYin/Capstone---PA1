class Course < ApplicationRecord
  has_and_belongs_to_many :subject
  serialize :requirements, Array
end
