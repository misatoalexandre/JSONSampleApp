//
//  TextTVC.h
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebVCViewController.h"


@interface TextTVC : UITableViewController <WebVCViewControllerDelegate>

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSMutableArray *textEntries;

@end
