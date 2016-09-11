class MeetingsController < ApplicationController
  def index
    if params[:tag]
      @meetings = Tag.find_by(name: params[:tag]).meetings
    else
      @meetings = Meeting.all
    end
    render 'index.html.erb'
  end

  def new
    @meeting = Meeting.new(start_time: DateTime.current, end_time: 1.hour.from_now)
    render 'new'
  end

  def show
    @meeting = Meeting.find_by(id: params[:id])
    render 'show.html.erb'
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
      params[:tag_ids].each do |tag_id|
        MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
      end
      flash[:success] = "Meeting was successfully saved!"
      redirect_to "/meetings"
    else
      flash[:error] = "Sorry, the meeting couldn't be saved"
      render 'new'
    end
  end

  def edit
    @meeting = Meeting.find_by(id: params[:id])
    render 'edit'
  end

  def update
    @meeting = Meeting.find_by(id: params[:id])
    if @meeting.update(
        name: params[:name],
        address: params[:address],
        start_time: params[:start_time],
        end_time: params[:end_time],
        notes: params[:notes]
      )
      @meeting.tags.destroy_all
      params[:tag_id].each do |tag_id|
        MeetingTag.create(meeting_id: @meeting.id, tag_id: tag_id)
      end
      flash[:success] = "Meeting was updated!"
      redirect_to "/meetings/#{@meeting.id}"
    else
      flash[:error] = "Meeting was not updated"
      render 'edit'
    end

  end
end
