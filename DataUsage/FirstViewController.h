//
//  FirstViewController.h
//  DataUsage
//
//  Created by Deepak Bharati on 19/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *daysRemainingLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentageDataLabelForMinimumDisplay;
@property (strong, nonatomic) IBOutlet UILabel *percentageSymbolLabelForMinimumDisplay;
@property (strong, nonatomic) IBOutlet UILabel *usedStringLabelForMinimumDisplay;


@property (strong,nonatomic) NSUserDefaults *defaults;
@property (strong,nonatomic) NSDateFormatter *dateFormat;
@property (strong,nonatomic) NSDateFormatter *dateFormatFordateInteger;


-(NSDate *)getStartDate;
-(NSUInteger)getDataCap;
-(NSUInteger)getDataUsed;


@end
