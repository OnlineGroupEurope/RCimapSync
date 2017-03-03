#!/usr/bin/perl

use strict;
use DBI;
use MIME::Base64;
use Sys::Syslog;
use LockFile::Simple qw(lock trylock unlock);

use vars qw/ %db_conf /;

my $lock_file = "/var/run/imapsync/imapsync-all.lock";
my $lockmgr = LockFile::Simple->make(-autoclean => 1, -max => 1);
$lockmgr->lock($lock_file) || &log_and_die("can't lock ${lock_file}");

require "config.conf" || log_and_die($!);

my $DBH = DBI->connect('DBI:mysql:database='.$Conf::db_conf{'db'}.';host='.$Conf::db_conf{'host'}, $Conf::db_conf{'username'}, $Conf::db_conf{'password'}) || &log_and_die("cannot connect the database");

&main();

sub main {
	syslog("info", "imapsync started");

	my $select_stmnt = "
		SELECT
			id,
			mailbox,
			src_server,
			src_auth,
			src_user,
			src_password,
			src_folder,
			fetchall,
			keep,
			protocol,
			mda,
			extra_options,
			usessl,
			sslcertck,
			sslcertpath,
			sslfingerprint
	        FROM imapsync
	        WHERE active = 1 AND unix_timestamp(now())-unix_timestamp(date) > poll_time*60
	";

	my $sth = $DBH->prepare($select_stmnt);
	my $rc = $sth->execute() || &log_and_die(DBI->errstr);

	syslog("info", $rc." Accounts gefunden");
	
	while(my $ref = $sth->fetchrow_hashref()) {
		syslog("info", "Sync: ".$ref->{'src_user'}.'@'.$ref->{'src_server'});

		
		my $update_stmnt = "UPDATE fetchmail SET returned_text=".$DBH->quote('').", date=now() WHERE id=".$ref->{'id'};
		$DBH->do($update_stmnt);
	}

}

sub log_and_die {
        my($message) = @_;
  syslog("err", $message);
  die $message;
}
1;
