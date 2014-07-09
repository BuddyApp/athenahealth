module Athena
  class Client
    include HTTParty
    debug_output $stdout

    HOST = "https://api.athenahealth.com"

    attr_reader :client_id, :client_secret, :site, :host, :access_token
    attr_writer :access_token

    def initialize(client_id, client_secret, site=:athenanet)
      @client_id = client_id
      @client_secret = client_secret
      @site = site
      self.class.base_uri @host = base_url
      get_access_token!
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

    def base_url
      HOST + api_path
    end

    def get_access_token!
      response = self.class.post('/token',
                                 :basic_auth => {:username => client_id, :password => client_secret},
                                 :body => {:grant_type => "client_credentials"})

      @access_token = response["access_token"]
    end
  end
end
