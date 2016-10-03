require 'active_support'
require 'mail'
require 'action_mailer'
require 'action_mailer/base'


module Airmail
  class << self
    def receive( original )
      raise RoutesNotDefined unless defined? @@route

      mail = self.parse( original )
      MailProcessor.new(mail, @@route, original).receive

      mail
    end

    def parse(msg)
      ::Mail::Message.new(msg)
    end

    def route(&route)
      @@route = route
    end

    def get_route
      @@route
    end

    def logger= logr
      @@logger = logr
    end

    def logger
      defined?(@@logger) ? @@logger : Logger.new("airmail.log")
    end

  end
end

class RoutesNotDefined < StandardError
end
