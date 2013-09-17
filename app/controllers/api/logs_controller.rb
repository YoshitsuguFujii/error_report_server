class Api::LogsController < ApiController
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
    def log_params
      params.require(:log).permit(:ltsv)
    end
end
