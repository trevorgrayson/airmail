require 'mail'

module Airmail
  class << self
    def receive( original )
      raise RoutesNotDefined unless defined? @@route

      mail = Mail.new( original )     
      MailProcessor.new(mail, @@route, original).receive

      mail
    end

    def route(&route)
      @@route = route
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
