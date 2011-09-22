class GraphsController < ApplicationController
  def new
    @graph = Graph.new
    # finish me
  end

  def create
    @graph = Graph.new(params[:graph])
    # finish me
  end
end
