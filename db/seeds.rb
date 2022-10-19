# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "abc@abc",
  password: "naganocake"
)

10.times do |n|
  Genre.create!(
    name: "ジャンルテスト#{n + 1}",
  )
end

10.times do |n|
  Item.create!(
    genre_id: n + 1,
    name: "商品テスト#{n + 1}",
    introduction: "おいしいよ",
    price: 1000 + (n * 6),
    is_active: true
  )
end

10.times do |n|
  Customer.create!(
    email: "test#{n + 1}@example.com",
    last_name: "test",
    first_name: "#{n + 1}",
    last_name_kana: "テスト",
    first_name_kana: "スウジ",
    postal_code: "200-20#{n + 1}",
    address: "aaaaa",
    telephone_number: "000-000-00#{n+1}",
    is_deleted: false,
    password: "naganocake"
  )
end