class MessagesController < ApplicationController
  before_action :set_group
  before_action :set_group_message, only: [:show, :update, :destroy]

  def index
    json_response(@group.messages)
  end

  def show
    json_response(@message)
  end

  def create
    @group.messages.create!(message_params)
    json_response(@group, :created)
  end

  def update
    @message.update(message_params)
    head :no_content
  end

  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params 
    params.permit(:content, :created_by)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_message
    @message = @group.messages.find_by!(id:params[:id]) if @group
  end
end
