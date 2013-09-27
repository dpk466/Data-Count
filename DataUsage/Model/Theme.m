//
//  Theme.m
//  DataUsage
//
//  Created by Deepak Bharati on 27/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "Theme.h"

@implementation Theme

@synthesize theme0,theme1,theme2;//,theme3,theme4;

#pragma mark- theme data initialization

-(id)init
{
    self = [super init];
    
    theme0 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(57/255.0) green:(181/255.0) blue:(74/255.0) alpha:1.0],
              [UIColor colorWithRed:(141/255.0) green:(198/255.0) blue:(63/255.0) alpha:1.0],
              [UIColor colorWithRed:(247/255.0) green:(148/255.0) blue:(29/255.0) alpha:1.0],
              [UIColor colorWithRed:(242/255.0) green:(101/255.0) blue:(34/255.0) alpha:1.0],
              [UIColor colorWithRed:(158/255.0) green:(11/255.0) blue:(15/255.0) alpha:1.0], nil];//Default
    
    theme1 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(122/255.0) green:(204/255.0) blue:(200/255.0) alpha:1.0],
              [UIColor colorWithRed:(125/255.0) green:(167/255.0) blue:(217/255.0) alpha:1.0],
              [UIColor colorWithRed:(135/255.0) green:(129/255.0) blue:(189/255.0) alpha:1.0],
              [UIColor colorWithRed:(168/255.0) green:(100/255.0) blue:(168/255.0) alpha:1.0],
              [UIColor colorWithRed:(158/255.0) green:(0/255.0) blue:(57/255.0) alpha:1.0], nil];//Pastels
    
    theme2 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(198/255.0) green:(156/255.0) blue:(109/255.0) alpha:1.0],
              [UIColor colorWithRed:(140/255.0) green:(98/255.0) blue:(57/255.0) alpha:1.0],
              [UIColor colorWithRed:(82/255.0) green:(26/255.0) blue:(4/255.0) alpha:1.0],
              [UIColor colorWithRed:(57/255.0) green:(5/255.0) blue:(5/255.0) alpha:1.0],
              [UIColor colorWithRed:(29/255.0) green:(3/255.0) blue:(3/255.0) alpha:1.0], nil];//Coffee
    /*
    theme0 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(105/255.0) green:(210/255.0) blue:(231/255.0) alpha:1.0],
              [UIColor colorWithRed:(167/255.0) green:(219/255.0) blue:(219/255.0) alpha:1.0],
              [UIColor colorWithRed:(224/255.0) green:(228/255.0) blue:(204/255.0) alpha:1.0],
              [UIColor colorWithRed:(243/255.0) green:(134/255.0) blue:(48/255.0) alpha:1.0],
              [UIColor colorWithRed:(250/255.0) green:(105/255.0) blue:(0/255.0) alpha:1.0], nil];//1. Giant Goldfish
    
    theme1 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(53/255.0) green:(64/255.0) blue:(79/255.0) alpha:1.0],
              [UIColor colorWithRed:(74/255.0) green:(170/255.0) blue:(165/255.0) alpha:1.0],
              [UIColor colorWithRed:(122/255.0) green:(204/255.0) blue:(200/255.0) alpha:1.0],
              [UIColor colorWithRed:(163/255.0) green:(211/255.0) blue:(156/255.0) alpha:1.0],
              [UIColor colorWithRed:(228/255.0) green:(95/255.0) blue:(86/255.0) alpha:1.0], nil];//17. WerkPress
    
    theme2 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(203/255.0) green:(187/255.0) blue:(88/255.0) alpha:1.0],
              [UIColor colorWithRed:(154/255.0) green:(173/255.0) blue:(189/255.0) alpha:1.0],
              [UIColor colorWithRed:(192/255.0) green:(89/255.0) blue:(73/255.0) alpha:1.0],
              [UIColor colorWithRed:(149/255.0) green:(79/255.0) blue:(71/255.0) alpha:1.0],
              [UIColor colorWithRed:(117/255.0) green:(58/255.0) blue:(72/255.0) alpha:1.0], nil];//30. Windows of New York
    
    theme3 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(162/255.0) green:(215/255.0) blue:(216/255.0) alpha:1.0],
              [UIColor colorWithRed:(191/255.0) green:(225/255.0) blue:(191/255.0) alpha:1.0],
              [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(234/255.0) alpha:1.0],
              [UIColor colorWithRed:(252/255.0) green:(208/255.0) blue:(89/255.0) alpha:1.0],
              [UIColor colorWithRed:(222/255.0) green:(88/255.0) blue:(66/255.0) alpha:1.0], nil];//44. Gravual
    
    theme4 = [NSArray arrayWithObjects:
              [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0],
              [UIColor colorWithRed:(195/255.0) green:(215/255.0) blue:(223/255.0) alpha:1.0],
              [UIColor colorWithRed:(105/255.0) green:(145/255.0) blue:(172/255.0) alpha:1.0],
              [UIColor colorWithRed:(103/255.0) green:(114/255.0) blue:(122/255.0) alpha:1.0],
              [UIColor colorWithRed:(215/255.0) green:(92/255.0) blue:(55/255.0) alpha:1.0], nil];//45. Scott McCarthy Design
    
    */
    return self;
}


@end
