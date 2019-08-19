#!/usr/bin/perl
# from http://lab4.org/wiki/Zabbix_API 
# see also: https://www.zabbix.com/documentation/3.2/manual/api/reference/configuration/export
# usage:
# zabbix-dump.pl <type> <object_ID>
#
use strict;
use warnings;
use JSON::RPC::Legacy::Client;
use Data::Dumper;
 
# Authenticate yourself
my $client = new JSON::RPC::Legacy::Client;
my $url = 'http://3.187.7.36/zabbix/zabbix/api_jsonrpc.php';
my $authID;
my $response;

my $json = {
        jsonrpc => "2.0",
        method => "user.login",
        params => {
                user => "Admin",
                password => "zabbix" },
        id => 1
}; 
 
$response = $client->call($url, $json);
#print($response);
# Check if response was successful
die "Authentication failed\n" unless $response->content->{'result'};
# Print full response to console
#print Dumper($response);

# Extract AuthID from returned object.
$authID = $response->content->{'result'};
#print "Authentication successful. Auth ID: " . $authID . "\n";

# Get list of all hosts using authID
$json = {
        jsonrpc=> '2.0',
        method => 'configuration.export',
        params => {
                options => { $ARGV[0] => ["$ARGV[1]"] },
                format => 'json' },
        id => 1,
        auth => "$authID",
        };

#print Dumper($json);
$response = $client->call($url, $json);
#print($response);
# Check if response was successful
die "Failed\n" unless $response->content->{result};
print $response->content->{result};
