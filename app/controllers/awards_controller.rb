class AwardsController < ApplicationController

    #GET /awards/?filing=xxx
    def index
        @awards = Award.all
        if params[:filing]
            @awards = Award.where(filing_id: params[:filing])
        end
        render json: @awards
    end

    #GET /awards/:id
    def show
        @award = Award.find(params[:id])
        render json: @award
    end

end
