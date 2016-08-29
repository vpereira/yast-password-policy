require_relative "default"
require_relative "endpoint"
module Password
  #
  # class responsible for collect all endpoints
  # apply changes or revert it
  #
  class Password
    attr_reader :policy, :endpoints
    def initialize(params = {})
      @policy = DEFAULT_POLICY.merge(params[:policy])
      endpoints = params[:endpoints].nil? ? ENDPOINTS : params[:endpoints]
      @endpoints = endpoints.collect do |k, v|
        Endpoint.new(policy: policy, name: k, path: v)
      end
    end

    # for now we apply all
    def apply
      @endpoints.each(&:dispatch)
    end

    # for now revert all
    def revert
      @endpoints.each(&:revert)
    end

    # the YAML_CONFIG file will be generated
    # after the policy was successfuly applied
    def self.current_policy
      current_policy = if File.exists? YAML_CONFIG
        YAML.load(File.read(YAML_CONFIG))
      else
        DEFAULT_POLICY
      end
    end
  end
end
