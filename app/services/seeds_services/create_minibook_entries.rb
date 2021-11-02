module SeedsServices
  class CreateMinibookEntries < ApplicationService
    def call
      @logger.info 'Processing Minibook Entries seed file'
      MinibookEntry.destroy_all
      @logger.info 'Deleted all data from Minibook Entries'
      @minibook = MiniBook.all
      @minibook.each do |book|
        entry_count = 0
        3.times do
          MinibookEntry.create(user_id: book.user_id, mini_book_id: book.id, date_minib_entry: Time.zone.today, minibook_entry_description: "Payment for #{Faker::Appliance.equipment}", or_vat_reg_tin_minib: Faker::Finance.vat_number, debit_minib: Faker::Number.decimal(l_digits: 3, r_digits: 3), credit_minib: Faker::Number.decimal(l_digits: 3, r_digits: 3))
          entry_count += 1
        end
      end
      @logger.info '10 Mainbook entries data created'
    end
  end
end
