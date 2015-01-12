//
//  ViewController.m
//  TicTacToe
//
//  Created by Tewodros Wondimu on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
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

@property NSMutableArray *imageViewsAlreadyTapped;

@property (weak, nonatomic) IBOutlet UIImageView *xDragableButton;
@property (weak, nonatomic) IBOutlet UIImageView *oDragableButton;
@property (weak, nonatomic) IBOutlet UIView *imageViewContainer;

@property NSMutableSet *xMoves;
@property NSMutableSet *oMoves;

@property NSSet *winningCondition1;
@property NSSet *winningCondition2;
@property NSSet *winningCondition3;
@property NSSet *winningCondition4;
@property NSSet *winningCondition5;
@property NSSet *winningCondition6;
@property NSSet *winningCondition7;
@property NSSet *winningCondition8;
@property NSArray *allConditions;

@property NSString *winner;

@property UIAlertView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageViewsAlreadyTapped = [[NSMutableArray alloc] init];
    self.xMoves = [[NSMutableSet alloc] init];
    self.oMoves = [[NSMutableSet alloc] init];
    self.alertView.delegate = self;
    [self currentPlayer];
}

// When the imageView is tapped, change the background image to show an 'X' or an 'O'
- (IBAction)onImageViewTapped:(UITapGestureRecognizer *)gesture {
    // touchPoint registers where the user tapped
    CGPoint touchPoint = [gesture locationInView:self.imageViewContainer];

    // Create an array that holds all the image views
    NSArray *arrayOfImageViews = [NSArray arrayWithObjects:self.a1, self.a2, self.a3, self.b1, self.b2, self.b3, self.c1, self.c2, self.c3, nil];

    UIImageView *imageViewTouched = [self findImageViewUsingPoint:touchPoint andArrayOfView:arrayOfImageViews];

    // Check which user is playing and set the background image of that imageView to the player's type then switches player
    // Handle whether the player has already tapped on the imageView
    if ([arrayOfImageViews containsObject:imageViewTouched] && imageViewTouched.image == nil) {
        if (self.playerType) {
            // Add the move made by x to a set
            [self.xMoves addObject:[NSString stringWithFormat:@"%i", (int)imageViewTouched.tag]];

            // check if there is a winner
            self.winner = [self findOutWhoWonWithPlayer:self.playerType playerMoves:self.xMoves];

            // if there is a winner show a alert
            if(self.winner != nil) {
                [self showWinnerWithWinner:self.winner];
            }

            // Change the image of the slot that was pressed to X
            imageViewTouched.image = [UIImage imageNamed:@"x.png"];
            [self nextPlayer];
        }
        else
        {
            [self.oMoves addObject:[NSString stringWithFormat:@"%i", (int)imageViewTouched.tag]];

            // check if there is a winner
            self.winner = [self findOutWhoWonWithPlayer:self.playerType playerMoves:self.oMoves];

            // if there is a winner show a alert
            if(self.winner != nil) {
                [self showWinnerWithWinner:self.winner];
            }

            // Change the image of the slot that was pressed to O
            imageViewTouched.image = [UIImage imageNamed:@"o.png"];
            [self nextPlayer];
        }
    }
}

// Shows an alert proclaiming victory for that player
- (void)showWinnerWithWinner:(NSString *)winner
{
    NSString *title = [NSString stringWithFormat:@"%@ is the Winner", winner];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"Do you want to reset this game?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];

    [alert addButtonWithTitle:@"New Game"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // If the New Game button is tapped return segue to root view controller
    if (buttonIndex == 1) {
        // Works by dragging the view controller to exit and setting an identifier named back
        // then calling the performSegueWithIdentifier called back on self
        [self performSegueWithIdentifier:@"back" sender:self];
    }
}


- (NSString *)findOutWhoWonWithPlayer:(BOOL)player playerMoves:(NSMutableSet *)playerMoves
{

    self.winningCondition1 = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    self.winningCondition2 = [NSSet setWithObjects:@"4",@"5",@"6",nil];
    self.winningCondition3 = [NSSet setWithObjects:@"7",@"8",@"9",nil];
    self.winningCondition4 = [NSSet setWithObjects:@"1",@"4",@"7",nil];
    self.winningCondition5 = [NSSet setWithObjects:@"2",@"5",@"8",nil];
    self.winningCondition6 = [NSSet setWithObjects:@"3",@"6",@"9",nil];
    self.winningCondition7 = [NSSet setWithObjects:@"1",@"5",@"9",nil];
    self.winningCondition8 = [NSSet setWithObjects:@"3",@"5",@"7",nil];
    self.allConditions = [NSArray arrayWithObjects:
                        self.winningCondition1, self.winningCondition2,
                        self.winningCondition3, self.winningCondition4,
                        self.winningCondition5, self.winningCondition6,
                        self.winningCondition7, self.winningCondition8, nil];

    for (NSSet *winningCondition in self.allConditions) {
        if ([winningCondition isSubsetOfSet:playerMoves])
        {
            if (player)
            {
                return @"X";
            }
            else
            {
                return @"O";
            }
        }
    }
    return nil;
}

// Change the player type to next player
- (void)nextPlayer
{
    self.playerType = !self.playerType;
    if (self.playerType) {
        self.whichPlayerLabel.text = @"It's X turn";
        self.oDragableButton.alpha = 0.3;
        self.xDragableButton.alpha = 1;
    }
    else
    {
        self.whichPlayerLabel.text = @"It's O turn";
        self.xDragableButton.alpha = 0.3;
        self.oDragableButton.alpha = 1;
    }
}

// Change the player type to next player
- (void)currentPlayer
{
    if (self.playerType) {
        self.whichPlayerLabel.text = @"It's X turn";
        self.oDragableButton.alpha = 0.3;
        self.xDragableButton.alpha = 1;
    }
    else
    {
        self.whichPlayerLabel.text = @"It's O turn";
        self.xDragableButton.alpha = 0.3;
        self.oDragableButton.alpha = 1;
    }
}

// This methods finds the imageView where the user tapped and returns that imageView
- (UIImageView *)findImageViewUsingPoint:(CGPoint)point andArrayOfView:(NSArray *)arrayOfImageViews
{
    // Create an tappedImageView to return
    UIImageView *tappedImageView = [[UIImageView alloc] init];
    //tappedImageView.image = nil;

    // Go through each image view and check if the place
    // where the user tapped is within that imageView
    for (UIImageView *imageView in arrayOfImageViews) {
        if (CGRectContainsPoint(imageView.frame, point)) {
            tappedImageView = imageView;
        }
    }

    return tappedImageView;
}

// Recognizes the pan gestures and drags the X and O buttons depending on which button they tapped first
- (IBAction)panHandler:(UIPanGestureRecognizer *)gesture {
    CGPoint firstTouchPointX, firstTouchPointO, touchPoint;
    UIImageView *imageViewButtonTouched = [[UIImageView alloc] init];

    firstTouchPointX.x = 38.5;
    firstTouchPointX.y = 94.5;
    firstTouchPointO.x = 281.5;
    firstTouchPointO.y = 94.5;

    // Create an array that holds all the button image views
    NSArray *arrayOfButtonImageViews = [NSArray arrayWithObjects:self.oDragableButton, self.xDragableButton, nil];

    // Create an array that holds all the image views
    NSArray *arrayOfImageViews = [NSArray arrayWithObjects:self.a1, self.a2, self.a3, self.b1, self.b2, self.b3, self.c1, self.c2, self.c3, nil];

    touchPoint = [gesture locationInView:self.view];
    // Get the touchpoint of the gesture
    imageViewButtonTouched = [self findImageViewUsingPoint:touchPoint andArrayOfView:arrayOfButtonImageViews];

    if (gesture.state == UIGestureRecognizerStateChanged)
    {
        // Move the x or o buttons along the path of the finger
        if (imageViewButtonTouched.tag == 10 && !self.playerType) {
            imageViewButtonTouched.center = touchPoint;
            imageViewButtonTouched.image = [UIImage imageNamed:@"oDraggingBegan.png"];
        }
        else if (imageViewButtonTouched.tag == 11 && self.playerType)
        {
            imageViewButtonTouched.center = touchPoint;
            imageViewButtonTouched.image = [UIImage imageNamed:@"xDraggingBegan.png"];
        }
    }

    // When user lets go of the button, take it back to the its original center
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint pointOfRelease;
        pointOfRelease = imageViewButtonTouched.center;

        // The navigation bar ads 80 to the y, which needs to be sutracted to find the right uiimageview
        pointOfRelease.y -= 80;

        // Pass self into the animation block
        __block ViewController *selfVC = self;

        [UIView animateWithDuration:.5 animations:^
         {
             // Initialize a new UIImageView inside the block
             UIImageView *imageViewChange = [[UIImageView alloc] init];

             if (imageViewButtonTouched.tag == 10) {
                 imageViewButtonTouched.center = firstTouchPointO;
                 imageViewButtonTouched.image = [UIImage imageNamed:@"oDrag.png"];

                 // Change the UIView into a pressed if the UIImageView doesn't have an image
                 imageViewChange = [self findImageViewUsingPoint:pointOfRelease andArrayOfView:arrayOfImageViews];
                 if (imageViewChange.image == nil) {


                     // Add the move made by x to a set
                     [selfVC.oMoves addObject:[NSString stringWithFormat:@"%i", (int)imageViewChange.tag]];

                     // check if there is a winner
                     selfVC.winner = [selfVC findOutWhoWonWithPlayer:selfVC.playerType playerMoves:selfVC.oMoves];

                     // if there is a winner show a alert
                     if(selfVC.winner != nil) {
                         [selfVC showWinnerWithWinner:selfVC.winner];
                     }

                     imageViewChange.image = [UIImage imageNamed:@"o.png"];
                     [selfVC nextPlayer];
                 }
             }

             else if (imageViewButtonTouched.tag == 11) {
                 imageViewButtonTouched.center = firstTouchPointX;
                 imageViewButtonTouched.image = [UIImage imageNamed:@"xDrag.png"];

                 // Change the UIView into a pressed if the UIImageView doesn't have an image
                 imageViewChange = [self findImageViewUsingPoint:pointOfRelease andArrayOfView:arrayOfImageViews];

                 if (imageViewChange.image == nil) {

                     // Add the move made by x to a set
                     [selfVC.xMoves addObject:[NSString stringWithFormat:@"%i", (int)imageViewChange.tag]];

                     // check if there is a winner
                     selfVC.winner = [selfVC findOutWhoWonWithPlayer:self.playerType playerMoves:selfVC.xMoves];

                     // if there is a winner show a alert
                     if(selfVC.winner != nil) {
                         [selfVC showWinnerWithWinner:selfVC.winner];
                     }

                     imageViewChange.image = [UIImage imageNamed:@"x.png"];
                     [selfVC nextPlayer];
                 }
             }
         }];
    }
}

@end
