//
//  SecondViewController.m
//  DataUsage
//
//  Created by Deepak Bharati on 19/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "SecondViewController.h"

#import "FindDataUsage.h"
#import "Theme.h"
#import "MyLocalNotifications.h"

@interface SecondViewController ()

@property (strong, nonatomic) NSArray *data;



@property (nonatomic) NSUInteger lastCellUploadData;
@property (nonatomic) NSUInteger lastCellDownloadData;

@property (nonatomic) NSUInteger lastWifiUploadData;
@property (nonatomic) NSUInteger lastWifiDownloadData;

@property (nonatomic) NSUInteger currentCellUploadData;
@property (nonatomic) NSUInteger currentCellDownloadData;

@property (nonatomic) NSUInteger currentWifiUploadData;
@property (nonatomic) NSUInteger currentWifiDownloadData;

@property (nonatomic) NSUInteger percentageCellDataUsed;

@property(strong,nonatomic)NSArray *currentColorTheme;


//for History...
@property (strong,nonatomic) NSString *cycleName;
@property (strong,nonatomic) NSString *dataCapString;
@property (strong,nonatomic) NSString *dataUsed;
@property (strong, nonatomic) NSString *uploadData;
@property (strong, nonatomic) NSString *downloadData;



@end

@implementation SecondViewController


@synthesize defaults, dateFormat, dateFormatFordateInteger;



#pragma  mark-Xcode generated methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    dateFormat = [[NSDateFormatter alloc] init];
    dateFormatFordateInteger = [[NSDateFormatter alloc] init];
    
    NSLog(@"SecondViewDidLaod method called");
    
    
    NSDateFormatter *detailedDateFormat;
    detailedDateFormat = [[NSDateFormatter alloc] init];
    [detailedDateFormat setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSLog(@"Start Date: %@",[detailedDateFormat stringFromDate:[self getStartDate]]);
    NSLog(@"Today's Date: %@",[detailedDateFormat stringFromDate:[NSDate date]]);
    NSLog(@"End Date: %@",[detailedDateFormat stringFromDate:[self getEndDate]]);
    NSLog(@"Days Remaining: %i",[self getDaysRemaining]);
    
    //NSLog(@"Data Cap: %i %@",[defaults integerForKey:@"Data Cap"],[defaults objectForKey:@"Data Cap Unit"]);
    //NSLog(@"Earlier Usage: %i %@",[defaults integerForKey:@"Data Used"],[defaults objectForKey:@"Data Used Unit"]);
    
    
    _currentColorTheme = [self getThemeType];
    
    [self findCurrentData];
    [self setCustomFont];
    [self CompleteDisplayOnView];
    [self setBackgroundColor];
    
    //[self updateHistory];use to add the current data usage to histo®y table
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
    
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- date calculation

-(NSDate *)getStartDate
{
    defaults = [NSUserDefaults standardUserDefaults];
    
    [dateFormat setDateFormat:@"dd MMM"];
    [dateFormatFordateInteger setDateFormat :@"dd"];
    
    NSUInteger todayDateInteger = [[dateFormatFordateInteger stringFromDate:[NSDate date]]integerValue];
    
    
    //Calculate Start Date.................
    NSDate *startDate;
    
    
    if([defaults integerForKey:@"Plan Type"] == 0 || [defaults integerForKey:@"Plan Type"] == 1)//Monthly and 30 Days plan
    {
        if([defaults integerForKey:@"Start Date"] > todayDateInteger)
        {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps = [[NSDateComponents alloc]init];
            comps = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit) fromDate:[NSDate date]];
            [comps setDay:[defaults integerForKey:@"Start Date"]];
            startDate = [calendar dateFromComponents:comps];
            NSDateComponents *comps1 = [[NSDateComponents alloc]init];
            comps1.month = -1;//going to previous(last) month
            startDate = [calendar dateByAddingComponents:comps1 toDate:startDate options:0];
        }
        else
        {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps = [[NSDateComponents alloc]init];
            comps = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearForWeekOfYearCalendarUnit) fromDate:[NSDate date]];
            [comps setDay:[defaults integerForKey:@"Start Date"]];
            startDate = [calendar dateFromComponents:comps];
        }
        
        [defaults setInteger:[[dateFormatFordateInteger stringFromDate:startDate]integerValue] - 1 forKey:@"StartDateRow"];
        
    }
    else if([defaults integerForKey:@"Plan Type"] == 2)//weekly Plan
    {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc]init];
        comps = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:[NSDate date]];
        
        int x = [defaults integerForKey:@"Week Day No."];
        //NSLog(@"start week day No.%i",x);
        int y = x - comps.weekday;
        if(y>0) y = y-7;
        //NSLog(@"today week day No.%i",comps.weekday);
        startDate = [[NSDate date]dateByAddingTimeInterval:y*24*60*60];
        
        //Hr and min. is set to Zero 0.
        NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:startDate];
        
        // Set the time components manually
        [dateComps setHour:0];
        [dateComps setMinute:0];
        [dateComps setSecond:0];
        
        // Convert back
        startDate = [calendar dateFromComponents:dateComps];
        
        [defaults setInteger:([defaults integerForKey:@"Week Day No."]-1) forKey:@"StartDateRow"];
        
    }
    else if([defaults integerForKey:@"Plan Type"] == 3)//daily Plan
    {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc]init];
        comps = [calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearForWeekOfYearCalendarUnit) fromDate:[NSDate date]];
        [comps setDay:todayDateInteger];
        startDate = [calendar dateFromComponents:comps];
        
        [defaults setInteger:(todayDateInteger-1) forKey:@"StartDateRow"];//used in locking the pickerView
        [defaults setInteger:todayDateInteger forKey:@"Start Date"];
    }
    
    //for new cycle....
    if ([[NSDate date] compare:[defaults objectForKey:@"myEndDate"]] == NSOrderedDescending)//true if today > endDate
    {
        NSLog(@"New Cycle");
        startDate = [defaults objectForKey:@"myEndDate"];
        //updating the history....
        [self updateHistory];
        
        [defaults setObject:startDate forKey:@"myStartDate"];
        
        [MyLocalNotifications createAndScheduleLocalNotifications];
        
        
        [defaults setInteger:[[dateFormatFordateInteger stringFromDate:startDate]integerValue] forKey:@"Start Date"];
        
        [defaults setBool:YES forKey:@"Reset"];
        
    }
    
    [defaults setObject:startDate forKey:@"myStartDate"];
    
    return startDate;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(NSDate *)getEndDate
{
    
    [dateFormat setDateFormat:@"dd MMM"];
    [dateFormatFordateInteger setDateFormat :@"dd"];
    
    //Calculate End Date.................
    NSDate *endDate;
    
    if([defaults integerForKey:@"Plan Type"] == 0)
    {
        //NSLog(@"Monthly Plan");
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.month = 1;
        endDate = [calendar dateByAddingComponents:comps toDate:[self getStartDate] options:0];
        
    }
    
    else if([defaults integerForKey:@"Plan Type"] == 1)
    {
        //NSLog(@"30 Days Plan");
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.day = 30;
        endDate = [calendar dateByAddingComponents:comps toDate:[self getStartDate] options:0];
    }
    
    else if([defaults integerForKey:@"Plan Type"] == 2)
    {
        //NSLog(@"Weekly Plan");
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.day = 7;
        endDate = [calendar dateByAddingComponents:comps toDate:[self getStartDate] options:0];
    }
    
    else if([defaults integerForKey:@"Plan Type"] == 3)
    {
        //NSLog(@"Daily Plan");
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.day = 1;
        endDate = [calendar dateByAddingComponents:comps toDate:[self getStartDate] options:0];
        /*//Hr and min. is set to Zero 0.
         NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:endDate];
         
         // Set the time components manually
         [dateComps setHour:0];
         [dateComps setMinute:0];
         [dateComps setSecond:0];
         
         // Convert back
         endDate = [calendar dateFromComponents:dateComps];
         */
    }
    
    [defaults setObject:endDate forKey:@"myEndDate"];
    
    return endDate;
    
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(NSUInteger)getDaysRemaining
{
    
    //Calculate the days remaining.........
    NSDateFormatter* dayFmt = [[NSDateFormatter alloc] init];
    //[dayFmt setTimeZone:<whatever time zone you want>];
    [dayFmt setDateFormat:@"g"];
    NSInteger firstDay = [[dayFmt stringFromDate:[NSDate date]] integerValue];// today's date...
    NSInteger secondDay = [[dayFmt stringFromDate:[self getEndDate]] integerValue];// end date...
    NSInteger daysRemaining = secondDay - firstDay;
    
    return daysRemaining;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- data calculation

-(NSUInteger)getDataCap
{
    NSUInteger dataCap;
    
    defaults = [NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"Data Cap Unit"] isEqual: @"KB"])
    {
        dataCap = [defaults integerForKey:@"Data Cap"];
    }
    else
        if([[defaults objectForKey:@"Data Cap Unit"] isEqual: @"MB"])
        {
            dataCap = [defaults integerForKey:@"Data Cap"]*1024;
        }
        else
            if([[defaults objectForKey:@"Data Cap Unit"] isEqual: @"GB"])
            {
                dataCap = [defaults integerForKey:@"Data Cap"]*1024*1024;
            }
            else
            {
                dataCap = 1024*1024*1024;//a large value to divide at first time
            }
    
    //for History
    _dataCapString = [NSString stringWithFormat:@"%i %@",[defaults integerForKey:@"Data Cap"],[defaults objectForKey:@"Data Cap Unit"]];
    
    //NSLog(@"dataCap= %i",dataCap);
    [defaults setInteger:dataCap forKey:@"AbsoluteDataCap"];
    return dataCap;
    
}

-(NSUInteger)getDataUsed
{
    NSUInteger dataUsed;
    
    defaults = [NSUserDefaults standardUserDefaults];
    if([[defaults objectForKey:@"Data Used Unit"] isEqual: @"KB"])
    {
        dataUsed = [defaults integerForKey:@"Data Used"];
    }
    else
        if([[defaults objectForKey:@"Data Used Unit"] isEqual: @"MB"])
        {
            dataUsed = [defaults integerForKey:@"Data Used"]*1024;
        }
        else
            if([[defaults objectForKey:@"Data Used Unit"] isEqual: @"GB"])
            {
                dataUsed = [defaults integerForKey:@"Data Used"]*1024*1024;
            }
            else
                dataUsed = 0;
    //NSLog(@"dataUsed= %i",dataUsed);
    [defaults setInteger:dataUsed forKey:@"AbsoluteDataUsed"];
    return dataUsed;
    
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)findCurrentData //used
{
    //find system' reboot date
    NSDate *rebootDate = [[NSDate date]dateByAddingTimeInterval: - [[NSProcessInfo processInfo] systemUptime]];
    
    FindDataUsage *fdu = [[FindDataUsage alloc]init];
    _data = [fdu getDataCounters];
    
    
    BOOL isReset = [defaults boolForKey:@"Reset"];
    
    if(!isReset)
    {
        //NSLog(@"Not Reseted");
        
        if([defaults boolForKey:@"FirstRun"])
        {
            //NSLog(@"Previous values Exist");
            [defaults setBool:NO forKey:@"FirstRun"];
            
            if ([rebootDate compare:[defaults objectForKey:@"DateOfUpdate"]] == NSOrderedDescending)//true if rebooted > updated
            {
                NSLog(@"Restarted...");
                
                
                _lastCellDownloadData = [defaults integerForKey:@"Cell Download"];
                _lastCellUploadData = [defaults integerForKey:@"Cell Upload"];
                _lastWifiDownloadData = [defaults integerForKey:@"Wifi Download"];
                _lastWifiUploadData = [defaults integerForKey:@"Wifi Upload"];
                
                [defaults setInteger:_lastCellDownloadData forKey:@"LastCellDownloadData"];
                [defaults setInteger:_lastCellUploadData forKey:@"LastCellUploadData"];
                [defaults setInteger:_lastWifiDownloadData forKey:@"LastWifiDownloadData"];
                [defaults setInteger:_lastWifiUploadData forKey:@"LastWifiUploadData"];
                
                [defaults setInteger:0 forKey:@"CellValueAtLastReset"];
                [defaults setInteger:0 forKey:@"WifiValueAtLastReset"];
                [defaults setObject:nil forKey:@"DataArrayAtLastReset"];
                
            }
        }
        else
        {
            //NSLog(@"No Previous values Exist");
        }
        
        _currentWifiUploadData = [[_data objectAtIndex:0]integerValue] + [defaults integerForKey:@"LastWifiUploadData"] - [[[defaults objectForKey:@"DataArrayAtLastReset"] objectAtIndex:0]integerValue];
        _currentWifiDownloadData = [[_data objectAtIndex:1]integerValue] + [defaults integerForKey:@"LastWifiDownloadData"] - [[[defaults objectForKey:@"DataArrayAtLastReset"] objectAtIndex:1]integerValue];
        
        _currentCellUploadData = [[_data objectAtIndex:2]integerValue] +[defaults integerForKey:@"LastCellUploadData"] - [[[defaults objectForKey:@"DataArrayAtLastReset"] objectAtIndex:2]integerValue];
        _currentCellDownloadData = [[_data objectAtIndex:3]integerValue] + [defaults integerForKey:@"LastCellDownloadData"] - [[[defaults objectForKey:@"DataArrayAtLastReset"] objectAtIndex:3]integerValue];
        
        
        
        
    }
    else
    {
        NSLog(@"Reseted");
        [defaults setBool:NO forKey:@"Reset"];
        
        [defaults setInteger:0 forKey:@"Cell Download"];
        [defaults setInteger:0 forKey:@"Cell Upload"];
        [defaults setInteger:0 forKey:@"Wifi Download"];
        [defaults setInteger:0 forKey:@"Wifi Upload"];
        
        [defaults setInteger:0 forKey:@"LastCellDownloadData"];
        [defaults setInteger:0 forKey:@"LastCellUploadData"];
        [defaults setInteger:0 forKey:@"LastWifiDownloadData"];
        [defaults setInteger:0 forKey:@"LastWifiUploadData"];
        
        [defaults setObject:_data forKey:@"DataArrayAtLastReset"];
        
        [defaults setInteger:0 forKey:@"Data Used"];
        //for Earlier Used Data Picker Row
        [defaults setInteger:0 forKey:@"DataUsedRowForComponent0"];
        [defaults setInteger:0 forKey:@"DataUsedRowForComponent1"];
        [defaults setInteger:0 forKey:@"DataUsedRowForComponent2"];
        [defaults setInteger:0 forKey:@"DataUsedRowForComponent3"];
        [defaults setInteger:0 forKey:@"DataUsedRowForComponent4"];
    }
    
    [defaults setObject:[NSDate date] forKey:@"DateOfUpdate"];//updated time is updated....
    
    //updating defaults for reboot option
    [defaults setInteger:_currentCellDownloadData forKey:@"Cell Download"];
    [defaults setInteger:_currentCellUploadData forKey:@"Cell Upload"];
    [defaults setInteger:_currentWifiDownloadData forKey:@"Wifi Download"];
    [defaults setInteger:_currentWifiUploadData forKey:@"Wifi Upload"];
    
    
    //NSLog(@"_currentCellUploadData : %0.1f",(float)_currentCellUploadData/1024);
    //NSLog(@"_currentCellDownLoadData : %0.1f",(float)_currentCellDownloadData/1024);
    //NSLog(@"_currentWifiUploadData : %0.1f",(float)_currentWifiUploadData/1024);
    //NSLog(@"_currentWifiDownloadData : %0.1f",(float)_currentWifiDownloadData/1024);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- displays


-(void)CompleteDisplayOnView
{
    
    _percentageCellDataUsed = (_currentCellUploadData + _currentCellDownloadData + [self getDataUsed])*100/[self getDataCap];
    
    //store for history
    [dateFormat setDateFormat:@"dd MMM"];
    _cycleName = [NSString stringWithFormat:@"%@ - %@",[dateFormat stringFromDate:[self getStartDate]],[dateFormat stringFromDate:[self getEndDate]]];
    
    if((float)(_currentCellUploadData + _currentCellDownloadData + [self getDataUsed])/1024/1000 >= 1)
    {
        _dataUsed = [NSString stringWithFormat:@"%0.1f GB",(float)(_currentCellUploadData + _currentCellDownloadData + [self getDataUsed])/1024/1024];
    }
    else
    {
        _dataUsed = [NSString stringWithFormat:@"%0.1f MB",(float)(_currentCellUploadData + _currentCellDownloadData + [self getDataUsed])/1024];
    }
    //NSLog(@"Total Cell Data Used: %@",_dataUsed);
    
    if((float)_currentCellUploadData/1024/1000 >= 1)
    {
        _uploadData = [NSString stringWithFormat:@" %0.1f GB",(float)_currentCellUploadData/1024/1024];
    }
    else
    {
        _uploadData = [NSString stringWithFormat:@" %0.1f MB",(float)_currentCellUploadData/1024];
    }
    
    if((float)(_currentCellDownloadData + [self getDataUsed])/1024/1000 >= 1)
    {
        _downloadData = [NSString stringWithFormat:@" %0.1f GB",(float)(_currentCellDownloadData + [self getDataUsed])/1024/1024];
    }
    else
    {
        _downloadData = [NSString stringWithFormat:@" %0.1f MB",(float)(_currentCellDownloadData + [self getDataUsed])/1024];
    }
    
    _cycleLabel.text = _cycleName;
    _cellularDataUsage.text = _dataUsed;
    _cellUploadLabel.text = _uploadData;
    _cellDownloadLabel.text = _downloadData;
    
    //_cellularDataUsage.text = @"644.6 MB";
    //_cellUploadLabel.text = @"19.2 MB";
    //_cellDownloadLabel.text = @"625.4 MB";
    
    //Now for Wifi...
    
    //Total
    if((float)(_currentWifiUploadData + _currentWifiDownloadData)/1024/1000 >= 1)
    {
        _wi_fiDataUsage.text = [NSString stringWithFormat:@"%0.1f GB",(float)(_currentWifiUploadData + _currentWifiDownloadData)/1024/1024];
    }
    else
    {
        _wi_fiDataUsage.text = [NSString stringWithFormat:@"%0.1f MB",(float)(_currentWifiUploadData + _currentWifiDownloadData)/1024];
    }
    
    //Sent
    if((float)_currentWifiUploadData/1024/1000 >= 1)
    {
        _wifiUploadLabel.text = [NSString stringWithFormat:@" %0.1f GB",(float)(_currentWifiUploadData/1024)/1024];
    }
    else
    {
        _wifiUploadLabel.text = [NSString stringWithFormat:@" %0.1f MB",(float)_currentWifiUploadData/1024];
    }
    
    
    //Received
    if((float)_currentWifiDownloadData/1024/1000 >= 1)
    {
        _wifiDownloadLabel.text = [NSString stringWithFormat:@" %0.1f GB",(float)(_currentWifiDownloadData/1024)/1024];
    }
    else
    {
        _wifiDownloadLabel.text = [NSString stringWithFormat:@" %0.1f MB",(float)_currentWifiDownloadData/1024];
    }
    
    //_wi_fiDataUsage.text = @"1.6 GB";
    //_wifiDownloadLabel.text = @"322.3 MB";
    //_wifiUploadLabel.text = @"1.3 GB";
    
    CGRect frame1, frame2;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        frame1 = CGRectMake(100, _cellularString.frame.origin.y+70, self.view.frame.size.width-200, 0.27);
        frame2 = CGRectMake(100, _wifiString.frame.origin.y+70, self.view.frame.size.width-200, 0.27);
    }
    else
    {
        frame1 = CGRectMake(20, 150, self.view.frame.size.width-40, 0.27);
        frame2 = CGRectMake(20, 320, self.view.frame.size.width-40, 0.27);

    }

    CGRect frame3 = CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 0.27);
    
    UIView *separatorLine1 = [[UIView alloc]init];
    UIView *separatorLine2 = [[UIView alloc]init];
    UIView *separatorLine3 = [[UIView alloc]init];
    
    separatorLine1.backgroundColor = [UIColor whiteColor];
    separatorLine1.frame = frame1;
    [self.view addSubview:separatorLine1];
    
    separatorLine2.backgroundColor = [UIColor whiteColor];
    separatorLine2.frame = frame2;
    [self.view addSubview:separatorLine2];
    
    separatorLine3.backgroundColor = [UIColor whiteColor];
    separatorLine3.frame = frame3;
    [self.view addSubview:separatorLine3];
    
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- theme

-(void)setCustomFont
{
    NSArray    *allSubviews;
    
    
    allSubviews = [self.view subviews];
    for (UIView *subview in allSubviews)
    {
        if (([subview isKindOfClass: [UILabel class]]) || ([subview isKindOfClass: [UIButton class]]))
        {
            UIFont     *font;
            CGFloat    pointSize;
            
            font = [(UILabel *) subview font];
            pointSize = font.pointSize;
            [(UILabel *) subview setFont: [UIFont fontWithName: [defaults objectForKey:@"FontName"] size: pointSize]];
            
        }
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(NSArray *)getThemeType
{
    
    switch([defaults integerForKey:@"Theme Type"])
    {
            
        case 0:
            return [[Theme alloc]init].theme0;
            break;
            
        case 1:
            return [[Theme alloc]init].theme1;
            break;
            
        case 2:
            return [[Theme alloc]init].theme2;
            break;
            
            /*case 3:
             return [[Theme alloc]init].theme3;
             break;
             
             case 4:
             return [[Theme alloc]init].theme4;
             break;
             */
            
        defaults:
            return [[Theme alloc]init].theme0;
            break;
            
    }
    return [[Theme alloc]init].theme0;
    
}


//Changing the background view Color.............

-(void)setBackgroundColor  //call [self setBackgroundColor] in viewDidLoad;
{
    //if(_currentCellData)// in case theme required only for cellular connection
    {
        if(_percentageCellDataUsed<20)
        {    self.view.backgroundColor = [_currentColorTheme objectAtIndex:0];
            return;
        }
        
        if(_percentageCellDataUsed<40)
        {
            self.view.backgroundColor = [_currentColorTheme objectAtIndex:1];
            return;
        }
        
        if(_percentageCellDataUsed<60)
        {
            self.view.backgroundColor = [_currentColorTheme objectAtIndex:2];
            return;
        }
        
        if(_percentageCellDataUsed<80)
        {
            self.view.backgroundColor = [_currentColorTheme objectAtIndex:3];
            return;
        }
        
        self.view.backgroundColor = [_currentColorTheme objectAtIndex:4];
        
    }
}

#pragma mark- timer method
-(void)refreshData
{
    [self findCurrentData];
    [self CompleteDisplayOnView];
    [self findCurrentData];
    [self setCustomFont];
    _currentColorTheme = [self getThemeType];
    [self setBackgroundColor];//sets different of colors to background
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateColor"object:self];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark- history methods

-(void)updateHistory
{
    NSLog(@"in updateHistory method");
    NSMutableArray *historyArray = [[NSMutableArray alloc]init];//a local MutableArray
    
    //current log
    NSArray *currentHistoryArrayObject = [[NSArray alloc]initWithObjects: _cycleName, _dataCapString, _dataUsed, _uploadData, _downloadData, nil];
    NSLog(@"currentHistoryArrayObject Count: %i",[currentHistoryArrayObject count]);//it should always be 5
    
    // add the current log
    //[historyArray addObject:currentHistoryArrayObject];
    historyArray = [[NSMutableArray alloc]initWithObjects:currentHistoryArrayObject, nil];
    
    //retrieve and add the previous logs
    if([defaults objectForKey:@"History"])
    {
        NSArray *historyArrayLocal = [defaults objectForKey:@"History"];
        [historyArray addObjectsFromArray:historyArrayLocal];
    }
    
    NSLog(@"Before adding History Count :%i",[[defaults objectForKey:@"History"] count]);
    
    //update the log history
    [defaults setObject:historyArray forKey:@"History"];
    
    NSLog(@"After adding History Count :%i",[[defaults objectForKey:@"History"] count]);
    [self displayHistory];
    
    
}


-(void)displayHistory
{
    for(NSArray *aPInfo in [defaults objectForKey:@"History"])
    {
        
        NSLog(@"displayHistory");
        for(NSString *details in aPInfo)
        {
            NSLog(@"......................");
            NSLog(@"%@",details);
        }
        
    }
}

@end

