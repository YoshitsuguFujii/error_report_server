class Log
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  field :privileged_application_id, type: Integer

  META_KEY = %w(_id privileged_application_id created_at updated_at)

  validates :privileged_application_id, presence: true


  # 作成日時とかの付加情報をhashで返したいメソッド
  def meta
  end

  def log
    log_attr =  self.attributes.dup
    log_attr.delete_if{|attr| META_KEY.include?(attr)}
  end

  def log_str
    self.log.inject(""){|str,(key, value)| str << [key,value].join(":") + " " }
  end

  def privileged_application
    PrivilegedApplication.find(self.privileged_application_id)
  end
end
