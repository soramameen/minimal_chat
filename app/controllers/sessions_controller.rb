class SessionsController < ApplicationController
  def create
    session[:user_name] = params[:user_name]
    redirect_to messages_path
  end
end
