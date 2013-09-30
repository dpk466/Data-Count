//
//  ViewController.m
//  DataUsage
//
//  Created by Deepak Bharati on 06/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "ViewController.h"
//#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"



@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *controllers;

@property (strong, nonatomic) IBOutlet UIButton *myButtonForSettingMenu;



@end

@implementation ViewController


@synthesize controllers;

#pragma mark - menu button pressed
- (IBAction)goToSetting:(id)sender
{
    NSLog(@"goToSetting");
   
    
    //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        NSLog(@"Popover");
        
            if (self.navigationControllerForSetting == nil)
            {
                //UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];//from iphone Storyboard
                //UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"IpadStoryboard" bundle:nil];
                //self.navigationControllerForSetting = [mystoryboard instantiateViewControllerWithIdentifier:@"navigationControllerForSetting"];
                self.navigationControllerForSetting = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationControllerForSetting"];
                
                SettingTableViewController *stvc = (SettingTableViewController *)self.navigationControllerForSetting.topViewController;
                
                //Set this VC as the delegate.
                stvc.delegate = self;
            }
            
            if (self.settingTVCPopover == nil)
            {
                //The settingTVC popover is not showing. Show it.
              //  UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.navigationControllerForSetting];
               
                _settingTVCPopover = [[UIPopoverController alloc] initWithContentViewController:self.navigationControllerForSetting];
                
                
                //[_settingTVCPopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
                [_settingTVCPopover presentPopoverFromRect:self.myButtonForSettingMenu.frame inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
                _settingTVCPopover.delegate=self;
                
                
            }
            else
            {
                //The settingTVC popover is showing. Hide it.
                [self.settingTVCPopover dismissPopoverAnimated:YES];
                self.settingTVCPopover = nil;
            }
        
    }
    else
    {
        // The device is an iPhone or iPod touch.
        //load setting table
       // [self performSegueWithIdentifier: @"setting" sender: self];
        
        
        UINavigationController *navigationControllerForSetting = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationControllerForSetting"];
        
        //SettingTableViewController *stvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingTableViewController"];
        // Pass the selected object to the new view controller.
        //[self.navigationController pushViewController:stvc animated:YES];
        [self presentViewController:navigationControllerForSetting animated:YES completion:nil];

    }
    
}

#pragma mark - popover delegate method

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.settingTVCPopover = nil;
}

#pragma mark - mySettingDelegate delegate method

-(void)dismissSettingPopOverView
{
    NSLog(@"Done pressed in dismissDatePopOverView");
    //Dismiss the popover if it's showing.
    if (self.settingTVCPopover)
    {
        [self.settingTVCPopover dismissPopoverAnimated:YES];
        self.settingTVCPopover = nil;
        
    }
}

#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setColor:) name:@"updateColor" object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:@"installed"];

	// Do any additional setup after loading the view.
    controllers = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
       
    //just adding two controllers
   
    FirstViewController *one = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    //Update the frame of its view
    one.view.frame = CGRectMake(self.scrollView.frame.size.width * 0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:one.view];
    [controllers addObject:one];
    
    SecondViewController *two = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    //Update the frame of its view
    two.view.frame = CGRectMake(self.scrollView.frame.size.width * 1, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:two.view];
    [controllers addObject:two];
    
    self.scrollView.backgroundColor = two.view.backgroundColor;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height);
    //NSLog(@"\nEntire content size :\n\n\t\t%1.0f\n\t\t%1.0f",self.scrollView.contentSize.width,self.scrollView.contentSize.height);
    self.pageControl.numberOfPages = [controllers count];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // The device is an iPad running iPhone 3.2 or later.
        

    }
    else
    {
        // The device is an iPhone or iPod touch.
    }
}

#pragma mark - scroll view delegates

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	_pageControlBeingUsed = NO;
}

#pragma mark - my method to change to appropriate page

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    _pageControlBeingUsed = YES;
}

#pragma mark - selector for NotificationCenter

- (void) setColor:(NSNotification *)notification
{
    //NSLog(@"received For Color Change");
    if([[notification object] isKindOfClass:[FirstViewController class]])
    {
        //NSLog(@"typeOne");
        FirstViewController *top = [notification object];
        self.scrollView.backgroundColor = top.view.backgroundColor;
    }
    else
    {
        //NSLog(@"typeTwo");
        SecondViewController *top = [notification object];
        self.scrollView.backgroundColor = top.view.backgroundColor;
    }
    
}

@end
