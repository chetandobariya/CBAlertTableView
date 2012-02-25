//
//  CBViewController.h
//  CBAlertTableView
//
//  Created by katsuya kato on 12/02/18.
//  Copyright (c) 2012年 CrossBridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAlertTableView.h"

@interface CBViewController : UIViewController <CBAlertTableViewDelegate> {
}
- (IBAction)handleShowButton:(id)sender;

@end
