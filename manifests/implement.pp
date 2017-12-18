#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class baseline_crontab_mgmt::implement (
  $bmenu_path = '/admin',
  $delaytime = '900',
  $bmenu_time = '2', ) {
   cron { 'add_buildmenu':
      ensure  => 'present',
      command => "/bin/sleep $( expr \$RANDOM \\% $delaytime); $bmenu_path/masmenu/buildmenu.sh >>/var/log/buildmenu.log 2>&1;",
      user    => root,
      hour    => "$bmenu_time",
      minute  => '0',
   }

   cron { 'unmanaged:/usr/local/bin/check_services.sh':
      ensure  => 'absent',
      command => '/usr/local/bin/check_services.sh',
      user    => 'root',
   }

   cron { 'managed:/usr/local/bin/check_services.sh':
      ensure  => 'present',
      command => '/usr/local/bin/check_services.sh >>/var/log/cron-check_services.log 2>&1',
      user    => 'root',
   }

   cron { 'unmanaged:/usr/local/bin/inactivitycheck.pl':
      ensure  => 'absent',
      command => '/usr/local/bin/inactivitycheck.pl',
      hour    => '4',
      minute  => '0',
      user    => 'root',
   }

   cron { 'managed:/usr/local/bin/inactivitycheck.pl':
      ensure  => 'present',
      command => '/usr/local/bin/inactivitycheck.pl >>/var/log/cron-inactivitycheck.log 2>&1',
      hour    => '4',
      minute  => '0',
      user    => 'root',
   }

   file { '/usr/local/bin/inactivitycheck.pl':
     ensure   => 'file',
     owner    => '0',
     group    => '0',
     mode     => '744',
     selrange => 's0',
     selrole  => 'object_r',
     seltype  => 'bin_t',
     seluser  => 'system_u',
     content  => template('baseline_crontab_mgmt/inactivitycheck.pl.new.erb'),
   }

   file { '/root/.puppet-backups.d':
     ensure   => 'directory',
     owner    => '0',
     group    => '0',
     mode     => '770',
     selrange => 's0',
     selrole  => 'object_r',
     seltype  => 'admin_home_t',
     seluser  => 'system_u',
   } ->

   exec { 'CRONTAB_copy_operation':
     command => 'cp -p /etc/crontab /root/.puppet-backups.d',
     path    => '/usr/bin:/bin',
     unless  => 'test -f /root/.puppet-backups.d/crontab',
   } ->

   file { '/etc/crontab':
     ensure   => 'file',
     owner    => '0',
     group    => '0',
     mode     => '644',
     selrange => 's0',
     selrole  => 'object_r',
     seltype  => 'system_cron_spool_t',
     seluser  => 'system_u',
     content  => template('baseline_crontab_mgmt/crontab.new.erb'),
  }

}

class baseline_crontab_mgmt::implement::tmpclearadd {
   
      file { '/root/tmpclear.sh':
              ensure  => 'present',
              replace => 'yes',
              content => template('baseline_crontab_mgmt/tmpclear.sh.erb'),
              owner   => root,
              group   => root,
              mode    => 700,
      } ->

      cron { 'cleantmpdir':
              ensure  => 'present',
              command => '/root/tmpclear.sh >>/var/log/cron-tmpclear.log 2>&1',
              user    => root,
              hour    => '2',
              minute  => '30',
      }
}

class baseline_crontab_mgmt::implement::restartgoferadd (
        $hour_set_gofer = '*/2',
        $min_set_gofer = '0',
){
      cron { 'restart_goferd':
              ensure  => 'present',
              command => '/sbin/service goferd restart >>/var/log/cron-goferd.log 2>&1',
              user    => root,
              hour    => $hour_set_gofer,
              minute  => $min_set_gofer,
      }
}
