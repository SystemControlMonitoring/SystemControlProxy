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
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","y") == 0) {
	    OracleDBAdmin(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
	} else {
	    ClientInfo(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("m"));
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","SYSINFO","n") == 0) {
	    SysInfo(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DBINFO","n") == 0) {
	    DbInfo(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","OracleDBAdmin","n") == 0) {
	    OracleDBAdmin(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("date_start"),kSCbasic::GetUrlKeyValue("date_end"));
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
