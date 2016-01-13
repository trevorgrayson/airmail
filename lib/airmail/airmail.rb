require 'mail'

module Airmail
  class << self
    def receive( original )
      raise RoutesNotDefined unless defined? @@route

      mail = Mail.new( original )     
      processor = MailProcessor.new(mail, @@route, original)
      processor.before_receive if processor.respond_to? :before_receive
      processor.receive

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
