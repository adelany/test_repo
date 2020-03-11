class ntp_client () {
      case $facts['os']['name'] {
    /RedHat|CentOS/: {
      contain dns_resolv::config
    }
    default: {
      fail('Unsupported OS')
    }
  }
}

