module SeedsServices
  class CreateMainbookEntries < ApplicationService
    def call
      @logger.info 'Processing Mainbook entries seed file'
      MainBook.destroy_all # destroy all mainbook entry data first
      @logger.info 'Deleted all data from Mainbook model'
      @user = User.all
      @user.each do |uid|
        entry_count = 0
        5.times do
          MainBook.create(user_id: uid.id, date_mainb: Time.zone.today, mainbook_description: "Payment for #{Faker::Appliance.equipment}", or_vat_reg_tin_mainb: Faker::Finance.vat_number, debit_mainb: Faker::Number.decimal(l_digits: 3, r_digits: 3), credit_mainb: Faker::Number.decimal(l_digits: 3, r_digits: 3))
          entry_count += 1
        end
      end
      @logger.info '10 Mainbook entries data created per user'
    end
  end
end
