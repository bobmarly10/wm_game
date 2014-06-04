
require 'savon'

class OpenLigaDB
  def initialize
    @client = Savon.client( wsdl: "http://www.openligadb.de/Webservices/Sportsdata.asmx?wsdl" )
  end

  def request(action, params)
    action = "get_#{action}".gsub(/id$/, 'iD').to_sym
    message = {}
    params.each do |key, value|
      unless key == :action
        key = key.to_s.gsub(/Id$/, 'ID').gsub(/Id_1$/, 'ID1').gsub(/Id_2$/, 'ID2')
        message[key] = value
      end
    end

    response = @client.call action, message: message
    #response = @client.call action do |soap|
    #  soap.body = {}
    #  params.each do |key, value|
    #    unless key == :action
    #      key = key.to_s.gsub(/Id$/, 'ID').gsub(/Id_1$/, 'ID1').gsub(/Id_2$/, 'ID2')
    #      soap.body[key] = value
    #    end
    #  end
    #end

    hash = response.to_hash
    hash = hash[hash.keys.first]
    hash.delete :@xmlns
    hash[hash.keys.first]    
  end

  private

end