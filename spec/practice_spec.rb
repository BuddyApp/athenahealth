require 'spec_helper'

describe Athena::Practice do
  describe "when connected to a client" do
    before do
      @cnf = YAML::load_file(File.join(__dir__, '../config.yml'))
      @client = Athena::Client.new(@cnf['athena']['client_id'],
                                   @cnf['athena']['client_secret'],
                                   :preview)
    end

    it "should be able to fetch all practices information" do
      practices = @client.practices
      expect(practices).to be_kind_of(Athena::PracticeCollection)
      expect(practices.length).to be(1)
      expect(practices.first.id).to be(@cnf['athena']['default_practice_id'])
    end

    it "should be able to fetch a single practice" do
      practice = @client.practices.find @cnf['athena']['default_practice_id']
      expect(practice).to be_kind_of(Athena::Practice)
      expect(practice.id).to be(@cnf['athena']['default_practice_id'])
    end

  end

end
