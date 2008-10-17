/*************************************************************************************************************
/*************************************************************************************************************
/* Name: com.fabbeast.effects.FaderGroup
/* Author: Marc George
/* Description: Simple class to cycle through a set of elements.
/* Dependencies: jQuery 1.2.1
/*
/*   Usage: var mycom.fabbeast.effects.FaderGroup = new com.fabbeast.effects.FaderGroup(String:selector, Boolean:randomize, Integer:speed(milliseconds))
/*          mycom.fabbeast.effects.FaderGroup.cycle()
/*          mycom.fabbeast.effects.FaderGroup.stop();
/*
/*          The selector parameter is any string that jQuery can use to select elements,
/*          usually in the form of a css class selector.
/*
/*************************************************************************************************************
/************************************************************************************************************/

if(!com){var com = {}};
if(!com.fabbeast){com.fabbeast = {}};
if(!com.fabbeast.effects){com.fabbeast.effects = {}};

com.fabbeast.effects.FaderGroup = function(/* String */ selector, /* Bool */ randomized, /* Integer*/ speed)
{
		/*check for presence of jQuery 1.2.1*/
		if(!$){
		throw new Error("com.fabbeast.effects.FaderGroup requires jQuery 1.2.1");
		return;
		}
		
		/*TODO - allow later versions of jQuery*/
		if($.fn.jquery != "1.2.1"){
		throw new Error("com.fabbeast.effects.FaderGroup requires jQuery 1.2.1. Your version: " + $.fn.jquery);
		return;
		}
		
		this.selector = selector;
		this.randomized = randomized;
		this.speed = speed;
		
		this.inter = null;
		this.fadeElements = [];
		this.currentIndex = 0;
		this.totalElements = 0;
		
		this.initialise();
		
}


com.fabbeast.effects.FaderGroup.prototype = {
	
	initialise: function(){
		
		var root = this;
				
		//push all fadeable elements into a storage array
		$(this.selector).each(
		
			function(){root.fadeElements.push(this)}
			
						)
		
		this.totalElements = this.fadeElements.length;
		
		if(this.randomized){
			this.randomize();
			this.currentIndex = Math.round(Math.random()* (this.totalElements - 1))
			}
			
		var firstObject = this.fadeElements[this.currentIndex];
		
		$(firstObject).show();
									
		
	},
	
	cycle: function(){
		
		var f = this;
		
		this.inter = setInterval(function(){f.doFadeOut.call(f)}, f.speed);
		
	},
	
	doFadeOut: function(){
		
		clearInterval(this.inter);
		var root = this;
		var els = this.fadeElements;
		var ce = els[this.currentIndex];
		
		//fadeout the current element
		
		$(ce).fadeOut(1000, function(){
			
				//advance the index
				root.currentIndex ++;
				if(root.currentIndex >= root.totalElements){
					root.currentIndex = 0;
				}
				
				ce = els[root.currentIndex];
				
				$(ce).fadeIn(1000, function(){root.cycle.call(root)});
				
		});
		
	},
	
	randomize: function(){
		
			var tempArray = [];
						
			while(this.fadeElements.length > 0){
				
				var randomIndex = Math.round(Math.random()*this.fadeElements.length - 1);
				var removedItemsArray = this.fadeElements.splice(randomIndex,1);
				tempArray.push(removedItemsArray[0])
				
			}
			
			//push them back in to the original array
			
			for(var i = this.totalElements - 1; i >= 0 ; i--){
				
				this.fadeElements.push(tempArray[i]);
				
			}
			
		},

	toString: function(){
	
	return "FaderGroup(" + this.totalElements +  " elements): {selector: " + this.selector + ", randomize: " + this.randomized + ", speed: " + this.speed + "}";
		
	}
	
	
}


