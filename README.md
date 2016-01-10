# airmail
Incoming Email Router

    Airmail.route do
      deliver AttachmentController if has_attachment?

      deliver DefaultEmailController
    end

Controller can look like

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
