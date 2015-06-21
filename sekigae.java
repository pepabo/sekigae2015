// javac sekigae.java && java Sekigae

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

class Sekigae {
    public static void main (String[] args) throws Exception {
        final List<String> names = Files.readAllLines(Paths.get("names.txt"), StandardCharsets.UTF_8);
        Collections.shuffle(names);
        eachSlice(names, 3)
            .stream()
            .map(list -> list.stream().collect(Collectors.joining(" ")))
            .forEach(System.out::println);
    }

    private static <T> List<List<T>> eachSlice(List<T> list, int size) {
        List<List<T>> result = new ArrayList<List<T>>();
        int l = list.size();

        for (int i = 0; i < l; i += size) {
            result.add(list.subList(i, i + size));
        }

        return result;
    }
}
