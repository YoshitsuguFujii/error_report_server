class ApiController < ActionController::Base
  rescue_from Exception, with: :system_error

#  before_action :api_authorize

  ##
  # エラーを全部引き受ける(個々のハンドリングは継承先でやるといいです)
  def system_error(ex)
    logger.error(ex.message)
    logger.error(ex.backtrace.join("\n"))
    render json: ApiResponse.system_error , :status => 500
  end

  def save_and_render(model)
    method = defined?(current_user) && current_user.present? ? [:save, current_user] : [:save_without_operator]
    if model.send(*method)
      model.api_response = ApiResponse.sucess
      render json: ApiResponse.sucess, :status => 201
    else
      if model.errors.any?
        render json: ApiResponse.param_error(model.errors.full_messages), :status => 400
      else
        render json: ApiResponse.param_error("#{model.class.name} register failed"), :status => 400
      end
    end
  end

  private
    def api_authorize
      if APP_CONFIG["debug"]
        @current_user = User.last
        return
      end

      auth = Certification::Authentication.new

      result = auth.check request

      # 認証失敗
      if result == false
        render json: ApiResponse.auth_failed , :status => 401
      else
      end
    end
  # end private
end
