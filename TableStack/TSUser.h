//
//  TSUser.h
//  TableStack
//
//  Created by Steven Petteruti on 11/30/17.
//  Copyright © 2017 Steven Petteruti. All rights reserved.
//

/*
 *
 * This class is responsible for setting up the StackOverFlow user object
 *
 */

#import <Foundation/Foundation.h>

@interface TSUser : NSObject

@property NSString *name;
@property NSString *link;
@property NSDictionary *badges;

- (instancetype)initWithName:(NSString *)name andImageLink:(NSString *)link andBadges:(NSDictionary *)badges;

@end
