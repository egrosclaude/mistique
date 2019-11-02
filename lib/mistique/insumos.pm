package mistique::insumos;
use MongoDB ();
use JSON::MaybeXS;
use BSON::Types ':all';

my $client = MongoDB::MongoClient->new(host=>'localhost', port=>27017);
my $db = $client->get_database('mistica');
my $coll = $db->get_collection('insumos'); 
my $json = JSON::MaybeXS->new;

use Data::Dumper; 
	

sub get {
	my ($self, $id) = @_;

	#use Data::Dumper; print Dumper($id);
	#return $ins->find_one({ _id => BSON::OID->new({oid => pack("H*","$id")})});
	return $coll->find_id(BSON::OID->new({oid => pack("H*", "$id")})); 
}

sub get_as_JSON {
	my ($self, $id) = @_;

    	$json->convert_blessed(1);
    	return $json->encode(mistique::insumos->get($id));
}

sub get_all {
	my $self = shift;

	my @i = $coll->find->all;
	return \@i;
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

true;
