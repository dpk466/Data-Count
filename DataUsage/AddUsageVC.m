//
//  AddUsageVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "AddUsageVC.h"
#import "FirstViewController.h"
#import "Flurry.h"

@interface AddUsageVC ()
{
    NSUInteger usageEarlier;
    NSString *usageEarlierUnit;
    int r0, r1, r2, r3, r4;
    BOOL boolr0, boolr1, boolr2, boolr3, boolr4;
}


@property (strong, nonatomic) IBOutlet UINavigationBar *myNavigationBar;


@end

@implementation AddUsageVC

@synthesize defaults;

#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
	// Do any additional setup after loading the view.
    _thousandDigits = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _hundredDigits = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _tenthDigits = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _unitDigits = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    _kbMbGb = [[NSMutableArray alloc]initWithObjects:@"KB",@"MB",@"GB", nil];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    [_pickerView selectRow:[defaults integerForKey:@"DataUsedRowForComponent0"] inComponent:0 animated:YES];
    [_pickerView selectRow:[defaults integerForKey:@"DataUsedRowForComponent1"] inComponent:1 animated:YES];
    [_pickerView selectRow:[defaults integerForKey:@"DataUsedRowForComponent2"] inComponent:2 animated:YES];
    [_pickerView selectRow:[defaults integerForKey:@"DataUsedRowForComponent3"] inComponent:3 animated:YES];
    [_pickerView selectRow:[defaults integerForKey:@"DataUsedRowForComponent4"] inComponent:4 animated:YES];
    
    if([defaults boolForKey:@"installed"])
    {
        //remove nevigation title...
        [self.myNavigationBar removeFromSuperview];
    }
    
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return  [_thousandDigits count];
    
    if(component == 1)
        return [_hundredDigits count];
    
    if(component == 2)
        return [_tenthDigits count];
    
    if(component == 3)
        return [_unitDigits count];
    
    if(component == 4)
        return [_kbMbGb count];
    return  0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [_thousandDigits objectAtIndex:row];
    }
    
    if(component == 1)
    {
        return [_hundredDigits objectAtIndex:row];
    }
    
    if(component == 2)
    {
        return [_tenthDigits objectAtIndex:row];
    }
    
    if(component == 3)
    {
        return [_unitDigits objectAtIndex:row];
    }
    
    if(component == 4)
    {
        return [_kbMbGb objectAtIndex:row];
    }
    return 0;
}

#pragma mark - Picker view delegates


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        
    usageEarlier = [[_thousandDigits objectAtIndex:[pickerView selectedRowInComponent:0]]integerValue]*1000
                    +[[_hundredDigits objectAtIndex:[pickerView selectedRowInComponent:1]]integerValue]*100
                    +[[_tenthDigits objectAtIndex:[pickerView selectedRowInComponent:2]]integerValue]*10
                    +[[_unitDigits objectAtIndex:[pickerView selectedRowInComponent:3]]integerValue];
    
    usageEarlierUnit = [_kbMbGb objectAtIndex:[pickerView selectedRowInComponent:4]];
    
    if(component == 0){
        r0 = row;
        boolr0 = YES;
    }
    
    if(component == 1) {
        
        r1 = row;
        boolr1 = YES;
    }
    
    if(component == 2){
        r2 = row;
        boolr2 = YES;
    }
    
    if(component == 3){
        r3 = row;
        boolr3 = YES;
    }
    
    if(component == 4) {
        r4= row;
        boolr4 = YES;
    }


}

- (void) save
{
    NSLog(@"saving existing usage");
    [Flurry logEvent:@"saving existing usage"];
    
    NSUInteger prevUsage = [defaults integerForKey:@"Data Used"];
    NSString *prevUnit = [defaults objectForKey:@"Data Used Unit"];
    
    if(usageEarlier)[defaults setInteger:usageEarlier forKey:@"Data Used"];
    if(usageEarlierUnit)[defaults setObject:usageEarlierUnit forKey:@"Data Used Unit"];
    
    if([[[FirstViewController alloc]init] getDataUsed] > [[[FirstViewController alloc]init] getDataCap])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Oops!"
                              message:[NSString stringWithFormat:@"Selected usage exceeds your data cap."]
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show];
        
        [defaults setInteger:prevUsage forKey:@"Data Used"];
        [defaults setObject:prevUnit forKey:@"Data Used Unit"];
        
        return;
    }

    [defaults setInteger:boolr0 ? r0 :[defaults integerForKey:@"DataUsedRowForComponent0"] forKey:@"DataUsedRowForComponent0"];
    [defaults setInteger:boolr1 ? r1 :[defaults integerForKey:@"DataUsedRowForComponent1"] forKey:@"DataUsedRowForComponent1"];
    [defaults setInteger:boolr2 ? r2 :[defaults integerForKey:@"DataUsedRowForComponent2"] forKey:@"DataUsedRowForComponent2"];
    [defaults setInteger:boolr3 ? r3 :[defaults integerForKey:@"DataUsedRowForComponent3"] forKey:@"DataUsedRowForComponent3"];
    [defaults setInteger:boolr4 ? r4 :[defaults integerForKey:@"DataUsedRowForComponent4"] forKey:@"DataUsedRowForComponent4"];
    
    if([defaults boolForKey:@"installed"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

    
}


// only for installation time..
- (IBAction)action:(UIBarButtonItem *)sender
{
    [self save];
    UIViewController *finishVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Finish"];
    //[self  presentViewController:finishVC animated:YES completion:nil];
    [self.navigationController pushViewController:finishVC animated:YES];
}

@end
