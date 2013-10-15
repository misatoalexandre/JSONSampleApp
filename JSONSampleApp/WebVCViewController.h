//
//  WebVCViewController.h
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WebVCViewControllerDelegate;

@interface WebVCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) id<WebVCViewControllerDelegate> delegate;
- (IBAction)back:(id)sender;

@end

@protocol WebVCViewControllerDelegate

-(void)webVCBack;

@end
