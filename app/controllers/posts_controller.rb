class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '正常に投稿されました'
      redirect_to root_url
    else
      @posts = current_user.posts.order('created_at DESC').page(params[:page])#トップページからこっちに移る際に@postsのなかのデータ転送されないのでもう一度取得している。
      flash.now[:danger] ='投稿に失敗しました'
      render 'toppages/index.html.erb'
    end 
    
  end

  def destroy
    @post.destroy
    flash[:success]='削除に成功しました'
    redirect_back(fallback_location: root_path)
  end
 
 
 
  private
  def post_params
    params.require(:post).permit(:content)
  end
  def correct_user
  @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end 
  end 
end

