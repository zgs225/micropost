namespace :db do
  desc "填充数据库数据"

  task populate: :environment do
    make_users
    make_posts
    make_relationships
  end

  def make_users
    puts "生成管理员用户……"
    User.create!(name: "Yuez", 
                 email: "zgs225@gmail.com", 
                 password: "xxq665398", 
                 password_confirmation: "xxq665398",
                 admin: true)
    puts "完成"

    puts "生成用户……"
    999.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email
      password = "password"

      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    puts "完成"
  end

  def make_posts
    puts "生成测试微博……"
    users = User.all limit: 150
    users.each do |user|
      rand(200).times do
        user.posts.create!(content: Faker::Lorem.sentence(5))
      end
    end
    puts "完成"
  end

  def make_relationships
    puts "生成用户关系"
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end
end
