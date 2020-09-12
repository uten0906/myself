class PostsController < ApplicationController
  before_action :login_required, except: [:index, :show]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts
    else
      @posts = Post.all
    end
    @posts = @posts.page(params[:page]).per(10)
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
      render "new"
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)
    if @post.save
      redirect_to @post, notice: "投稿を編集しました。"
    else
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
    flash[:notice] = "いいねをしました。"
    redirect_back(fallback_location: root_path)
  end

  def unlike
    current_user.liked_posts.destroy(Post.find(params[:id]))
    flash[:notice] = "いいねを削除しました。"
    redirect_back(fallback_location: root_path)
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
