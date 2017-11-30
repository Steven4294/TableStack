//
//  TSObjectManager.h
//  TableStack
//
//  Created by Steven Petteruti on 11/30/17.
//  Copyright © 2017 Steven Petteruti. All rights reserved.
//

/*
 *
 * This class (using a single-ton pattern) is responsible for fetching the data from api.stackexchange
 *
 */

#import <Foundation/Foundation.h>

@interface TSObjectManager : NSObject

+ (id)sharedManager;

- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback;


@end
