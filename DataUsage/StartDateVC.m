//
//  StartDataVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "StartDateVC.h"
#import "DataCapVC.h"
#import "MyLocalNotifications.h"
#import "Flurry.h"

@interface StartDateVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

@end

@implementation StartDateVC

@synthesize defaults;

#pragma  mark-Xcode generated methods

- (void)viewDidLoad

{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
    defaults = [NSUserDefaults standardUserDefaults];

	// Do any additional setup after loading the view.
    
    _days = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    


    if([defaults integerForKey:@"Plan Type"] == 2)//weekly
    {
        _days = [[NSArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thrusday",@"Friday",@"Saturday", nil];
        

    }
    
    [_pickerView selectRow:[defaults integerForKey:@"StartDateRow"] inComponent:0 animated:NO];
    
    
    

    NSLog(@"StartDateRow used is %i",[defaults integerForKey:@"StartDateRow"]);
    
    if([defaults boolForKey:@"installed"])
    {
        //remove nevigation title...
        [self.myNavigationBar removeFromSuperview];
        if([defaults integerForKey:@"Plan Type"] == 3)//for daily plan disabling the picker view
        {
            [_pickerView setUserInteractionEnabled:NO];
            [_pickerView setAlpha:.6];
        }
        
    }

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}

-(void) viewWillAppear:(BOOL)animated
{
   
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_days count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [_days objectAtIndex:row];
    
}

#pragma mark - Picker view delegate

int startDate, weekDayNumber, startDateRow;
id weekDay;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    startDate = [[_days objectAtIndex:row] integerValue];//object at the row is set
    weekDay = [_days objectAtIndex:row];//week day string
    weekDayNumber = row+1; //here row starts with zero. therefore, sunday as 1st day
    startDateRow = row;
    
}

- (void) save
{
    NSLog(@"saving start date");
    [Flurry logEvent:@"saving start date"];
    
    if(startDate)
    {
        [defaults setInteger:startDate forKey:@"Start Date"];//object at the row is set
    }
    if(weekDay)
    {
        [defaults setObject:weekDay forKey:@"Week Day"];
    }
    if(weekDayNumber)
    {
        [defaults setInteger:weekDayNumber forKey:@"Week Day No."];//here row starts with zero. therefore, sunday as 1st day
    }
   
    [defaults setInteger:startDateRow ? startDateRow : 0 forKey:@"StartDateRow"];

    
    [MyLocalNotifications createAndScheduleLocalNotifications];
    
    if([defaults boolForKey:@"installed"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


// only for installation time..
- (IBAction)action:(UIBarButtonItem *)sender
{
    [self save];
    DataCapVC *dcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Data_Cap"];
    //[self  presentViewController:dcvc animated:YES completion:nil];
    [self.navigationController pushViewController:dcvc animated:YES];
    
}

@end
