//
//  FindDataUsage.m
//  DataUsage
//
//  Created by Deepak Bharati on 01/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "FindDataUsage.h"
#include <stdio.h>
#include <arpa/inet.h> 
#include <net/if.h> 
#include <ifaddrs.h>
#include <net/if_dl.h>

@implementation FindDataUsage

#pragma mark- return data usage list

- (NSArray *)getDataCounters
{
    
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    long int WiFiSent = 0;
    long int WiFiReceived = 0;
    long int WWANSent = 0;
    long int WWANReceived = 0;
    
    NSString *name=[[NSString alloc]init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
           
                                               
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            //NSLog(@"\nifa_name %s == %@\n", cursor->ifa_name,name);
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    //NSLog(@"WiFiSent %ld ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    //NSLog(@"WiFiReceived %ld ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                    
                    /*
                    char* socketAddress = inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr);
                    int socketPort = ntohs(((struct sockaddr_in *)cursor->ifa_addr)->sin_port);
                    printf("Socket IP Address: %s\nPort :%d\n\n",socketAddress, socketPort);
                    */
                                        
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                {
                    
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                    //NSLog(@"WWANSent %ld ==%d",WWANSent,networkStatisc->ifi_obytes);
                    //NSLog(@"WWANReceived %ld ==%d",WWANReceived,networkStatisc->ifi_ibytes);
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent/1024], [NSNumber numberWithInt:WiFiReceived/1024],[NSNumber numberWithInt:WWANSent/1024],[NSNumber numberWithInt:WWANReceived/1024], nil];
    
    
}

@end
