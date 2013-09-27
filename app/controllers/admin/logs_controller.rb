class Admin::LogsController < ApplicationController
  before_action :set_log, only: [:show]

  def index
    @privileged_application = PrivilegedApplication.find(params[:privileged_application_id])
    @logs = @privileged_application.logs.where(build_search_query).desc(:created_at).page(params[:page])
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    def build_search_query
      # DBがUTCなので+9する
      @created_at_gteq = parse_date(:created_at_gteq)
      @created_at_lt = parse_date(:created_at_lt)
      {:created_at.gte => @created_at_gteq, :created_at.lt => @created_at_lt.tomorrow}
    rescue => ex
      nil
    end

    def parse_date(index_name )
      year = params[index_name][:year]
      month = params[index_name][:month]
      day = params[index_name][:day]
      Time.new(year,month,day, 9 , 0 , 0)
    end
end
