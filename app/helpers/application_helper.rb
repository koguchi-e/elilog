module ApplicationHelper
  def page_description
    content_for?(:description) ? content_for(:description) : "技術記事、学習記録、日記を記す個人ブログです。"
  end

  def post_description(post)
    post.body.squish.truncate(120)
  end
end
