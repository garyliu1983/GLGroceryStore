//
//  GLGroceryFetcher.m
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import "GLGroceryFetcher.h"
#import "GLGroceryItem.h"


static NSString * const kGroceryURL = @"https://instacart-ios-builds.s3.amazonaws.com/Products.json";

@implementation GLGroceryFetcher

+ (void) fetchGroceryItemsWithCompletion:(void (^) (NSArray *items, NSError *error))completion {
    
    
    NSURL *url = [NSURL URLWithString:kGroceryURL];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(error == nil && [httpResponse statusCode] == 200) {
            NSArray *items = [self itemsFromData:data];
            if (completion) {
                completion(items, nil);
            }
            
        } else {
            if (completion) {
                completion(nil, error);
            }
        }
    }];
    [task resume];
    
}


+ (NSArray *) itemsFromData:(NSData *)data {
    NSMutableArray *items = [NSMutableArray array];
    if(data) {
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(error) {
            return items;
        }
        NSArray *jsonItems = dict[@"data"][@"items"];
        for(NSDictionary *jsonItem in jsonItems) {
            GLGroceryItem *item = [[GLGroceryItem alloc] init];
            item.name = jsonItem[@"name"];
            item.imageURL = jsonItem[@"primary_image_url"];
            item.price = jsonItem[@"price"];
            item.size = jsonItem[@"size"];
            [items addObject:item];
        }
    }
    
    return items;
}

@end
