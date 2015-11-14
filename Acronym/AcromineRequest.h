//
//  AcromineRequest.h
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AcromineRequest : NSObject
    
- (void) fetch:(NSString *)urlString :(void (^)(NSArray *))handler;
@property (nonatomic) AFHTTPRequestOperationManager *manager;


@end