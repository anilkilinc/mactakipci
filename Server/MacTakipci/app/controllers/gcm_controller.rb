class GcmController < ApplicationController
  def register
    @reg_id = params[:reg_id]
    @user = User.create :reg_id=>@reg_id
  end

  def send_message
  end
end
