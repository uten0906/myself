class PostsController < ApplicationController
  before_action :login_required, except: [:index, :show]

  def index
    @posts = Post.all
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: "投稿しました。"
    else
      flash.alert = "エラーがあります。"
      render "new"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    if params[:post][:remove_post_pictures]
      params[:post][:remove_post_pictures].each do |picture_id|
        picture = @post.post_pictures.find(picture_id)
        picture.purge
      end
    end
    if @post.save
      redirect_to @post, notice: "投稿を編集しました。"
    else
      flash.alert = "エラーがあります。"
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :posts, notice: "投稿を削除しました。"
  end

  def like
    @post = Post.find(params[:id])
    current_user.liked_posts << @post
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end

  def unlike
    @post = Post.find(params[:id])
    current_user.liked_posts.destroy(Post.find(params[:id]))
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_path)}
      format.js
    end
  end

  def liked
    @posts = current_user.liked_posts
  end

  private def post_params
    params.require(:post).permit(
      :user_id,
      :body,
      new_post_pictures: []
    )
  end
end
