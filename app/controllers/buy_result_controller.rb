class BuyResultController < ApplicationController
    def cart_view
        session[:login_id]=1
        uid=session[:login_id]
        @cart=[]
        #test_calc(uid)
        @users_cart=Cart.where(user_id: uid)
        @sum_price=0
        @users_cart.each do |u|
            @sum_price+=Product.find(u.product_id).price
            if not(@cart.include?(u.product_id))
               @cart.push(u.product_id)
            end
        end
        test_calc(@users_cart)
    end
    
    def cp_delete
        session[:login_id]=1
        uid=session[:login_id]
        x=Cart.where(user_id: uid)
        y=x.where(product_id: params[:d_id])
        y.destroy_all        
    end
    
    def buied
        session[:login_id]=1
        uid=session[:login_id]
        x=Cart.where(user_id: uid)
        
        x.each do |r|
        Purchased.create(user_id: r.user_id,seller_id: Product.find(r.product_id).seller_id,product_id: r.product_id)
        end
        
        x.destroy_all
    end
    
    def purchased_view
        @cart=[]
        session[:login_id]=1
        uid=session[:login_id]
        @users_cart=Purchased.where(user_id: uid)
        @users_cart.each do |u|
            if not(@cart.include?(u.product_id))
               @cart.push(u.product_id)
            end
        end
    end
    
    def seller_purchased_view
        @cart=[]
        session[:login_id]=5
        uid=session[:login_id]
        @sellers_cart=Purchased.where(seller_id: uid)
        #test_calc(@sellers_cart)
        @sellers_cart.each do |u|
            @su=@sellers_cart.where(user_id: u.user_id)
            #userごとの商品重複なしで追加
            @su.each do |s|
            if not(@cart.include?([s.user_id,u.product_id]))
               @cart.push([s.user_id,u.product_id])
            end
            end
            
        end
    end
    
    def seller_purchased_delete
        x=Purchased.where(seller_id: params[:sid])
        x1=x.where(user_id: params[:uid])
        x2=x1.where(product_id: params[:pid])
        test_calc(x2)
        x2.each do |t|
        t.seller_id=nil
        t.save
        end
    end
    
    def test_calc(p)
        puts '------------'
        puts p
        puts '------------'
    end
end
