//
//  UserResizableView.h
//  Draw
//
//  Created by DungNT on 10/11/13.
//  Copyright (c) 2013 DungNT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct UserResizableViewAnchorPoint {
    CGFloat adjustsX;
    CGFloat adjustsY;
    CGFloat adjustsH;
    CGFloat adjustsW;
} UserResizableViewAnchorPoint;

@protocol UserResizableViewDelegate;
@class GripViewBorderView;

@interface UserResizableView : UIView {
    GripViewBorderView *borderView;
    UIView *contentView;
    CGPoint touchStart;
    CGFloat minWidth;
    CGFloat minHeight;
    
    // Used to determine which components of the bounds we'll be modifying, based upon where the user's touch started.
    UserResizableViewAnchorPoint anchorPoint;
    
    id <UserResizableViewDelegate> delegate;
}

@property (nonatomic, assign) id <UserResizableViewDelegate> delegate;

// Will be retained as a subview.
@property (nonatomic, assign) UIView *contentView;

// Default is 48.0 for each.
@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat minHeight;

// Defaults to YES. Disables the user from dragging the view outside the parent view's bounds.
@property (nonatomic) BOOL preventsPositionOutsideSuperview;

- (void)hideEditingHandles;
- (void)showEditingHandles;

@end

@protocol UserResizableViewDelegate <NSObject>

@optional

// Called when the resizable view receives touchesBegan: and activates the editing handles.
- (void)userResizableViewDidBeginEditing:(UserResizableView *)userResizableView;

// Called when the resizable view receives touchesEnded: or touchesCancelled:
- (void)userResizableViewDidEndEditing:(UserResizableView *)userResizableView;

@end
