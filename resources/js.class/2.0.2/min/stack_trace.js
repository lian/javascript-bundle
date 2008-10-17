JS.StackTrace=new JS.Module({extend:{included:function(h){var f=h.__mod__||h,b=this;f.extend({define:function(a,c){if(!JS.isFn(c))return this.callSuper();var g=b.wrap(c,f,a);return this.callSuper(a,g)}});for(var d in f.__fns__)f.define(d,f.__fns__[d]);if(!f.__name__)setTimeout(function(){f.__name__=b.nameOf(h)},1)},nameOf:function(a,c){if(a instanceof Array){var g=[],h,f;for(h=0,f=a.length;h<f;h++)g.push(this.nameOf(a[h]));return g}if(a.__name__)return a.__name__;var b=[{name:null,o:c||this.root}],d=0;while(typeof b==='object'&&d<this.maxDepth){d+=1;b=this.descend(b,a)}if(typeof b=='string'){b=b.replace(/\.prototype\./g,'#');a.__name__=b;if(a.__meta__)a.__meta__.__name__=b+'.__meta__'}return a.__name__},descend:function(a,c){var g=[],h=a.length,f=h,b,d,i;while(f--){d=a[f];if(h>1&&JS.indexOf(this.excluded,d.o)!==-1)continue;if(d.o instanceof Array)continue;i=d.name?d.name+'.':'';for(b in d.o){if(c&&d.o[b]===c)return i+b;g.push({name:i+b,o:d.o[b]})}}return g},root:this,excluded:[],maxDepth:8,logLevel:'full',stack:new JS.Singleton({_0:[],indent:function(){var a='',c=this._0.length;while(c--)a+='|  ';return a},push:function(a,c,g){if(JS.StackTrace.logLevel==='full')window.console&&console.log(this.indent()+a+'(',g,')');this._0.push({name:a,object:c,args:g})},pop:function(a){var c=this._0.pop().name;if(JS.StackTrace.logLevel==='full')window.console&&console.log(this.indent()+c+'() --> ',a);return c},top:function(){return this._0[this._0.length-1]||{}},backtrace:function(){var a=this._0.length,c;while(a--){c=this._0[a];window.console&&console.log(c.name,'in',c.object,'(',c.args,')')}}}),flush:function(){this.stack._0=[]},print:function(){this.stack.backtrace()},wrap:function(g,h,f){var b=JS.StackTrace;var d=function(){var a,c=b.nameOf(h)+'#'+f;b.stack.push(c,this,arguments);if(b.logLevel==='errors'){try{a=g.apply(this,arguments)}catch(e){if(e.logged)throw e;e.logged=true;window.console&&console.error(e,'thrown by',b.stack.top().name+'. Backtrace:');b.print();b.flush();throw e;}}else{a=g.apply(this,arguments)}b.stack.pop(a);return a};d.toString=function(){return g.toString()};return d}}});(function(){var a=JS.StackTrace;for(var c in a.root){if(c!=='JS')a.excluded.push(a.root[c])}})();