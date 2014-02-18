namespace :db do
  desc "填充数据库数据"

  task populate: :environment do
    User.create!(name: "Yuez", 
                 email: "zgs225@gmail.com", 
                 password: "xxq665398", 
                 password_confirmation: "xxq665398")
    999.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      password = "password"

      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
