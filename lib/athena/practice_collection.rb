module Athena
  class PracticeCollection
    def initialize(client)
      @client = client
      @subject = @client.get_practice_info
    end

    def find(id)
      @subject.detect { |x| x.id == id }
    end

    private

    def method_missing(method, *args, &block)
      @subject.send(method, *args, &block)
    end
  end
end
