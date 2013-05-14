#!/usr/bin/perl
#
# Include Library Path
use FCGI;
use lib '/kSCproxy/MOD/html';
use lib '/kSCproxy/MOD/basic';
use lib '/kSCproxy/MOD/http';
use lib '/kSCproxy/MOD/json';
# Include Library
use kSChtml;
use kSCbasic;
use kSChttp;
use kSCjson;
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
sub ShowCritical {
    my $uid = shift;
    my $search = shift;
    my $rows = shift;
    my $page = shift;
    my $sidx = shift;
    my $sord = shift;
    my @temp;
    my $total_page;
    my $limit;
    my $start;
    my $out;
    #####
    #
    # Get data from client
    #
    #####
    my $ah = kSCjson::GetJQgrid("lda","json","U2hvd0NyaXRpY2FsHjdz6d",$uid);

    #print Dumper $ah;
    #####
    #
    # Loop trough array
    #
    #####
    foreach my $key (keys %{$ah}) {
	my @array = @{$ah->{$key}->{'result'}};
	my $count = scalar(@array);
	for (my $x=0;$x<$count;$x++) {
	    push @temp, [$ah->{$key}->{'result'}[$x]->{'SERVICE_STATUS'},$ah->{$key}->{'result'}[$x]->{'TIMESTAMP'},$ah->{$key}->{'result'}[$x]->{'SERVICE_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_STATUS'},$ah->{$key}->{'result'}[$x]->{'OUTPUT'},$key];
	}
    }
    #####
    #
    # Sorting
    #
    #####
    my @tmp = reverse sort {$a->[1] cmp $b->[1]} @temp;
    #####
    #
    # Output
    #
    #####
    my $count = scalar(@tmp);
    if ($rows ne "z") {
	if ($count > $rows) {
	    if (($rows*$page) > $count) {
		$limit = $rows - (($rows*$page)-$count);
	    } else {
		$limit = $rows;
	    }
	} else {
	    $limit = $count;
	}
	if( $count > 0 ) {
	    $total_page = int(($count/$limit) + 0.99);
	} else {
	    $total_page = 0;
	}
	$start = $limit*$page - $limit;
    } else {
	$limit = $count;
	$total_page = "1";
	$start = 0;
    }
    if( $page > $total_page) {
	$page = $total_page;
    }
    $limit = $limit*$page;
    $out.="\"total\":\"". $total_page ."\",\"page\":\"". $page ."\",";
    $out.="\"records\":\"". $count ."\",\"rows\": [";
    for(my $i=$start;$i<$limit;$i++) {
	$out.="{\"id\":\"". $i ."\", \"cell\":[\"<img src='". $tmp[$i][0] ."'></img>\",\"". kSCbasic::ConvertUt2Ts($tmp[$i][1]) ."\",\"". $tmp[$i][2] ."\",\"". $tmp[$i][3] ."\",\"". $tmp[$i][4] ."\",\"". kSCbasic::EncodeHTML($tmp[$i][5]) ."\",\"". $tmp[$i][6] ."\"]},";
    }
    $out = substr($out, 0, -1);
    $out.="]";
    print kSChtml::ContentType("text");
    print "{". $out ."}";
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
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
	    ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
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
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
	    ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
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
