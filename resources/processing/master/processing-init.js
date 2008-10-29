function loadProcessing () {
	document.addEventListener("DOMContentLoaded", initProcessingScripts, false);
}

/* This code searches for all the <script type="application/processing" target="canvasid">
 * in your page and loads each script in the target canvas with the proper id.
 * It is useful to smooth the process of adding Processing code in your page and starting
 * the Processing.js engine. */
function initProcessingScripts () {
	/* the original init.js code from John Resig's examples */

	var scriptsOnPage, i, curScript, targetCanvas;
	
	scriptsOnPage = document.getElementsByTagName("script");
	
	for (i=0; i < scriptsOnPage.length; i++) {

		curScript = scriptsOnPage[i];
		
		if (scriptsOnPage[i].getAttribute("type") == "application/processing") {
			targetCanvas = document.getElementById(scriptsOnPage[i].getAttribute("targetCanvas"));

			if (targetCanvas) {
				Processing(targetCanvas, curScript.textContent);
			}
		}
	}

}

function initProcessingScripts_v2 () {
	/* Inspired by the original init.js code from John Resig's examples */
	if ( window.addEventListener ) {
		window.addEventListener("load", function() {
			var scripts = document.getElementsByTagName("script");
			
			for ( var i = 0; i < scripts.length; i++ ) {
				if ( scripts[i].type == "application/processing" ) {
					var src = scripts[i].src, canvas = scripts[i].nextSibling;
			
					if ( src && src.indexOf("#") ) {
						canvas = document.getElementById( src.substr( src.indexOf("#") + 1 ) );
					} else {
						while ( canvas && canvas.nodeName.toUpperCase() != "CANVAS" )
						canvas = canvas.nextSibling;
					}
			
					if ( canvas ) {	Processing(canvas, scripts[i].textContent);	}
				}
			}
		}, false);
	}
}


//window.onload = function()
//{
//  var canvas = document.getElementsByTagName("canvas");
//  for ( var i = 0; i < canvas.length; i++ )
//  {
//    Processing( canvas[i], canvas[i].previousSibling.textContent );
//  }
//};

initProcessingScripts_v2();