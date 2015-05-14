//
//  Rev_PastDataViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/04/18.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "Rev_PastDataViewController.h"

@interface Rev_PastDataViewController ()

@end

@implementation Rev_PastDataViewController{
    __weak IBOutlet UILabel *pastDataLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *pastData = [NSArray arrayWithObjects:@"aaa"];
    
    for(NSInteger i = 0 ; i<[pastData count] ; i++){
        NSString *pastData_str = [pastData objectAtIndex:i];
        pastDataLabel.text = [NSString stringWithFormat:@"%@\n",pastData_str];
    }
    
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
