class DisplayGraphTokensController < ApplicationController
  load_and_authorize_resource

  def generate_show_token
    @token = DisplayGraphToken.create(
      :display_graph_id => params[:display_graph],
      :permission_level => "show")

    respond_to do |format|
      format.json { render :json => { :url => process_access_token_url(@token.token) } }
    end
  end
  
  def generate_edit_token
    @token = DisplayGraphToken.create(
      :display_graph_id => params[:display_graph],
      :permission_level => "edit")

    respond_to do |format|
      format.json { render :json => { :url => process_access_token_url(@token.token) } }
    end
  end

  def process_token
    # this line is broken or the token create is broken
    @token = DisplayGraphToken.find_by_token(params[:token])
    unless @token.expired?
      DisplayGraphPermission.create(
        :user => current_user, 
        :display_graph => @token.display_graph, 
        :permission_level => @token.permission_level) 
    end

    respond_to do |format|
      format.html { redirect_to(display_graph_path(@token.display_graph), :notice => "You have been added to this display graph.") }
    end
  end
end
