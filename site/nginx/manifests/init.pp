class nginx {
  
  case $::osfamily {
    'RedHat' : {
      $package = 'nginx',
      $owner   = 'root',
      $group   = 'root',
      $docroot = '/var/www',
      $confdir  = '/etc/nginx',
      $blockdir = '/etc/nginx/conf.d',
      $logdir   = '/var/log/nginx',
      $service  = 'nginx',
      $user     = 'ngnix',
    }
    'Debian' : {
      $package = 'nginx',
      $owner   = 'root',
      $group   = 'root',
      $docroot = '/var/www',
      $confdir  = '/etc/nginx',
      $blockdir = '/etc/nginx/conf.d',
      $logdir   = '/var/log/nginx',
      $service  = 'nginx',
      $user     = 'www-data',
    }
    'windows' : {
      $package = 'nginx-service',
      $owner   = 'Administrator',
      $group   = 'Administrators',
      $docroot = 'c:/programdata/nginx/html',
      $confdir  = 'c:/programdata/nginx',
      $blockdir = 'c:/programdata/nginx/conf.d',
      $logdir   = 'c:/programdata/nginx/logs',
      $service  = 'nginx',
      $user     = 'nobody',
    }
    default {
      fail { "Not a supprted Operating System!! : }
    }
 }
 
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  package { 'nginx' :
    ensure => present,
    before => [File['block'],File['config']],
  }
  
  file { 'docroot':
    ensure  => directory,
    path    => "/var/www",
  }
  
  file { 'index':
    ensure  => file,
    path    => "${docroot}/index.html",
    content => template('nginx/index.html.erb'),
    notify  => Service['nginx'],
  }
  
  file { 'config':
    ensure  => file,
    path    => "${confdir}/nginx.conf",
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { 'block':
    ensure  => file,
    path    => "${blockdir}/default.conf",
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  service { 'nginx':
    ensure    => running,
    enable    => true,
    name      => $service,
    require => [File['docroot'],File['index']],
    subscribe => [File['config'],File['block']],
  }
  
}
  
