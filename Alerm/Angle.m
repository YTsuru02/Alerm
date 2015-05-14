//
//  Angle.m
//  Alerm
//
//  Created by 鶴貝康男 on 2015/04/20.
//  Copyright (c) 2015年 鶴貝康男. All rights reserved.
//

#import "Angle.h"

@implementation Angle

@synthesize hour;
@synthesize min;
@synthesize sec;


-(id)init{
    if(self = [super init]){
        self.hour = 0.0;
        self.min = 0.0;
        self.sec = 0.0;
    }
    return self;
}

@end
