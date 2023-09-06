class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.new(post_params) # 何を新しく保存するか指定
    @post.user_id = current_user.id # 誰が投稿したかを指定
    if @post.save #もし保存ができたら
     redirect_to new_post_path  # 投稿画面に遷移
    else  # できなければ
     render :new  # newに遷移
    end
  end

  def new
   @post = Post.new
   @posts = Post.all
  end

  private  # ストロングパラメーター（予期しない値を変更されてしまう脆弱性を防ぐ機能）
  def post_params
   params.require(:post).permit(:title, :content)  # titleとbodyの変更を許可
  end
end
