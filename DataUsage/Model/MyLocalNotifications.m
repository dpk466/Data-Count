//
//  MyLocalNotifications.m
//  DataUsage
//
//  Created by Deepak Bharati on 26/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "MyLocalNotifications.h"

@implementation MyLocalNotifications



+ (void) createAndScheduleLocalNotifications
{
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults boolForKey:@"NotificationToBeScheduled"])
    {
        
        
        UILocalNotification *localNotification1 = [[UILocalNotification alloc]init];
        UILocalNotification *localNotification2 = [[UILocalNotification alloc]init];
        UILocalNotification *localNotification3 = [[UILocalNotification alloc]init];
        UILocalNotification *localNotification4 = [[UILocalNotification alloc]init];
        
        
        if([defaults integerForKey:@"Plan Type"] == 0 || [defaults integerForKey:@"Plan Type"] == 1)//for monthly or 30 days Plan
        {
            
            // Set the notification time.
            //at end of WEEK at 9:00 PM (6*24*60*60)+(21*60*60)
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(06*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(13*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(20*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(27*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            //test Cases
            //Uncomment the following test
            /*on last day of plan
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(30*24*60*60)+(20*60*60)+(02*60+20) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(30*24*60*60)+(20*60*60)+(02*60+32) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(0*24*60*60)+(10*60*60)+(49*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(0*24*60*60)+(11*60*60)+(28*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            */
            NSDateFormatter *detailedDateFormat = [[NSDateFormatter alloc]init];
            [detailedDateFormat setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
            NSLog(@"........StartDate: %@",[detailedDateFormat stringFromDate:[defaults objectForKey:@"myStartDate"]]);
            NSLog(@"..................localNotification1.fireDate: %@",[detailedDateFormat stringFromDate:localNotification1.fireDate]);
            NSLog(@"..................localNotification2.fireDate: %@",[detailedDateFormat stringFromDate:localNotification2.fireDate]);
            NSLog(@"..................localNotification3.fireDate: %@",[detailedDateFormat stringFromDate:localNotification3.fireDate]);
            NSLog(@"..................localNotification4.fireDate: %@",[detailedDateFormat stringFromDate:localNotification4.fireDate]);
            //*/
            // Set the alertbody of the notification here.
            localNotification1.alertBody = @"Week 1 of your bill cycle ends in 3 hours. Open DataCount to check your usage.";
            localNotification2.alertBody = @"Week 2 of your bill cycle ends in 3 hours. Open DataCount to check your usage.";
            localNotification3.alertBody = @"Week 3 of your bill cycle ends in 3 hours. Open DataCount to check your usage.";
            localNotification4.alertBody = @"Week 4 of your bill cycle ends in 3 hours. Open DataCount to update your usage.";
            
            
        }
        else if ([defaults integerForKey:@"Plan Type"] == 2)//for Weekly plan
        {
            
            
            // Set the notification time.
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(4*24*60*60)+(24*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(5*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(9*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            //test Cases
            //Uncomment the following to test
            /*
             localNotification1.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(40*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification2.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(41*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification3.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(44*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification4.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(16*60*60)+(1*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             */
            NSDateFormatter *detailedDateFormat = [[NSDateFormatter alloc]init];
            [detailedDateFormat setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
            NSLog(@"........StartDate: %@",[detailedDateFormat stringFromDate:[defaults objectForKey:@"myStartDate"]]);
            NSLog(@"..................localNotification1.fireDate: %@",[detailedDateFormat stringFromDate:localNotification1.fireDate]);
            NSLog(@"..................localNotification2.fireDate: %@",[detailedDateFormat stringFromDate:localNotification2.fireDate]);
            NSLog(@"..................localNotification3.fireDate: %@",[detailedDateFormat stringFromDate:localNotification3.fireDate]);
            NSLog(@"..................localNotification4.fireDate: %@",[detailedDateFormat stringFromDate:localNotification4.fireDate]);
            //*/
            // Set the alertbody of the notification here.
            localNotification1.alertBody = @"Day 5 of your weekly bill cycle. Open DataCount to check your usage.";
            localNotification2.alertBody = @"Your bill cycle ends tomorrow. Open DataCount to check your usage.";
            localNotification3.alertBody = @"Your bill cycle ends today. Open DataCount to update your usage.";
            localNotification4.alertBody = @"Your bill cycle ends in 3 hours. Open DataCount to update your usage.";
            
        }
        /*
         else //for Daily plan
         {
         
             // Set the notification time.
             localNotification1.fireDate = [NSDate dateWithTimeInterval:(4*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification2.fireDate = [NSDate dateWithTimeInterval:(12*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification3.fireDate = [NSDate dateWithTimeInterval:(20*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification4.fireDate = [NSDate dateWithTimeInterval:(23*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             //test Cases
             //Uncomment the following to test
             localNotification1.fireDate = [NSDate dateWithTimeInterval:(13*60*60)+(22*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification2.fireDate = [NSDate dateWithTimeInterval:(13*60*60)+(23*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification3.fireDate = [NSDate dateWithTimeInterval:(15*60*60)+(01*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification4.fireDate = [NSDate dateWithTimeInterval:(15*60*60)+(10*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             
             // Set the alertbody of the notification here.
             localNotification1.alertBody = @"4 hours of your weekly data plan is finished";
             localNotification2.alertBody = @"12 hours of your weekly data plan is remaining";
             localNotification3.alertBody = @"Your Data plan will finish in 4 hours";
             localNotification4.alertBody = @"Your data plan will finish in 1 hour";
             
         }
         */
        
        
        // Set the notification time zone. // all same time zone
        localNotification1.timeZone = [NSTimeZone localTimeZone];
        localNotification2.timeZone = [NSTimeZone localTimeZone];
        localNotification3.timeZone = [NSTimeZone localTimeZone];
        localNotification4.timeZone = [NSTimeZone localTimeZone];
        
        // You can specify the alarm sound here. // all same alarm sound
        localNotification1.soundName = UILocalNotificationDefaultSoundName;
        localNotification2.soundName = UILocalNotificationDefaultSoundName;
        localNotification3.soundName = UILocalNotificationDefaultSoundName;
        localNotification4.soundName = UILocalNotificationDefaultSoundName;
        
        //Set the user ifno of the notification here.
        localNotification1.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification1"] forKey:@"info"];
        localNotification2.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification2"] forKey:@"info"];
        localNotification3.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification3"] forKey:@"info"];
        localNotification4.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification4"] forKey:@"info"];
        
        // Schedule the notification
        if(!([defaults integerForKey:@"Plan Type"] == 3))
        {
            
            NSLog(@"Local Notifications Enabled");
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification1];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification2];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification3];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification4];
        }
    
    }
    else
    {
        NSLog(@"Local Notifications Desabled");
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /*
     // Set the notification time zone. // all same time zone
     localNotificationW1.timeZone = [NSTimeZone localTimeZone];
     
     
     // You can specify the alarm sound here. // all same alarm sound
     localNotificationW1.soundName = UILocalNotificationDefaultSoundName;
     
     // Set the alertbody of the notification here.
     localNotificationW1.alertBody = @"1st week of your data plan will finish in 3 hour";
     
     
     //Set the user ifno of the notification here.
     localNotificationW1.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotificationW1"] forKey:@"info"];
     
     
     
     [[UIApplication sharedApplication]scheduleLocalNotification:localNotificationW1];
     */
    
}

@end

