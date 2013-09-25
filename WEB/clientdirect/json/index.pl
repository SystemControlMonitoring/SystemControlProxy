#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCproxy/MOD/html';
use lib '/kSCproxy/MOD/basic';
use lib '/kSCproxy/MOD/http';
# Include Library
use kSChtml;
use kSCbasic;
use kSChttp;
use warnings;
use strict;
use Data::Dumper;
#
my $request = FCGI::Request();
#
#
#
#
#
# Functions
#
sub ClientInfo {
    my $corenode = shift;
    my $client = shift;
    my $uid = shift;
    my $module = shift;
    my $ah = kSChttp::RedirectSysInfo($corenode,$client,"cinfo","json",$module,$uid);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub SysInfo {
    my $corenode = shift;
    my $client = shift;
    my $uid = shift;
    my $ah = kSChttp::RedirectSysInfo($corenode,$client,"cinfo","json","U1lTSU5GTw==KK86tT",$uid);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub DbInfo {
    my $corenode = shift;
    my $client = shift;
    my $db = shift;
    my $uid = shift;
    my $ah = kSChttp::RedirectDbInfo($corenode,$client,$db,"cinfo","json","REJJTkZPKlUQz7",$uid);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub GetWls {
    my $mode = shift;
    my $corenode = shift;
    my $client = shift;
    my $port = shift;
    my $uid = shift;
    my $ah = kSChttp::RedirectWlsInfo($corenode,$client,$port,"cinfo","json",kSCbasic::EncodeBase64u6($mode),$uid);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub OracleDBAdmin {
    my $corenode = shift;
    my $client = shift;
    my $db = shift;
    my $uid = shift;
    my $cm = shift;
    my $datestart = shift;
    my $dateend = shift;
    my $ah = kSChttp::RedirectODBAdmin($corenode,$client,$db,"cinfo","json","T3JhY2xlREJBZG1pbg==KlUQz7",$uid,$cm,$datestart,$dateend);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub LogAdmin {
    my $corenode = shift;
    my $client = shift;
    my $log = shift;
    my $uid = shift;
    my $cm = shift;
    #
    #
    my $ah = kSChttp::RedirectLogAdmin($corenode,$client,$log,"cinfo","json","TG9nQWRtaW4=KlUQz7",$uid,$cm);
    #
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= $data;
    }
    print kSChtml::ContentType("json");
    print $out;
}
#
sub SrvLogAdmin {
    my $client = shift;
    my $log = shift;
    my $uid = shift;
    my $cm = shift;
    my $out;
    #
    # String Vorbereitungen
    $client = substr($client, 0, -1);
    $client =~ s/[\s\r\n]+//g;
    $log = substr($log, 0, -1);
    $log =~ s/[\s\r\n]+//g;
    #
    # Array Vorbereitungen
    my @clnt = split(";", $client);
    my @lgfl = split(";", $log);
    #
    # Auswertungen
    for (my $c=0;$c<scalar(@lgfl);$c++) {
	#
	# Get Logfile
	$lgfl[$c] =~ s/LOGWATCH_//g;
	my $lg = substr($lgfl[$c], rindex($lgfl[$c], "/")+1);
	#
	# Get Client@Node
	my @clnd = split("@", $clnt[$c]);
	#
	# Execution
	#$out .= ">". $lg .":". $clnd[0] .":". $clnd[1] ."";
        my $ah = kSChttp::RedirectLogAdmin($clnd[1],kSCbasic::EncodeBase64u6($clnd[0]),$lg,"cinfo","json","TG9nQWRtaW4=KlUQz7",$uid,$cm);
	#
	foreach my $key (keys %{$ah}) {
	    my $data = $ah->{$key}->{'result'};
	    $out .= $data .",";
	}
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    if ($out eq "," || $out =~ /,,/i) {
	print "{\"ResultValue\":\"0\"}";
    } else {
	print "[". $out ."]";
    }
}
#
#
#
#
#
#
#
# Output
#
# e = encoded, m = module, cm = coremodule

while($request->Accept() >= 0) {
    if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","SYSINFO","y") == 0) {
	    SysInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DBINFO","y") == 0) {
	    DbInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","GETWLS","y") == 0) {
	    GetWls("GETWLS",kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("port"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLSINFO","y") == 0) {
	    GetWls("WLSINFO",kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("port"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","y") == 0) {
	    OracleDBAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","LogAdmin","y") == 0) {
	    LogAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("log"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SrvLogAdmin","y") == 0) {
	    SrvLogAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("c")),kSCbasic::GetUrlKeyValue("log"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"));
	} else {
	    ClientInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m"));
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","SYSINFO","n") == 0) {
	    SysInfo(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DBINFO","n") == 0) {
	    DbInfo(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","GETWLS","n") == 0) {
	    GetWls("GETWLS",kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("port"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","WLSINFO","n") == 0) {
	    GetWls("WLSINFO",kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("port"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","n") == 0) {
	    OracleDBAdmin(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","LogAdmin","n") == 0) {
	    LogAdmin(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("log"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SrvLogAdmin","n") == 0) {
	    SrvLogAdmin(kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("log"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"));
	} else {
	    ClientInfo(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m"));
	}
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","0");
	print $out;
    }
}

#
# End
#
