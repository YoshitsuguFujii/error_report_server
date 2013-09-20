# coding: utf-8
require 'openssl'

class PrivilegedApplication < ActiveRecord::Base
  ## :nodoc:
  # Validation
  validates :name, :presence => true, :uniqueness => true

  ## :nodoc:
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
