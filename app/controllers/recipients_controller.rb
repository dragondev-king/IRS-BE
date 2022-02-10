class RecipientsController < ApplicationController
    
    #GET /recipients?state=xxx&amount=yyy
    def index
        @recipients = Recipient.joins(filings: :awards)
        if params[:state]
            @recipients = @recipients.where(state: params[:state])
        end
        if params[:filing]
            @recipients = @recipients.where(filings: {id: params[:filing]})
        end
        if params[:award]
            @recipients = @recipients.where(awards: {id: params[:award]})
        end
        render json: @recipients
    end

    #GET /recipients/:id
    def show
        @recipient = Recipient.find(params[:id])
        render json: @recipient
    end
end
