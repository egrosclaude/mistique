package mistique;
use Dancer2;

our $VERSION = '0.1';

use MongoDB ();
use mistique::insumos;

#use JSON::MaybeXS;
#use BSON::Types ':all';

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


#get '/insumosx' => sub {
#    my $c = MongoDB::MongoClient->new(host=>'localhost',port=>27017);
#   my $db = $c->get_database('mistica');
#
#   my $in = $db->get_collection('insumos');
#   my @data = $in->find()->all;
#
#   template 'insumos' => { 
#	    insumos => \@data, 
#   };
#};

true;
