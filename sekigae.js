// Usage: node sekigae.js

var names = require("fs").readFileSync("./names.txt").toString().split("\n");
names.splice(names.length - 1, 1);
for(var i = names.length - 1; i >= 0; i--){
    var r = Math.floor(Math.random() * i);
    var tmp = names[i];
    var len = names[i].length;
    names[i] = names[r];
    names[r] = tmp;
}
var nlh =  Math.floor(names.length / 2);
for(i = 0; i < nlh; i++){
    var deff = names[i].length - names[i + nlh].length;
    if(deff > 0){
	var a = nlh;
    }else if(deff < 0){
	var a = 0;
    }
    for(var j = 0; j < Math.abs(deff); j++){
	names[i + a] += " ";
    }
}
var nstr = "";
for(i = 0; i < names.length; i++){
    nstr += names[i];
    if(i == nlh - 1){
    	nstr += "\n";
    }else if(i != names.length - 1){
    	nstr += " ";
    }
}
console.log(nstr);
