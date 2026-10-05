require "rails_helper"

RSpec.describe "Admin::Posts", type: :request do
  around do |example|
    original_password = ENV["ADMIN_PASSWORD"]
    ENV["ADMIN_PASSWORD"] = "test-password"
    example.run
  ensure
    ENV["ADMIN_PASSWORD"] = original_password
  end

  def log_in
    post admin_login_path, params: { password: "test-password" }
  end

  it "redirects an unauthenticated visitor to the login page" do
    get admin_posts_path

    expect(response).to redirect_to(admin_login_path)
  end

  it "logs in and creates an article" do
    log_in
    expect(response).to redirect_to(admin_posts_path)

    expect {
      post admin_posts_path, params: {
        post: { title: "管理画面からの記事", body: "本文です", published_on: "2026-10-05" }
      }
    }.to change(Post, :count).by(1)

    expect(response).to redirect_to(admin_posts_path)
    expect(Post.last).to have_attributes(title: "管理画面からの記事", body: "本文です", published_on: Date.new(2026, 10, 5))
  end

  it "re-renders the form and keeps submitted values when validation fails" do
    log_in

    post admin_posts_path, params: {
      post: { title: "下書きの題名", body: "", published_on: "2026-10-05" }
    }

    expect(response).to have_http_status(:unprocessable_content)
    expect(response.body).to include("下書きの題名", "入力内容を確認してください。")
    expect(response.body).to include('value="2026-10-05"')
  end

  it "updates and deletes an article" do
    post = Post.create!(title: "変更前", body: "古い本文", published_on: Date.new(2026, 10, 1))
    log_in

    patch admin_post_path(post), params: {
      post: { title: "変更後", body: "新しい本文", published_on: "2026-10-02" }
    }
    expect(response).to redirect_to(admin_posts_path)
    expect(post.reload).to have_attributes(title: "変更後", body: "新しい本文", published_on: Date.new(2026, 10, 2))

    expect { delete admin_post_path(post) }.to change(Post, :count).by(-1)
    expect(response).to redirect_to(admin_posts_path)
  end
end
