package mistique;
use Dancer2;
our $VERSION = '0.1';

use utf8;
use Encode; 

use MongoDB ();
use mistique::insumos;

get '/' => sub {
    template 'index' => { 'title' => 'mistique' };
};

get '/insumos' => sub {
	template 'insumos' => { insumos => mistique::insumos->get_all() };
};

get '/insumos/view/:id' => sub {
        my $id = route_parameters->get('id'); 
	return mistique::insumos->get_as_JSON($id);
};

put '/insumos/put/:id' => sub {
	my $id = route_parameters->get('id');
	my $json = JSON::MaybeXS->new;
	my $doc = $json->decode(decode_utf8(request->body));
	mistique::insumos->put($id, $doc);
	delayed { content "200" ; }
};

#-------------------------------------------------------------------

use mistique::marcas;

get '/marcas' => sub {
	#	my @ms = mistique::marcas->get_all_sort();
	#for my $m (@{$ms[0]}) {
	#	print Dumper($m->{cat});
	#}

	my @ms = mistique::marcas->get_all_sort();
	my $cat = "";
	my @pl = ();
	my @tl = ();
	for my $m (@{$ms[0]}) {
		if($m->{cat} eq $cat) {
			push @pl, $m;
		} else {
			push @tl, {cat => $cat, pl => [@pl]} if @pl;
			@pl = ();
			push @pl, $m;
			$cat = $m->{cat};
		}
	} 
	push @tl, {cat => $cat, pl => [@pl]} if @pl;

	#use Data::Dumper; print Dumper([@tl]);
	template 'marcas' => { cats => [@tl]};
};

get '/marcas/view/:id' => sub {
        my $id = route_parameters->get('id'); 
	return mistique::marcas->get_as_JSON($id);
};

get '/marcas/del/:id' => sub {
        my $id = route_parameters->get('id'); 
	if(mistique::marcas->delete($id)) {
		delayed { content "200" ; }
	}
};

put '/marcas/put/:id?' => sub {
	my $id = route_parameters->get('id');
	use Data::Dumper; print "mistique ".Dumper($id);
	my $json = JSON::MaybeXS->new;
	my $doc = $json->decode(decode_utf8(request->body));
	mistique::marcas->put($id, $doc);
	delayed { content "200" ; }
};

#-------------------------------------------------------------------

true;
