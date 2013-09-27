//
//  DataPlanTVC.h
//  DataUsage
//
//  Created by Deepak Bharati on 08/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataPlanTVC : UITableViewController

//@property (weak,nonatomic)NSUserDefaults *dataPlan;
@property (strong,nonatomic)NSArray * valueArray;
@property (strong,nonatomic)NSArray * keyArray;

@property (strong,nonatomic) NSUserDefaults *defaults;

@end
