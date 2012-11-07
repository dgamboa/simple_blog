class ArticlesController < ApplicationController
  before_filter :load_article
  before_filter :title_upcase, :only => [:index]
  around_filter :error

  # GET /articles
  # GET /articles.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    raise "My little error"
    @article  = Article.includes(:comments).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private

  def load_article
    @article = Article.find(params[:id]) if params[:id]
  end

  def title_upcase
    @articles = Article.all

    @articles.each do |article|
      article.title = article.title.upcase
    end
  end

  def error
    begin
      yield
    rescue Exception => e
      flash[:notice] = "Sorry, #{e} was received for action #{params[:action]}"
      unless params[:action] == 'index'
        redirect_to :action => 'index'
      else
        render :action => 'index'
      end
    end
  end
end
