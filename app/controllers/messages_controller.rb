class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages/1/edit
  def edit
  end

  # POST /rooms/:room_id/messages
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user_name = session[:user_name]

    respond_to do |format|
      if @message.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_message",
            partial: "messages/form",
            locals: { message: Message.new, room: @room }
          )
        end
        format.html { redirect_to @room }
      else
        # We need to render the room show page, but we need @messages for it
        @messages = @room.messages
        format.html { render "rooms/show", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message.room, notice: "Message was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  def destroy
    @room = @message.room
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to @room, notice: "Message was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :content ])
    end
end
