//
//  BallStreamsSession.h
//  BallStreams
//
//  Created by Caleb Barde on 1/20/15.
//  Copyright (c) 2015 Caleb Barde. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <Foundation/Foundation.h>

@interface BallStreamsSession : NSObject
{
    AFHTTPRequestOperationManager *manager;
}

- (void)Login:(NSString *)username password:(NSString *)password;
@end