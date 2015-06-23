package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"math/rand"
	"os"
	"strings"
	"time"
)

var (
	col   = flag.Uint("c", 3, "number of columns")
	input = flag.String("f", "names.txt", "input file")
)

func main() {
	flag.Parse()

	f, err := os.Open(*input)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	// read lines
	var lines []string
	bio := bufio.NewScanner(f)
	for bio.Scan() {
		lines = append(lines, strings.TrimSpace(bio.Text()))
	}

	rand.Seed(time.Now().Unix())

	// shuffle
	for i := range lines {
		j := rand.Intn(i + 1)
		lines[i], lines[j] = lines[j], lines[i]
	}

	for i := range lines {
		fmt.Print(lines[i])
		if uint(i)%*col < *col-1 {
			fmt.Print(" ")
		} else {
			fmt.Println()
		}
	}
}
