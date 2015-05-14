//
//  ViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/03/04.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "ViewController.h"
#import "Angle.h"
#import "Time.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *clock_base;
@property (weak, nonatomic) IBOutlet UIImageView *clock_hour;
@property (weak, nonatomic) IBOutlet UIImageView *clock_min;
@property (weak, nonatomic) IBOutlet UIImageView *clock_sec;
@property (weak, nonatomic) IBOutlet UIImageView *clock_setAM;
@property (weak, nonatomic) IBOutlet UIImageView *clock_setPM;

@property (weak, nonatomic) IBOutlet UISlider *timeSetSlider;

@property (weak, nonatomic) IBOutlet UILabel *timeSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton_Push;
- (IBAction)stopButton_Push:(id)sender;


@end

@implementation ViewController{
    NSTimer *timer;
    AVAudioPlayer *ClockAlerm_sound;
    int timeSetCounter;
    float t;
    Angle *nowAngle;
    Angle *setAngle;
    Time *nowTime;
    Time *setTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.clock_setAM.alpha = 0;
    self.clock_setPM.alpha = 0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeProc:) userInfo:nil repeats:YES];
    
    NSString *ClockAlerm_path = [[NSBundle mainBundle]pathForResource:@"ClockAlerm_sound" ofType:@"mp3"];
    NSURL *ClockAlerm_url = [NSURL fileURLWithPath:ClockAlerm_path];
    ClockAlerm_sound = [[AVAudioPlayer alloc]initWithContentsOfURL:ClockAlerm_url error:NULL];//アラームの音
    
    [self.timeSetSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)timeProc:(NSTimer*)timer{
    
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    nowTime = [[Time alloc] init];
    nowTime.hour = components.hour;//現在の時間の取得
    nowTime.min = components.minute;//現在の分の取得
    nowTime.sec = components.second;//現在の秒の取得
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",nowTime.hour,nowTime.min,nowTime.sec];
    
    //float secAngle = (M_PI*2)/60*sec;//現在の時間の角度を取得
    
    
    nowAngle = [[Angle alloc] init];
    
    nowAngle.sec = (M_PI*2)/60*nowTime.sec;
    nowAngle.min = (M_PI*2)/60*nowTime.min+nowAngle.sec/60;//現在の分の角度を取得
    nowAngle.hour = (M_PI*2)/12*nowTime.hour+nowAngle.min/12;//現在の秒の角度を取得

    
    self.clock_hour.transform = CGAffineTransformMakeRotation(nowAngle.hour);
    self.clock_min.transform = CGAffineTransformMakeRotation(nowAngle.min);
    self.clock_sec.transform = CGAffineTransformMakeRotation(nowAngle.sec);
    
    if((fabs(setAngle.hour - nowAngle.hour)<0.001) && setAngle.hour!=0){
        if((setTime.hour<=12 && nowTime.hour<=12)||(setTime.hour>=13 && nowTime.hour>=13)){
            [ClockAlerm_sound play];//アラームの音を鳴らす
        }
    }//セットした時間で起こる処理
}

- (void)valueChange:(UISlider*)timeSetSlider{
    
    [self.stopButton_Push setImage:[UIImage imageNamed:@"StopButton_Push.png"] forState:UIControlStateNormal];
    
    t = self.timeSetSlider.value;
    
    setTime = [[Time alloc] init];
    setTime.hour = floorf(t);//セットした時間を取得
    
    float tDec = t - floorf(t);
    setTime.min = 60*tDec;//セットした分を取得
    setTime.sec = 1;
    
    
    setAngle = [[Angle alloc] init];
    setAngle.sec = (M_PI*2)/60*setTime.sec;
    setAngle.min = (M_PI*2)/60*setTime.min+setAngle.sec/60;
    setAngle.hour = (M_PI*2)/12*setTime.hour+setAngle.min/12;//セットした時間の角度を取得
    
    if(setTime.hour<12){
        self.timeSetSlider.minimumTrackTintColor = [UIColor redColor];
        
        self.clock_setAM.alpha = 1;
        self.clock_setPM.alpha = 0;
        
        self.clock_setAM.transform = CGAffineTransformMakeRotation(setAngle.hour);//セットした時間だけ針を回転
        self.timeSetLabel.textColor = [UIColor redColor];
    }
    else if(setTime.hour>=12){

        self.timeSetSlider.minimumTrackTintColor = [UIColor blueColor];
        
        self.clock_setAM.alpha = 0;
        self.clock_setPM.alpha = 1;
        
        self.clock_setPM.transform = CGAffineTransformMakeRotation(setAngle.hour);//セットした時間だけ針を回転
        self.timeSetLabel.textColor = [UIColor blueColor];
    }

    
    self.timeSetLabel.text = [NSString stringWithFormat:@"%02d:%02d:00",setTime.hour,setTime.min];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)stopButton_Push:(id)sender {
    [ClockAlerm_sound stop];

    [self.stopButton_Push setImage:[UIImage imageNamed:@"StopButton_Set.png"] forState:UIControlStateNormal];
    
    //UIImage *img = [UIImage imageNamed:@"StopButton_Set.png"];
    //self.stopButton_Push.imageView = img;
    
}
@end
