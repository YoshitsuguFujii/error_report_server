class Admin::TopController < AdminController
  #before_action :set_log, only: [:show, :edit, :update, :destroy]
  layout 'application'

  def index
    @logs = Log.all
  end

  private
    #def set_log
    #  @log = Log.find(params[:id])
    #end

    ## Never trust parameters from the scary internet, only allow the white list through.
    #def log_params
    #  params.require(:log).permit(:ltsv)
    #end
end
