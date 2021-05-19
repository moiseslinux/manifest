
class intdns_uxxi {
include acceso_uxxi::service
if $facts['networking']['network'] == '172.23.0.0' {
file_line { 'Dns1 Intref':
        #after            => '# Authentication',
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line             => '#puppet',
        match            => '^DNS1="172.23.21.62"',
        replace    => true,
        #notify          => Service[sshd],
    }

file_line { 'Dns1.1 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line            => 'DNS1="172.23.21.139"',
        replace    => true,
     }


file_line { 'Dns2 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line             => '#',
        match            => '^DNS2="172.23.21.2"',
        replace    => true,
     }

file_line { 'Dns2.1 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line            => 'DNS2="172.23.21.138"',
        replace    => true,
     }
}


if $facts['networking']['network'] == '172.21.0.0' {
file_line { 'Dns1 Intref':
        #after            => '# Authentication',
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line             => '#puppet',
        match            => '^DNS1="172.23.21.62"',
        replace    => true,
        #notify          => Service[sshd],
    }

file_line { 'Dns1.1 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line            => 'DNS1="172.23.21.139"',
        replace    => true,
     }


file_line { 'Dns2 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line             => '#',
        match            => '^DNS2="172.23.21.2"',
        replace    => true,
     }

file_line { 'Dns2.1 Intref':
        path             => '/etc/sysconfig/network-scripts/ifcfg-ens192',
        line            => 'DNS2="172.23.21.138"',
        replace    => true,
     }
}







}








