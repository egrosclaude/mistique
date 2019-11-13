package mistique::marcas;
use MongoDB ();
use JSON::MaybeXS;
use BSON::Types ':all';


my $client = MongoDB::MongoClient->new(host=>'localhost', port=>27017);
my $db = $client->get_database('mistica');
my $coll = $db->get_collection('marcas'); 
my $json = JSON::MaybeXS->new;

use Data::Dumper; 
	
sub makeOID {
	my ($self, $id) = @_;
	return BSON::OID->new({oid => pack("H*", "$id")});
}

sub get {
	my ($self, $id) = @_;

	return $coll->find_id(mistique::marcas->makeOID("$id")); 
}

sub get_as_JSON {
	my ($self, $id) = @_;

    	$json->convert_blessed(1);
    	return $json->encode(mistique::marcas->get($id));
}

sub get_all {
	my $self = shift;

	my @i = $coll->find->all;
	return \@i;
}

sub get_all_sort {
	my ($self,$field) = @_;

	my @i = $coll->find({},{sort => {"cat" => 1}})->result->{_docs};
	return @i;
}

sub get_all_filter {
	my ($self,$filter) = @_;

	my @i = $coll->find($filter)->result->{_docs}; ### VER
	return \@i;
}

sub get_all_as_JSON {
	my $self = shift;

    	$json->convert_blessed(1);
	my @list;
	foreach my $i ($coll->find->all) {
		push @list, $json->encode($i);
	}
	return \@list;
}

sub put {
	my ($self, $id, $doc) = @_;
	if($id) {
		return $coll->replace_one({'_id' => mistique::marcas->makeOID($id)},$doc);
	} else {
		return $coll->insert_one($doc);
	}
}

true;
