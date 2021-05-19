class sudoers_uxxi::smart (
$users = '',
) {
# agrgar grupos
file_line { '$users':
      path => '/etc/sudoers',
      line => $users,
    }
}