class FilingsController < ApplicationController

    #GET /filings?filer=xxx
    def index

        @filings = Filing.all
        if params[:filer]
            @filings = Filing.where(filer_id: params[:filer])
        end
        render json: @filings
    end

    #GET /filings/:id
    def show
        @filing = Filing.find(params[:id])
        render json: @filing
    end
end
