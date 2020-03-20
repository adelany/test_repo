# Class: ntp_config
# Great
#
class ntp_config {
  # resources
  file { '/etc/ntp/ntp.conf':
    ensure => 'present'
  }
}
