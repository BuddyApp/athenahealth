require 'spec_helper'

describe Athena::Client do
  describe "when trying to connect to the Athena API" do
    before do
      cnf = YAML::load_file(File.join(__dir__, '../config.yml'))
      @client = Athena::Client.new(cnf['athena']['client_id'],
                                   cnf['athena']['client_secret'],
                                   :preview)
    end

    it "should set the access token" do
      expect(@client.access_token).not_to be_nil
    end

  end

end
