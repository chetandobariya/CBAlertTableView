//
//  CBAlertTableView.m
//
//  Created by katsuya kato on 12/02/18.
//
//  Copyright (c) 2012 CrossBridge. All rights reserved.
//  Licensed under the Apache License, Version 2.0;
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import <QuartzCore/QuartzCore.h>
#import "CBAlertTableView.h"

#define kTableViewX       12
#define kTableViewY       45
#define kTableViewWidth   260
#define kTableViewHeight  120

#define kTableViewCellHeight    30
#define kTableViewCellFontSize  15

@interface CBAlertTableView()
- (id)initWithStringArray:(NSArray *)stringArray
                   titile:(NSString *)title
        cancelButtonTitle:(NSString *)buttonTitle
                 delegate:(id)delegate;
@end

@implementation CBAlertTableView
@synthesize cbAlertTableViewDelegate = cbAlertTableViewDelegate_;
@synthesize stringArray = stringArray_;
@synthesize tableView= tableView_;

#pragma mark - Public Method
+ (id)alertTabaleViewWithStringArray:(NSArray *)stringArray
                              titile:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                            delegate:(id<CBAlertTableViewDelegate>)delegate {
  return [[[CBAlertTableView alloc] initWithStringArray:stringArray
                                                 titile:title
                                      cancelButtonTitle:cancelButtonTitle
                                               delegate:delegate] autorelease];
}

#pragma mark - Private Method

- (id)initWithStringArray:(NSArray *)stringArray
                   titile:(NSString *)title
        cancelButtonTitle:(NSString *)buttonTitle
                 delegate:(id)delegate {
  self = [[CBAlertTableView alloc] initWithTitle:title
                                         message:nil
                                        delegate:self
                               cancelButtonTitle:buttonTitle
                               otherButtonTitles:nil];
  
  if (self) {
    self.delegate = self;
    self.cbAlertTableViewDelegate = delegate;
    self.stringArray = stringArray;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kTableViewX,
                                                                   kTableViewY,
                                                                   kTableViewWidth,
                                                                   kTableViewHeight)
                                                  style:UITableViewStylePlain];
    tableView_.layer.cornerRadius = 5;
    tableView_.clipsToBounds = true;
    tableView_.rowHeight = kTableViewCellHeight;
    tableView_.delegate = self;
    tableView_.dataSource = self;
    
    [self addSubview:tableView_];
    [tableView_ release];
  }
  
  return self;
}

- (void)dealloc {
  self.stringArray = nil;
  [super dealloc];
}

#pragma mark - UIAlertViewDelegate Method
- (void)willPresentAlertView:(UIAlertView *)alertView {
	
  // To adjust the size of AlertView, depending on the size of the TableView
	int offsetHeight = tableView_.frame.size.height;
  
  CGRect frame = self.frame;
  frame.size.height += offsetHeight;
  self.frame = frame;

  for (UIView *view in self.subviews) {
    CGRect viewFrame = view.frame;
    if (self.tableView.frame.origin.y < viewFrame.origin.y) {
      viewFrame.origin.y += offsetHeight;
			view.frame = viewFrame;
    }
  }

  // To adjust the position of the AlertView
  UIScreen *screen = [UIScreen mainScreen];
  CGRect rect = screen.bounds;
  self.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    [cbAlertTableViewDelegate_ canceled];
  }
}

#pragma mark - UITableViewDelegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [cbAlertTableViewDelegate_ selectedIndex:indexPath.row];
  [self dismissWithClickedButtonIndex:-1 animated:YES]; // Turn off the AlertView
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return [stringArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"CBTableAlertViewCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
  }
  
  cell.textLabel.font = [UIFont systemFontOfSize:kTableViewCellFontSize];
  cell.textLabel.text = [stringArray_ objectAtIndex:indexPath.row];
  
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

@end
