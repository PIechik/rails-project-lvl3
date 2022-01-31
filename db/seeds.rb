# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
%w[Hobby Animals Electronics Interior].each do |name|
  Category.create(name: name)
end
categories = Category.all
admin = User.create(name: Faker::Name.name, email: 'admin@example.com', admin: true)
5.times do
  bulletin = Bulletin.new(
    title: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    user_id: admin.id,
    category_id: categories.sample.id
  )
  bulletin.image.attach(io: File.open(Rails.root.join('app/assets/images/dog.jpeg')), filename: 'dog.jpeg', content_type: 'image/jpeg')
  bulletin.moderate
  bulletin.publish
  bulletin.save!
end
