class ApiResponse
  include ActiveModel::Model

  attr_accessor :result, :message

  def initialize
    yield self if block_given?
  end

  def as_json(options={})
    {
      data:
        {
          result: self.result,
          message: self.message
        }
    }
  end

  class << self

    def instance_get(result_string, message)
      ApiResponse.new do |br|
        # 正常終了コード以外は-1(異常終了)
        br.result = result_string
        br.message = message
      end
    end
   private :instance_get

    # 成功
    def sucess(success_message = "sucess")
      instance_get("success", success_message)
    end

    # 認証失敗系
    def auth_failed(err_message = "認証に失敗しました")
      instance_get("failed-1", err_message)
    end

    # システムエラー系
    def system_error(err_message = "system error", db_error_message = "cant connect database")
      # DB接続できないなら
      unless ActiveRecord::Base.connected?
        instance_get("failed-2", db_error_message)
      else
        instance_get("failed-3", err_message)
      end
    end
  end # end eigen methods

end
