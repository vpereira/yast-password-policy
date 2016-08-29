require_relative "default"
require_relative "endpoint"
require "yaml"

module Password
  #
  # class responsible for collect all endpoints
  # apply changes or revert it
  #
  class Password
    attr_reader :policy, :endpoints
    def initialize(params = {})
      @policy = Password::current_policy.merge(params[:policy])
      endpoints = params[:endpoints].nil? ? ENDPOINTS : params[:endpoints]
      @endpoints = endpoints.collect do |k, v|
        Endpoint.new(policy: policy, name: k, path: v)
      end
    end

    # for now we apply all
    # return the policy
    def apply
      @endpoints.each(&:dispatch)
      self
    end

    # for now revert all
    def revert
      @endpoints.each(&:revert)
    end

    # the YAML_CONFIG file will be generated
    # after the policy was successfuly applied
    def self.current_policy
      if File.exists? YAML_CONFIG
        YAML.load(File.read(YAML_CONFIG))
      else
        DEFAULT_POLICY
      end
    end
    def save_policy
      File.open(YAML_CONFIG, "w") do |file|
        file.write @policy.to_yaml
      end
    end
  end
end
