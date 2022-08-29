class ApplicationController < ActionController::Base
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from Pagy::OverflowError, with: :redirect_to_root

  private
    def error(status, errors,  message)
      render json: {errors: errors , message: message}, status: status
    end

    def redirect_to_root
      redirect_to root_path
    end

    def record_not_unique (e)
      error(409, e, 'Hash entered already exists')
    end

    def parameter_missing (e)
      error(402, e, "There's and empty field, check your hash")
    end
end