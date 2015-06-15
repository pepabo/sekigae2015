// Usage: dmd -c -J. sekigae.di

import std.algorithm, std.array, std.conv, std.random, std.range, std.regex, std.stdio, std.string;

auto extractDigits(string s) {
  typeof(s) t;
  foreach(i, c; s) if('0' <= c && c <= '9') t ~= c;
  return t;
}

auto readNamesShuffled(alias path)() {
  auto rng = Xorshift(__TIME__.extractDigits.to!uint);
  auto names = import(path).chomp.split;
  names.randomShuffle(rng);
  return names;
}

auto formatNames(R)(R names, int nlines) {
  auto lines = new string[](nlines);
  foreach(col; names.chunks(nlines)) {
      immutable len = col.map!"a.length".reduce!max;
      foreach(i, name; col) {
        if(lines[i].length) lines[i] ~= ' ';
        lines[i] ~= name.leftJustify(len);
      }
  }
  return lines;
}

pragma(msg, readNamesShuffled!"names.txt".formatNames(2).join('\n'));
