class Api::LogsController < ApiController
  before_action :set_log, only: [:show]

  def index
    @logs = Log.all
  end

  def create
    @log = Log.new(ltsv: params[:log])

    begin
      @log.save!
      render json: ApiResponse.sucess, :status => 201
    rescue => ex
      render json: ApiResponse.system_error(ex.message), :status => 500
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    def log_params
      params.require(:log).permit(:ltsv)
    end
end
