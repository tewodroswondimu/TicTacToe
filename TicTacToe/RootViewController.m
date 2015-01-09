//
//  RootViewController.m
//  TicTacToe
//
//  Created by Tewodros Wondimu on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// When the user taps the play as... button send that to the ViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    ViewController *vc = segue.destinationViewController;
    vc.playerType = sender.tag;
}

@end
