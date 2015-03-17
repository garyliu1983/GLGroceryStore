//
//  GLGroceryItemCell.m
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import "GLGroceryItemCell.h"

@interface GLGroceryItemCell()



@end

@implementation GLGroceryItemCell


- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.itemImageView = [[UIImageView alloc] init];
        self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.itemImageView];
        
        self.itemNameLabel = [[UILabel alloc] init];
        self.itemNameLabel.numberOfLines = 0;
        self.itemNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.itemNameLabel.font = [UIFont systemFontOfSize:12];
        self.itemNameLabel.textColor = [UIColor blackColor];
        self.itemNameLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.itemNameLabel];
        
        self.itemDescLabel = [[UILabel alloc] init];
        self.itemDescLabel.font = [UIFont systemFontOfSize:11];
        self.itemDescLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.itemDescLabel];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.itemDescLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self setupConstraints];
        
    }
    return self;
}

- (void) prepareForReuse {
    self.itemImageView.image = nil;
    self.itemNameLabel.text = nil;
    self.itemDescLabel.text = nil;
}

- (void) configureWithItem:(GLGroceryItem *)item {
    self.itemNameLabel.text = item.name;
    [self.itemNameLabel sizeToFit];
    
    self.itemDescLabel.text = [NSString stringWithFormat:@"$ %@ - %@",item.price, item.size];
    [self.itemDescLabel sizeToFit];
    
    __weak typeof(self) weak_self = self;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:item.imageURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weak_self.itemImageView.image = [UIImage imageWithData:data];
            });
        }
    }];
    [task resume];
    [self setNeedsLayout];
}

- (void) setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings( _itemImageView, _itemNameLabel, _itemDescLabel);
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_itemImageView(80)]-1-[_itemNameLabel(<=80)]-3-[_itemDescLabel]-|" options:0 metrics:nil views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[_itemImageView]-1-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_itemNameLabel]-5-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_itemDescLabel]-5-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:constraints];
}

@end
