class postfix::install () {

include postfix::config
include postfix::service

$postfix = ['cronie', 'sysstat', 'postfix', 'mailx']

  service { 'sendmail':
    ensure => stopped,
    enable => false,
  } ->

  exec { '/usr/bin/yum -y remove sendmail':
    onlyif => '/bin/rpm -ql sendmail',
  } ->

  service { 'exim':
    ensure => stopped,
    enable => false,
  } ->

  exec { '/usr/bin/yum -y remove exim':
    onlyif => '/bin/rpm -ql exim',
  } ->

  package { $postfix:
    ensure => installed,
  }
}
