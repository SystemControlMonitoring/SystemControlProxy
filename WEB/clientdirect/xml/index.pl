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
    my $coreml = shift;
    my $module = shift;
    my $uid = shift;
    #
    my $ah = kSChttp::AllHosts($coreml,"xml",$module,$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	if ( $type ne "1" ) {
	    $data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	}
	$out .= $data;
	$out = substr($out, 1);
	$out = substr($out, 0, -1);
    }
    # Del old header
    $out = substr($out, index($out, "?>")+2 );
    # add >
    $out .= ">";
    print kSChtml::ContentType("xml");
    print $out;
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
	Proxy(kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	Proxy(kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
    } else {
	my $out = kSChtml::ContentType("xml");
	$out.= kSCbasic::ErrorMessage("xml","0");
	print $out;
    }
}

#
# End
#
