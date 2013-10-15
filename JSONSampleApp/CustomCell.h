//
//  CustomCell.h
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *contentType;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *uniqueId;

@end
