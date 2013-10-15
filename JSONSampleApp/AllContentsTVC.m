//
//  AllContentsTVC.m
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#define bkgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define fuzzURL [NSURL URLWithString:@"http://dev.fuzzproductions.com/MobileTest/test.json"]

#import "AllContentsTVC.h"
#import "CustomCell.h"

@interface AllContentsTVC ()

@end

@implementation AllContentsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       dispatch_async(bkgQueue, ^{
        NSData *data= [NSData dataWithContentsOfURL:fuzzURL];
        [self performSelectorInBackground:@selector(fetchedData:) withObject:data];
    });
}
-(void)fetchedData:(NSData *)responseData{
    NSError *error;
    self.entries=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    //operate tasks to update the UI in the main queue.
 dispatch_async(dispatch_get_main_queue(), ^{
     NSLog(@"%@", self.entries);
     [self.tableView reloadData];
     self.title=[NSString stringWithFormat:@"Contents: %d items", [self.entries count]];

        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
   CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
    }
    
    
    // Configure the cell...
    
    NSDictionary *entry=[self.entries objectAtIndex:indexPath.row];
    NSString *type=[entry objectForKey:@"type"];
    NSString *uniqueId=[entry objectForKey:@"id"];
    NSString *dataContent=[entry objectForKey:@"data"];
    
    if ([[entry objectForKey:@"type"]isEqualToString:@"image"]) {
        NSURL *imageURL=[NSURL URLWithString:[entry objectForKey:@"data"]];
        NSData *imageData=[NSData dataWithContentsOfURL:imageURL];
        UIImage *imageLoad=[UIImage imageWithData:imageData];
        
        cell.contentType.text=type;
        cell.uniqueId.text=uniqueId;
        cell.imageView.image=imageLoad;
    } else{
        
        cell.contentType.text=type;
        cell.uniqueId.text=uniqueId;
        cell.textView.text=dataContent;
    }
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"web" sender:self];
}
@end
