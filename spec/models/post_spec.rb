require "rails_helper"

RSpec.describe Post, type: :model do
  subject(:post) { described_class.new(title: "記事", body: "本文", published_on: Date.current) }

  it "is valid with a title, body, and published date" do
    expect(post).to be_valid
  end

  %i[title body published_on].each do |attribute|
    it "requires #{attribute}" do
      post.public_send("#{attribute}=", nil)

      expect(post).to be_invalid
      expect(post.errors[attribute]).to include("can't be blank")
    end
  end

  it "orders posts by newest published date first" do
    older = described_class.create!(title: "古い記事", body: "本文", published_on: Date.new(2026, 9, 1))
    newer = described_class.create!(title: "新しい記事", body: "本文", published_on: Date.new(2026, 10, 1))

    expect(described_class.newest_first).to eq([newer, older])
  end
end
