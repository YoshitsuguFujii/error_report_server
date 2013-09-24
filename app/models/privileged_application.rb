# coding: utf-8
require 'openssl'

class PrivilegedApplication < ActiveRecord::Base
  # Association
  has_many :logs

  # Validation
  validates :name, :presence => true, :uniqueness => true

  # Callback Method
  before_create :generate_key, :generate_secret

  private
    def generate_key
      self.key = [OpenSSL::Random.random_bytes(32)].pack("m").gsub(/\n/, '')
    end

    def generate_secret
      self.secret = [OpenSSL::Random.random_bytes(32)].pack("m").gsub(/\n/, '')
    end
end
