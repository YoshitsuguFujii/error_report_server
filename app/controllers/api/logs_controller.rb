class Api::LogsController < ApiController
  before_action :set_log, only: [:show]

  def index
    @logs = Log.all
  end

  def create
    @logs = []

    logs = Log.new(log: params[:log])
    logs = JSON.parse(params[:log])
    #logs = JSON.parse("[ \"key1:value1\\tkey2:value2\", \"key3:value3\\tkey4:value4\" ]")

    Array.wrap(logs).each do |log|
      @logs << Log.new(log: log)
    end

    Log.import(@logs)
    render json: ApiResponse.sucess, :status => 201
  rescue JSON::ParserError => ex
    logger.error("JSON::ParserError")
    logger.error(ex.message)
    logger.error(ex.backtrace.join("\n"))
    render json: ApiResponse.system_error(ex.message), :status => 500
  rescue => ex
    logger.error("SystemError")
    logger.error(ex.message)
    logger.error(ex.backtrace.join("\n"))
    render json: ApiResponse.system_error(ex.message), :status => 500
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:log)
    end
end
