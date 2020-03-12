# config class for ntp client puppet module.
class ntp_client::config (
$ntp_servers
)
{
  package { 'ntp':
    ensure => installed,
  }

  file { '/etc/ntp.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/ntp.conf.erb"),
  }

  file { '/etc/sysconfig/ntpd':
    ensure => present,
    path   => '/etc/sysconfig/ntpd',
    owner  => root,
    group  => root,
    mode   => '0644',
    source => ['puppet:///modules/ntp_client/ntpd'],
    notify => Service['ntpd'],
  }

  service { 'ntpd':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ntp.conf'],
  }

  Package['ntp'] -> File['/etc/ntp.conf'] -> Service['ntpd']
}
