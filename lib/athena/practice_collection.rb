module Athena
  class PracticeCollection
    def initialize(client)
      @client = client
      @subject = @client.get_practice_info
    end

    private

    def method_missing(method, *args, &block)
      @subject.send(method, *args, &block)
    end
  end
end
