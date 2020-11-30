#body = "今日はカフェに行ってきました！"
#%w(Taro Hana Satoshi).each do |name|
#  user = User.find_by(name: name)
#  0.upto(4) do |idx|
#    Post.create(
#      user: user,
#      body: body
#    )
#  end
names = %w(Yuma Taro Hana Yujiro Satoshi Kumi Kosuke Akira Mari Takashi)
bodies = %W(今日はカフェに行ってきました。
          これから仕事に向かいます！
          昨日から体調が悪いので、今日は病院に行きます。
          天気が良いので、外へ遊びに行きたい！
          明日のサッカーの試合はどちらが勝つだろうか？
          本を読むことはとても勉強になりますね。
          新型のパソコンの調子が良いです！作業が捗ります！
          満員電車で通勤中。
          今日は資格の合否発表があります。受かっていると願います。
          ライブチケットが当たりました！)
0.upto(9) do |idx|          
  Post.create(
    user: User.find_by(name: names[idx]),
    body: bodies[idx]
  )
end
