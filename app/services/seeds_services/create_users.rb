module SeedsServices
  class CreateUsers < ApplicationService
    def call
      @logger.info 'Processing Users seed file'
      User.destroy_all # destroy all user data first
      Faker::Name.unique.clear
      @logger.info 'Deleted all data from User model'
      user_count = 0
      15.times do
        user = User.create(email: "#{Faker::Internet.email}+#{user_count}", password: "abc12345#{user_count}", full_name: Faker::Name.unique.name, username: "abctech_#{user_count}", company: Faker::Company.name, status: [0, 1].sample)
        user_count += 1
        user.skip_confirmation!
        user.save!
      end
      @logger.info '15 user data created'
    end
  end
end
