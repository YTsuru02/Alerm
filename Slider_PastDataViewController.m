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
    int line;
    NSMutableArray *pastData;
    NSMutableArray *pastData_hms;
    NSMutableArray *pastData_hour;
    NSMutableArray *pastData_min;
    NSMutableArray *pastData_sec;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pastData_hour = [NSMutableArray array];
    pastData_min = [NSMutableArray array];
    pastData_sec = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
        
        NSString *pastData_time = [pastData_str substringWithRange:subRange];//1行ごとの過去データを取得
        
        [pastData addObject:pastData_time];
        
        pastData_hms = [pastData_time componentsSeparatedByString:@":"];//1行ごとの過去データを":"で分割
        
        
        [pastData_hour addObject:[pastData_hms objectAtIndex:0]];
        [pastData_min addObject:[pastData_hms objectAtIndex:1]];
        [pastData_sec addObject:[pastData_hms objectAtIndex:2]];
        
        
        range.location = NSMaxRange(subRange);//subRangeの最終位置を、次のsubRangeの最初として使う
        range.length -= subRange.length;
        line++;
                        
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [pastData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *homeDir = [NSString stringWithFormat:@"/Users/Y_Tsurugai/Desktop/GitHub/Alerm"];
    
    NSString *filepath_h = [homeDir stringByAppendingPathComponent:@"selectPastData_h.txt"];//書き込みたいファイルのパスを生成
    NSString *filepath_m = [homeDir stringByAppendingPathComponent:@"selectPastData_m.txt"];//書き込みたいファイルのパスを生成
    NSString *filepath_s = [homeDir stringByAppendingPathComponent:@"selectPastData_s.txt"];//書き込みたいファイルのパスを生成
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:filepath_h]) {
        
        BOOL result = [fileManager createFileAtPath:filepath_h contents:[NSData data] attributes:nil];//空のファイルを作成
        
        if (!result) {
            NSLog(@"Failed creating the file.");
            return;
            
        }
    }
    if (![fileManager fileExistsAtPath:filepath_m]) {
        
        BOOL result = [fileManager createFileAtPath:filepath_m contents:[NSData data] attributes:nil];//空のファイルを作成
        
        if (!result) {
            NSLog(@"Failed creating the file.");
            return;
            
        }
    }
    if (![fileManager fileExistsAtPath:filepath_s]) {
        
        BOOL result = [fileManager createFileAtPath:filepath_s contents:[NSData data] attributes:nil];//空のファイルを作成
        
        if (!result) {
            NSLog(@"Failed creating the file.");
            return;
            
        }
    }
    
    NSFileHandle *fileHandle_h = [NSFileHandle fileHandleForWritingAtPath:filepath_h];//ファイルハンドラを生成
    
    NSFileHandle *fileHandle_m = [NSFileHandle fileHandleForWritingAtPath:filepath_m];//ファイルハンドラを生成
    
    NSFileHandle *fileHandle_s = [NSFileHandle fileHandleForWritingAtPath:filepath_s];//ファイルハンドラを生成
    
    if ((!fileHandle_h) || (!filepath_m) || (!filepath_s)) {
        NSLog(@"Failed Writing the filehandle.");
        return;
    }
    
    
    NSString *selectData_hour = [pastData_hour objectAtIndex:indexPath.row];//選択されたセルの時間を取得
    NSString *selectData_min = [pastData_min objectAtIndex:indexPath.row];//選択されたセルの分を取得
    //NSString *pastData_sec_str = [pastData_sec objectAtIndex:indexPath.row];//選択されたセルの秒を取得
    
    NSData *data_h = [NSData dataWithBytes:selectData_hour.UTF8String length:selectData_hour.length];
    NSData *data_m = [NSData dataWithBytes:selectData_min.UTF8String length:selectData_min.length];
    //NSData *data_s = [NSData dataWithBytes:pastData_sec_str.UTF8String length:pastData_sec_str.length];
    
    [fileHandle_h writeData:data_h];//選択した時間と分をファイルに登録
    [fileHandle_m writeData:data_m];//選択した時間と分をファイルに登録
}

/*
#pragma mark - Navigation


 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
