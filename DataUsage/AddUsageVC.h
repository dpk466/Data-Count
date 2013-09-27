//
//  AddUsageVC.h
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUsageVC : UIViewController
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;


@property (strong,nonatomic) NSMutableArray *unitDigits;
@property (strong,nonatomic) NSMutableArray *tenthDigits;
@property (strong,nonatomic) NSMutableArray *hundredDigits;
@property (strong,nonatomic) NSMutableArray *thousandDigits;
@property (strong,nonatomic) NSMutableArray *kbMbGb;

@property (strong,nonatomic) NSUserDefaults *defaults;



@end
