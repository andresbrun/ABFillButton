//
//  ViewController.m
//  ABFillButtonExample
//
//  Created by Andrés Brun on 24/01/14.
//  Copyright (c) 2014 Brun's Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    float _numberOfPulses;
}

@property (weak, nonatomic) IBOutlet ABFillButton *playButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _numberOfPulses=0;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //If we want to add shadows and a grow up effect when user press the button
    [self.playButton configureButtonWithHightlightedShadowAndZoom:YES];
    
    //If we want to empty the button with user pressing
    [self.playButton setEmptyButtonPressing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonPressed:(id)sender
{
    //If we want to empty the button with every press
//    _numberOfPulses++;
//    [self.playButton setFillPercent:1-(_numberOfPulses*0.1)];
//    
//    if(_numberOfPulses>10){
//        _numberOfPulses=0;
//        [self.playButton setFillPercent:1.0];
//    }
    
}

#pragma mark - ABFillButton Delegate
- (void)buttonIsEmpty:(ABFillButton *)button
{
    NSLog(@"buttonIsEmpty");
    [self.playButton setFillPercent:1.0];
}

@end
