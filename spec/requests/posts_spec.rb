require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:older_post) { Post.create!(title: "古い記事", body: "古い本文", published_on: Date.new(2026, 9, 1)) }
  let!(:newer_post) { Post.create!(title: "新しい記事", body: "新しい本文", published_on: Date.new(2026, 10, 1)) }

  describe "GET /" do
    it "lists posts in published date descending order with SEO metadata" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("<title>elilog | 技術記事・学習記録・日記</title>")
      expect(response.body).to include('name="description" content="技術記事、学習記録、日記を新しい順に掲載する個人ブログです。"')
      expect(response.body.index(newer_post.title)).to be < response.body.index(older_post.title)
    end
  end

  describe "GET /posts/:id" do
    it "shows a post and derives its description from the body" do
      get post_path(newer_post)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(newer_post.title, newer_post.body)
      expect(response.body).to include("<title>#{newer_post.title} | elilog</title>")
      expect(response.body).to include('name="description" content="新しい本文"')
    end

    it "returns 404 for a missing post" do
      get post_path(0)

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("ページが見つかりません")
    end
  end
end
