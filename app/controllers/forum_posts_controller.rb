class ForumPostsController < ApplicationController
  def create
    # render plain: params.inspect
    @thread = ForumThread.find(params[:forum_thread_id])
    @post = ForumPost.new(resources_params)
    
    @post.forum_thread = @thread
    @post.user = User.first
    @post.save

    redirect_to forum_thread_path(@thread)
  end

  private

  def resources_params
    params.require(:forum_post).permit(:content)
  end

end