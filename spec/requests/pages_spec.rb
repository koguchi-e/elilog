require "rails_helper"

RSpec.describe "Pages", type: :request do
  it "shows the profile page with SEO metadata" do
    get profile_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("elilogについて")
    expect(response.body).to include("<title>Profile | elilog</title>")
    expect(response.body).to include('name="description" content="elilogの運営者と、このブログで扱う内容の紹介です。"')
  end

  it "returns a 404 page for an unknown route" do
    get "/missing-page"

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include("ページが見つかりません")
  end
end
