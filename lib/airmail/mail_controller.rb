module Airmail
  class Controller
    def initialize(mail)
      @mail = mail
    end

    def from
      return @from if @from

      @from = if @mail.from.is_a? Array
        @mail.from.first
      else
        @mail.from
      end
    end

    def to
      @to ||= Array.wrap(@mail.to) + Array.wrap(@mail.cc)
    end

    def subject
      @mail.subject
    end

    def headers
      @mail.header
    end

    def reference_id
      reference_id = headers['Reference-ID'].is_a?(Array) && headers['Reference-ID'].last.value
      reference_id ||= headers['Reference-ID'] && headers['Reference-ID'].value 
      reference_id ||= headers['References'] && headers['References'].value

      reference_id = headers['Message-ID'] if reference_id.blank? 
      reference_id
    end
    
    def attachments
      @mail.attachments
    end

  end
end
