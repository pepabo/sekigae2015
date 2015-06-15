#!/usr/bin/env rdmd

// Usage:
//   rdmd sekigae.d
// or
//   dmd -ofsekigae sekigae.d && ./sekigae

import std.algorithm, std.array, std.random, std.range, std.stdio, std.string;

auto readNamesShuffled(string path) {
  return File(path).byLineCopy.array.randomCover.array;
}

auto formatNames(R)(R names, int nlines) {
  return names.chunks(nlines).map!((col) {
      const len = col.map!"a.length".reduce!max;
      return col.map!(n => n.leftJustify(len));
    }).array.transposed.map!(s => s.join(' '));
}

void main() {
  readNamesShuffled("names.txt").formatNames(2).each!writeln;
}
