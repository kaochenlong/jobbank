# frozen_string_literal: true

desc '產生測試用履歷'
namespace :data do
  task generate_resume: :environment do
    puts 'Generating Dummy Resumes...'
    user = User.create(
      email: Faker::Internet.email,
      password: 'password',
      birthday: 20.years.ago
    )

    5.times do
      Resume.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        tel: Faker::PhoneNumber.cell_phone,
        intro: Faker::Lorem.paragraph(sentence_count: 3),
        user:
      )
    end
    puts 'Done!'
  end
end
