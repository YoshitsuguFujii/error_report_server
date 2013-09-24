class Admin::LogsController < ApplicationController
  before_action :set_log, only: [:show]

  def index
    @privileged_application = PrivilegedApplication.find(params[:privileged_application_id])
    @logs = @privileged_application.logs
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end
end
