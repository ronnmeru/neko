class PostsController < ApplicationController
  before_action :authenticate_user!

 def top
 end

 def index
   @post_new = Post.new
   @post = @search_post || Post.all.page(params[:page]).per(5)
   @user = current_user
   @tags = ActsAsTaggableOn::Tag.all
    # タグの一覧表示

   if params[:tag]
      @post = Post.tagged_with(params[:tag]).page(params[:page]).per(10)
      # タグ検索時にそのタグずけしているものを表示
   else
      @post = @search_post.page(params[:page]).per(5) || Post.all.page(params[:page]).per(5)
   end


 end


  def new
      @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @user = current_user
   if @post.save
    flash[:notice]= 'You have created book successfully.'
     redirect_to posts_path
   else
    render action: :show
   end
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @user = current_user
    if  @post.update(post_params)
       flash[:update]='You have updated book successfully.'
       redirect_to post_path(@post.id)
    else
       render action: :edit
    end
  end

  def show
   @user_id = current_user
   @post = Post.find(params[:id])
   @post_new = Post.new
   @user = @post.user
   @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
   @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end



  def edit
    @post=Post.find(params[:id])
    if @post.user != current_user
       redirect_to  post_path(@post.id)
    end
  end

  def destroy
   @post=Post.find(params[:id])
   @post.destroy
   redirect_to posts_path
  end



  private

  def post_params
    params.require(:post).permit(:title,:content,:image,:tag_list).merge(user_id: current_user.id)
  end
end
