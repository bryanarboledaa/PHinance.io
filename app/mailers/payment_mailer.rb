class PaymentMailer < ApplicationMailer
  def payment_notification
    @email = params[:email]
    mail(to: @email, subject: 'Thank you for your payment!')
  end

  def admin_payment_notification
    @admin_email = ENV['GMAIL_USERNAME']
    mail(to: @admin_email, subject: 'New payment from user')
  end
end
