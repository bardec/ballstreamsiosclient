//
//  ViewController.m
//  BallStreams
//
//  Created by Caleb Barde on 1/20/15.
//  Copyright (c) 2015 Caleb Barde. All rights reserved.
//

#import "ViewController.h"
#import "BallStreamsSession.h"
#import "JNKeychain.h"
#import "Constants.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self passwordField].secureTextEntry = YES;
    
    session = [[BallStreamsSession alloc] init];
    [[self usernameField] setText:[JNKeychain loadValueForKey:keystoreUsername]];
    [[self passwordField] setText:[JNKeychain loadValueForKey:keystorePassword]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    [session Login:[self usernameField].text password:[self passwordField].text];
}

@end
