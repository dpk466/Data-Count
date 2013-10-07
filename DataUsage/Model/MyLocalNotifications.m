//
//  MyLocalNotifications.m
//  DataUsage
//
//  Created by Deepak Bharati on 26/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "MyLocalNotifications.h"
#import "FirstViewController.h"

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
        UILocalNotification *localNotification5 = [[UILocalNotification alloc]init];
        
        
        if([defaults integerForKey:@"Plan Type"] == 0 || [defaults integerForKey:@"Plan Type"] == 1)//for monthly or 30 days Plan
        {
            
            // Set the notification time based on start date.
            /*
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(06*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(13*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(20*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(27*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            */
            // Set the notification time based on end date.
            localNotification1.fireDate = [NSDate dateWithTimeInterval:-(22*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:-(15*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:-(8*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:-(1*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            localNotification5.fireDate = [NSDate dateWithTimeInterval:(9*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            
            //test Cases
            //Uncomment the following test
            /*
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(30*24*60*60)+(20*60*60)+(02*60+20) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(30*24*60*60)+(20*60*60)+(02*60+32) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(0*24*60*60)+(10*60*60)+(49*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(0*24*60*60)+(11*60*60)+(28*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification5.fireDate = [NSDate dateWithTimeInterval:(9*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            */
            
            NSDateFormatter* dayFmt = [[NSDateFormatter alloc] init];
            //[dayFmt setTimeZone:<whatever time zone you want>];
            [dayFmt setDateFormat:@"g"];
            NSInteger firstFireDay = [[dayFmt stringFromDate:localNotification1.fireDate] integerValue];// first fire date...
            NSInteger startDay = [[dayFmt stringFromDate:[defaults objectForKey:@"myStartDate"]] integerValue];// start date...
            NSInteger daysTillFirstFire = firstFireDay - startDay;
            NSLog(@"No. of days till first Fire: %i",daysTillFirstFire+1);
            // Set the alertbody of the notification here.
            localNotification1.alertBody = [NSString stringWithFormat:@"You have completed %i days of your bill cycle. Open DataCount to check your usage.",daysTillFirstFire+1];
            localNotification2.alertBody = @"Week 2 of your bill cycle ends in 3 hours. Open DataCount to check your usage.";
            localNotification3.alertBody = @"Week 3 of your bill cycle ends in 3 hours. Open DataCount to check your usage.";
            localNotification4.alertBody = @"Week 4 of your bill cycle ends in 3 hours. Open DataCount to update your usage.";
            localNotification5.alertBody = @"Day 1 of your bill cycle has commenced. Open DataCount to automatically update your usage.";//start of new cycle
            
            
        }
        else if ([defaults integerForKey:@"Plan Type"] == 2)//for Weekly plan
        {
            
            
            // Set the notification time.
            localNotification1.fireDate = [NSDate dateWithTimeInterval:(4*24*60*60)+(24*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification2.fireDate = [NSDate dateWithTimeInterval:(5*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification3.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(9*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification4.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(21*60*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
            localNotification5.fireDate = [NSDate dateWithTimeInterval:(9*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            //test Cases
            //Uncomment the following to test
            /*
             localNotification1.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(40*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification2.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(41*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification3.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(15*60*60)+(44*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification4.fireDate = [NSDate dateWithTimeInterval:(6*24*60*60)+(16*60*60)+(1*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification5.fireDate = [NSDate dateWithTimeInterval:(9*60*60) sinceDate:[defaults objectForKey:@"myEndDate"]];
            */
            
            // Set the alertbody of the notification here.
            localNotification1.alertBody = @"Day 5 of your weekly bill cycle. Open DataCount to check your usage.";
            localNotification2.alertBody = @"Your bill cycle ends tomorrow. Open DataCount to check your usage.";
            localNotification3.alertBody = @"Your bill cycle ends today. Open DataCount to update your usage.";
            localNotification4.alertBody = @"Your bill cycle ends in 3 hours. Open DataCount to update your usage.";
            localNotification5.alertBody = @"Day 1 of your bill cycle has commenced. Open DataCount to automatically update your usage.";//start of new cycle
            
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
             ///
             localNotification1.fireDate = [NSDate dateWithTimeInterval:(13*60*60)+(22*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification2.fireDate = [NSDate dateWithTimeInterval:(13*60*60)+(23*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification3.fireDate = [NSDate dateWithTimeInterval:(15*60*60)+(01*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             localNotification4.fireDate = [NSDate dateWithTimeInterval:(15*60*60)+(10*60) sinceDate:[defaults objectForKey:@"myStartDate"]];
             //
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
        localNotification5.timeZone = [NSTimeZone localTimeZone];
        
        // You can specify the alarm sound here. // all same alarm sound
        localNotification1.soundName = UILocalNotificationDefaultSoundName;
        localNotification2.soundName = UILocalNotificationDefaultSoundName;
        localNotification3.soundName = UILocalNotificationDefaultSoundName;
        localNotification4.soundName = UILocalNotificationDefaultSoundName;
        localNotification5.soundName = UILocalNotificationDefaultSoundName;
        
        //Set the user ifno of the notification here.
        localNotification1.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification1"] forKey:@"info"];
        localNotification2.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification2"] forKey:@"info"];
        localNotification3.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification3"] forKey:@"info"];
        localNotification4.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification4"] forKey:@"info"];
        localNotification5.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"localNotification5"] forKey:@"info"];
        
        // Schedule the notification
        if(!([defaults integerForKey:@"Plan Type"] == 3))
        {
            
            NSLog(@"Local Notifications Enabled");
            
            NSDateFormatter *detailedDateFormat = [[NSDateFormatter alloc]init];
            [detailedDateFormat setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
            NSLog(@"........StartDate: %@",[detailedDateFormat stringFromDate:[defaults objectForKey:@"myStartDate"]]);
            NSLog(@"........EndDate: %@",[detailedDateFormat stringFromDate:[defaults objectForKey:@"myEndDate"]]);
            NSLog(@"..................localNotification1.fireDate: %@",[detailedDateFormat stringFromDate:localNotification1.fireDate]);
            NSLog(@"..................localNotification2.fireDate: %@",[detailedDateFormat stringFromDate:localNotification2.fireDate]);
            NSLog(@"..................localNotification3.fireDate: %@",[detailedDateFormat stringFromDate:localNotification3.fireDate]);
            NSLog(@"..................localNotification4.fireDate: %@",[detailedDateFormat stringFromDate:localNotification4.fireDate]);
            NSLog(@"..................localNotification5.fireDate: %@",[detailedDateFormat stringFromDate:localNotification5.fireDate]);
            
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification1];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification2];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification3];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification4];
            [[UIApplication sharedApplication]scheduleLocalNotification:localNotification5];
        }
        else
        {
            NSLog(@"Local-Notifications are desabled for daily plan");
        }

        
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

