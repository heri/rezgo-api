module Rezgo
  class Connection
    def initialize(transcode, api_key, result_type = "raw")
      raise ArgumentError, "Invalid Transcode" unless transcode.downcase.start_with?("p")
      raise ArgumentError, "Invalid API Key" unless api_key.match(/[a-zA-Z0-9]{3}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{3}/i)
      
      @transcode = transcode
      @api_key = api_key
      @result_type = result_type
      @base_url = "https://xml.rezgo.com/xml?"
    end
        
    def company
      request("company")
    end
    
    def headers
      request("headers")
    end
    
    def about
      request("about")
    end
    
    def search_items(opt_args = {})
      request("search_items", opt_args)
    end
    
    def tags
      request("tags")
    end
    
    def commit(opt_args = {})
      request("commit", opt_args)
    end
    
    def modify_bookings(cancel_code, voucher_code)
      request("modify_bookings", {:a => "cancel", :cancel_code => cancel_code, :q => voucher_code})
    end
    
    def search_bookings(transaction_code)
      request("search_bookings", {:q => transaction_code})
    end
    
    def month(uid, opt_args = {})
      request("month", opt_args.merge(:q => uid))
    end
    
    def region_list
      request("region_list")
    end
    
    def classification_list
      request("classification_list")
    end

    private

    def request(request_type, opt_args = {})
      valid_reqs = ["company", "headers", "about", "search_items", "tags", "commit", "modify_bookings", 
                    "search_bookings", "month", "region_list", "classification_list"]
      raise ArgumentError, "Invalid Request Type" unless valid_reqs.include?(request_type.downcase)
      
      params = {:key => @api_key, :transcode => @transcode, :i => request_type}
      
      url = @base_url + params.merge(opt_args).to_query
      
      response = open(url).read
      
      @result_type == "raw" ? response : Hash.from_xml(response)["response"]
    end
  end
end