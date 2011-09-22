class DisplayGraphsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.has_role?(:admin)
      @display_graphs = DisplayGraph.all
    else
      @display_graphs = DisplayGraph.by_permissions(current_user)
    end

    respond_to do |format|
      format.html
    end
  end

  def new
    @display_graph = DisplayGraph.new

    respond_to do |format|
      format.html
    end
  end
  
  def create
    @display_graph = DisplayGraph.new(params[:display_graph])

    respond_to do |format|
      if @display_graph.save
        format.html { redirect_to(@display_graph, :notice => "Created a display graph") }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
