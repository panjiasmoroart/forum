class ForumThreadsController < ApplicationController
  def index
    @threads = ForumThread.order(id: :desc)
    # render plain: @threads.inspect 
  end

  def show
    @thread = ForumThread.find(params[:id])
    @post = ForumPost.new
  end

  def new
    @thread = ForumThread.new
  end 

  def create
    # render plain: params.inspect
    @thread = ForumThread.new(resources_params)
    @thread.user = User.first
    if @thread.save
      redirect_to root_path
    else
      #  puts @thread.errors.full_messages
       render 'new'
    end
   
  end 

  private

  def resources_params
    params.require(:forum_thread).permit(:title, :content)
  end
end