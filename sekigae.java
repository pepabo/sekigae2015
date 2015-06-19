// javac sekigae.java && java sekigae

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class sekigae {
    public static void main (String[] args) {
        List<String> names = loadFile("names.txt");
        Collections.shuffle(names);
        eachSlice(names, 3).forEach((List<String> list) -> {
            System.out.println(list.stream().collect(Collectors.joining(" ")));
        });
    }

    private static List<String> loadFile(String path) {
        List<String> list = new ArrayList<String>();

        try {
            FileReader fr = new FileReader(path);
            BufferedReader br = new BufferedReader(fr);
            list = br.lines().collect(Collectors.toList());
        } catch(Exception e) {}

        return list;
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
