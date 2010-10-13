require 'rmb/version'

module Rmb
  class Error < StandardError; end
  
  class MissingResourceError < Error; end
  class AuthorizationError   < Error; end
  class RequestError         < Error; end
  class ServerError          < Error; end
  
  class Config
    class << self
      attr_accessor :api_key, :api_secret, :base_url, :api_url, :upload_url, :version, :debug, :timeout
    end
  end
  
end

Rmb::Config.base_url   = "http://down.rmb.io"
Rmb::Config.api_url    = "http://api.rmb.io"
Rmb::Config.upload_url = "http://up.rmb.io/upload"
Rmb::Config.version    = "3.0"
Rmb::Config.debug      = false
Rmb::Config.timeout    = 60 # Default in Ruby

require 'rmb/api'
require 'rmb/client'
require 'rmb/resource'
require 'rmb/drop'
require 'rmb/asset'
require 'rmb/subscription'
require 'rmb/job'

