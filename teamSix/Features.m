//
//  Features.m
//  teamSix
//
//  Created by Shiuh Yaw Phang on 07/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "Features.h"

@implementation Features

- (id)initWithDictionary:(NSDictionary *)dictionary;
{
    self = [super init];
    if (self) {
        if ([[dictionary allKeys]containsObject:@"anger"]) {
            if (dictionary[@"anger"] != nil
                && dictionary[@"anger"] != [NSNull null]) {
                self.anger = dictionary[@"anger"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"disgust"]) {
            if (dictionary[@"disgust"] != nil
                && dictionary[@"disgust"] != [NSNull null]) {
                self.disgust = dictionary[@"disgust"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"fear"]) {
            if (dictionary[@"fear"] != nil
                && dictionary[@"fear"] != [NSNull null]) {
                self.fear = dictionary[@"fear"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"joy"]) {
            if (dictionary[@"joy"] != nil
                && dictionary[@"joy"] != [NSNull null]) {
                self.joy = dictionary[@"joy"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"sadness"]) {
            if (dictionary[@"sadness"] != nil
                && dictionary[@"sadness"] != [NSNull null]) {
                self.sadness = dictionary[@"sadness"];
            }
        }
    }
    return self;
}

#pragma mark - Momento Pattern
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.anger  = [aDecoder decodeObjectForKey:@"anger"];
        self.disgust    = [aDecoder decodeObjectForKey:@"disgust"];
        self.fear     = [aDecoder decodeObjectForKey:@"fear"];
        self.joy      = [aDecoder decodeObjectForKey:@"joy"];
        self.sadness      = [aDecoder decodeObjectForKey:@"sadness"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.anger
                  forKey:@"anger"];
    [aCoder encodeObject:self.disgust
                  forKey:@"disgust"];
    [aCoder encodeObject:self.fear
                  forKey:@"fear"];
    [aCoder encodeObject:self.joy
                  forKey:@"joy"];
    [aCoder encodeObject:self.sadness
                  forKey:@"sadness"];

}

#pragma mark - NSCopying method
- (id)copyWithZone:(NSZone *)zone;
{
    Features *movieCopy = [[[self class]allocWithZone:zone]init];
    [movieCopy setAnger:self.anger];
    [movieCopy setDisgust:self.disgust];
    [movieCopy setFear:self.fear];
    [movieCopy setJoy:self.joy];
    [movieCopy setSadness:self.sadness];
    return movieCopy;
}

@end
