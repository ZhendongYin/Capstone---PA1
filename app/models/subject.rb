class Subject < ApplicationRecord
  has_and_belongs_to_many :segments
  has_and_belongs_to_many :courses
end
