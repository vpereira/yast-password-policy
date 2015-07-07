require_relative 'default'
require_relative 'endpoint'



module Password

  class Password
    attr_reader :policy, :endpoints
    def initialize(params = {})
      @policy = DEFAULT_POLICY.merge(params)
      @endpoints = ENDPOINTS.collect { |k,v| Endpoint.new({:policy=>policy,:name=>k,:path=>v}) }
    end

    # for now we apply all
    def apply
      @endpoints.each { |endpoint| endpoint.dispatch }
    end

    # for now revert all
    def revert
      @endpoints.each { |endpoint| endpoint.revert }
    end

  end
end
