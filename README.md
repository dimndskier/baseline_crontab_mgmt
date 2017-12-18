# baseline_crontab_mgmt

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with baseline_crontab_mgmt](#setup)
    * [What baseline_crontab_mgmt affects](#what-baseline_crontab_mgmt-affects)
    * [Beginning with baseline_crontab_mgmt](#beginning-with-baseline_crontab_mgmt)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module is intended currently to manage crontabs for all users across the enterprise.
This module specifically is written to address the removal of an unmanaged (not yet manage
by Puppet) cronjob for buildmenu.sh and alter the time of execution and forced it under a 
Puppet managed configuration and now manage: kdecache.

## Module Description

This module will manage, using a Puppet CRON resource, the crontab for: root, nothing more.
You would use this module and expand its framework to implement the _addition_ of new crontab
entries, and the _removal_ of old or unmanaged entries in a crontab; all you have to do is
update the appropriate sub-class {such as addition.pp or removal.pp} for what you intend to
accomplish.

## Setup

### What baseline_crontab_mgmt affects

Currently this module only affects:
1. buildmenu.sh under root's crontab
2. kdecache-<username> directories under cron.daily

### Beginning with baseline_crontab_mgmt

Simply determine, do you want to remove an old unnecessary entry, or do you prefer 
to insert a new entry.  For insertions add the appropriate Puppet resource to the
_addition_ subclass, and for removals add the appropriate Puppet cron resource to
the _removal_ subclass.

Ensure that the subclasses are stored into 1 each unique Puppet Profile file (.pp)
aptly named addition.pp and removal.pp in the same directory as the main init.pp.

## Usage

Once the subclasses are updated appropriately there is nothing else to do.

## Reference

CLASSes: baseline_crontab_mgmt
Sub-Classes: baseline_crontab_mgmt::addition and baseline_crontab_mgmt::removal
Resources: cron
Types: cron

## Limitations

This module is intended only for RHEL-6 and RHEL-7.

## Development

Change at your own risk; alter the author attribute within the metadata.json file.

## ChangeLog - documented from newest on top, down to oldest.

mm/dd/yyyy(newest on top) - ModuleName_Rev-Maj.Min      -Addresses={DR#0000000}                 -BITS=number         -Author;

10/19/2017      -__baseline_crontab_mgmt-1.4.0__           `-Addresses={DR#3003484,NETS#IM477846}`                -BITS=2861.57113_CRONTAB_MGMT_1_4.0000.1        -WFrench;
        Approved for release to Production.

10/19/2017      -__baseline_crontab_mgmt-1.3.5__           `-Addresses={DR#3003484,NETS#IM477846}`                -BITS=2861.57113_CRONTAB_MGMT_1_4.0000.1        -WFrench;
        Aligned parameters, one per row, with 2-char indentation.  Note, doing this __DID NOT__ fix the parameters issue; however, running some commands from Red Hat Support did.

10/19/2017      -__baseline_crontab_mgmt-1.3.4__           `-Addresses={DR#3003484,NETS#IM477846}`                -BITS=2861.57113_CRONTAB_MGMT_1_4.0000.1        -WFrench;
        Crunched in the parameters to the implement class to see if that helps them show up in Host Groups Parameters tab automatically (they do not currently).

10/11/2017      -__baseline_crontab_mgmt-1.3.3__           `-Addresses={DR#3003484,NETS#IM477846}`                -BITS=2861.57113_CRONTAB_MGMT_1_4.0000.1        -WFrench;
        Added SLEEP_DELAY ($delaytime)  before buildmenu.sh cronjob execution to prevent overload of NFS, saturation of A51 MAS network, and cause __negative__ client performance impacts.
         Also parameterized the time-of-day-Hour ($bmenu_time) so that sites can choose their own their own specified time (hour) of day to execute the buildmenu.sh script.

08/23/2017      -__baseline_crontab_mgmt-1.3.2__           `-Addresses={DR#}`                 -BITS=XXXX.57113_CRONTAB_MGMT_1_4.0000.1        -WFrench;
        Implemented the new file resource in the Implement and Backout classes to provide (or revert) the __inactivitycheck.pl__ script that was corrected by Loc Ngo.

08/23/2017      -__baseline_crontab_mgmt-1.3.1__           `-Addresses={DR#}`                -BITS=2815.57113_CRONTAB_MGMT_1_3.0000.1        -WFrench;
        Added Puppetized Header to all template files.

07/24/2017	-__baseline_crontab_mgmt-1.3.0__           `-Addresses={DR#2957674,DR#2995874}`                -BITS=2815.57113_CRONTAB_MGMT_1_3.0000.1        -WFrench
	Approved for Production by PRivera.

07/14/2017      -__baseline_crontab_mgmt-1.2.5__           `-Addresses={DR#2957674,DR#2995874}`                -BITS=2815.57113_CRONTAB_MGMT_1_3.0000.1        -WFrench
        Site requested that all cronjobs everywhere have stderr/stdout explicitly and deliberately be added to the end of each cronjob (instead) of in the middle
         where things currently are.  Also, applied dos2unix changes to tmpclear.sh.erb so that when pushed out to other puppet clients the script will not produce 
         BAD INTERPRETER errors.

05/24/2017      -__baseline_crontab_mgmt-1.2.4__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Added additional 'onlyif' attribute to the Exec within the ::backout class to address missing /root/.puppet-backups.d/crontab
         file.

05/23/2017      -__baseline_crontab_mgmt-1.2.3__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Corrected logic within ::backout sub-class.  Originally, the backout sub-class was going to lay down an ERB-template
         of .orig.*.erb; however, later on it was realized this was the wrong approach.  It was not revoked from the module
         entirely until this newer version.  Delivered to Production to satisfy DR#2966404 and DR#2957674.

05/23/2017      -__baseline_crontab_mgmt-1.2.2__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Removed the /usr/bin references from cp command in both of the sub-classes; path => was already set, and leaving a 
         fqp was causing me problems.

05/23/2017      -__baseline_crontab_mgmt-1.2.1__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Added path => '/usr/bin:/bin' because apparently the Exec resource requires it even if the full path to an executable
         is being explicitly provided.'

05/23/2017      -__baseline_crontab_mgmt-1.2.0__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Added additional Exec resource to address the need for backing up the original /etc/crontab file (per machine)
         to ensure an easier recovery back to the original crontab settings in the case the CRONTAB::implement class' 
         results are not accepted.  Also, altered the default for $bmenu_path to the intended value '/admin.'

05/18/2017      -__baseline_crontab_mgmt-1.1.9__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Corrected ERB-template, crontab.new.erb, to correct <% end %> to <% end -%>.

05/18/2017      -__baseline_crontab_mgmt-1.1.8__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Corrected the ERB-template, crontab.new.erb, to address conditional properly (USE 2 == signs).

05/18/2017      -__baseline_crontab_mgmt-1.1.7__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Addressed the issue that the backout class could not properly account for cronjobs laid down by the ::implement class by
         adding two more cron resources to 'scrub' them from the crontab for root.

05/18/2017      -__baseline_crontab_mgmt-1.1.6__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Corrected the typo of the $bemnu_path to $bmenu_path.  Also corrected the ::addition subclass to the new standard of ::implement.
         Finally, corrected the path of /sbin/aide over to /usr/sbin/aide.

05/18/2017      -__baseline_crontab_mgmt-1.1.5__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Corrected the variable as instantiated as a parametric value to the addition class, {} are not legal in Puppet Language; 
         unlike UNIX shell scripting.

05/17/2017      -__baseline_crontab_mgmt-1.1.4__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Addresses the request in a DR for '/m/iasa612' to '/admin' but this is a parameterized variable called ${bmenu_path}.

05/16/2017      -__baseline_crontab_mgmt-1.1.3__           -BITS=2771.57113_CRONTAB_MGMT_1.2.3.0000.1       -WFrench;
        Updated again to send _ANY_ and _ALL_ cronjobs' stderr and stdout to a log file, named after the cronjob and deposited
         within the /var/log directory.

05/02/2017      -__baseline_crontab_mgmt-1.1.2__           -BITS=2722.57113_CRONTAB_MGMT_1.1.0000.3       -WFrench;
        Updated for Patrick's changes to eradicate CLOSE_WAIT sockets as they relate to GOFERD.  This module to be
         tested and released as a combined effort of the Goferd socket cleanup and the stderr/stdout redirection for the
         MAS buildmenu.sh cronjob.  Altered removal submodule to alter the cronjob back to hour=2 and minute=0.

04/19/2017      -__baseline_crontab_mgmt-1.1.1__           -BITS=2722.57113_CRONTAB_MGMT_1.1.0000.3       -WFrench;
        Now adding stderr/stdout for buildmenu.sh to the cronjob configuration.

4/04/2017       -__baseline_crontab_mgmt-1.1.0__           -BITS=2722.57113_CRONTAB_MGMT_1.1.0000.2       -PRivera;
        Module approved.  Updated version.  Additionally, updated the hour on the buildmenu class from 11 to 2 per customer request.

04/03/2017      -__baseline_crontab_mgmt-1.0.1__           -BITS=2722.57113_CRONTAB_MGMT_1.1.0000.2       -PRivera;
        Added additional subclasses to addition.pp and removal.pp to manage the kdecache of users not logged in.

03/23/2017      -__baseline_crontab_mgmt-1.0.0__           -BITS=2722.57113_CRONTAB_MGMT_1.0_0000.1       -WFrench;
        Module approved in its current state; simply Uprevving to v1.0.0.

03/20/2017      -__baseline_crontab_mgmt-0.1.0__                                                          -WFrench;
        Initial module creation.  No syntax added yet.



