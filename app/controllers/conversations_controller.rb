class ConversationsController < ApplicationController
  def index
    @conversations = policy_scope(Conversation)
    @current_conversation = current_conversation
    @message = Message.new
  end

  private

  def current_conversation
    Conversation.new(
      main_user: current_user, 
      other_user: current_correspondent
    )
  end
  
  def current_correspondent
    User.find_by_id(params[:user_id]) || current_user.messages.last.recipient if current_user.messages.last.present? || nil
  end
end