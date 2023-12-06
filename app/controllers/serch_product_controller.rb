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
        if @major==nil && params[:major_id]==nil
        @major=Major.find(params[:m_id])
        end
        
        if @major==nil
           @major=Major.find(params[:major_id])
        end
        @middle=Middle.where(major_id: @major)
        
        if(@middle.find_by(did: params[:mc])==nil)
        Middle.create(did: params[:mc],up_middle_id: params[:um],major_id: params[:major_id])
        end
        
        #redirect_to '/serch_product/regist_category'
    end
end
