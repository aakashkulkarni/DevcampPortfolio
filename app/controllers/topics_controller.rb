class TopicsController < ApplicationController
  before_action :set_topic
  skip_before_action :set_topic, only: [:index , :new, :create]
  before_action :set_sidebar_topics
  layout 'blog'
  
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    if logged_in?(:site_admin)
      @blogs = @topic.blogs.recent.page(params[:page]).per(5)
    else
      @blogs =  @topic.blogs.published.recent.page(params[:page]).per(5)
    end
  end
  
  def new
    @topic = Topic.new
  end
  
  def edit
  end
  
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'New topic created!' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @topic.destroy
    
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was deleted.' }
      format.json { head :no_content }
    end
  end
  
  private
  
    def set_sidebar_topics
      @side_bar_topics = Topic.with_blogs 
    end
    
    def topic_params
      params.require(:topic).permit(:title)
    end
    
    def set_topic
      @topic = Topic.find(params[:id])
    end
end

