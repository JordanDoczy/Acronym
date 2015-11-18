//
//  AcromineResult.h
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcromineResult : NSObject

@property NSString *description;
@property int frequency;
@property int yearEstablished;
@property NSMutableArray *variations;

- (id)initWithDictionary:(NSDictionary *)values;



@end