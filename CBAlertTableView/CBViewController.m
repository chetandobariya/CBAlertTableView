//
//  CBViewController.m
//  CBAlertTableView
//
//  Created by katsuya kato on 12/02/18.
//  Copyright (c) 2012年 CrossBridge. All rights reserved.
//

#import "CBViewController.h"

@interface CBViewController ()

@end

@implementation CBViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)handleShowButton:(id)sender {
  NSArray *stringArray = [NSArray arrayWithObjects:@"first",
                          @"second",
                          @"third",
                          @"fourth",
                          @"fifth",
                          nil];
  CBAlertTableView *alertTabView = [CBAlertTableView alertTabaleViewWithStringArray:stringArray
                                                                             titile:@"Select"
                                                                  cancelButtonTitle:@"Cancel"
                                                                           delegate:self];
  [alertTabView show];
}

#pragma mark - CBAlertTableViewDelegate Method
- (void)selectedIndex:(int)index {
  // index is 0 origin
  UIAlertView* alertView;
	alertView = [[UIAlertView alloc] initWithTitle:@"Selected Index"
                                         message:[NSString stringWithFormat:@"%d", index]
                                        delegate:nil
                               cancelButtonTitle:nil
                               otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

- (void)canceled {
  UIAlertView* alertView;
	alertView = [[UIAlertView alloc] initWithTitle:nil
                                         message:@"Canceled"
                                        delegate:nil
                               cancelButtonTitle:nil
                               otherButtonTitles:@"OK", nil];
	[alertView show];
	[alertView release];
}

@end
