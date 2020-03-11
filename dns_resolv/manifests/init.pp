class dns_resolv () {
  case $facts['os']['name'] {
    /RedHat|CentOS/: {
      contain dns_resolv::config
    }
    default: {
      fail('Unsupported OS')
    }
  }
}
