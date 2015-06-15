// Usage: node sekigae.js

var names = require("fs").readFileSync("./names.txt", "utf-8").trim().split("\n");
for(var i = names.length - 1; i >= 0; i--){
	var r = Math.floor(Math.random() * i);
	var tmp = names[i];
	var len = names[i].length;
	names[i] = names[r];
	names[r] = tmp;
}
var nlh =  Math.floor(names.length / 2);
for(i = 0; i < nlh; i++){
	var diff = names[i].length - names[i + nlh].length;
	if(diff > 0){
		var a = nlh;
	}else if(diff < 0){
		var a = 0;
	}
	names[i + a] += new Array(Math.abs(diff) + 1).join(" ");
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
