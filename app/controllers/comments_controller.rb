class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      #redirect_to request.referer  #コメント送信後は、一つ前のページへリダイレクトさせる。
      #redirect_to @comment.post
    end
    @comments = current_user.comments.where(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end


end
