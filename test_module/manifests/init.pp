# Class: ntp_config
#
#
class ntp_config {
  # resources
  file { '/etc/ntp/ntp.conf':
    ensure => 'present'
  }
}
