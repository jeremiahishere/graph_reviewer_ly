class GraphsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.has_role?(:admin)
      @graphs = Graph.all
    else
      @graphs = Graph.by_user(current_user)
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @graph = Graph.new

    respond_to do |format|
      format.html
    end
  end

  def edit 
    @graph = Graph.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @graph = Graph.new(params[:graph])
    @graph.user = current_user

    respond_to do |format|
      if @graph.save
        format.html { redirect_to(@graph, :notice => "Create a graph") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
  end

  def destroy
  end
end
