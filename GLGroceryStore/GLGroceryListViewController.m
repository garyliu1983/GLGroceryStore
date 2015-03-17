//
//  GLGroceryListViewController.m
//  GLGroceryStore
//
//  Created by Gary on 3/16/15.
//  Copyright (c) 2015 uniqueu. All rights reserved.
//

#import "GLGroceryListViewController.h"
#import "GLGroceryFetcher.h"
#import "GLGroceryItem.h"
#import "GLLoadingOverlay.h"
#import "GLGroceryItemCell.h"
#import "GLCollectionViewLayout.h"

@interface GLGroceryListViewController ()

@property (nonatomic, strong) GLLoadingOverlay *loadingOverlay;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) GLCollectionViewLayout *layout;

@end

@implementation GLGroceryListViewController {
    NSMutableArray *_overlayConstraints;
}

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init {
    self = [super init];
    if(self) {
        GLCollectionViewLayout *collectionViewLayout = [[GLCollectionViewLayout alloc] init];
        self.layout = collectionViewLayout;
        self = [self initWithCollectionViewLayout:collectionViewLayout];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"All groceries";
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    // Register cell classes
    [self.collectionView registerClass:[GLGroceryItemCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    [self showLoadingOverlay];    
    [GLGroceryFetcher fetchGroceryItemsWithCompletion:^(NSArray *items, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingOverlay];
            
            self.items = items;
            self.layout.groceryItems = items;
            [self.layout invalidateLayout];
            [self.collectionView reloadData];
        });
    }];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self.layout invalidateLayout];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showLoadingOverlay {
    [self.collectionView addSubview:self.loadingOverlay];
    if(_overlayConstraints == nil) {
        _overlayConstraints = [NSMutableArray array];
    }
    
    [_overlayConstraints addObject:[NSLayoutConstraint constraintWithItem:_loadingOverlay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [_overlayConstraints addObject:[NSLayoutConstraint constraintWithItem:_loadingOverlay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_overlayConstraints addObject:[NSLayoutConstraint constraintWithItem:_loadingOverlay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [_overlayConstraints addObject:[NSLayoutConstraint constraintWithItem:_loadingOverlay attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.collectionView addConstraints:_overlayConstraints];
    
    [self.loadingOverlay.indicatorView startAnimating];
}

- (void) hideLoadingOverlay {
    [_loadingOverlay.indicatorView stopAnimating];
    
    if(_overlayConstraints.count > 0) {
        [self.collectionView removeConstraints:_overlayConstraints];
        [_overlayConstraints removeAllObjects];
    }
    
    [_loadingOverlay removeFromSuperview];
}

- (GLLoadingOverlay *) loadingOverlay {
    if(_loadingOverlay == nil) {
        _loadingOverlay = [[GLLoadingOverlay alloc] init];
    }
    return _loadingOverlay;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLGroceryItem *item = [self.items objectAtIndex:indexPath.row];
    
    
    GLGroceryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell configureWithItem:item];
    
    
    return cell;
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
