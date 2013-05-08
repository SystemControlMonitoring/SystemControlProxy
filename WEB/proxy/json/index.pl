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
	my $data = $ah->{$key}->{'result'};
	if ( $type ne "1" ) {
	    $data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	}
	$out .= $data;
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
sub SlimTaov {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","U2xpbVRhb3Y=Hkd83k",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub FillLiveticker {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","RmlsbExpdmV0aWNrZXI=RpY2Fs",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub SelectLiveticker {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","U2VsZWN0TGl2ZXRpY2tlcg==RpKlFs",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"SERVICES\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AllHosts {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","QWxsSG9zdHM=Uhd739",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"HOSTS\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
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
	if (kSCbasic::CheckUrlKeyValue("m","SlimTaov","y") == 0) {
	    SlimTaov(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","y") == 0) {
	    FillLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","y") == 0) {
	    SelectLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","y") == 0) {
	    AllHosts(kSCbasic::GetUrlKeyValue("u"));
	} else {
	    Proxy(kSCbasic::GetUrlKeyValue("t"),kSCbasic::DecodeBase64u6(kSCbasic::GetUrlKeyValue("cm")),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
	}
    } elsif (kSCbasic::CheckUrlKeyValue("e","0","n") == 0) {
	if (kSCbasic::CheckUrlKeyValue("m","SlimTaov","y") == 0) {
	    SlimTaov(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","FillLiveticker","y") == 0) {
	    FillLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","SelectLiveticker","y") == 0) {
	    SelectLiveticker(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllHosts","y") == 0) {
	    AllHosts(kSCbasic::GetUrlKeyValue("u"));
	} else {
	    Proxy(kSCbasic::GetUrlKeyValue("t"),kSCbasic::GetUrlKeyValue("cm"),kSCbasic::GetUrlKeyValue("m"),kSCbasic::GetUrlKeyValue("u"));
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
