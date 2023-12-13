class ApplicationController < ActionController::Base
private
    def current_user
        if session[:login_uid]
            User.find_by(uid: session[:login_uid])
        end
    end
    helper_method :current_user
    
    def current_seller
        if session[:login_sid]
            Seller.find_by(sid: session[:login_sid])
        end
    end
    helper_method :current_seller
    
    def current_admin
        if session[:login_aid]
            Admin.find_by(aid: session[:login_aid])
        end
    end
    helper_method :current_admin
end
