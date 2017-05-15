class EventsController < ApplicationController
  before_action :set_group
  before_action :set_group_event, only: [:show, :update, :destroy]

  def index
    json_response(@group.events)
  end

  def show
    json_response(@event)
  end

  def create
    @group.events.create!(event_params)
    json_response(@group, :created)
  end

  def update
    @event.update(event_params)
    head :no_content
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def event_params 
    params.permit(:title, :description, :created_by, :expires_at)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_event
    @event = @group.events.find_by!(id:params[:id]) if @group
  end
end
