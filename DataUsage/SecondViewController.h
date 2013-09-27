//
//  SecondViewController.h
//  DataUsage
//
//  Created by Deepak Bharati on 19/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *cycleLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellularDataUsage;
@property (strong, nonatomic) IBOutlet UILabel *wi_fiDataUsage;

@property (strong, nonatomic) IBOutlet UILabel *wifiUploadLabel;
@property (strong, nonatomic) IBOutlet UILabel *wifiDownloadLabel;

@property (strong, nonatomic) IBOutlet UILabel *cellUploadLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellDownloadLabel;

@property (strong, nonatomic) IBOutlet UILabel *cellularString;
@property (strong, nonatomic) IBOutlet UIImageView *cellularUploadImage;
@property (strong, nonatomic) IBOutlet UIImageView *cellularDownloadImage;

@property (strong, nonatomic) IBOutlet UILabel *wifiString;
@property (strong, nonatomic) IBOutlet UIImageView *wifiUploadImage;
@property (strong, nonatomic) IBOutlet UIImageView *wifiDownloadImage;


@property (strong,nonatomic) NSUserDefaults *defaults;
@property (strong,nonatomic) NSDateFormatter *dateFormat;
@property (strong,nonatomic) NSDateFormatter *dateFormatFordateInteger;


-(NSDate *)getStartDate;

@end
