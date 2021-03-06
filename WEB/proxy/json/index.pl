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
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","y") == 0) {
	    AllDatabases(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	    HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfo","y") == 0) {
	    DatabaseFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfo","y") == 0) {
	    MiddlewareFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHosts","y") == 0) {
	    ListHosts(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListServices","y") == 0) {
	    ListServices(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListDatabases","y") == 0) {
	    ListDatabases(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListMiddleware","y") == 0) {
	    ListMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHostgroups","y") == 0) {
	    ListHostgroups(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceHostList","y") == 0) {
	    ServiceHostList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("c"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceStatusSelect","y") == 0) {
	    ServiceStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceSearchList","y") == 0) {
	    ServiceSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseStatusSelect","y") == 0) {
	    DatabaseStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseSearchList","y") == 0) {
	    DatabaseSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostStatusSelect","y") == 0) {
	    HostStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSearchList","y") == 0) {
	    HostSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoSearchHost","y") == 0) {
	    HostFullInfoSearchHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoStatusHost","y") == 0) {
	    HostFullInfoStatusHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoSearchDatabase","y") == 0) {
	    DatabaseFullInfoSearchDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoStatusDatabase","y") == 0) {
	    DatabaseFullInfoStatusDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoSearchMiddleware","y") == 0) {
	    MiddlewareFullInfoSearchMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoStatusMiddleware","y") == 0) {
	    MiddlewareFullInfoStatusMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
	    ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowAllComments","y") == 0) {
	    ShowAllComments(kSCbasic::GetUrlKeyValue("u"));
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
	} elsif (kSCbasic::CheckUrlKeyValue("m","AllDatabases","y") == 0) {
	    AllDatabases(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfo","y") == 0) {
	    HostFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfo","y") == 0) {
	    DatabaseFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfo","y") == 0) {
	    MiddlewareFullInfo(kSCbasic::GetUrlKeyValue("u"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHosts","y") == 0) {
	    ListHosts(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListServices","y") == 0) {
	    ListServices(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListDatabases","y") == 0) {
	    ListDatabases(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListMiddleware","y") == 0) {
	    ListMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ListHostgroups","y") == 0) {
	    ListHostgroups(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceHostList","y") == 0) {
	    ServiceHostList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("c"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceStatusSelect","y") == 0) {
	    ServiceStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ServiceSearchList","y") == 0) {
	    ServiceSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseStatusSelect","y") == 0) {
	    DatabaseStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseSearchList","y") == 0) {
	    DatabaseSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostStatusSelect","y") == 0) {
	    HostStatusSelect(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostSearchList","y") == 0) {
	    HostSearchList(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoSearchHost","y") == 0) {
	    HostFullInfoSearchHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","HostFullInfoStatusHost","y") == 0) {
	    HostFullInfoStatusHost(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoSearchDatabase","y") == 0) {
	    DatabaseFullInfoSearchDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","DatabaseFullInfoStatusDatabase","y") == 0) {
	    DatabaseFullInfoStatusDatabase(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoSearchMiddleware","y") == 0) {
	    MiddlewareFullInfoSearchMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("searchstring"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","MiddlewareFullInfoStatusMiddleware","y") == 0) {
	    MiddlewareFullInfoStatusMiddleware(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("s"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowCritical","y") == 0) {
	    ShowCritical(kSCbasic::GetUrlKeyValue("u"),kSCbasic::GetUrlKeyValue("_search"),kSCbasic::GetUrlKeyValue("rows"),kSCbasic::GetUrlKeyValue("page"),kSCbasic::GetUrlKeyValue("sidx"),kSCbasic::GetUrlKeyValue("sord"));
	} elsif (kSCbasic::CheckUrlKeyValue("m","ShowAllComments","y") == 0) {
	    ShowAllComments(kSCbasic::GetUrlKeyValue("u"));
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
    my @temp;
    my $out = "";
    #####
    #
    # Get data from client
    #
    #####
    my $ah = kSCjson::GetServices("lda","json","U2VsZWN0TGl2ZXRpY2tlcg==RpKlFs",$uid);
    #####
    #
    # Loop trough array
    #
    #####
    foreach my $key (keys %{$ah}) {
	my @array = @{$ah->{$key}->{'result'}};
	my $count = scalar(@array);
	for (my $x=0;$x<$count;$x++) {
	    push @temp, [$ah->{$key}->{'result'}[$x]->{'TIMESTAMP'},$ah->{$key}->{'result'}[$x]->{'INCIDENT'},$ah->{$key}->{'result'}[$x]->{'DISPLAY_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_NAME'},$ah->{$key}->{'result'}[$x]->{'SERVICE_STATE'},$ah->{$key}->{'result'}[$x]->{'HOST_STATE'},$ah->{$key}->{'result'}[$x]->{'CUSTOM_VAR'},$ah->{$key}->{'result'}[$x]->{'ICON'},$ah->{$key}->{'result'}[$x]->{'OUTPUT'},$key];
	}
    }
    #####
    #
    # Sorting
    #
    #####
    my @tmp = reverse sort {$a->[0] cmp $b->[0]} @temp;
    #####
    #
    # Output
    #
    #####
    for(my $i=0;$i<scalar(@tmp);$i++) {
	$out.="{\"TIMESTAMP\":\"". kSCbasic::ConvertUt2Ts($tmp[$i][0]) ."\",\"INCIDENT\":\"". $tmp[$i][1] ."\",\"SERVICE_NAME\":\"". $tmp[$i][2] ."\",\"HOST_NAME\":\"". $tmp[$i][3] ."\",\"SERVICE_STATUS\":\"". $tmp[$i][4] ."\",\"HOST_STATUS\":\"". $tmp[$i][5] ."\",\"CUST_VAR\":\"". $tmp[$i][6] ."\",\"HOST_ICON\":\"". $tmp[$i][7] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($tmp[$i][8]) ."\",\"NODE\":\"". $tmp[$i][9] ."\"},";
    }
    $out = substr($out, 0, -1);
    #
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
sub HostFullInfo {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","SG9zdEZ1bGxJbmZvHd78h3",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"HostFullInfo\",\"HFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostFullInfoSearchHost {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","SG9zdEZ1bGxJbmZvU2VhcmNoSG9zdA==Ki88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"HostFullInfoSearchHost\",\"STRING_PROXY\":\"". $searchstring ."\",\"HFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";

}
#
sub HostFullInfoStatusHost {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","SG9zdEZ1bGxJbmZvU3RhdHVzSG9zdA==Ki88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"HostFullInfoStatusHost\",\"STRING_PROXY\":\"". $state ."\",\"HFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseFullInfo {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","RGF0YWJhc2VGdWxsSW5mbw==Hd78h3",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"DatabaseFullInfo\",\"DBFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseFullInfoSearchDatabase {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","RGF0YWJhc2VGdWxsSW5mb1NlYXJjaERhdGFiYXNlKi88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"DatabaseFullInfoSearchDatabase\",\"STRING_PROXY\":\"". $searchstring ."\",\"DBFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";

}
#
sub DatabaseFullInfoStatusDatabase {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","RGF0YWJhc2VGdWxsSW5mb1N0YXR1c0RhdGFiYXNlKi88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"DatabaseFullInfoStatusDatabase\",\"STRING_PROXY\":\"". $state ."\",\"DBFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub MiddlewareFullInfo {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","TWlkZGxld2FyZUZ1bGxJbmZvHd78h3",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"MiddlewareFullInfo\",\"WLSFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub MiddlewareFullInfoSearchMiddleware {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","TWlkZGxld2FyZUZ1bGxJbmZvU2VhcmNoTWlkZGxld2FyZQ==Ki88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"MiddlewareFullInfoSearchMiddleware\",\"STRING_PROXY\":\"". $searchstring ."\",\"WLSFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";

}
#
sub MiddlewareFullInfoStatusMiddleware {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","TWlkZGxld2FyZUZ1bGxJbmZvU3RhdHVzTWlkZGxld2FyZQ==Ki88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"MODUL\":\"MiddlewareFullInfoStatusMiddleware\",\"STRING_PROXY\":\"". $state ."\",\"WLSFI\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    $out =~ s/\"HFI\":}/\"HFI\":""}/g;
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ShowCritical2 {
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
sub ShowCritical {
    my $uid = shift;
    my @temp;
    my $out;
    #####
    #
    # Get data from client
    #
    #####
    my $ah = kSCjson::GetServices("lda","json","U2hvd0NyaXRpY2FsHjdz6d",$uid);
    #####
    #
    # Loop trough array
    #
    #####
    foreach my $key (keys %{$ah}) {
	my @array = @{$ah->{$key}->{'result'}};
	my $count = scalar(@array);
	for (my $x=0;$x<$count;$x++) {
	    push @temp, [$ah->{$key}->{'result'}[$x]->{'SERVICE_STATUS_ICON'},$ah->{$key}->{'result'}[$x]->{'SERVICE_STATUS'},$ah->{$key}->{'result'}[$x]->{'TIMESTAMP'},$ah->{$key}->{'result'}[$x]->{'SERVICE_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_STATUS'},$ah->{$key}->{'result'}[$x]->{'OUTPUT'},$key,$ah->{$key}->{'result'}[$x]->{'ACK'},$ah->{$key}->{'result'}[$x]->{'CMT'}];
	}
    }
    #####
    #
    # Sorting
    #
    #####
    my @tmp = reverse sort {$a->[2] cmp $b->[2]} @temp;
    #####
    #
    # Output
    #
    #####
    for(my $i=0;$i<scalar(@tmp);$i++) {
	$out.="{\"SERVICE_STATUS_ICON\":\"". $tmp[$i][0] ."\",\"SERVICE_STATUS\":\"". $tmp[$i][1] ."\",\"TIMESTAMP\":\"". kSCbasic::ConvertUt2Ts($tmp[$i][2]) ."\",\"SERVICE_NAME\":\"". $tmp[$i][3] ."\",\"HOST_NAME\":\"". $tmp[$i][4] ."\",\"HOST_STATUS\":\"". $tmp[$i][5] ."\",\"OUTPUT\":\"". kSCbasic::EncodeHTML($tmp[$i][6]) ."\",\"NODE\":\"". $tmp[$i][7] ."\",\"ACK\":\"". $tmp[$i][8] ."\",\"CMT\":\"". $tmp[$i][9] ."\"},";
    }
    $out = substr($out, 0, -1);
    #
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ListHosts {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSearchArray("search","json","TGlzdEhvc3RzHj86Hz",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	$out .= $data .",";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "{\"hosts\":[". $out ."]}";
}
#
sub ListServices {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSearchArray("search","json","TGlzdFNlcnZpY2VzHj86Hz",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	$out .= $data .",";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "{\"services\":[". $out ."]}";
}
#
sub ListDatabases {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSearchArray("search","json","TGlzdERhdGFiYXNlcw==Hj86Hz",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	$out .= $data .",";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "{\"databases\":[". $out ."]}";
}
#
sub ListMiddleware {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSearchArray("search","json","TGlzdE1pZGRsZXdhcmU=Hj86Hz",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	$out .= $data .",";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "{\"middleware\":[". $out ."]}";
}
#
sub ListHostgroups {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSearchArray("search","json","TGlzdEhvc3Rncm91cHM=Hj86Hz",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/{\"/{\"NODE\":\"$key\",\"/g;
	$out .= $data .",";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "{\"hostgroups\":[". $out ."]}";
}
#
sub ServiceHostList {
    my $uid = shift;
    my $client = shift;
    #
    my $ah = kSChttp::GetServiceArray("search","json","U2VydmljZUhvc3RMaXN0KhdU8Z",$uid,$client);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= $ah->{$key}->{'result'};
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ServiceStatusSelect {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","U2VydmljZVN0YXR1c1NlbGVjdA==Ki88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/\"SERVICELIST\":]}/\"SERVICELIST\":[]}/g;
	$out .= "{\"NODE\":\"". $key ."\",\"SRVSTATSEL\":". $data ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ServiceSearchList {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","U2VydmljZVNlYXJjaExpc3Q=Ki88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$data =~ s/\"SERVICELIST\":]}/\"SERVICELIST\":[]}/g;
	$out .= "{\"NODE\":\"". $key ."\",\"SRVSEARCH\":". $data ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostStatusSelect {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","SG9zdFN0YXR1c1NlbGVjdA==Ki88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"HOSTS\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub HostSearchList {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","SG9zdFNlYXJjaExpc3Q=Ki88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"HOSTS\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub AllDatabases {
    my $uid = shift;
    #
    my $ah = kSChttp::GetArray("lda","json","QWxsRGF0YWJhc2VzZhd873",$uid);
    my $out;
    foreach my $key (keys %{$ah}) {
	$out .= "{\"NODE\":\"". $key ."\",\"DATABASES\":". $ah->{$key}->{'result'} ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseStatusSelect {
    my $uid = shift;
    my $state = shift;
    #
    my $ah = kSChttp::GetSrvStatSelArray("lda","json","RGF0YWJhc2VTdGF0dXNTZWxlY3Q=Ki88uU",$uid,$state);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= "{\"NODE\":\"". $key ."\",\"DBSTATSEL\":". $data ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub DatabaseSearchList {
    my $uid = shift;
    my $searchstring = shift;
    #
    my $ah = kSChttp::GetSrvSearchArray("lda","json","RGF0YWJhc2VTZWFyY2hMaXN0Ki88uU",$uid,$searchstring);
    my $out;
    foreach my $key (keys %{$ah}) {
	my $data = $ah->{$key}->{'result'};
	$out .= "{\"NODE\":\"". $key ."\",\"DBSEARCH\":". $data ."},";
    }
    $out = substr($out, 0, -1);
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}
#
sub ShowAllComments {
    my $uid = shift;
    my @temp;
    my $out;
    #
    # Get data from client
    my $ah = kSCjson::GetServices("lda","json","U2hvd0FsbENvbW1lbnRzHjdz6d",$uid);
    #
    # Loop trough array
    foreach my $key (keys %{$ah}) {
	my @array = @{$ah->{$key}->{'result'}};
	my $count = scalar(@array);
	for (my $x=0;$x<$count;$x++) {
	    push @temp, [$ah->{$key}->{'result'}[$x]->{'AUTHOR'},$ah->{$key}->{'result'}[$x]->{'COMMENT'},$ah->{$key}->{'result'}[$x]->{'TIMESTAMP'},$ah->{$key}->{'result'}[$x]->{'TIMESTAMP_ISO'},$key,$ah->{$key}->{'result'}[$x]->{'SERVICE_NAME'},$ah->{$key}->{'result'}[$x]->{'HOST_NAME'}];
	}
    }
    #
    # Sorting
    my @tmp = reverse sort {$a->[2] cmp $b->[2]} @temp;
    #
    # Output
    for(my $i=0;$i<scalar(@tmp);$i++) {
	$out.="{\"AUTHOR\":\"". $tmp[$i][0] ."\",\"COMMENT\":\"". $tmp[$i][1] ."\",\"TIMESTAMP\":\"". $tmp[$i][2] ."\",\"TIMESTAMP_ISO\":\"". $tmp[$i][3] ."\",\"NODE\":\"". $tmp[$i][4] ."\",\"SERVICE_NAME\":\"". $tmp[$i][5] ."\",\"HOST_NAME\":\"". $tmp[$i][6] ."\"},";
    }
    $out = substr($out, 0, -1);
    #
    print kSChtml::ContentType("json");
    print "[". $out ."]";
}