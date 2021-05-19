class sophos::instalar {
    exec { 'Instalacion_SophosInstall' :
    command => "/bin/sh '/tmp/SophosInstall.sh'",
    timeout => 1000
  }
}
