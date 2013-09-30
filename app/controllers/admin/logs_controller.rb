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
      rtn_hash = {}
      clear_empty_params
      rtn_hash.merge(build_date_query)
      rtn_hash.merge(build_dynamic_input_query)
    rescue => ex
      nil
    end

    # 空文字削除
    def clear_empty_params
      params[:input_key].reject!(&:empty?)
      params[:input_value].reject!(&:empty?)
    end

    # フリー入力による検索
    def build_dynamic_input_query
      rtn_hash = {}
      return {} if params[:input_key].blank? && params[:input_value].blank?
      params[:input_key].each_with_index do |key, idx|
        rtn_hash.update({params[:input_key][idx].to_s => Regexp.new(params[:input_value][idx])})
      end
      rtn_hash
    end

    # 日付による検索
    def build_date_query
      # DBがUTCなので+9する
      @created_at_gteq = parse_date(:created_at_gteq)
      @created_at_lt = parse_date(:created_at_lt)
      {:created_at.gte => @created_at_gteq, :created_at.lt => @created_at_lt.tomorrow}
    end

    def parse_date(index_name )
      year = params[index_name][:year]
      month = params[index_name][:month]
      day = params[index_name][:day]
      Time.new(year,month,day, 9 , 0 , 0)
    end
end
