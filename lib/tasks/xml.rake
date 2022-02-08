desc "Parse XML and store."
task :parse_and_store, [:file_name] => :environment do |t, args|
    require "rexml/document"

    include REXML

    xmlfile = File.new(args[:file_name])
    xmldoc = Document.new(xmlfile)
    elements = xmldoc.elements

    #parse filer information
    puts 'working on with the filer information'
    filer_node = elements['Return/ReturnHeader/Filer']

    f_ein = filer_node.elements['EIN'].text
    f_name = filer_node.elements['Name/BusinessNameLine1'].text

    f_address_node = filer_node.elements['USAddress']

    f_address = f_address_node.elements['AddressLine1'].text
    f_city = f_address_node.elements['City'].text
    f_state = f_address_node.elements['State'].text
    f_zipcode = f_address_node.elements['ZIPCode'].text

    #store filer information into Filer table
    filer = Filer.new(ein: f_ein, name: f_name, address: f_address, city: f_city, state: f_state, zipcode: f_zipcode)
    filer.save
    puts 'filer information saved'

    #parse tax period
    tax_period_begin = elements['Return/ReturnHeader/TaxPeriodBeginDate'].text
    tax_period_end = elements['Return/ReturnHeader/TaxPeriodEndDate'].text

    #parse and store filings 
    puts 'working on filings and recipients'
    XPath.each(xmldoc, "Return/ReturnData/IRS990ScheduleI/RecipientTable") do |table_node|
        #parse recipient information
        r_ein = table_node.elements['EINOfRecipient'] ? table_node.elements['EINOfRecipient'].text : ''
        r_name = table_node.elements['RecipientNameBusiness/BusinessNameLine1'].text
        r_address_node = table_node.elements['AddressUS']
        r_address = r_address_node.elements['AddressLine1'].text
        r_city = r_address_node.elements['City'].text
        r_state = r_address_node.elements['State'].text
        r_zipcode = r_address_node.elements['ZIPCode'].text
        # store recipient data
        recipient = Recipient.new(ein: r_ein, name: r_name, address: r_address, city: r_city, state: r_state, zipcode: r_zipcode)
        recipient.save

        #parse filing info and store 
        amount = table_node.elements['AmountOfCashGrant'].text
        purpose = table_node.elements['PurposeOfGrant'].text

        filing = Filing.new(filer_id: filer.id, amount: amount, purpose: purpose, tax_period_begin: tax_period_begin, tax_period_end: tax_period_end, recipient_id: recipient.id)
        filing.save
    end

    puts 'XML parsing and storing has done successfully'
end
