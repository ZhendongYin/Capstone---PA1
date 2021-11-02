class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if request.method == "POST"
      if params[:subject].present?
        @courses = Subject.find_by_id(params[:subject])&.courses
      end
      if params[:search_text].present?
        @courses ||= Course.all
        @courses = @courses.where("name LIKE ?", "%#{params[:search_text]}%")
      end
      @courses ||= []
    end
  end
end
