class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: @message.content,
        user: @message.user.nickname,
        groupName: @message.group.name
      redirect_to group_path(id: params[:message][:group_id])
    else
      flash[:mess_error] = "There was an error sending the message. Try again"
      redirect_to group_path(id: params[:message][:group_id])
    end
  end

  def new_messages
    render json: Message.all
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :group_id, :content)
  end
end
