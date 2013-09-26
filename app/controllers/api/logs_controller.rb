class Api::LogsController < ApiController
  before_action :set_log, only: [:show]
  skip_before_action :authenticate_api!, only: [:index, :show]

  def index
    @logs = Log.all
  end

  def create
    @logs = []

    begin
      logs = Log.new(log: params[:log])
      logs = JSON.parse(params[:log])
    rescue JSON::ParserError => ex
      #logs = JSON.parse("[ \"key1:value1\\tkey2:value2\", \"key3:value3\\tkey4:value4\" ]")
      logs = params[:log]
    end

    Array.wrap(logs).each do |log|
      @logs << Ltsv.parse(log).merge(privileged_application_id: @app.id, created_at: Time.now, updated_at: Time.now)
    end

    begin
      # bulk insert
      Log.collection.insert(@logs)
      render json: ApiResponse.sucess, :status => 201
    rescue => ex
      logger.error(ex.message)
      logger.error(ex.backtrace.join("\n"))
      render json: ApiResponse.system_error(ex.message), :status => 500
    end
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
