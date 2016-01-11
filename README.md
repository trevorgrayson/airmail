# Airmail
Incoming Email Router.  Bringing you from SMTP text format straight through routing to a ruby controller. 
This project is looking to give you the tools to classify and handle incoming emails.

Set up routes, much like you would in Ruby on Rails.  Perhaps in /config/mail_routes.rb?

    Airmail.route do
      deliver AttachmentController if has_attachment?

      deliver DefaultEmailController
    end

A controller can look like:

    class DefaultEmailController < Airmail::Controller
      def receive
        logger.info("Email '#{subject}' received from #{from}")
      end
    end
    

Then receive emails!

    mail = <<EOF
    FROM: bob@thomas.com
    TO: anyone@yourdomain.com
    Subject: This is a great email!

    This is the body.
    EOF

    Airmail.receive( mail )
