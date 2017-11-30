//
//  TSUser.m
//  TableStack
//
//  Created by Steven Petteruti on 11/30/17.
//  Copyright © 2017 Steven Petteruti. All rights reserved.
//

#import "TSUser.h"

@implementation TSUser

- (instancetype)initWithName:(NSString *)name andImageLink:(NSString *)link andBadges:(NSDictionary *)badges
{
    self = [super init];
    if (self != nil)
    {
        // Further initialization if needed
        _name = name;
        _link = link;
        _badges = badges;
    }
    return self;
}

@end
