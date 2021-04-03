class ApplicationController < ActionController::API
  include ActionController::Helpers
  helper_method :set_per_page, :set_page

  def set_page
    if !params[:page].nil?
      @page = params[:page].to_i - 1
    else
      @page = 0
    end
  end

  def set_per_page
    if !params[:per_page].nil?
      @limit = params[:per_page].to_i
    else
      @limit = 20
    end
  end
end
