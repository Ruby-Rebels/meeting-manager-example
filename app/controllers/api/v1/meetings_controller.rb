class Api::V1::MeetingsController < ApplicationController
  def index
    @meetings = Meeting.all
  end

  def create
    @meeting = Meeting.new(
      name: params[:name],
      address: params[:address],
      start_time: params[:start_time],
      end_time: params[:end_time],
      notes: params[:notes]
    )
    if @meeting.save
      # params[:tag_ids].each do |tag_id|
      #   MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
      # end
      render json: {success: "Meeting was created!"}
    else
      render json: {error: @meeting.errors.full_messages}, status: 422
    end

  end
end
