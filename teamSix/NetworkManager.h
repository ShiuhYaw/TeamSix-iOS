//
//  NetworkManager.h
//  teamSix
//
//  Created by Shiuh Yaw Phang on 06/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


typedef void (^NetworkCompletionBlock)(NSArray *resultsArray, NSError *error);

@interface NetworkManager : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
- (void)setupMovieCompletionBlock:(NetworkCompletionBlock)completionBlock withString:(NSString *)paramString;
- (NSArray *)movies;

@end
