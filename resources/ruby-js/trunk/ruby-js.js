// Ext::Javascript.rb_init
Ext.namespace('Rb');
Rb.scope = {};
Rb.request = function(url) {
	Ext.Ajax.request({ url: url, method: 'GET',
		//params: { filename: name },
		success: function( result, request ) { window.eval(result.responseText); },
		failure: function() { Ext.Msg.alert('Error', 'Error in Rb.request('+url+')'); }
	});
}
Rb.ext = function(url) { Rb.request("/javascript-bundle-ext/"+url) };
