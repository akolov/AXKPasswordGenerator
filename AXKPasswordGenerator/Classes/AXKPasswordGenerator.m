//
//  AXKPasswordGenerator.m
//  AXKPasswordGenerator
//
//  Created by Alexander Kolov on 7/15/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//
//  Based on GPW - Generate pronounceable passwords by Tom Van Vleck
//  http://www.multicians.org/thvv/tvvtools.html
//

#import "AXKPasswordGenerator.h"
#import "AXKPasswordGeneratorTrigrams.h"

extern inline double arc4random_double();

inline double arc4random_double() {
  return (double)arc4random() / UINT_MAX;
}

@implementation AXKPasswordGenerator

+ (NSString *)generateWithLength:(unsigned long)length addDashes:(BOOL)addDashes {
  double pik = arc4random_double();     // Random number [0,1]
  long sumfreq = sigma;                 // Sigma calculated by loadtris
  long ranno = (long)(pik * sumfreq);   // Weight by sum of frequencies
  long sum = 0;
  char password[100];                   // Buffer to develop a password

  for (int c1 = 0; c1 < 26; c1++) {
    for (int c2 = 0; c2 < 26; c2++) {
      for (int c3 = 0; c3 < 26; c3++) {
		    sum += tris[c1][c2][c3];
		    if (sum > ranno) {              // Pick first value
          password[0] = 'a' + c1;
          password[1] = 'a' + c2;
          password[2] = 'a' + c3;
          c1 = c2 = c3 = 26;            // Break all loops
		    } // if sum
      } // for c3
    } // for c2
	} // for c1

  // Do a random walk

	int nchar = 3;                        // We have three chars so far
	while (nchar < length) {
    password[nchar] = '\0';
    password[nchar + 1] = '\0';
    int c1 = password[nchar - 2] - 'a'; // Take the last 2 chars
    int c2 = password[nchar - 1] - 'a'; // .. and find the next one

    sumfreq = 0;
    for (int c3 = 0; c3 < 26; c3++) {
      sumfreq += tris[c1][c2][c3];
    }

    // Note that sum < duos[c1][c2] because duos counts all digraphs, not just those in a trigraph. We want sum.
    if (sumfreq == 0) {                 // If there is no possible extension..
      break;                            // Break while nchar loop & print what we have
    }

    // Choose a continuation
    pik = arc4random_double();
    ranno = (long)(pik * sumfreq);      // Weight by sum of frequencies for row
    sum = 0;

    for (int c3 = 0; c3 < 26; c3++) {
      sum += tris[c1][c2][c3];
      if (sum > ranno) {
		    password[nchar++] = 'a' + c3;
		    c3 = 26;                        // Break the for c3 loop
      }
    } // for c3
	} // while nchar

  NSMutableString *string = [NSMutableString stringWithCString:password encoding:NSASCIIStringEncoding];
  for (NSUInteger i = 0; i < [string length] / 3; i++) {
    NSUInteger index = arc4random_uniform((uint32_t)[string length]);
    NSRange range = NSMakeRange(index, 1);
    NSString *uppercase = [[string substringWithRange:range] uppercaseString];
    [string replaceCharactersInRange:range withString:uppercase];
  }

  {
    NSUInteger number = arc4random_uniform(10);
    NSString *numberString = [NSString stringWithFormat:@"%lu", (unsigned long)number];
    NSUInteger index = arc4random_uniform((uint32_t)[string length]);
    NSRange range = NSMakeRange(index, 1);
    [string replaceCharactersInRange:range withString:numberString];
  }

  if (addDashes) {
    for (int i = 1; i < length / 3; i++) {
      int index = -1 + 4 * i;
      [string insertString:@"-" atIndex:index];
    }
  }

  return string;
}

@end
