module Athena
  class Client
    include HTTParty
    HOST = "https://api.athenahealth.com"

    attr_reader :client_id, :client_secret, :site, :host, :access_token
    attr_writer :access_token

    def initialize(client_id, client_secret, site=:athenanet)
      @client_id = client_id
      @client_secret = client_secret
      @site = site
      set_base_uri!
      get_access_token!
      set_base_uri!
    end

    def api_path
      case site
      when :athenanet
        "/oauth"
      when :preview
        "/oauthpreview"
      when :limited_preview
        "/oauthopenpreview"
      end
    end

    def set_base_uri!
      if access_token.nil?
        self.class.base_uri HOST + api_path
      else
        self.class.base_uri HOST + "/preview1"
      end
    end

    def get_access_token!
      response = self.class.post('/token',
                                 :basic_auth => {:username => client_id, :password => client_secret},
                                 :body => {:grant_type => "client_credentials"})

      @access_token = response["access_token"]
    end

    def practices
      PracticeCollection.new(self)
    end

    def get(route, body = {})
      self.class.get(route, :body => body, :headers => {"Authorization" => "Bearer " + access_token})
    end

  end
end
