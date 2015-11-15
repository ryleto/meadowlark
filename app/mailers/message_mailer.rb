class MessageMailer < ApplicationMailer
    default from: "Meadowlark <noreply@meadowlark.com>"
    default to: "Recipient Name <username@gmail.com>"

    def new_message(message)
        @message = message
        mail subject: "Message from #{message.name}"
    end
end
