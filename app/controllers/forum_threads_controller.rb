class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @threads = ForumThread.order(sticky_order: :asc).order(id: :desc).paginate(page: params[:page], per_page: 5)
    # render plain: @threads.inspect 
  end

  def show
    @thread = ForumThread.friendly.find(params[:id])
    @post = ForumPost.new
    @posts = @thread.forum_posts.paginate(per_page: 5, page: params[:page])
  end

  def new
    @thread = ForumThread.new
  end 

  def create
    # render plain: params.inspect
    @thread = ForumThread.new(resources_params)
    @thread.user = current_user
    if @thread.save
      redirect_to root_path
    else
      #  puts @thread.errors.full_messages
       render 'new'
    end
  end 

  def edit
    @thread = ForumThread.friendly.find(params[:id])
    authorize @thread
  end

  def update
    @thread = ForumThread.friendly.find(params[:id])
    authorize @thread
    if @thread.update(resources_params)
      redirect_to forum_thread_path(@thread)
    else
      render 'edit'
    end
  end

  def destroy
    @thread = ForumThread.friendly.find(params[:id]) 
    authorize @thread

    @thread.destroy 
    redirect_to root_path, notice: 'Thread berhasil dihapus'
  end

  def pinit 
    @thread = ForumThread.friendly.find(params[:id])
    @thread.pinit!
    redirect_to root_path
  end

  private

  def resources_params
    params.require(:forum_thread).permit(:title, :content)
  end
end