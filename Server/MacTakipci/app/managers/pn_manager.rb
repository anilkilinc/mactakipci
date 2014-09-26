class PnManager

  def self.send_notification push_token,platform,notification
    if !(Rails.env.production? || Rails.env.staging?)
      return
    end
    if platform == 'ios'
      if Rails.env.production?
        APNS.host = 'gateway.push.apple.com'
        APNS.pem  = 'config/GongProduction.pem'
        APNS.pass = 'gongproduction2014'
      else
        APNS.host = 'gateway.sandbox.push.apple.com'
        APNS.pem  = 'config/GongStaging.pem'
        APNS.pass = 'gongstaging'
      end
      APNS.send_notification(push_token, notification)
    elsif platform == 'android'
      GCM.host = 'https://android.googleapis.com/gcm/send'
      GCM.format = :json
      GCM.key = "AIzaSyBbdwlKFfzJyh8puufGUaYXQX3UxYLWNEg"
      destination = [push_token]
      GCM.send_notification( destination, notification)
    end
  end

  #ANIL
  def self.send push_token, notification
    GCM.host = 'https://android.googleapis.com/gcm/send'
    GCM.format = :json
    GCM.key = "AIzaSyBbdwlKFfzJyh8puufGUaYXQX3UxYLWNEg"
    destination = [push_token]
    GCM.send_notification( destination, notification)
  end

  def self.gcm_test user_id
    #get push token from user id
    user = User.find(user_id)
    gcm_id = user.gcm_regid
    PnManager.send gcm_id, {
        :team => 'Galata',
        :league => 'CL 2014',
        :type => 'test'
    }
  end
  #ANIL


  def self.truncate_message message
    if message
      length = 100

      if message.length <= length
        return message
      else
        return message[0..(length-4)] + "..."
      end
    end
  end


  def self.send_organization_predefined_notification user_id, organization_name
    auth = Authentication.where(:user_id=>user_id).last
    if auth == nil
      return false
    elsif auth.platform == 'ios'
      puts "Sending iOS notification" if !Rails.env.test?
      other = {
        :other=>{
          'aps'=>{
            'alert' => {
              'loc-key' => 'ORGANIZATION_PREDEFINED',
              'loc-args' => [organization_name]
            },
            'sound' => 'Calypso.caf',
            'content-available' => 1
          }
        }
      }
      PNManager.send_notification auth.push_token,auth.platform,other
      puts "iOS Notification sent with #{other.to_json}" if !Rails.env.test?
      return true
    elsif auth.platform == 'android'
      puts "Sending Android notification" if !Rails.env.test?
      PNManager.send_notification auth.push_token,auth.platform,{
        :message=>self.truncate_message("'#{organization_name}' predefined you")
      }
      puts "Android Notification sent" if !Rails.env.test?
      return true
    end
  end

  def self.send_contact_registered_notification user_id,contact_name
    auth = Authentication.where(:user_id=>user_id).last
    if auth == nil
      return false
    elsif auth.platform == 'ios'
      puts "Sending iOS notification" if !Rails.env.test?
      other = {
        :other=>{
          'aps'=>{
            'alert' => {
              'loc-key' => 'CONTACT_REGISTERED_TEXT',
              'loc-args' => [contact_name.to_s]
            },
            'sound' => 'Calypso.caf',
            'content-available' => 1
          }
        }
      }
      PNManager.send_notification auth.push_token,auth.platform,other

      puts "iOS Notification sent with #{other.to_json}" if !Rails.env.test?
      return true
    elsif auth.platform == 'android'
      puts "Sending Android notification" if !Rails.env.test?
      PNManager.send_notification auth.push_token,auth.platform,{
        :message=>self.truncate_message("Your contact '#{contact_name}' joined to gong")
      }
      puts "Android Notification sent" if !Rails.env.test?
      return true
    end
  end

  def self.send_new_message_notification send_to
    auth = Authentication.where(:user_id=>send_to.receiver_id).last
    if auth == nil
      return false
    else
      sender_name = send_to.message.sender.full_name ? send_to.message.sender.full_name : send_to.message.sender.phone
      sender_key = send_to.message.message_type == 'group' ? 'gid' : 'sid'
      sender_id = send_to.message.message_type == 'group' ? send_to.message.group.id : send_to.message.sender_id
      new_message_count = Message.get_new_messages_for_user(send_to.receiver).count
      if auth.platform == 'ios'
        puts "Sending iOS notification" if !Rails.env.test?
        # puts "Text:#{send_to.message.text} Sender:#{sender_name} To:#{send_to.receiver.full_name}"
        if send_to.message.attachment.exists?
          loc_key = send_to.message.message_type == 'group' ? 'IMAGE_PUSH_GROUP' : 'IMAGE_PUSH'
          loc_args = send_to.message.message_type == 'group' ? [sender_name,send_to.message.group.name] : [sender_name]
          alert = {
              "loc-key" => loc_key,
              "loc-args" => loc_args
          }
        else
          alert = self.truncate_message("#{sender_name}: #{send_to.message.text}")
        end
        PNManager.send_notification auth.push_token,auth.platform,{
            :other=>{
                'aps'=>{
                    'alert'=>self.truncate_message(alert),
                    'badge'=>new_message_count,
                    'sound' => 'Calypso.caf',
                    'content-available' => 1,
                    sender_key => sender_id
                }
            }
        }
        puts "iOS Notification sent" if !Rails.env.test?
        return true
      elsif auth.platform == 'android'
        if send_to.message.attachment.exists?
          has_attachment = true
          attachment_type = send_to.message.attachment_type
        else
          has_attachment = false
          attachment_type = nil
        end
        puts "Sending Android notification" if !Rails.env.test?
        PNManager.send_notification auth.push_token,auth.platform, {
            :sender=>send_to.message.sender.to_json(:for_user => send_to.message.sender),
            sender_key => sender_id,
            :message=>self.truncate_message(send_to.message.text),
            :badge=>new_message_count,
            :has_attachment => has_attachment,
            :attachment_type => attachment_type
        }
        puts "Android Notification sent" if !Rails.env.test?
        return true


      end

    end



  end


  def self.send_silent_push_for_refresh user_id

    auth = Authentication.where(:user_id=>user_id).last
    if auth == nil
      return false
    elsif auth.platform == 'ios'
      puts "Sending iOS silent push notification" if !Rails.env.test?
      PNManager.send_notification auth.push_token,auth.platform,{
        :other=>{
          'aps'=>{
            'sound' => '',
            'content-available' => 1
          }
        }
      }
      puts "iOS Notification sent" if !Rails.env.test?
      return true
    elsif auth.platform == 'android'
      puts "Sending Android notification" if !Rails.env.test?
      PNManager.send_notification auth.push_token,auth.platform,{
        :type => 'silent_push'
      }
      puts "Android Notification sent" if !Rails.env.test?
      return true
    end

  end

end
