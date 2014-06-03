class ChatMessagesController < ApplicationController

  def create
    @chat_message = ChatMessage.create chat_params.merge(:user => current_user)
  end

  def chat_params
    params.require(:chat_message).permit(:body)
  end

end
