//
//  Slider_PastDataViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/04/18.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "Slider_PastDataViewController.h"

@interface Slider_PastDataViewController ()

@end

@implementation Slider_PastDataViewController{
    __weak IBOutlet UILabel *pastDataLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *pastData = [NSArray arrayWithObjects:@"Hour",@"Min",@"00",nil];
    
    for(NSInteger i =0 ; i<[pastData count] ; i++){
        NSString *pastData_str = [pastData objectAtIndex:i];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
