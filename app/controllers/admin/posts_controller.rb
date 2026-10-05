class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.newest_first
  end

  def new
    @post = Post.new(published_on: Date.current)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "記事を公開しました。"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "記事を更新しました。"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy!
    redirect_to admin_posts_path, notice: "記事を削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.expect(post: %i[title body published_on])
  end
end
