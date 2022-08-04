class UsersController < ApplicationController
   before_action :authenticate_user!

  def index
   @user = current_user
   @post_new = Post.new
   @users= User.all.where(is_deleted: false)
  end

  def show
    @user = User.find(params[:id])
    @post_new = Post.new
    @posts = Post.all.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
       redirect_to user_path(current_user.id)
    end
  end


#   def create
    # @book = Book.new(book_params)
    # @book.user_id = current_user.id
#   if @book.save
#       flash[:notice]= 'You have created book successfully.'
#     redirect_to books_path(@book.id)
#   else
#     @book_each=Book.all
#     render action: :index
#   end
#   end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
       flash[:update]='You have updated user successfully.'
       redirect_to user_path(@user.id)
    else
       @user_each=post.all
       render action: :edit
    end
  end

def  withdraw
     current_user.update(is_deleted: true)
     reset_session
     redirect_to root_path
end

def usubscribe
end


  private

  def user_params
    params.require(:user).permit(:name, :image,:introduction,:is_deleted)
  end

end

