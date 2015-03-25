//
//  ViewController.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/03/04.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *clock_base;
@property (weak, nonatomic) IBOutlet UIImageView *clock_hour;
@property (weak, nonatomic) IBOutlet UIImageView *clock_min;
@property (weak, nonatomic) IBOutlet UIImageView *clock_sec;
@property (weak, nonatomic) IBOutlet UIImageView *clock_set;
@property (weak, nonatomic) IBOutlet UIImageView *clock_set02;
@property (weak, nonatomic) IBOutlet UIImageView *clock_set03;

//@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISlider *timeSetSlider;
@property (weak, nonatomic) IBOutlet UISlider *timeSetSlider02;
@property (weak, nonatomic) IBOutlet UISlider *timeSetSlider03;


@property (weak, nonatomic) IBOutlet UILabel *timeSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSetLabel02;
@property (weak, nonatomic) IBOutlet UILabel *timeSetLabel03;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeSetButton;
- (IBAction)timeSetButton:(id)sender;
- (IBAction)stopButton:(id)sender;


@end

@implementation ViewController{
    NSTimer *timer;
    float setHourAngle;
    float setHourAngle02;
    float setHourAngle03;
    AVAudioPlayer *ClockAlerm_sound;
    AVAudioPlayer *ClockSec_sound;
    int timeSetCounter;
    float t;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.datePicker.alpha = 0;//UIDatePickerは初めは非表示
    self.timeSetSlider.alpha = 0;//スライダーは初めは非表示
    self.timeSetSlider02.alpha = 0;//スライダーは初めは非表示
    self.timeSetSlider03.alpha = 0;//スライダーは初めは非表示
    
    self.timeSetLabel.alpha = 0;
    self.timeSetLabel02.alpha = 0;
    self.timeSetLabel03.alpha = 0;
    
    self.clock_set.alpha = 0;
    self.clock_set02.alpha = 0;
    self.clock_set03.alpha = 0;
    
    //self.timeSetButton.alpha = 1;//timeSetButtonは初めは表示
    
    //[self.datePicker addTarget:self action:@selector(pickerChange:) forControlEvents:UIControlEventValueChanged];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeProc:) userInfo:nil repeats:YES];
    
    NSString *ClockAlerm_path = [[NSBundle mainBundle]pathForResource:@"ClockAlerm_sound" ofType:@"mp3"];
    NSURL *ClockAlerm_url = [NSURL fileURLWithPath:ClockAlerm_path];
    ClockAlerm_sound = [[AVAudioPlayer alloc]initWithContentsOfURL:ClockAlerm_url error:NULL];//アラームの音
    
    NSString *ClockSec_path = [[NSBundle mainBundle]pathForResource:@"ClockSec_sound" ofType:@"mp3"];
    NSURL *ClockSec_url = [NSURL fileURLWithPath:ClockSec_path];
    ClockSec_sound = [[AVAudioPlayer alloc]initWithContentsOfURL:ClockSec_url error:NULL];//秒針の音
    
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
    
    if(((fabs(setHourAngle - hourAngle)<0.001 || fabs(setHourAngle02 - hourAngle)<0.001 || fabs(setHourAngle03 - hourAngle)<0.001 )) && setHourAngle!=0){
        [ClockAlerm_sound play];//アラームの音を鳴らす
    }//セットした時間で起こる処理
}

- (void)valueChange:(UISlider*)timeSetSlider{
    
    t = self.timeSetSlider.value;
    NSInteger setHour = floorf(t);//セットした時間を取得
    
    float tDec = t - floorf(t);
    NSInteger setMin = 60*tDec;//セットした分を取得
    
    NSInteger setSec = 1;
    
    float setSecAngle = (M_PI*2)/60*setSec;
    float setMinAngle = (M_PI*2)/60*setMin+setSecAngle/60;
    setHourAngle = (M_PI*2)/12*setHour+setMinAngle/12;//セットした時間の角度を取得
    
    self.clock_set.transform = CGAffineTransformMakeRotation(setHourAngle);//セットした時間だけ針を回転
    
    self.timeSetLabel.textColor = [UIColor redColor];
    self.timeSetLabel.text = [NSString stringWithFormat:@"%02d:%02d:00",setHour,setMin];
}

- (void)valueChange02:(UISlider*)timeSetSlider{
    
    t = self.timeSetSlider02.value;
    NSInteger setHour = floorf(t);//セットした時間を取得
    
    float tDec = t - floorf(t);
    NSInteger setMin = 60*tDec;//セットした分を取得
    
    NSInteger setSec = 1;
    
    float setSecAngle = (M_PI*2)/60*setSec;
    float setMinAngle = (M_PI*2)/60*setMin+setSecAngle/60;
    setHourAngle02 = (M_PI*2)/12*setHour+setMinAngle/12;//セットした時間の角度を取得
    
    self.clock_set02.transform = CGAffineTransformMakeRotation(setHourAngle02);
    
    self.timeSetLabel02.textColor = [UIColor redColor];
    self.timeSetLabel02.text = [NSString stringWithFormat:@"%02d:%02d:00",setHour,setMin];
}

- (void)valueChange03:(UISlider*)timeSetSlider{

    t = self.timeSetSlider03.value;
    NSInteger setHour = floorf(t);//セットした時間を取得
    
    float tDec = t - floorf(t);
    NSInteger setMin = 60*tDec;//セットした分を取得
    
    NSInteger setSec = 1;
    
    float setSecAngle = (M_PI*2)/60*setSec;
    float setMinAngle = (M_PI*2)/60*setMin+setSecAngle/60;
    setHourAngle03 = (M_PI*2)/12*setHour+setMinAngle/12;//セットした時間の角度を取得
    
    self.clock_set03.transform = CGAffineTransformMakeRotation(setHourAngle03);
    
    self.timeSetLabel03.textColor = [UIColor redColor];
    self.timeSetLabel03.text = [NSString stringWithFormat:@"%02d:%02d:00",setHour,setMin];
}

/*
- (void)pickerChange:(UIDatePicker*)datePicker{

    NSDate *dateP = self.datePicker.date;//セットした日時を取得
    NSCalendar *calP = [NSCalendar currentCalendar];
    
    NSDateComponents *compP = [calP components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateP];//セットした時間と分を取得
    
    NSInteger setHour = compP.hour;//セットした時間を取得
    NSInteger setMin = compP.minute;//セットした分を取得

    NSInteger setSec = 1;

    float setSecAngle = (M_PI*2)/60*setSec;
    float setMinAngle = (M_PI*2)/60*setMin+setSecAngle/60;
    setHourAngle = (M_PI*2)/12*setHour+setMinAngle/12;//セットした時間の角度を取得
    
    self.clock_set.transform = CGAffineTransformMakeRotation(setHourAngle);
    
    self.timeSetLabel.textColor = [UIColor redColor];
    self.timeSetLabel.text = [NSString stringWithFormat:@"%02d:%02d:00",setHour,setMin];
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeSetButton:(id)sender {
    
    timeSetCounter++;

    switch (timeSetCounter) {
        case 1:
            self.timeSetSlider.alpha = 1;
            self.timeSetLabel.alpha = 1;
            self.clock_set.alpha = 1;
            [self.timeSetSlider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
            break;
            
        case 2:
            self.timeSetSlider02.alpha = 1;
            self.timeSetLabel02.alpha = 1;
            self.clock_set02.alpha = 1;
            [self.timeSetSlider02 addTarget:self action:@selector(valueChange02:) forControlEvents:UIControlEventValueChanged];
            
            break;
        case 3:
            self.timeSetSlider03.alpha = 1;
            self.timeSetLabel03.alpha = 1;
            self.clock_set03.alpha = 1;
            [self.timeSetSlider03 addTarget:self action:@selector(valueChange03:) forControlEvents:UIControlEventValueChanged];
            
            break;
            
        default:
            
            break;
    }//プラスボタンが押されただけスライダーを表示
    
    
    //self.datePicker.alpha = 1;//timeSetButtonが押されたらUIDatePickerを表示
    //self.timeSetButton.alpha =0;//timeSetButtonが押されたらtimeSetButtonを非表示
}

- (IBAction)stopButton:(id)sender {
    [ClockAlerm_sound stop];
}
@end