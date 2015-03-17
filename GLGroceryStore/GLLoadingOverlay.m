//
//  GLLoadingOverlay.m
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import "GLLoadingOverlay.h"

@interface GLLoadingOverlay()


@end

@implementation GLLoadingOverlay {
    NSMutableArray *_constraints;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.indicatorView];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;

        _constraints = [NSMutableArray array];
        [self setupConstraints];
    }
    return self;
}

- (void) updateConstraints {
    [super updateConstraints];
    [self setupConstraints];
}

- (void) setupConstraints {
    if(_constraints.count > 0) {
        [self removeConstraints:_constraints];
        [_constraints removeAllObjects];
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:20.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:_indicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:20.0]];
    [self addConstraints:_constraints];
    
}



@end
