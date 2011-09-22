class DisplayGraphsController < ApplicationController
  load_and_authorize_resource

  before_filter :check_show_permission, :only => [ :show, :interact ]
  before_filter :check_edit_permission, :only => [ :edit, :display ]
  before_filter :check_full_permission, :only => [ :destroy ]

  def check_show_permission
    @display_graph = DisplayGraph.find(params[:id])
    if !@display_graph.has_permission?(current_user, "show")
      redirect_to display_graphs_path, :notice => "You do not have enough permissions to view this page"
    end
  end

  def check_edit_permission
    @display_graph = DisplayGraph.find(params[:id])
    if !@display_graph.has_permission?(current_user, "edit")
      redirect_to display_graphs_path, :notice => "You do not have enough permissions to view this page"
    end
  end

  def check_edit_permission
    @display_graph = DisplayGraph.find(params[:id])
    if !@display_graph.has_permission?(current_user, "full")
      redirect_to display_graphs_path, :notice => "You do not have enough permissions to view this page"
    end
  end

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

  def show
    @display_graph = DisplayGraph.find(params[:id])

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

  def edit 
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  def create
    @display_graph = DisplayGraph.new(params[:display_graph])
    @display_graph.user = current_user

    respond_to do |format|
      if @display_graph.save
        format.html { redirect_to(@display_graph, :notice => "Created a display graph") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      if @display_graph.update_attributes(params[:display_graph])
        format.html { redirect_to(@display_graph, :notice => "Updated a display graph") }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @display_graph = DisplayGraph.find(params[:id])
    @display_graph.destroy

    respond_to do |format|
      format.html { redirect_to(display_graphs_url) }
    end
  end

  def edit_display
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update_display
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      if @display_graph.update_attributes(params[:display_graph])
        format.html { redirect_to(@display_graph, :notice => "Updated a display") }
      else
        format.html { render :action => "edit_display" }
      end
    end
  end

  def interact
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
