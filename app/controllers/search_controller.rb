class SearchController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if params[:subject].present?
      @courses = Subject.find_by_id(params[:subject])&.courses
    else
      @courses = Course.all
    end
    if params[:search_text].present?
      @courses = @courses.where("name LIKE ?", "%#{params[:search_text]}%")
    end
    @courses ||= []
  end
end
