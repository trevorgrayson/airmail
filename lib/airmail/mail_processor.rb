class MailProcessor 

  def initialize mail, route, original=nil
    @mail = mail
    @raw_mail = original
    @route = route
    default_controller
  end

  def receive
    default_controller
    self.instance_eval(&@route)

    @delivering_controller ||= AirmailDefaultController
    controller = @delivering_controller.new(@mail, @raw_mail)
    controller.before_receive if controller.respond_to? :before_receive
    controller.receive
  end

  def from? *args
    from
  end

  def has_attachment?
    @mail.attachments.size > 0
  end

  def deliver controller
    @delivering_controller ||= controller
  end

  def deliver_to controller
    controller = controller.gsub(/(^|_)([a-z])/){ $2.upcase }
    @delivering_controller ||= "#{controller}Controller".constantize
  end

  def default_controller
    @delivering_controller = nil
  end

  def logger
    Airmail.logger
  end

end
