//
//  BallStreamsSession.m
//  BallStreams
//
//  Created by Caleb Barde on 1/20/15.
//  Copyright (c) 2015 Caleb Barde. All rights reserved.
//

#import "BallStreamsSession.h"
#import "JNKeychain.h"
#import "Constants.h"
#import <UIKit/UIAlertView.h>

@implementation BallStreamsSession

- (id)init
{
    self = [super init];
    manager = [AFHTTPRequestOperationManager manager];
    return self;
}

- (void)Login:(NSString *)username password:(NSString *)password
{
    NSDictionary *params = @{ @"username" : username, @"password" : password, @"key": @"49cbf902ea0f81ac4add3795e629e7a5" };
    [manager POST:@"https://api.ballstreams.com/Login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // check if there is data in the keychain
        if ([JNKeychain loadValueForKey:keystoreUsername] == nil) {
            NSLog(@"I AM HERE");
            [JNKeychain saveValue:username forKey:keystoreUsername];
            [JNKeychain saveValue:password forKey:keystorePassword];
        }
        
        NSLog(@"%@", responseObject);
        if ([[(NSDictionary *)responseObject valueForKey:@"membership"]  isEqual: @"Premium"]) {
            [JNKeychain saveValue:[(NSDictionary *)responseObject valueForKey:@"token"] forKey:keystoreSessionToken];
            NSLog(@"TOKEN = %@", [JNKeychain loadValueForKey:keystoreSessionToken]);
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Upgrade account to Premium to use this app" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Username and/or password invalid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }];
}

@end
