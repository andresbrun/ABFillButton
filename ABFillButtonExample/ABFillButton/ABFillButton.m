//
//  IconButton.m
//  uSpeak
//
//  Created by Andrés Brun on 7/31/13.
//  Copyright (c) 2013 uSpeak Ltd. All rights reserved.
//

#import "ABFillButton.h"

#define ANIMATION_BUTTON_DURATION 0.2
#define FILL_TIMER_SPEED 4 /*seconds*/
#define FILL_PERCENT 0.01 /*frame rate*/

@interface ABFillButton ()

@property (nonatomic, assign) BOOL needShadow;
@property (nonatomic, assign) BOOL needZoom;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, assign) BOOL keepHighlighted;

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CALayer *bgLayer;

@property (nonatomic, strong) NSTimer *pressingTimer;

@end

@implementation ABFillButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //Draw the fill layer
    self.maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    self.maskLayer.path = path;
    CGPathRelease(path);
    
    self.imageView.layer.mask = self.maskLayer;
    
}

- (void)setFillPercent: (float) percent
{
    _fillPercent = percent;
    
    if(!self.bgLayer){
        //Draw the bg layer
        self.bgLayer = [[CALayer alloc] init];
        self.bgLayer.frame = self.imageView.frame;
        self.bgLayer.contents = (id)[self imageForState:UIControlStateNormal].CGImage;
        [self.bgLayer setOpacity:0.2];
        [self.layer insertSublayer:self.bgLayer below:self.imageView.layer];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.maskLayer setFrame:CGRectMake(0,
                                            (1-percent)*self.bounds.size.height,
                                            self.bounds.size.width,
                                            (percent)*self.bounds.size.height)];

    }];
    
}

#pragma mark - Helpers

- (void)configureButtonWithHightlightedShadowAndZoom: (BOOL)shadowAndZoom
{
    [self setNeedShadow:shadowAndZoom];
    [self setNeedZoom:shadowAndZoom];
    
    [self setExclusiveTouch:YES];
    
    [self configureToSelected:NO];
    
}

#pragma mark -  Addition properties methods

#pragma mark - Buttons states
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self configureToSelected:highlighted];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self configureToSelected:selected];
    
}

- (void) keepHighLighted: (BOOL) keepHighlighted
{
    [super setSelected:keepHighlighted];
    self.keepHighlighted = keepHighlighted;
    [self configureToSelected:keepHighlighted];
}

- (void) configureToSelected: (BOOL) selected
{    
    if (self.keepHighlighted || selected) {
        
        [self setAlpha:1.0];
        if(self.emptyButtonPressing){
            [self createTimer:YES];
        }
        if (self.needZoom) {
            [UIView animateWithDuration:ANIMATION_BUTTON_DURATION animations:^{
                [self setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                if(self.needShadow){
                    [self.layer setShadowOpacity:1];
                }
            }];
            
        }
        if (self.needShadow) {
            [self.layer setShadowColor:[UIColor blackColor].CGColor];
            [self.layer setShadowOffset:CGSizeMake(0, 0)];
            [self.layer setShadowOpacity:1];
            [self.layer setShadowRadius:3];
        }
        
    }else{
        
        if(self.emptyButtonPressing){
            [self createTimer:NO];
        }
        
        if (self.needZoom) {
            [UIView animateWithDuration:ANIMATION_BUTTON_DURATION animations:^{
                [self setTransform:CGAffineTransformMakeScale(ICON_BUTTON_SCALE, ICON_BUTTON_SCALE)];
                if (self.needShadow) {
                    [self.layer setShadowOpacity:0];
                }
            }];
        }
    }
    
}

- (void) emptyButton
{
    [self setFillPercent:_fillPercent-FILL_PERCENT];
    
    if(self.fillPercent<0.0){
        if(self.delegate && [self.delegate respondsToSelector:@selector(buttonIsEmpty:)]){
            [self.delegate buttonIsEmpty:self];
            [self createTimer:NO];
        }
    }
}

- (void) createTimer: (BOOL) timer
{

    if(timer){
        if(!self.pressingTimer){
            self.pressingTimer = [NSTimer scheduledTimerWithTimeInterval:FILL_TIMER_SPEED/(1/FILL_PERCENT)
                                                         target:self
                                                       selector:@selector(emptyButton)
                                                       userInfo:nil repeats:YES];
        }
    }else{
        if(self.pressingTimer){
            [self.pressingTimer invalidate];
            self.pressingTimer = nil;
        }
        
    }
    
}
                          
                          
@end
