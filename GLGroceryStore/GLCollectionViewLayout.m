//
//  GLCollectionViewLayout.m
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import "GLCollectionViewLayout.h"


@interface GLCollectionViewLayout ()

@property (strong, nonatomic) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGSize contentSize;

@end

static CGFloat const kInternalPadding = 1.0;
static CGFloat const kCellHeight = 200.0;

@implementation GLCollectionViewLayout

- (void) prepareLayout {
    _itemAttributes = [NSMutableArray array];
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
    CGFloat cellWidth = ceilf((collectionViewWidth - 2*kInternalPadding)/3);
    
    NSUInteger itemCount = _groceryItems.count;
    NSUInteger rowCount = itemCount/3 + (itemCount%3==0?0:1);
    CGFloat contentHeight = rowCount*kCellHeight + (rowCount-1)*kInternalPadding;
    _contentSize = CGSizeMake(collectionViewWidth, contentHeight);
    
    for(int i=0; i<self.groceryItems.count; i++) {
        
        int rows = (i+1)/3;
        CGFloat y = 0;
        CGFloat x = 0;
        if((i+1)%3 == 0) {
            y = (rows-1)*kCellHeight + (rows-1)*kInternalPadding;
            x = 2*(cellWidth+kInternalPadding);
            
        }else {
            int mod = (i+1)%3;
            if(rows == 0) {
                y = 0;
            }else {
                y = rows * (kCellHeight + kInternalPadding);
            }
            if (mod == 1) x = 0;
            if (mod == 2) x = cellWidth + kInternalPadding;
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        layoutAttributes.frame = CGRectIntegral(CGRectMake(x, y, cellWidth, kCellHeight));
        
        [_itemAttributes addObject:layoutAttributes];
    }
    
}


- (CGSize) collectionViewContentSize {
    return _contentSize;
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_itemAttributes objectAtIndex:indexPath.row];
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesFroRect = [NSMutableArray array];
    for(UICollectionViewLayoutAttributes *attributes in _itemAttributes) {
        if(CGRectIntersectsRect(attributes.frame, rect)) {
            [attributesFroRect addObject:attributes];
        }
    }
    return attributesFroRect;
}


@end
