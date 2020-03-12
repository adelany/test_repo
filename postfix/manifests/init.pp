# Init class for postfix puppet module.
class postfix () {
  case $facts['os']['name'] {
    /RedHat|CentOS/: {
      contain postfix::install
    }
    default: {
      fail('Unsupported OS')
    }
  }
}
