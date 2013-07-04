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
sub OracleDB {
    my $host = shift;
    my $client = shift;
    my $db = shift;
    my $cm = shift;
    my $uid = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    my $ah = kSChttp::RedirectJqGridDbInfo($host,$client,$db,"cinfo","json","T3JhY2xlREI=LkUu88",$uid,$cm,$search,$rows,$page,$sidx,$sord);
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
	if (kSCbasic::CheckUrlKeyValue("m","OracleDB","y") == 0) {
	    OracleDB(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} else {
	    my $out = kSChtml::ContentType("json");
	    $out.= kSCbasic::ErrorMessage("json","1");
	    print $out;
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","OracleDB","n") == 0) {
	    OracleDB(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("db"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} else {
	    my $out = kSChtml::ContentType("json");
	    $out.= kSCbasic::ErrorMessage("json","2");
	    print $out;
	    print kSCbasic::CheckUrlKeyValue("m","OracleDB","n");
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
