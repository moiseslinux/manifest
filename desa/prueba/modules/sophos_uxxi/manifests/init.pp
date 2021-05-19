class sophos_uxxi  {
     Class['sophos_uxxi::instalar'] -> Class['sophos_uxxi::descarga'] ->  Class['sophos_uxxi::service']
     #class { 'sophos::instalar': }
     #class { 'sophos::descarga':  }
}


class sophos_uxxi::instalar {
    wget::fetch { 'Descarga del archivo de instalacion':
    source      => 'http://serverforeman.uxxi.net/pulp/repos/UXXI/sophos/SophosInstall.sh',
    destination => '/tmp/',
    verbose     => false,
    notify => Exec['Instalacion_SophosInstall'],
  }
}


class sophos_uxxi::descarga {
    exec { 'Instalacion_SophosInstall' :
    command => "/bin/sh '/tmp/SophosInstall.sh'",
    unless  =>  "/bin/test -e /opt/sophos-av/",
   }
}

class sophos_uxxi::service {
  service { 'sav-protect':
    ensure => 'running',
    enable => true,
  }
}



