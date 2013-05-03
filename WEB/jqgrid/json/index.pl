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
sub JqGridDirect {
    my $corenode = shift;
    my $client = shift;
    my $module = shift;
    my $uid = shift;
    my $api_module = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    my $ah = kSChttp::RedirectJqGridInfo($corenode,$client,"cinfo","json",$module,$uid,$api_module,$search,$rows,$page,$sidx,$sord);
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
	JqGridDirect(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("h")),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	JqGridDirect(kSCbasic::GetUrlKeyValue("h"),kSCbasic::GetUrlKeyValue("c"),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","0");
	print $out;
    }
}

#
# End
#
