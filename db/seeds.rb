# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class TempSegmentsMap < ApplicationRecord
  self.table_name = :segments_subjects
end

class TempCoursesMap < ApplicationRecord
  self.table_name = :courses_subjects
end

# Data Storing Method
def store_data(modle, data)
  if data[0].is_a?(Hash)
    modle.import(data.first.keys, data, batch_size: 100, recursive: true)
  else
    modle.import(data, batch_size: 100, recursive: true)
  end
end

Instructor.delete_all
Subject.delete_all
Segment.delete_all
TempSegmentsMap.delete_all
Course.delete_all
TempCoursesMap.delete_all

# Store Instructor Data
data = ParseJson.parse_instructors
store_data(Instructor, data)

# Store Subject Data
data = ParseJson.parse_subjects
segments = {}
segments_map = []
data = data.map do |t|
  t['s_id'] = t.delete('id')
  t.delete('segments').each do |c|
    segments[c['id']] = c
    segments_map << { segment_id: c['id'], subject_id: t['s_id'] }
  end
  t
end

store_data(Segment, segments.values)
store_data(Subject, data)

# _segments_map = []
segments_map = segments_map.map do |t|
  { subject_id: Subject.find_by(s_id: t[:subject_id]).id, segment_id: t[:segment_id] }
end
store_data(TempSegmentsMap, segments_map)

# Store Course Data
data = ParseJson.parse_courses
maps = []
data = data.map do |t|
  t['subjects'].each do |m|
    subject = Subject.find_by(s_id: m['id'])
    next if subject.nil?

    maps << { subject_id:  subject.id, code: t['code'] }
  end
  t.slice('code', 'name', 'description', 'independent_study', 'requirements')
end
store_data(Course, data)

maps = maps.map do |t|
  { subject_id:  t[:subject_id], course_id: Course.find_by(code: t[:code]).id }
end
store_data(TempCoursesMap, maps)
