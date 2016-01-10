require 'mail'
class MailRouter

  def initialize(mail)
    @mail = mail
  end

  def route #this is the app specific controller logic
    MailRouter.info("Receiving email '#{@mail.subject}' from #{@mail.from}, #{@mail.to} with #{@mail.attachments.count} attachments")

    @mail.attachments.each do |attach|
      MailRouter.info(">> #{attach.filename}")#(#{a.content_type.to_s})")
    end

    #TODO catch mailerdaemon stuff
    #TODO circular loops? throttle speed
    #if from? :mailerdaemon, :root

    (deliver MailDemoController and return) if @mail.to.join(" ") =~ /demo.*@amendment.io/

    if has_attachment? 
      #if not on the contact list, don't grant access to services
      (deliver ThanksForPlayingController and return) unless Contact.find_by_email(@mail.from.collect{|f| f.downcase})

      (deliver AttachmentController and return) 
    end

    deliver DefaultController and return
  end

  def from? *args
    from
  end

  def has_attachment?
    @mail.attachments.size > 0
  end

  def deliver controller
    controller.new(@mail).receive
  end

  class << self

    def receive( original )
      mail = Mail.new( original )     

      record(mail, original)
      self.new(mail).route

      mail
    end

    def record(mail, original)
      Message.create!(
        from: mail.from.first,
        #reference_id: mail.
        to: mail.to,
        subject: mail.subject,
        original: original,
        taxonomy: 'log'
      )
    end

    def info msg
      @logger && @logger.info(msg)
    end

    def logger= loggr
      @logger = loggr
    end

  end
end
