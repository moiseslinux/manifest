class sophos::instalar {
  exec { 'Instalacion_SophosInstall':
  command => "/bin/sh '/tmp/SophosInstall.sh'",
  }
}
