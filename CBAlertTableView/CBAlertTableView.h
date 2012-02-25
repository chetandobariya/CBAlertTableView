//
//  CBAlertTableView.h
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

#import <UIKit/UIKit.h>

@protocol CBAlertTableViewDelegate
- (void)selectedIndex:(int)index;
- (void)canceled;
@end

@interface CBAlertTableView : UIAlertView
<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate> {
  id<CBAlertTableViewDelegate> cbAlertTableViewDelegate_;
  UITableView *tableView_;
  NSArray *stringArray_;
}
@property(nonatomic, assign) id<CBAlertTableViewDelegate> cbAlertTableViewDelegate;
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, copy) NSArray *stringArray;

+ (id)alertTabaleViewWithStringArray:(NSArray *)stringArray
                              titile:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                            delegate:(id<CBAlertTableViewDelegate>)delegate;
@end
