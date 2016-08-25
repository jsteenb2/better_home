class YelpMain

  @@client = Yelp::Client.new({
                    consumer_key: Rails.application.secrets.yelp_con_key,
                    consumer_secret: Rails.application.secrets.yelp_con_secret,
                    token: Rails.application.secrets.yelp_token,
                    token_secret: Rails.application.secrets.yelp_token_secret
                    })

  #takes neighborhood name, city, and state
  def self.get_yelp_poi(neighborhood)
    @@client.search(neighborhood, limit: 4, sort: 2).businesses
  end

end
