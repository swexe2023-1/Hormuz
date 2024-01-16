class SerchProductController < ApplicationController
    def serch
        session[:serch_target]=params[:major_id]
        gen_target(session[:serch_target])
    end
    
    def serch_result
        x=Category.where(key_word: Major.find(params[:major_id]).jid)
        rs=[]
        x.each do |r|
            rs.push(r.product_id)
        end
        ch=[]
        if params[:checks]!=nil
        params[:checks].each do |r|
            if r[1]=="1"
                s=Category.find_by(key_word: Minor.find(r[0]).nid)
                if s!=nil
                if rs.include?(s.product_id)
                ch.push(s.product_id)
                end
                end
            end
        end
        
        end
        maney_range=[]
        another_range=[]
        
        if params[:upper_range]!=nil
        params[:upper_ranges].each do |r|
            if Minor.find(r[0].to_i).nid=='価格範囲'
                params[:upper_ranges].each do |n|
                    params[:lower_ranges].each do |t|
                        if n[0]==t[0]
                            n[1]=upper_nil_check(n[1])
                            t[1]=under_nil_check(t[1])
                            rs.each do |k|
                                m=Product.find(k).price
                                if m<=n[1].to_i && m>=t[1].to_i
                                    maney_range.push(k)
                                end
                            end
                        end
                    end
                end
            elsif Minor.find(r[0].to_i).nid!='' || Minor.find(r[0].to_i).nid!=nil
                x=Category.all
                x.each do |k|
                    if k.key_word =~ /\A[0-9]+\z/
                        params[:upper_ranges].each do |r|
                        params[:lower_ranges].each do |t|
                            r[1]=upper_nil_check(r[1])
                            t[1]=under_nil_check(t[1])
                            if k.key_word.to_i<=r[1].to_i && k.key_word.to_i>=t[1].to_i && rs.include?(k.product_id)
                            another_range.push(k.product_id)
                            end
                        end
                        end
                    end
                end
            end
        #Minor.find(params[:upper_ranges][0][0].to_i)
    end
    
    if another_range!=[] && maney_range!=[]
    another_range.each do |an|
        if maney_range.include?(an)
            ch.push(an)
        end
    end
    elsif another_range==[]
           maney_range.each do |k|
               ch.push(k)
           end
    end
    if maney_range==[]
        ch=[]
    end
    
    else
    rs.each do |r|
        ch.push(r)
    end
    end
    
    
    
    if params[:input_keyword]!=''
        keywords=params[:input_keyword].split(' ')
        key_array=[]
        keywords.each do |k|
            c=Category.find_by(key_word: k)
            if c!=nil
            key_array.push(c.product_id)
            end
        end
        ch=[]
        key_array.each do |k|
            rs.include?(k)
            ch.push(k)
        end
        
    end
    
        session[:result]=ch.uniq
        
    end
    def category_view
        session[:edit_id]=nil
        @all_major=Major.all
        if(params[:nc]!=nil && @all_major.find_by(jid: params[:nc])==nil)
            Major.create(jid: params[:nc])
            redirect_to '/serch_product/category_view'
        end
    end
    
    def category_all_delete
        Major.find(params[:m_id]).destroy
        mid=Middle.where(major_id: params[:m_id])
        if mid.size<0
        else
            mid.each do |d|
                delete_middles(d)
                d.destroy
            end
        end
        redirect_to '/serch_product/category_view'
    end
    
    def regist_category
        if session[:edit_id]==nil# || session[:edit_id]!=params[:m_id]
        session[:edit_id]=params[:m_id]
        end
        
        if params[:mc]!=nil && session[:befor_middle]!=[params[:mc],params[:upm],params[:r_major_id]]
            add_middle
        end
        
        #小カテゴリ登録
        #test_calc(params[:mi])
        if params[:mi]!=nil && session[:befor_minor]!=[params[:mi],params[:r_middle_id],params[:itp]]
            add_minor
        end
        #@major_id=12
        gen_target(session[:edit_id])
        #redirect_to '/serch_product/regist_category'
    end
    
    def gen_target(target)
        @regi_cate=[Major.find(target).jid]
        middles=Middle.where(major_id: target)
        
        if middles.size>0
        middles.each do |ms|
            @regi_cate.push(ms)
            minors=Minor.where(middle_id: ms.id)

            if minors.size>0
            minors.each do |mi|
                @regi_cate.push(mi)
            end
            end
        end
        end
    end
    
    def add_middle
        if params[:r_major_id]!=nil && params[:mc]!=nil && params[:mc]!=''
            Middle.create(did: params[:mc],up_middle_id: params[:upm],major_id: params[:r_major_id])
            session[:befor_middle]=[params[:mc],params[:upm],params[:r_major_id]]
        end
        
        if session[:edit_id]==nil
        session[:edit_id]=params[:m_id]
        end
    end
    
    def add_minor
        if params[:r_middle_id]!=nil && params[:mi]!=nil && params[:itp]!=nil && params[:mi]!=''
            Minor.create(nid: params[:mi],middle_id: params[:r_middle_id],input_type: params[:itp])
            session[:befor_minor]=[params[:mi],params[:r_middle_id],params[:itp]]
        end
        if session[:edit_id]==nil
        session[:edit_id]=params[:m_id]
        end
    end
    
    def delete
        params[:m_id]=session[:edit_id]
        if params[:d_id]!=nil
            if params[:target]=='middle'
            x=Middle.find(params[:d_id])
            #x.destroy
            #x=Middle.where(up_middle_id: params[:d_id])
            delete_middles(x)
            x.destroy
            elsif params[:target]=='minor'
            x=Minor.find(params[:d_id])
            x.destroy
            end
            
        elsif params[:j_id]!=nil
            x=Minor.find(params[:j_id])
            test_calc(x.nid)
            x.destroy
        end
        params[:d_id]=nil
        params[:j_id]=nil
        params[:mc]=nil
        params[:mi]=nil
    end
    
    def product_pages
        @product=Product.find(params[:product_id])
    end
    
    def cart_in
        Cart.create(user_id: session[:login_user_id],product_id: params[:p_id])
        test_calc(params[:p_id])
        redirect_to root_path
    end
    
    def test_calc(p)
        puts '------------'
        puts p
        puts '------------'
    end
    
    def upper_nil_check(p)
        if p==nil || p==''
            p='2147483647'
        end
    end
    
    def under_nil_check(p)
        if p==nil || p==''
            p='0'
        end
    end
    
    def delete_middles(pa)
        x=Middle.where(up_middle_id: pa.id)
        if x.size<=0
            pa.destroy
            y=Minor.where(middle_id: pa.id)
            y.destroy_all
        else
            x.each do |q|
                delete_middles(q)
                q.destroy
            end
        end
    end
end
