package main

// Usage:
//   go build -o sekigae sekigae.go && ./sekigae

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"
)

func readNames(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var names []string
	for scanner.Scan() {
		names = append(names, scanner.Text())
	}
	return names, scanner.Err()
}

func shuffle(a []string) {
	n := len(a)
	for i := 0; i < n-1; i++ {
		j := i + rand.Intn(n-i)
		a[j], a[i] = a[i], a[j]
	}
}

func format(names []string, nlines int) []string {
	ncols := len(names) / nlines
	if len(names)%nlines != 0 {
		ncols++
	}

	widths := make([]int, ncols)
	for i, name := range names {
		c := i / nlines
		if widths[c] < len(name) {
			widths[c] = len(name)
		}
	}

	lines := make([]string, nlines)
	for i, name := range names {
		c := i / nlines
		l := i % nlines
		if c > 0 {
			lines[l] += " "
		}
		lines[l] += name + strings.Repeat(" ", widths[c]-len(name))
	}

	return lines
}

func main() {
	const path = "./names.txt"
	const nlines = 2
	rand.Seed(time.Now().UnixNano())

	names, err := readNames(path)
	if err != nil {
		panic(err)
	}

	shuffle(names)

	for _, line := range format(names, nlines) {
		fmt.Println(line)
	}
}
