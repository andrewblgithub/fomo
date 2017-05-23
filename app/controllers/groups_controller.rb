class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  # GET /groups
  def index
    @groups = current_user.groups 
    json_response(@groups)
  end

  # GET /groups/:id
  def show 
    json_response(@group)
  end

  # POST /groups
  def create
    @group = current_user.groups.create!(group_params)
    json_response(@group, :created)
  end

  # PUT /groups/:id
  def update
    @group.update(group_params)
    head :no_content
  end

  # DELETE /groups/:id
  def destroy
    @group.destroy
    head :no_content
  end

  private

  def group_params 
    params.permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
