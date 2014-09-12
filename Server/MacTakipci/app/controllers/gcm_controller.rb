class GcmController < ApplicationController
  def register
    @regid = params[:regid]
    @user = User.create :gcm_regid=>@regid
  end

  def send_message
  end

  def list
    @devices = User.all
  end

  def new

  end
end
