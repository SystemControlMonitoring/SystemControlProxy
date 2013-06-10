#!/usr/bin/perl
#########################################################
#                                                       #
# Basis Funktionen für kVASy System Control             #
#                                                       #
#########################################################
use strict;
use LWP::Simple;
use Config::Properties;
use DBI;
# Name
package kSCpostgre;
# Redirect Error Output
#########################################################
#                                                       #
#                  Read Configuration                   #
#                                                       #
#########################################################
open my $CF, '<', '/kSCproxy/CFG/proxy.properties' or die "[". (localtime) ."] Kann Konfiguration '/kSCproxy/CFG/proxy.properties' nicht öffnen!";
my $properties = Config::Properties->new();
$properties->load($CF);
#########################################################
#                                                       #
#                       Functions                       #
#                                                       #
#########################################################
sub REPOConnect {
    my $repo = DBI->connect("dbi:Pg:dbname=". $properties->getProperty("repo.name") .";host=". $properties->getProperty("repo.host") .";port=". $properties->getProperty("repo.port") .";", $properties->getProperty("repo.user"), $properties->getProperty("repo.pass")) or die "[". (localtime) ."] Unable to connect Repository: $DBI::errstr\n";
    return ($repo);
}
#
sub SelectDashboardAll {
    my $uid = shift;
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT decode(tv1,'base64'),decode(tv2,'base64'),decode(tv3,'base64') FROM repo_config WHERE tus = encode('". $uid ."','base64') AND tmd = encode('DASHBOARD','base64') ORDER BY tid ASC") or die "[". (localtime) ."] Repo Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
sub InsertRepository {
    # Insert into Web Repository
    my $tus = shift;
    my $tmd = shift;
    my $tky = shift;
    my $tv1 = shift;
    my $tv2 = shift;
    my $tv3 = shift;
    # Execution
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT tid FROM repo_config WHERE tus = encode('". $tus ."','base64') AND tmd = encode('". $tmd ."','base64') AND tky = encode('". $tky ."','base64') AND tv1 = encode('". $tv1 ."','base64') AND tv2 = encode('". $tv2 ."','base64') AND tv3 = encode('". $tv3 ."','base64')") or die "[". (localtime) ."] Repo Insert Select Failed: $DBI::errstr\n";
    $sth->execute();
    if ($sth->rows == 1) {
	# nothing to do
    } else {
	$dbh->do("INSERT INTO repo_config(tus,tmd,tky,tv1,tv2,tv3) VALUES (encode('". $tus ."','base64'),encode('". $tmd ."','base64'),encode('". $tky ."','base64'),encode('". $tv1 ."','base64'),encode('". $tv2 ."','base64'),encode('". $tv3 ."','base64')) ") or die "[". (localtime) ."] Repo Insert Failed: $DBI::errstr\n";
    }
    $sth->finish;
    $dbh->disconnect;
    return 0;
}
#
sub DeleteFromRepository {
    # Insert into Web Repository
    my $tus = shift;
    my $tmd = shift;
    my $tky = shift;
    # Execution
    my $dbh = REPOConnect();
    $dbh->do("DELETE FROM repo_config WHERE tus = encode('". $tus ."','base64') AND tmd = encode('". $tmd ."','base64') AND tky = encode('". $tky ."','base64')") or die "[". (localtime) ."] Delete From Repo Failed: $DBI::errstr\n";
    $dbh->disconnect;
    return 0;
}
#
sub DeleteAllRepository {
    # Insert into Web Repository
    my $tus = shift;
    # Execution
    my $dbh = REPOConnect();
    $dbh->do("DELETE FROM repo_config WHERE tus = encode('". $tus ."','base64')") or die "[". (localtime) ."] Delete From Repo Failed: $DBI::errstr\n";
    $dbh->disconnect;
    return 0;
}
#
sub SelectFromRepository {
    my $uid = shift;
    my $mdl = shift;
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT decode(tky,'base64'),decode(tv1,'base64'),decode(tv2,'base64'),decode(tv3,'base64') FROM repo_config WHERE tus = encode('". $uid ."','base64') AND tmd = encode('". $mdl ."','base64') ORDER BY tid ASC") or die "[". (localtime) ."] Repo Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
sub InsertUpdateConfig {
    # Insert into Web Repository
    my $tus = shift;
    my $tmd = shift;
    my $tky = shift;
    my $tv1 = shift;
    my $tv2 = shift;
    my $tv3 = shift;
    # Execution
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT tid FROM repo_config WHERE tus = encode('". $tus ."','base64') AND tmd = encode('". $tmd ."','base64') AND tky = encode('". $tky ."','base64')") or die "[". (localtime) ."] Repo Insert Select Failed: $DBI::errstr\n";
    $sth->execute();
    if ($sth->rows == 1) {
	while ( (my $tid) = $sth->fetchrow_array()) {
	    $dbh->do("UPDATE repo_config SET tv1 = encode('". $tv1 ."','base64'), tv2 = encode('". $tv2 ."','base64'), tv3 = encode('". $tv3 ."','base64') WHERE tid = ". $tid ." ") or die "[". (localtime) ."] Repo Insert Failed: $DBI::errstr\n";
	}
    } else {
	$dbh->do("INSERT INTO repo_config(tus,tmd,tky,tv1,tv2,tv3) VALUES (encode('". $tus ."','base64'),encode('". $tmd ."','base64'),encode('". $tky ."','base64'),encode('". $tv1 ."','base64'),encode('". $tv2 ."','base64'),encode('". $tv3 ."','base64')) ") or die "[". (localtime) ."] Repo Insert Failed: $DBI::errstr\n";
    }
    $sth->finish;
    $dbh->disconnect;
    return 0;
}
#
sub SelectModView {
    my $uid = shift;
    my $mdl = shift;
    my $tky = shift;
    my $dbh = REPOConnect();
    my $sth = $dbh->prepare("SELECT decode(tv1,'base64') FROM repo_config WHERE tus = encode('". $uid ."','base64') AND tmd = encode('". $mdl ."','base64') AND tky = encode('". $tky ."','base64') ORDER BY tid ASC") or die "[". (localtime) ."] Repo Select Failed: $DBI::errstr\n";
    $sth->execute();
    return ($sth);
    $sth->finish;
    $dbh->disconnect;
}
#
close ($CF);
#
1;
