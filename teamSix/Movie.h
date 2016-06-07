//
//  Movie.h
//  teamSix
//
//  Created by Shiuh Yaw Phang on 07/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Features.h"

@interface Movie : NSObject

@property (nonatomic, strong) NSString      *original_title;
@property (nonatomic, strong) NSString      *overview;
@property (nonatomic, strong) NSString      *poster_path;
@property (nonatomic, strong) Features      *features;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)copyWithZone:(NSZone *)zone;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
