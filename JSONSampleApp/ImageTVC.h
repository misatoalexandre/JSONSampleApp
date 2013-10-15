//
//  ImageTVC.h
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "WebVCViewController.h"

@interface ImageTVC : UITableViewController<WebVCViewControllerDelegate>

@property (nonatomic, strong) NSArray *imageResults;
@property (nonatomic, strong) NSMutableArray *imageEntries;

@end
