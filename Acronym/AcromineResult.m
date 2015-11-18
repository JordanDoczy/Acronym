//
//  AcromineResult.m
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import "AcromineResult.h"

@implementation AcromineResult

@synthesize description;

NSString *const Frequency = @"freq";
NSString *const Description = @"lf";
NSString *const YearEstablished = @"since";
NSString *const Variations = @"vars";

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self.frequency = ((NSString *)dictionary[Frequency]).intValue;
    self.description = dictionary[Description];
    self.yearEstablished = ((NSString *)dictionary[YearEstablished]).intValue;
    self.variations = [NSMutableArray array];
    
    for (NSDictionary *variation in dictionary[Variations] ){
        AcromineResult *result = [[AcromineResult alloc] initWithDictionary:variation];
        [self.variations addObject:result];
    }
    return [self init];
}

@end