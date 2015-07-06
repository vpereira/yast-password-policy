require_relative 'endpoint'



module Password

  DEFAULT_POLICY = {
    :retries => 3, # retry is reserved
    :difok => 2,
    :minlen => 9,
    :dcredit => 1,
    :ucredit => 1,
    :lcredit => 1,
    :ocredit => 1,
    :minclass => 0,
    :maxrepeat =>0,
    :maxclassrepeat => 0,
    :gecoscheck => 0,
    :dicpath => ""

  }

  ENDPOINTS = {
    :pam_d => "/etc/pam.d/common-auth",
    :libpwquality => "/etc/security/pwquality.conf"
  }

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
