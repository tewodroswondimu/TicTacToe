//
//  HelpViewController.m
//  TicTacToe
//
//  Created by Tewodros Wondimu on 1/11/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the home page when the view loads
    [self loadWebPageWithAddress:@"http://en.wikipedia.org/wiki/Tic-tac-toe"];
    self.webView.delegate = self;
}

// Removes the help view modal
- (IBAction)onCloseButtonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Loads an andress on the webview
- (void)loadWebPageWithAddress:(NSString *)addressString
{
    NSURL *addressURL = [NSURL URLWithString:addressString];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];
}


// Show the animator when webpage loads
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
    self.spinner.hidden = false;
}

// Change navigation name
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
}

@end
