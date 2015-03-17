//
//  GLGroceryItemCell.h
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLGroceryItem.h"

@interface GLGroceryItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *itemNameLabel;
@property (nonatomic, strong) UILabel *itemDescLabel;

- (void) configureWithItem:(GLGroceryItem *)item;

@end
