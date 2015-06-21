// Usage: node sekigae.js

var names = require("fs").readFileSync("./names.txt", "utf-8").trim().split("\n");
for(var i = names.length - 1; i > 0; i--){
    var r = Math.floor(Math.random() * (i + 1);
    var tmp = names[i];
    names[i] = names[r];
    names[r] = tmp;
}
var mlen = Math.max.apply(null, names.map(function(m){ return m.length; }));
var hlen = Math.floor(names.length / 2);
var out = names.map(function(name, i){
    return (i == hlen - 1) ? name + '\n' : name + new Array((mlen - name.length) + 2).join(" ");
}).join('');
console.log(out);
