module Athena
  class Practice
    attr_reader :id, :name, :has_communicator, :is_coordinator_sender, :is_coordinator_receiver, :has_clinicials, :has_collector, :client

    def initialize(opts)
      @id = opts["practiceid"].to_i
      @name = opts["name"]
      @has_communicator = to_boolean opts["hascommunicator"]
      @is_coordinator_sender = to_boolean opts["iscoordinatorsender"]
      @has_clinicals = to_boolean opts["hasclinicals"]
      @has_collector = to_boolean opts["hascollector"]
      @client = opts["client"]
    end

    def to_boolean(str)
      str == 'true'
    end

    def method_missing(method)
      if method.to_s.ends_with?("?")
        self.send(method[0..-1])
      else
        super
      end
    end

    def departments
      Athena::DepartmentCollection.new(@id, @client)
    end

  end
end
