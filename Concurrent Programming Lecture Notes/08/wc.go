package main

import (
  "bufio"
  "fmt"
  "io"
  "log"
  "os"
)

func frequencies(r io.Reader) {
  freq := make(map[string]int)
  scanner := bufio.NewScanner(r)

  scanner.Split(bufio.ScanWords)
  for scanner.Scan() {
    freq[scanner.Text()]++
  }

  maxCount := 0
  for _, count  := range freq {
    if count > maxCount {
      maxCount = count
    }
  }

  mostFreq := []string{}
  for word, count := range freq {
    if count == maxCount {
      mostFreq = append(mostFreq, word)
    }
  }

  fmt.Println(mostFreq, maxCount)
}

func main() {
  if len(os.Args) == 1 {
    frequencies(os.Stdin)
  } else {
    if file, err := os.Open(os.Args[1]); err != nil {
      log.Fatal(err)
    } else {
      frequencies(file)
    }
  }
}
