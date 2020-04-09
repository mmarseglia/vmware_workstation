# == Class vmware_workstation::params
# Default parameters for vmware_workstation
#
class vmware_workstation::params {

  $url = 'https://download3.vmware.com/software/wkst/file/'
  $version = '14.1.0-7370693'

  if $::kernel in 'Linux' {
    $cache_dir = '/var/cache/wget'
    $destination = '/tmp/'
    $install_options = '--ignore-errors --console --required --eulas-agreed'
  } elsif $::kernel in 'Windows' {
    $cache_dir = 'C:\Windows\Temp\\'
    $destination  = 'C:\TEMP\\'
    $install_options = '/s /nsr /v "EULAS_AGREED=1"'
  }

}
