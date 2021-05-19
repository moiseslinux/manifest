
class sophosescarga {
include wget
wget::fetch { "download SophosInstall":
  source      => 'https://dzr-api-amzn-eu-west-1-9af7.api-upe.p.hmr.sophos.com/api/download/41b535f488a8af5b23d7bd6a5bb921b4/SophosInstall.sh',
  destination => '/tmp/',
  timeout     => 1550,
  verbose     => false,
}

}


