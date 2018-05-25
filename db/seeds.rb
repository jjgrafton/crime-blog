require 'faker'

# User.create(first_name: Faker::Hipster.word, last_name: Faker::Hipster.word, email: "hipster@hipster.com", password: "123123", birthday: "1990-01-08" )

200.times do |index|
Post.create(title: Faker::Hipster.sentence(10), content: Faker::Hipster.paragraph(3), user_id: Faker::Number.between(1, 30))
end

30.times do |index|
    User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password, birthday: Faker::Date.birthday(18, 65) )
end

200.times do |index|
    Tag.create(name: Faker::Hipster.sentence(3))
    end