//
//  AcromineRequest.m
//  Term Look Up
//
//  Created by Jordan Doczy on 11/13/15.
//  Copyright © 2015 Jordan Doczy. All rights reserved.
//

#import "AcromineRequest.h"
#import "AcromineResult.h"

@implementation AcromineRequest

- (void) fetch:(NSString *)urlString :(void (^)(NSArray *))handler{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSError *e = nil;
        NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingAllowFragments error: &e];
        NSMutableArray *results = [NSMutableArray array];
        
        @try {
            for (NSDictionary *dict in json[0][@"lfs"]){
                [results addObject: [[AcromineResult alloc] initWithDictionary:dict]];
            }

        }
        @catch (NSException *exception) {
            NSLog(@"%@%@", @"No results found at: ", urlString);
        }
        
        
        handler(results);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [operation start];
}

@end