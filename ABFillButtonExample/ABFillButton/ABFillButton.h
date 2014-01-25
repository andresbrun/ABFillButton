//
//  IconButton.h
//  uSpeak
//
//  Created by Andrés Brun on 7/31/13.
//  Copyright (c) 2013 uSpeak Ltd. All rights reserved.
//



#define ICON_BUTTON_SCALE 0.85

@class ABFillButton;

@protocol ABFillButtonDelegate <NSObject>
@optional
- (void) buttonIsEmpty: (ABFillButton *)button;
@end

@interface ABFillButton : UIButton

//Properties
@property (nonatomic, assign) BOOL emptyButtonPressing;

//Data
@property (nonatomic, assign) float fillPercent;

@property (assign) IBOutlet id<ABFillButtonDelegate> delegate;

- (void)setFillPercent: (float) percent;

- (void)configureButtonWithHightlightedShadowAndZoom: (BOOL)shadowAndZoom;

//Targets
- (void) configureToSelected: (BOOL) selected;
- (void) keepHighLighted: (BOOL) keepHighlighted;


@end
