JS.util.Enum={forEach:function(a,c){for(var b=0,e=this.length;b<e;b++){if(this[b])a.call(c||null,this[b],b)}},isComparable:function(c){return c.all(function(a){return Function.is(a.compareTo)})},Collection:JS.Class({initialize:function(c){this.length=0;var b=Array.prototype.push;JS.util.Enum.forEach.call(c,function(a){b.call(this,a)},this)}})};JS.util.Enum.methods={all:function(b,e){var d=true;this.forEach(function(a,c){d=d&&b.call(e||null,a,c)});return!!d},any:function(b,e){var d=false;this.forEach(function(a,c){d=d||b.call(e||null,a,c)});return!!d},forEachCons:function(a,c,b){var e=this.entries(),d=e.length,g=d-a;for(var f=0;f<=g;f++)c.call(b||null,e.slice(f,f+a),f)},forEachSlice:function(a,c,b){var e=this.entries(),d=e.length,g=Math.ceil(d/a);for(var f=0;f<g;f++)c.call(b||null,e.slice(f*a,(f+1)*a),f)},find:function(b,e){var d={},g=d;this.forEach(function(a,c){if(d!=g)return;d=b.call(e||null,a,c)?a:d});return d==g?null:d},inject:function(b,e,d){var g=0,f={};if(Function.is(b)){d=e;e=b;b=f}this.forEach(function(a,c){if(!g++&&b===f)return b=a;b=e.call(d||null,b,a,c)});return b},map:function(b,e){var d=[];this.forEach(function(a,c){d.push(b.call(e||null,a,c))});return d},max:function(a,c){var b=this.sort(a,c);return b[b.length-1]},member:function(c){return this.any(function(a){return a==c})},min:function(a,c){var b=this.sort(a,c);return b[0]},partition:function(b,e){var d=[],g=[];this.forEach(function(a,c){(b.call(e||null,a,c)?d:g).push(a)});return[d,g]},reject:function(b,e){var d=[];this.forEach(function(a,c){if(!b.call(e||null,a,c))d.push(a)});return d},select:function(b,e){var d=[];this.forEach(function(a,c){if(b.call(e||null,a,c))d.push(a)});return d},sort:function(b,e){var d=JS.util.Enum.isComparable(this),g=this.entries();b=b||(d?function(a,c){return a.compareTo(c)}:null);return b?g.sort(function(a,c){return b.call(e||null,a,c)}):g.sort()},sortBy:function(b,e){var d=JS.util.Enum;var g=new d.Collection(this.map(b,e));var f=d.isComparable(g);return new d.Collection(g.zip(this).sort(function(a,c){a=a[0];c=c[0];return f?a.compareTo(c):(a<c?-1:(a>c?1:0))})).map(function(a){return a[1]})},toArray:function(){return this.map(function(a){return a})},zip:function(){var e=JS.util.Enum;var d=[],g=0,f=arguments.length,h,i;if(arguments[f-1]instanceof Function){h=arguments[f-1];i={}}if(arguments[f-2]instanceof Function){h=arguments[f-2];i=arguments[f-1]}e.forEach.call(arguments,function(a){if(a==h||a==i)return;if(a.toArray)a=a.toArray();if(a instanceof Array)d.push(a)});var j=this.map(function(c){var b=[c];e.forEach.call(d,function(a){b.push(a[g]===undefined?null:a[g])});return++g&&b});if(!h)return j;e.forEach.call(j,h,i)}};JS.extend(JS.util.Enum.methods,{collect:JS.util.Enum.methods.map,detect:JS.util.Enum.methods.find,entries:JS.util.Enum.methods.toArray,every:JS.util.Enum.methods.all,findAll:JS.util.Enum.methods.select,filter:JS.util.Enum.methods.select,some:JS.util.Enum.methods.any});JS.Enumerable={included:function(a){a.include({forEach:JS.util.Enum.forEach},false);a.include(JS.util.Enum.methods)}};JS.util.Enum.Collection.include(JS.Enumerable);