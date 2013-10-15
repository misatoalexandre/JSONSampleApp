//
//  TextTVC.m
//  JSONSampleApp
//
//  Created by Misato Tina Alexandre on 10/15/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#define bkgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define fuzzURL [NSURL URLWithString:@"http://dev.fuzzproductions.com/MobileTest/test.json"]

#import "TextTVC.h"
#import "CustomCell.h"
#import "WebVCViewController.h"


@interface TextTVC ()

@end

@implementation TextTVC
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
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}
-(void)fetchedData:(NSData *)responseData{
    NSError *error;
    self.results=[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    //Array of contents with text data type
    self.textEntries=[[NSMutableArray alloc]init];
    
    for (NSDictionary *item in self.results ) {
        if ([[item objectForKey:@"type"] isEqualToString:@"text"]) {
            [self.textEntries addObject:item];
        }
    }
    NSLog(@"%@", self.textEntries);
    [self.tableView reloadData];
    self.title=[NSString stringWithFormat:@"Text Contents: %d items", [self.textEntries count]];
    
    //operate tasks to update the UI in the main queue.
    /* dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadData];
     self.title=[NSString stringWithFormat:@"%d items", [self.entries count]];
     //NSLog(@"%@", self.entries);
     });*/
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
    return self.results.count;
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
    
    NSDictionary *entry=[self.textEntries objectAtIndex:indexPath.row];
    NSString *type=[entry objectForKey:@"type"];
    NSString *uniqueId=[entry objectForKey:@"id"];
    NSString *dataContent=[entry objectForKey:@"data"];
   
    cell.contentType.text=type;
    cell.uniqueId.text=uniqueId;
    cell.textView.text=dataContent;

    
    /*if ([[entry objectForKey:@"type"]isEqualToString:@"image"]) {
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
    }*/
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"next" sender:self];
}
-(void)webVCBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"next"]) {
        WebVCViewController *webVC=(WebVCViewController *)[segue destinationViewController];
        webVC.delegate=self;
       
    }
}


@end
