class DisplayGraphTokensController < ApplicationController
  load_and_authorize_resource

  def generate_show_token
    @token = DisplayGraphToken.create(
      :display_graph_id => params[:display_graph_id],
      :permission_level => "show")

    respond_to do |format|
      format.json { render :json => { :url => process_access_token_url(@token.token) } }
    end
  end
  
  def generate_edit_token
    @token = DisplayGraphToken.create(
      :display_graph_id => params[:display_graph_id],
      :permission_level => "edit")

    respond_to do |format|
      format.json { render :json => { :url => process_access_token_url(@token.token) } }
    end
  end

  def process_token
    @token = DisplayGraphToken.find_by_token(params[:token])
    unless @token.expired?
      perm = DisplayGraphPermission.find_or_create_by_user_id_and_display_graph_id(
        :user => current_user, 
        :display_graph => @token.display_graph)
      perm.permission_level = @token.permission_level
      perm.save
    end

    respond_to do |format|
      format.html { redirect_to(interact_display_graph_path(@token.display_graph), :notice => "You have been added to this display graph.") }
    end
  end

  # gets the full graph structure through in a json object
  def get_graph_structure
    @display_graph = DisplayGraph.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => @display_graph.to_json }
    end
  end

  # sets position information about the nodes and connections of the graph
  # does not add or remove nodes (for now)
  def set_graph_structure
    @display_graph = DisplayGraph.find(params[:id])

    respond_to do |format|
      if @display_graph.update_positions(params[:data])
        format.json { render :json => { :status => "success" } }
      else
        format.json { render :json => { :status => "failure" } }
      end
    end
  end
end
