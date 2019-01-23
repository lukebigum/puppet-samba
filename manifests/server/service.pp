# == Class samba::server::server
#
class samba::server::service (
  $ensure               = running,
  $enable               = true,
  $nmbd_service_name    = undef,
  $smbd_service_name    = undef,
) inherits samba::server::params {
  $smbd = pick($smbd_service_name, $samba::server::params::service_name)
  $nmbd = pick($nmbd_service_name, $samba::server::params::nmbd_name)

  service { $smbd:
    ensure     => $ensure,
    hasstatus  => true,
    hasrestart => true,
    enable     => $enable,
    require    => Class['samba::server::config'],
  }

  if $samba::server::params::nmbd_name != undef {
    service { $nmbd:
      ensure     => $ensure,
      hasrestart => false,
      enable     => $enable,
      require    => Class['samba::server::config'],
    }
  }
}
