//
//  RevViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/04/01.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "RevViewController.h"

@interface RevViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clock_base;
@property (weak, nonatomic) IBOutlet UIImageView *clock_hour;
@property (weak, nonatomic) IBOutlet UIImageView *clock_min;
@property (weak, nonatomic) IBOutlet UIImageView *clock_sec;
@property (weak, nonatomic) IBOutlet UIImageView *clock_set;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)stopButton:(id)sender;

@end

@implementation RevViewController{
//
//  ViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/03/04.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//


    NSTimer *timer;
    float setHourAngle;
    AVAudioPlayer *ClockAlerm_sound;
    AVAudioPlayer *ClockSec_sound;
    int timeSetCounter;
    float t;
    NSInteger setHour;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeProc:) userInfo:nil repeats:YES];
    
    NSString *ClockAlerm_path = [[NSBundle mainBundle]pathForResource:@"ClockAlerm_sound" ofType:@"mp3"];
    NSURL *ClockAlerm_url = [NSURL fileURLWithPath:ClockAlerm_path];
    ClockAlerm_sound = [[AVAudioPlayer alloc]initWithContentsOfURL:ClockAlerm_url error:NULL];//アラームの音
    
    NSString *ClockSec_path = [[NSBundle mainBundle]pathForResource:@"ClockSec_sound" ofType:@"mp3"];
    NSURL *ClockSec_url = [NSURL fileURLWithPath:ClockSec_path];
    ClockSec_sound = [[AVAudioPlayer alloc]initWithContentsOfURL:ClockSec_url error:NULL];//秒針の音
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(selRotationGesture:)];
    
    [self.view addGestureRecognizer:rotationGesture];
    
}

- (void)timeProc:(NSTimer*)timer{
    [ClockSec_sound play];//秒針の音を鳴らす
    
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    NSInteger hour = components.hour%12;//現在の時間の取得
    NSInteger min = components.minute;//現在の分の取得
    NSInteger sec = components.second;//現在の秒の取得
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];
    
    float secAngle = (M_PI*2)/60*sec;//現在の時間の角度を取得
    float minAngle = (M_PI*2)/60*min+secAngle/60;//現在の分の角度を取得
    float hourAngle = (M_PI*2)/12*hour+minAngle/12;//現在の秒の角度を取得
    
    self.clock_hour.transform = CGAffineTransformMakeRotation(hourAngle);
    self.clock_min.transform = CGAffineTransformMakeRotation(minAngle);
    self.clock_sec.transform = CGAffineTransformMakeRotation(secAngle);
    
    if((fabs(setHourAngle - hourAngle)<0.001) && setHourAngle!=0){
            [ClockAlerm_sound play];//アラームの音を鳴らす
    }//セットした時間で起こる処理
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stopButton:(id)sender {
    [ClockAlerm_sound stop];
}

- (void)selRotationGesture:(UIRotationGestureRecognizer*)sender{
    
    float rotation = [sender rotation];
    self.clock_set.transform = CGAffineTransformMakeRotation(rotation);
    
    setHourAngle = rotation;
}


@end
