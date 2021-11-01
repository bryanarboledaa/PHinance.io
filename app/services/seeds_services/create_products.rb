module SeedsServices
  class CreateProducts < ApplicationService
    def call
      @logger.info 'Processing ABC Tech Product'
      AbcProduct.destroy_all
      @logger.info 'Deleted all data from ABC Tech Products'
      entry_count = 0
      2.times do
        AbcProduct.create(product_name: Faker::Appliance.equipment, product_price: Faker::Number.binary(digits: 3), user_status: [true, false].sample)
        entry_count += 1
      end
      @logger.info 'ABC Tech Products created'
    end
  end
end
