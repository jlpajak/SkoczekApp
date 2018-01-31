module ApplicationCable
  class Connection < ActionCable::Connection::Base
    
    identified_by :current_player
    
    def connect
      self.current_player = find_current_user
    end
    
    def disconnect
      
    end
    
    protected
    
      def find_current_user
        if current_player = Player.find_by(id: cookies.signed[:player_id])
          current_player
        else
          reject_unauthorized_connection
        end
      end
    
  end
end
