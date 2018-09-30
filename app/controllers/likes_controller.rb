class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.like @micropost
    respond_to do |format|
      format.html { redirect_back_or root_url }
      format.js
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    current_user.unlike @micropost
    respond_to do |format|
      format.html { redirect_back_or root_url }
      format.js
    end
  end
end
