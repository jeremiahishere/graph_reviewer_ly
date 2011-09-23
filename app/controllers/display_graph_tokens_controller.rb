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
end
