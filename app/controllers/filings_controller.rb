class FilingsController < ApplicationController

    #GET /filings?filer=xxx
    def index

        @filings = Filing.select('filings.id, filer_id, filers.name as filer_name, recipient_id, recipients.name as recipient_name, awards.purpose as purpose, awards.tax_period as tax_period, awards.amount as amount').joins(:recipient, :filer, :awards)
        if params[:filer]
            @filings = @filings.where(filer_id: params[:filer])
        end
        render json: @filings.order(:id)
    end

    #GET /filings/:id
    def show
        @filing = Filing.find(params[:id])
        render json: @filing
    end
end
