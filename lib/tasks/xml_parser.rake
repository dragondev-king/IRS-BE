def safe_data(val)
    return val ? val.text: ''
end

desc "Parse XML and store."
task :parse_and_store, [:file_name] => :environment do |t, args|
    require "rexml/document"
    require 'date'

    include REXML

    content = File.open(args[:file_name],"r:iso-8859-1:utf-8").read
    content.gsub!(/&(?!(?:amp|lt|gt|quot|apos);)/, '&amp;')
    xmldoc = Document.new(content)
    elements = xmldoc.elements

    #parse filer information
    puts 'working on with the filer information'
    filer_node = elements['Return/ReturnHeader/Filer']

    f_ein = safe_data(filer_node.elements['EIN'])
    f_name = safe_data(filer_node.elements['Name/BusinessNameLine1'] || filer_node.elements['BusinessName/BusinessNameLine1Txt'])

    f_address_node = filer_node.elements['USAddress'] || filer_node.elements['AddressUS']

    f_address = safe_data(f_address_node.elements['AddressLine1'] || f_address_node.elements['AddressLine1Txt'])
    f_city = safe_data(f_address_node.elements['City'] || f_address_node.elements['CityNm'])
    f_state = safe_data(f_address_node.elements['State'] || f_address_node.elements['StateAbbreviationCd'])
    f_zipcode = safe_data(f_address_node.elements['ZIPCode'] || f_address_node['ZIPCd'])

    #store filer information into Filer table
    filer = Filer.new(ein: f_ein, name: f_name, address: f_address, city: f_city, state: f_state, zipcode: f_zipcode)
    filer.save
    puts 'filer information saved'

    # #parse tax period
    tax_period = safe_data(elements['Return/ReturnHeader/TaxYear'] || elements['Return/ReturnHeader/TaxYr'])

    #parse and store filings 
    puts 'working on filings and recipients'
    XPath.each(xmldoc, "Return/ReturnData/IRS990ScheduleI/RecipientTable") do |table_node|
        #parse recipient information
        r_ein = safe_data(table_node.elements['EINOfRecipient'] || table_node.elements['RecipientEIN'])
        r_name = safe_data(table_node.elements['RecipientNameBusiness/BusinessNameLine1'] || table_node.elements['RecipientBusinessName/BusinessNameLine1Txt'])
        r_address_node = table_node.elements['AddressUS'] || table_node.elements['USAddress']
        r_address = safe_data(r_address_node.elements['AddressLine1'] || r_address_node.elements['AddressLine1Txt'])
        r_city = safe_data(r_address_node.elements['City'] || r_address_node.elements['CityNm'])
        r_state = safe_data(r_address_node.elements['State'] || r_address_node.elements['StateAbbreviationCd'])
        r_zipcode = safe_data(r_address_node.elements['ZIPCode'] || r_address_node.elements['ZIPCd'])
        # store recipient data
        recipient = Recipient.new(ein: r_ein, name: r_name, address: r_address, city: r_city, state: r_state, zipcode: r_zipcode)
        recipient.save

        #parse filing info and store 
        amount = safe_data(table_node.elements['AmountOfCashGrant'] || table_node.elements['CashGrantAmt'])
        purpose = safe_data(table_node.elements['PurposeOfGrant'] || table_node.elements['PurposeOfGrantTxt'])

        filing = Filing.new(filer_id: filer.id, recipient_id: recipient.id)
        filing.save

        award = Award.new(amount: amount, purpose: purpose, tax_period: tax_period, filing_id: filing.id)
        award.save
    end
    puts 'filings and recipients information saved'

    puts '=============================================='
    puts 'XML parsing and storing have done successfully'
end
