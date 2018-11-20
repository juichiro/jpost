class ToppagesController < ApplicationController
  def index
    @post = current_user.posts.build 
    @posts = current_user.posts.order('created_at DESC').page(params[:page])
  end
end
