posts = [
  { title: "個人ブログをはじめます", published_on: Date.new(2026, 10, 5), body: "学んだことや日々の考えを、自分の言葉で残すためにブログをはじめました。\n\n小さな発見も、あとで振り返れば次の一歩につながるはずです。" },
  { title: "学習を続けるために意識していること", published_on: Date.new(2026, 10, 1), body: "一度に多くを進めようとせず、毎日少しでもコードに触れるようにしています。\n\n記録を残すことで、昨日の自分より進めたことを確認できます。" },
  { title: "Railsで小さく作りはじめる", published_on: Date.new(2026, 9, 28), body: "最初から機能を増やしすぎず、まずは動く最小の形を作る。そこから必要なものを見極めて足していくことを大切にしています。" }
]

posts.each do |attributes|
  Post.find_or_initialize_by(title: attributes[:title]).update!(attributes)
end
