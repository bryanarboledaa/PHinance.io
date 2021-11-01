module SeedsServices
  class CreateUsers < ApplicationService
    def call
      @logger.info 'Processing Users seed file'
      User.destroy_all # destroy all user data first
      Faker::Name.unique.clear
      @logger.info 'Deleted all data from User model'
      user_count = 0
      5.times do
        user = User.create(email: "dummy_user+#{user_count}@abc.com", password: "abc12345#{user_count}", full_name: Faker::Name.unique.name, username: "abctech_#{user_count}", company: Faker::Company)
        user_count += 1
        user.skip_confirmation!
        user.save!
      end
      @logger.info '10 user data created'
    end
  end
end
