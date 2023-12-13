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
        redirect_to '/serch_product/category_view'
    end
    
    def regist_category
        if @major_id==nil && params[:major_id]==nil
        @major_id=params[:m_id]
        end
        
        if params[:mc]!=nil
            add_middle
        end
        #@major_id=12
        @regi_cate=[Major.find(@major_id).jid]
        middles=Middle.where(major_id: @major_id)
        
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
        
        if params[:r_major_id]!=nil
        @major_id=params[:r_major_id]
        end
    end
    
    
    def delete
        #x=Middle.find(params[:m_id])
        
        #test_calc(x.id)
        #x.destroy
        #params[:mc]=nil
        #@major_id=params[:r_major_id]
        
        #@reload_flag=true
        #ここに変数が入ります
        test_calc(1)
    end
    
    def test_calc(p)
        puts '------------'
        puts p
        puts '------------'
    end
end
