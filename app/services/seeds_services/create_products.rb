module SeedsServices
  class CreateProducts < ApplicationService
    def call
      @logger.info 'Processing ABC Tech Product'
      AbcProduct.destroy_all
      @logger.info 'Deleted all data from ABC Tech Products'

      AbcProduct.create(product_name: 'Minibooks')

      @logger.info 'ABC Tech Products created'
    end
  end
end
