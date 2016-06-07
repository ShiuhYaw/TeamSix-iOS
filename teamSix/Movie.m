//
//  Movie.m
//  teamSix
//
//  Created by Shiuh Yaw Phang on 07/06/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "Movie.h"

@implementation Movie


- (id)initWithDictionary:(NSDictionary *)dictionary;
{
    self = [super init];
    if (self) {
        if ([[dictionary allKeys]containsObject:@"original_title"]) {
            if (dictionary[@"original_title"] != nil
                && dictionary[@"original_title"] != [NSNull null]) {
                self.original_title = dictionary[@"original_title"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"overview"]) {
            if (dictionary[@"overview"] != nil
                && dictionary[@"overview"] != [NSNull null]) {
                self.overview = dictionary[@"overview"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"poster_path"]) {
            if (dictionary[@"poster_path"] != nil
                && dictionary[@"poster_path"] != [NSNull null]) {
                self.poster_path = dictionary[@"poster_path"];
            }
        }
        if ([[dictionary allKeys]containsObject:@"features"]) {
            if (dictionary[@"features"] != nil
                && dictionary[@"features"] != [NSNull null]) {
                self.features = [[Features alloc] initWithDictionary:dictionary[@"features"][@"doc-emotion"]];
            }
        }
    }
    return self;
}

#pragma mark - Momento Pattern
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.original_title  = [aDecoder decodeObjectForKey:@"StatsSchedules"];
        self.overview    = [aDecoder decodeObjectForKey:@"StatsOutlets"];
        self.poster_path     = [aDecoder decodeObjectForKey:@"StatsCities"];
        self.features      = [aDecoder decodeObjectForKey:@"StatsUsers"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
    [aCoder encodeObject:self.original_title
                  forKey:@"StatsSchedules"];
    [aCoder encodeObject:self.overview
                  forKey:@"StatsOutlets"];
    [aCoder encodeObject:self.poster_path
                  forKey:@"StatsCities"];
    [aCoder encodeObject:self.features
                  forKey:@"StatsUsers"];
}

#pragma mark - NSCopying method
- (id)copyWithZone:(NSZone *)zone;
{
    Movie *movieCopy = [[[self class]allocWithZone:zone]init];
    [movieCopy setOriginal_title:self.original_title];
    [movieCopy setOverview:self.overview];
    [movieCopy setPoster_path:self.poster_path];
    [movieCopy setFeatures:self.features];
    return movieCopy;
}

@end
