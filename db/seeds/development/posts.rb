body = "こんにちは"
%w(Taro Jiro Hana).each do |name|
  user = User.find_by(name: name)
  0.upto(4) do |idx|
    Post.create(
      user: user,
      body: body
    )
  end
end
