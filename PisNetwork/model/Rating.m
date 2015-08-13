//
//  Rating.m
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Rating.h"


NSString *const kRatingMin = @"min";
NSString *const kRatingAverage = @"average";
NSString *const kRatingMax = @"max";
NSString *const kRatingNumRaters = @"numRaters";


@interface Rating ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Rating

@synthesize min = _min;
@synthesize average = _average;
@synthesize max = _max;
@synthesize numRaters = _numRaters;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.min = [[self objectOrNilForKey:kRatingMin fromDictionary:dict] doubleValue];
            self.average = [self objectOrNilForKey:kRatingAverage fromDictionary:dict];
            self.max = [[self objectOrNilForKey:kRatingMax fromDictionary:dict] doubleValue];
            self.numRaters = [[self objectOrNilForKey:kRatingNumRaters fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.min] forKey:kRatingMin];
    [mutableDict setValue:self.average forKey:kRatingAverage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.max] forKey:kRatingMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.numRaters] forKey:kRatingNumRaters];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.min = [aDecoder decodeDoubleForKey:kRatingMin];
    self.average = [aDecoder decodeObjectForKey:kRatingAverage];
    self.max = [aDecoder decodeDoubleForKey:kRatingMax];
    self.numRaters = [aDecoder decodeDoubleForKey:kRatingNumRaters];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_min forKey:kRatingMin];
    [aCoder encodeObject:_average forKey:kRatingAverage];
    [aCoder encodeDouble:_max forKey:kRatingMax];
    [aCoder encodeDouble:_numRaters forKey:kRatingNumRaters];
}

- (id)copyWithZone:(NSZone *)zone
{
    Rating *copy = [[Rating alloc] init];
    
    if (copy) {

        copy.min = self.min;
        copy.average = [self.average copyWithZone:zone];
        copy.max = self.max;
        copy.numRaters = self.numRaters;
    }
    
    return copy;
}


@end
