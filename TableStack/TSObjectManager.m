//
//  TSObjectManager.m
//  TableStack
//
//  Created by Steven Petteruti on 11/30/17.
//  Copyright © 2017 Steven Petteruti. All rights reserved.
//

#import "TSObjectManager.h"
#import "SBJson5.h"
#import "TSUser.h"

@implementation TSObjectManager

+ (id)sharedManager {
    static TSObjectManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback{

    // making a GET request to /init
    NSString *targetUrl = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users?site=stackoverflow"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    
    // parsing blocks
    SBJson5ValueBlock block = ^(id v, BOOL *stop) {
        if ([v isKindOfClass:[NSMutableDictionary class]]) {
            NSArray *array = v[@"items"];
            NSMutableArray *listOfUsers = [[NSMutableArray alloc] init];
            for (id person in array) {
                
                TSUser *user = [[TSUser alloc] initWithName:person[@"display_name"] andImageLink:person[@"profile_image"] andBadges:person[@"badge_counts"]];
                [listOfUsers addObject:user];
                
            }
            aCallback([listOfUsers copy], nil); //copy creates an immutable version (since we want an NSArray and not an NSMutableArray)
            
        }
    };
    
    SBJson5ErrorBlock eh = ^(NSError* err) {
        aCallback(nil, err);

    };
    
    
    // create a url request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          // parse the data into a nsdictionary
          id parser = [SBJson5Parser parserWithBlock:block
                                        errorHandler:eh];
          
          [parser parse:data];
          
      }] resume];

}

@end
