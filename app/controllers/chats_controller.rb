class ChatsController < ApplicationController
  before_action :set_group
  before_action :set_group_chat, only: [:show, :update, :destroy]

  def index
    json_response(@group.chats)
  end

  def show
    json_response(@chat)
  end

  def create
    @group.chats.create!(chat_params)
    json_response(@group, :created)
  end

  def update
    @chat.update(chat_params)
    head :no_content
  end

  def destroy
    @chat.destroy
    head :no_content
  end

  private

  def chat_params 
    params.permit(:content, :created_by)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_chat
    @chat = @group.chats.find_by!(id:params[:id]) if @group
  end
end
