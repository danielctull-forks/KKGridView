//
//  GridViewDemoViewController.m
//  GridViewDemo
//
//  Created by Kolin Krewinkel on 7.25.11.
//  Copyright 2011 Giulio Petek, Jonathan Sterling, and Kolin Krewinkel. All rights reserved.
//

#import "GridViewDemoViewController.h"
#import <QuartzCore/QuartzCore.h>

static const NSUInteger kNumSection = 40;

@implementation GridViewDemoViewController {
    KKGridView *_gridView;
    NSMutableArray *_headerViews;
}

- (void)dealloc
{
    [_gridView release];
    [_headerViews release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    _headerViews = [[NSMutableArray alloc] init];
    for (NSUInteger section = 0; section < kNumSection; section++) {
        UILabel *view = [[[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 25.f)] autorelease];
        view.textAlignment = UITextAlignmentCenter;
        view.textColor = [UIColor blackColor];
        view.text = [NSString stringWithFormat:@"%i", section];
        [_headerViews addObject:view];
    }
    
    _gridView = [[KKGridView alloc] initWithFrame:self.view.bounds dataSource:self delegate:self];
    _gridView.cellSize = CGSizeMake(100.f, 100.f);
    _gridView.backgroundColor = [UIColor darkGrayColor];
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _gridView.cellPadding = CGSizeMake(5.f, 5.f);
    self.view = _gridView;
    
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    switch (section) {
        case 0:
            return 20;
            break;
        case 1:
            return 15;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 5;
            break;
        default:
            return 4;
            break;
    }
}

- (CGFloat)gridView:(KKGridView *)gridView heightForHeaderInSection:(NSUInteger)section
{
    return 25.f;
}

- (UIView *)gridView:(KKGridView *)gridView viewForHeaderInSection:(NSUInteger)section
{
    return [_headerViews objectAtIndex:section];
}

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return kNumSection;
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForRowAtIndexPath:(KKIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    KKGridViewCell *cell = [gridView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[KKGridViewCell alloc] initWithFrame:CGRectMake(0.f, 0.f, gridView.cellSize.width, gridView.cellSize.height) reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor grayColor];
//        cell.layer.shadowRadius = 2.f;
//        cell.layer.shadowColor = [UIColor blackColor].CGColor;
//        cell.layer.shadowOffset = CGSizeZero;
//        cell.layer.shadowOpacity = 0.8f;
//        cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectInset(cell.bounds, 1.f, 1.f)].CGPath;
    }
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
