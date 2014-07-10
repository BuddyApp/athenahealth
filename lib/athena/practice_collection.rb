module Athena
  class PracticeCollection
    def initialize(client)
      @client = client
      @performed_query = false
      @subject = []
    end

    def find(id)
      if @subject.length > 0
        @subject.detect { |x| x.id == id }
      else
        Athena::Practice.new(@client.get("/#{id}/practiceinfo")["practiceinfo"].first)
      end
    end

    private

    def method_missing(method, *args, &block)
      @subject = get_practice_info unless @performed_query
      @subject.send(method, *args, &block)
    end

    def get_practice_info
      response = @client.get('/1/practiceinfo')
      practices = response["practiceinfo"].map { |x| Athena::Practice.new(x.merge({ "client" => self })) }
      @performed_query = true
      practices
    end
  end
end
