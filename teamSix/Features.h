//
//  Features.h
//  teamSix
//
//  Created by Shiuh Yaw Phang on 07/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Features : NSObject

@property (nonatomic, strong) NSString      *anger;
@property (nonatomic, strong) NSString      *disgust;
@property (nonatomic, strong) NSString      *fear;
@property (nonatomic, strong) NSString      *joy;
@property (nonatomic, strong) NSString      *sadness;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)copyWithZone:(NSZone *)zone;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;


@end
