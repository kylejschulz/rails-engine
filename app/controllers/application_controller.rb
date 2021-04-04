class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  include ActionController::Helpers
  helper_method :set_per_page, :set_page

  def set_page
    if !params[:page].nil?
      @page = params[:page].to_i - 1
      if @page < 1
        @page = 0
      end
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

  def render_unprocessable_entity_response(exception)
   render json: exception.record.errors, status: 404
 end

 def render_not_found_response(exception)
   render json: { error: exception.message }, status: :not_found
 end
end
