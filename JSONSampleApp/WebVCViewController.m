//
//  WebVCViewController.m
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "WebVCViewController.h"

@interface WebVCViewController (){
    UIApplication *application;
}

@end

@implementation WebVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (!application) {
        application=[UIApplication sharedApplication];
        NSURL *url=[NSURL URLWithString:@"http://fuzzproductions.com"];
        NSURLRequest *request=[NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.delegate webVCBack];
}
@end
