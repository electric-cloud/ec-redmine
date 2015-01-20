use strict;
use warnings;
use LWP;
use JSON qw( decode_json );
use ElectricCommander;
use Data::Dumper;

my $ec = new ElectricCommander;

my $browser = LWP::UserAgent->new;
my $url = "http://$[/server/poc/REDMINE_HOST]/redmine/issue_statuses.json";
my $req = HTTP::Request->new(GET => $url);
$req->authorization_basic("$[/server/poc/REDMINE_USERNAME]", "$[/server/poc/REDMINE_PASSWORD]");

my $response = $browser->request($req);
if ($response->is_error) {
	if ($response->status_line ne '') {
		print "Error: " . $response->status_line;
	} else {
		print "Error: Unable to retrieve URL $url";
	}
	exit;
}
my $decoded = decode_json($response->content());
my $id;
foreach my $status(@{$decoded->{issue_statuses}}) {
    if ($status->{name} eq "$[new_status]") {
        $id = $status->{id};
    }
}
if (defined($id)) {
    $ec->setProperty("summary", "ID: $id");
    $ec->setProperty("/myParent/new_status_id", $id);
} else {
    print "Error: couldn't find ID for status $[new_status]";
}
