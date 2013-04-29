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
sub Proxy {
    my $type = shift;
    my $coreml = shift;
    my $module = shift;
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray($coreml,"json",$module,$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out.= $ah->{$key}->{'result'};
	$out = substr($out, 1);
	$out = substr($out, 0, -1);
    }
    print kSChtml::ContentType("json");
    if ( $type eq "1" ) {
	print "{". $out ."}";
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
#
# Output
#
# e = encoded, m = module, cm = coremodule

while($request->Accept() >= 0) {
    if (kSCbasic::CheckUrlKeyValue("e","1","n") == 0) {
	Proxy(kSCbasic::GetUrlKeyValue("t"),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	Proxy(kSCbasic::GetUrlKeyValue("t"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("json");
	$out.= kSCbasic::ErrorMessage("json","0");
	print $out;
    }
}

#
# End
#
