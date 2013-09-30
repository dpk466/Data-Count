//
//  AppDelegate.m
//  DataUsage
//
//  Created by Deepak Bharati on 01/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "AppDelegate.h"
#import "KeychainItemWrapper.h"

#import "MyLocalNotifications.h"


@interface AppDelegate()



@property (nonatomic, retain) WelcomeViewController * welcomeView;//

@property (nonatomic, retain) UINavigationController * welcomeNavigationController;

@property (nonatomic) BOOL isDefaultValueNotToBeUsed;

@end

@implementation AppDelegate


@synthesize isDefaultValueNotToBeUsed, welcomeView, welcomeNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //for getting value from keychain
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"DataCount" accessGroup:nil];
    //for getting value from keychain
    NSString *appVersionFromKeyChain = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    NSLog(@"appVersionKEY====%@",appVersionFromKeyChain);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [defaults setObject:appVersion forKey:@"Version"];
    NSLog(@"appversion===%@",appVersion);
    //  KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"TimeZlider" accessGroup:nil];
    [keychainItem setObject:appVersion forKey:(__bridge id)kSecAttrAccount];
    
    // [keychainItem resetKeychainItem];

    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"FirstRun"];
    
    isDefaultValueNotToBeUsed = [defaults boolForKey:@"SetDefault"];
    if(!isDefaultValueNotToBeUsed)
    {
        NSLog(@"Bool Value For Default: %d",isDefaultValueNotToBeUsed);
        [defaults setBool:YES forKey:@"SetDefault"];
        
        //here default setting goes...
        [defaults setObject:@"Monthly"forKey:@"Plan Type String"];
        [defaults setInteger:0 forKey:@"Plan Type"];
        [defaults setInteger:1 forKey:@"Start Date"];//1st of the month
        
        [defaults setInteger:1 forKey:@"Data Cap"];
        [defaults setObject:@"GB"forKey:@"Data Cap Unit"];
        [defaults setInteger:0 forKey:@"DataCapRowForComponent0"];//0
        [defaults setInteger:0 forKey:@"DataCapRowForComponent1"];//0
        [defaults setInteger:0 forKey:@"DataCapRowForComponent2"];//0
        [defaults setInteger:1 forKey:@"DataCapRowForComponent3"];//1
        [defaults setInteger:2 forKey:@"DataCapRowForComponent4"];//GB
        
        [defaults setInteger:0 forKey:@"Data Used"];
        [defaults setObject:@"KB"forKey:@"Data Used Unit"];
        
        [defaults setInteger:3 forKey:@"Font Style"];
        [defaults setObject:@"HelveticaNeue-Thin" forKey:@"FontName"];
        [defaults setObject:@"Default" forKey:@"Theme Type String"];
        
        [defaults setBool:YES forKey:@"NotificationToBeScheduled"];
        
        
        //here welcome note and initial setup UI goes...
        UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            myStoryBoard = [UIStoryboard storyboardWithName:@"IpadStoryboard" bundle: nil];
        }
        
        //welcomeView = [myStoryBoard instantiateViewControllerWithIdentifier:@"WelcomeView"];
        //self.window.rootViewController = welcomeView;
        
        welcomeNavigationController = [myStoryBoard instantiateViewControllerWithIdentifier:@"WelcomeNavigation"];
        self.window.rootViewController = welcomeNavigationController;
        
        [defaults setBool:NO forKey:@"installed"];
        
        
        [defaults setBool:YES forKey:@"Reset"];
        
    }
    
    /*// Cancel first all the existing notifications.
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    UILocalNotification *localNotif =[launchOptions    objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
    {
        [self application:application didReceiveLocalNotification:localNotif];
    }*/
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
   
    
    NSLog(@"%@ Received",[notification.userInfo objectForKey:@"info"]);
}

@end
