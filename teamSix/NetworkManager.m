//
//  NetworkManager.m
//  teamSix
//
//  Created by Shiuh Yaw Phang on 06/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "NetworkManager.h"
#import <EGOCache/EGOCache.h>
#import "Movie.h"

#define kKFITBaseURL                    @"http://conifest001.eu-gb.mybluemix.net"
#define kKFITStats                      @"/user_words"
#define KFITResponseNotMatchErrorCode 1001

static NSString *const ResponseValidationErrorDomain   = @"ResponseValidationErrorDomain";

@interface NetworkManager()
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSArray *movieArray;
@property (nonatomic, strong) Movie *movie;
@end

@implementation NetworkManager

+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
        sharedInstance->_baseURL = [NSURL URLWithString:kKFITBaseURL];
        sharedInstance->_sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:sharedInstance->_baseURL];
        sharedInstance->_sessionManager.requestSerializer                             = [AFJSONRequestSerializer serializer];
        sharedInstance->_sessionManager.responseSerializer                            = [AFJSONResponseSerializer serializer];
        sharedInstance->_sessionManager.responseSerializer.acceptableContentTypes     = [NSSet setWithObject:@"application/json"];
        sharedInstance->_movieArray = [NSArray array];
    });
    return sharedInstance;
}

- (NSArray *)movies
{
    return [NSArray arrayWithArray:self.movieArray];
}



- (void)setupMovieCompletionBlock:(NetworkCompletionBlock)completionBlock withString:(NSString *)paramString {
    __block NSError *error;
    dispatch_group_t downloadGroup = dispatch_group_create();
    __weak NetworkManager *weakSelf = self;
    NSString *urlString = [kKFITStats stringByAppendingFormat:@"?text=%@", paramString];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *result = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    [self.sessionManager GET:result
                  parameters:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         NSArray *array = nil;
                        if ([responseObject isKindOfClass:[NSDictionary class]]) {
                             NSDictionary *dictionary = responseObject;
                             if ([dictionary objectForKey:@"movie"]) {
                                 if ([dictionary[@"movie"] isKindOfClass:[NSArray class]]) {
                                     array = [NSArray arrayWithArray:dictionary[@"movie"]];
                                 }
                             }
                         }
                         if (array) {
                             if ([array count] > 0) {
                                 dispatch_group_enter(downloadGroup); // 2
                                 [weakSelf removeAllMovie];
                                 NSMutableArray *mutableArray = [NSMutableArray array];
                                 for (NSDictionary *dictionary in array) {
                                     Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
                                     [mutableArray addObject:movie];
                                 }
                                 if ([mutableArray count] > 0) {
                                     weakSelf.movieArray = mutableArray;
                                     [[EGOCache globalCache]setObject:weakSelf.movieArray forKey:@"Cache"];
                                 }
                                 dispatch_group_leave(downloadGroup); // 3
                             }
                             dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{ // 4
                                 if (completionBlock) {
                                     completionBlock(weakSelf.movieArray, error);
                                 }
                             });
                         }else{
                             NSString *description = NSLocalizedStringFromTable(@"Oops!", @"LocalizableUnmanaged", @"");
                             NSString *reason = NSLocalizedStringFromTable(@"Response Object not match", @"LocalizableUnmanaged", @"");
                             NSArray *objArray = [NSArray arrayWithObjects:description,reason, nil];
                             NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
                             NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
                             NSError *error = [NSError errorWithDomain:ResponseValidationErrorDomain code:KFITResponseNotMatchErrorCode userInfo:userInfo];
                             completionBlock(nil, error);
                         }
                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
#if DEBUG
                         NSLog(@"localizedDescription %@" , error.localizedDescription);
#endif
                         completionBlock(nil, error);
                     }];
}

- (void)removeAllMovie {
    if ([[EGOCache globalCache]hasCacheForKey:@"Cache"]) {
        [[EGOCache globalCache]removeCacheForKey:@"Cache"];
    }
    if ([_movieArray count] > 0) {
        _movieArray = nil;
    }
}

@end
