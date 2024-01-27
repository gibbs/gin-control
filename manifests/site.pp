# Disable file content backups
File {
  backup => false,
}

# Exec resource defaults
Exec {
  path     => '/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  provider => 'shell',
}

# Default node lookup
node default {
  lookup({
    'name'          => 'classes',
    'merge'         => {
      'strategy' => 'deep',
    },
    'default_value' => [],
  }).include
}
