require_relative 'endpoint'

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


module Password

  class Password
    attr_reader :policy, :endpoints
    def initialize(params)
      @policy = DEFAULT_POLICY.merge(params)
      @endpoints = ENDPOINTS.collect { |k,v| Endpoint.new({:policy=>policy,:name=>k,:path=>v}) }
    end

    def to_file
      @endpoints.each { |endpoint| endpoint.dispatch }
    end
  end
end


if $0 == __FILE__
  # man pwquality.conf to see which params are valid
  my_policy = {
    :difok=>2,
    :minlen=>9,
    :dcredit=>1
  }

  pwd_obj = Password::Password.new my_policy

  puts pwd_obj.to_file

end
