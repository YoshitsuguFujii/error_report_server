class ApiController < ActionController::Base
  class InvalidAccess < StandardError; end

  before_action :before_log
  before_action :authenticate_api!
  rescue_from Exception, with: :system_error
  # アクセスで弾く辺りはカプセル化したい
  rescue_from InvalidAccess, with: :auth_error

#  before_action :api_authorize

  ##
  # エラーを全部引き受ける(個々のハンドリングは継承先でやるといいです)
  def system_error(ex)
    puts(ex.message)
    puts(ex.backtrace.join("\n"))
    logger.error(ex.message)
    logger.error(ex.backtrace.join("\n"))
    render json: ApiResponse.system_error , :status => 500
  end

  # secret token不正
  def auth_error(ex)
    puts(ex.message)
    puts(ex.backtrace.join("\n"))
    logger.error(ex.message)
    logger.error(ex.backtrace.join("\n"))
    render json: ApiResponse.auth_failed , :status => 401
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

    def authenticate_api!
      api_key = request.env["HTTP_API_KEY"] || request.env["api_key"]
      secret_token = request.env["HTTP_SECRET_TOKEN"] || request.env["secret_token"]

      @app = PrivilegedApplication.find_by(key: api_key)

      if @app.secret != secret_token
        raise InvalidAccess, '不正なアクセスです'
      end
    end

    def before_log
      logger.info("params: #{params}")
    end
  # end private
end
