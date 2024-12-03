class MessagesController < ApplicationController

    before_action :authenticate_user!  # ユーザーがログインしているか確認
  
    def index
      @receiver = User.find(params[:user_id])  # チャット相手のユーザーを取得
      @messages = Message.where(sender_id: current_user.id, receiver_id: @receiver.id)
                          .or(Message.where(sender_id: @receiver.id, receiver_id: current_user.id))
                          .order(:created_at)  # 現在のユーザーと相手のメッセージを取得
      @message = Message.new  # 新しいメッセージを作成
    end
  
    def create
      @receiver = User.find(params[:user_id])
      @message = current_user.sent_messages.build(message_params)  # 送信者を設定
      @message.receiver = @receiver  # 受信者を設定
  
      if @message.save
        redirect_to messages_path(user_id: @receiver.id)  # メッセージ送信後、チャット画面にリダイレクト
      else
        render :index  # エラーがあれば再度表示
      end
    end
  
    private
    def message_params
      params.require(:message).permit(:content)
    end
  
end
