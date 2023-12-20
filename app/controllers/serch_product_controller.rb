class SerchProductController < ApplicationController
    def serch
    end
    
    def category_view
        @all_major=Major.all
        if(params[:nc]!=nil && @all_major.find_by(jid: params[:nc])==nil)
            Major.create(jid: params[:nc])
            redirect_to '/serch_product/category_view'
        end
    end
    
    def category_all_delete
        Major.find(params[:m_id]).destroy
        mid=Middle.where(params[:m_id])
        if mid.size<0
        else
            mid.each do |d|
                minor=Minor.where(middle_id: d.id)
                if minor.size>0
                    minor.destroy_all
                end
            end
        end
        redirect_to '/serch_product/category_view'
    end
    
    def regist_category
        if session[:edit_id]==nil# || session[:edit_id]!=params[:m_id]
        session[:edit_id]=params[:m_id]
        end
        
        if params[:mc]!=nil
            add_middle
        end
        #@major_id=12
        @regi_cate=[Major.find(session[:edit_id]).jid]
        middles=Middle.where(major_id: session[:edit_id])
        
        if middles.size>0
        middles.each do |ms|
            @regi_cate.push(ms)
            minors=Minor.where(middle_id: ms.id)

            if minors.size>0
            minors.each do |mi|
                @regi_cate.push([mi.nid,mi.input_type])
            end
            end
        end
        end
        #redirect_to '/serch_product/regist_category'
    end
    
    def add_middle
        if params[:r_major_id]!=nil && params[:mc]!=nil
            Middle.create(did: params[:mc],up_middle_id: params[:upm],major_id: params[:r_major_id])
            params[:mc]=nil
        end
        
        if session[:edit_id]==nil
        session[:edit_id]=params[:m_id]
        end
    end
    
    
    def delete
        params[:m_id]=session[:edit_id]
        if params[:d_id]!=nil
            x=Middle.find(params[:d_id])
            #x.destroy
            #x=Middle.where(up_middle_id: params[:d_id])
            delete_middles(x)
            x.destroy
            
        elsif params[:j_id]!=nil
            x=Minor.find(params[:j_id])
            #x.destroy
        end
        params[:d_id]=nil
        params[:j_id]=nil
        params[:mc]=nil
    end
    
    def test_calc(p)
        puts '------------'
        puts p
        puts '------------'
    end
    
    def delete_middles(pa)
        x=Middle.where(up_middle_id: pa.id)
        if x.size<=0
            pa.destroy
        else
            x.each do |q|
                delete_middles(q)
                q.destroy
            end
        end
    end
end
