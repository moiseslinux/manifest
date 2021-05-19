class sophos  {
     Class['sophos::instalar'] -> Class['sophos::descarga'] ->  Class['sophos::service']
     #class { 'sophos::instalar': }
     #class { 'sophos::descarga':  }
}


class sophos::instalar {
    wget::fetch { 'Descarga del archivo de instalacion':
    source      => 'http://serverforeman.uxxi.net/pulp/repos/UXXI/sophos/SophosInstall.sh',
    destination => '/tmp/',
    verbose     => false,
    notify => Exec['Instalacion_SophosInstall'],
  }
}


class sophos::descarga {
    exec { 'Instalacion_SophosInstall' :
    command => "/bin/sh '/tmp/SophosInstall.sh'",
    unless  =>  "/bin/test -e /opt/sophos-av/",
   }
}

class sophos::service {
  service { 'sav-protect':
    ensure => 'running',
    enable => true,
  }
}



