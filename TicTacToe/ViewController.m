//
//  ViewController.m
//  TicTacToe
//
//  Created by Tewodros Wondimu on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Define the IBOutlets for the imageviews of the tic tac toe plots
@property (weak, nonatomic) IBOutlet UIImageView *a1;
@property (weak, nonatomic) IBOutlet UIImageView *a2;
@property (weak, nonatomic) IBOutlet UIImageView *a3;
@property (weak, nonatomic) IBOutlet UIImageView *b1;
@property (weak, nonatomic) IBOutlet UIImageView *b2;
@property (weak, nonatomic) IBOutlet UIImageView *b3;
@property (weak, nonatomic) IBOutlet UIImageView *c1;
@property (weak, nonatomic) IBOutlet UIImageView *c2;
@property (weak, nonatomic) IBOutlet UIImageView *c3;

@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// When the imageView is tapped, change the background image to show an 'X' or an 'O'
- (IBAction)onImageViewTapped:(UITapGestureRecognizer *)gesture {
    // touchPoint registers where the user tapped
    CGPoint touchPoint = [gesture locationInView:self.view];
    UIImageView *imageViewTouched = [self findImageViewUsingPoint:touchPoint];

    // Check which user is playing and set the background image of that image to the player's type
    // Then switches player
    if (self.playerType) {
        imageViewTouched.image = [UIImage imageNamed:@"x.png"];
        [self nextPlayer];
    }
    else
    {
        imageViewTouched.image = [UIImage imageNamed:@"o.png"];
        [self nextPlayer];
    }
}

// Change the player type to next player
- (void)nextPlayer
{
    self.playerType = !self.playerType;
    if (self.playerType) {
        self.whichPlayerLabel.text = @"Player is X";
    }
    else
    {
        self.whichPlayerLabel.text = @"Player is O";
    }
}

// This methods finds the imageView where the user tapped and returns that imageView
- (UIImageView *)findImageViewUsingPoint:(CGPoint)point
{
    // Create an tappedImageView to return
    UIImageView *tappedImageView = [[UIImageView alloc] init];

    // Create an array that holds all the image views
    NSArray *arrayOfImageViews = [NSArray arrayWithObjects:self.a1, self.a2, self.a3, self.b1, self.b2, self.b3, self.c1, self.c2, self.c3, nil];

    // Go through each image view and check if the place
    // where the user tapped is within that imageView
    for (UIImageView *imageView in arrayOfImageViews) {
        if (CGRectContainsPoint(imageView.frame, point)) {
            tappedImageView = imageView;
        }
    }

    return tappedImageView;
}

@end
