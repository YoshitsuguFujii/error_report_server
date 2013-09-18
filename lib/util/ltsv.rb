module Ltsv
  class LtsvParseError < StandardError; end
  def parse(str)
    Hash[str.split("\t").map{|f| f.split(":", 2)}]
  end
  module_function :parse
end
