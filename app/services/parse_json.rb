require 'json'

class ParseJson
  class << self
    def parse_courses
      file_path = "#{Rails.root}/data/course.json"
      parse_json(file_path)
    end

    def parse_instructors
      file_path = "#{Rails.root}/data/instructor.json"
      parse_json(file_path)
    end

    def parse_subjects
      file_path = "#{Rails.root}/data/subject.json"
      parse_json(file_path)
    end

    private

    def parse_json(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    rescue
      reutrn []
    end
  end
end
