class PaymentMailer < ApplicationMailer
  def payment_notification
    @email = params[:email]
    mail(to: @email, subject: 'Thank you for subscribing to our application')
  end

  def admin_payment_notification
    @link = 'https://phinance-io-abc-tech.herokuapp.com/admins/sign_in'
    @admin_email = ENV['GMAIL_USERNAME']
    mail(to: @admin_email, subject: 'Minibooks subscription payment')
  end
end
