#!/usr/bin/env perl

use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

use LWP::UserAgent;
use JSON qw(from_json);

my $md5 = $ARGV[0] or die("Usage: bzc.pl <md5 hex>");

## DEPRECATED API! -- Fuck Google.
my $ua = LWP::UserAgent->new();
my $response = $ua->get("http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=".$md5);
my $json = from_json($response->content);

my $results_ref = $json->{"responseData"}{"results"};
my @results = @$results_ref;
foreach my $result (@results) {
	my $pattern = qr/([^\w])|_/;
	my @title = split($pattern, $result->{"title"});
	my @content = split($pattern, $result->{"content"});
	
	bzc_check($_, $md5) foreach (@title);
	bzc_check($_, $md5) foreach (@content);
	
	print "Did not find any matches.\n";
	exit 1;
}

sub bzc_check {
	my $str = shift;
	my $hex = shift;
	if (md5_hex($str) eq $hex) {
		print $md5.": ".$_."\n";
		exit 0;
	}
}