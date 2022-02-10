class RecipientsController < ApplicationController
    
    #GET /recipients?state=xxx&amount=yyy
    def index
        @recipients = Recipient.all
        if params[:state]
            @recipients = Recipient.where(state: params[:state])
        end
        render json: @recipients
    end

    #GET /recipients/:id
    def show
        @recipient = Recipient.find(params[:id])
        render json: @recipient
    end
end
