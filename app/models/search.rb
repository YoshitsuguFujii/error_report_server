class Search
  include ActiveModel::Model

  MAX_LENGTH_WORDS = 1000

  attr_accessor :words

  validates :words, length: {maximum: MAX_LENGTH_WORDS}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
  def something
    @something ||= find_something
  end

private
  def find_something
    something = Something.where(status: Status::PUBLIC).limit(10)
    something = something.where(words: words) if words
    something
  end
end
