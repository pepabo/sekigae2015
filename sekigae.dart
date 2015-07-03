import 'dart:io';

main() {
    new File('names.txt').readAsLines().then((List<String> names) {
        names.shuffle();
        var maxLen = names.fold(0, (len, name) => name.length > len ? name.length : len) + 1;
        var formattedNames = names.map((name) => name.padRight(maxLen));
        print(formattedNames.take(3).join());
        print(formattedNames.skip(3).join());
    });
}
