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

get '/insumos/prev/:id' => sub {
        my $id = route_parameters->get('id'); 
	return mistique::insumos->get_prev_as_JSON($id);
};

get '/insumos/next/:id' => sub {
        my $id = route_parameters->get('id'); 
	return mistique::insumos->get_next_as_JSON($id);
};

put '/insumos/put/:id' => sub {
	my $id = route_parameters->get('id');
	my $json = JSON::MaybeXS->new;
	my $doc = $json->decode(decode_utf8(request->body));
	mistique::insumos->put($id, $doc);
	delayed { content "200" ; }
};

true;
