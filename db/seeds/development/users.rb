names = %w(Yuma Taro Hana Yujiro Satoshi Kumi Kosuke Akira Mari Takashi)
0.upto(9) do |idx|
  User.create(
    name: names[idx],
    email: "#{names[idx]}@example.com",
    birthday: "1990-12-01",
    sex: [1, 1, 2][idx % 3],
    password: "myself!",
    password_confirmation: "myself!",
    administrator: (idx == 0)
  )
end
