//
//  AXKViewController.m
//  AXKPasswordGenerator
//
//  Created by Alexander Kolov on 7/15/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

#import "AXKViewController.h"
#import "AXKPasswordGenerator.h"

@interface AXKViewController ()

@end

@implementation AXKViewController

- (IBAction)didTapButton:(id)sender {
  self.label.text = [AXKPasswordGenerator generateWithLength:12 addDashes:YES];
}

@end
