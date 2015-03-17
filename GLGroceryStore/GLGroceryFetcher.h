//
//  GLGroceryFetcher.h
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLGroceryFetcher : NSObject

+ (void) fetchGroceryItemsWithCompletion:(void (^) (NSArray *items, NSError *error))completion;

@end
