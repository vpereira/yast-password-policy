module Password
  DEFAULT_POLICY = {
    retries:        3, # retry is reserved
    difok:          2,
    minlen:         9,
    dcredit:        1,
    ucredit:        1,
    lcredit:        1,
    ocredit:        1,
    minclass:       0,
    maxrepeat:      0,
    maxclassrepeat: 0,
    gecoscheck:     0,
    dicpath:        ""

  }.freeze

  ENDPOINTS = {
    pam_d:        "/etc/pam.d/common-auth",
    libpwquality: "/etc/security/pwquality.conf",
    login_defs: "/etc/login.defs"
  }.freeze
end
