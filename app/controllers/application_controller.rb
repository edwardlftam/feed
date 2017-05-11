class ApplicationController < ActionController::API
  include ResponseHelpers
  
  rescue_from ArgumentError, with: :invalid_params!
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_params!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!
end
