var Ajax = {};

Ajax.get = (url, callback) => {
	var xhr =  new XMLHttpRequest();
	xhr.open('GET', url, false);
	xhr.onerror = () => {
		console.error('Request failed!');
	};
	xhr.onload = () => {
		if(xhr.readyState == 4 && xhr.status < 400) {
			callback(xhr.responseText);
		} else {
			alert('Request failed.  Returned status of ' + xhr.status);
		}
	};
	xhr.send();
};

Ajax.put = (url,data) => {
	var xhr = new XMLHttpRequest();
	xhr.open('PUT', url);
	xhr.onerror = () => {
		console.error('Request failed!');
	};
	xhr.setRequestHeader('Content-Type', 'application/json');
	xhr.onload = function() {
	    if (xhr.status === 200) {
	        var userInfo = JSON.parse(xhr.responseText);
	    }
	};
	var j = JSON.stringify(data);
	xhr.send(JSON.stringify(data));
};


/*
fetch('/my/name').then( 
	function (response) {
			if (response.ok) {
				return response.text();
			} else {
				throw new Error();
			}
	}).then(
		function success(name) {
			console.log('my name is ' + name);
		},
		function failure() {
			console.error('Name request failed!');
		}
	);
*/


/*
Ajax.fetchget = (url, callback) => {
	fetch(url).then(	
		(response) => {
			if(response.ok) {
				return response.text();
			} else {
				throw new Error();
			}
	}).then (
		(result) => {
			console.log("RESPONSE: ",result);
			callback(result);
		},
		() => {
			console.error('Fallo en GET');
		}
	);
};

*/


/*

Ajax.post = () => {
	var newName = 'John Smith',
    xhr = new XMLHttpRequest();

	xhr.open('POST', 'myservice/username?id=some-unique-id');
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onload = function() {
	    if (xhr.status === 200 && xhr.responseText !== newName) {
	        alert('Something went wrong.  Name is now ' + xhr.responseText);
	    }
	    else if (xhr.status !== 200) {
	        alert('Request failed.  Returned status of ' + xhr.status);
	    }
	};
	xhr.send(encodeURI('name=' + newName));
};


ajax.param = function param(object) {
    var encodedString = '';
    for (var prop in object) {
        if (object.hasOwnProperty(prop)) {
            if (encodedString.length > 0) {
                encodedString += '&';
            }
            encodedString += encodeURI(prop + '=' + object[prop]);
        }
    }
    return encodedString;
};
*/
