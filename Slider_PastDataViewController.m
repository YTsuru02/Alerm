//
//  Ges_PastDataViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/05/17.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "Slider_PastDataViewController.h"

@interface Slider_PastDataViewController ()

@end

@implementation Slider_PastDataViewController{
    NSMutableArray *pastData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    pastData = [NSMutableArray array];
    
    NSString *homeDir = [NSString stringWithFormat:@"/Users/Y_Tsurugai/Desktop/GitHub/Alerm"];
    NSString *filepath = [homeDir stringByAppendingPathComponent:@"pastData.txt"];
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filepath];
    
    if (!fileHandle) {
        NSLog(@"Failed Reading the filehandle.");
        return;
    }
    
    NSData *data = [fileHandle readDataToEndOfFile];
    NSString *pastData_str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSRange range = NSMakeRange(0, pastData_str.length);
    
    while (range.length > 0) {
        NSRange subRange = [pastData_str lineRangeForRange:NSMakeRange(range.location, 0)];
        
            [pastData addObject:[pastData_str substringWithRange:subRange]];
        
            range.location = NSMaxRange(subRange);//subRangeの最終位置を、次のsubRangeの最初として使う
            range.length -= subRange.length;
                        
    }

                
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [pastData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [pastData objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
