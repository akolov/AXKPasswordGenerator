//
//  AXKPasswordGenerator.h
//  AXKPasswordGenerator
//
//  Created by Alexander Kolov on 7/15/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//
//  Based on GPW - Generate pronounceable passwords by Tom Van Vleck
//  http://www.multicians.org/thvv/tvvtools.html
//

@import Foundation;

@interface AXKPasswordGenerator : NSObject

+ (NSString *)generateWithLength:(unsigned long)length addDashes:(BOOL)addDashes;

@end
