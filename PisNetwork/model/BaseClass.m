//
//  BaseClass.m
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "Musics.h"


NSString *const kBaseClassMusics = @"musics";
NSString *const kBaseClassCount = @"count";
NSString *const kBaseClassTotal = @"total";
NSString *const kBaseClassStart = @"start";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize musics = _musics;
@synthesize count = _count;
@synthesize total = _total;
@synthesize start = _start;


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
    NSObject *receivedMusics = [dict objectForKey:kBaseClassMusics];
    NSMutableArray *parsedMusics = [NSMutableArray array];
    if ([receivedMusics isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMusics) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMusics addObject:[Musics modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMusics isKindOfClass:[NSDictionary class]]) {
       [parsedMusics addObject:[Musics modelObjectWithDictionary:(NSDictionary *)receivedMusics]];
    }

    self.musics = [NSArray arrayWithArray:parsedMusics];
            self.count = [[self objectOrNilForKey:kBaseClassCount fromDictionary:dict] doubleValue];
            self.total = [[self objectOrNilForKey:kBaseClassTotal fromDictionary:dict] doubleValue];
            self.start = [[self objectOrNilForKey:kBaseClassStart fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForMusics = [NSMutableArray array];
    for (NSObject *subArrayObject in self.musics) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMusics addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMusics addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMusics] forKey:kBaseClassMusics];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kBaseClassCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kBaseClassTotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.start] forKey:kBaseClassStart];

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

    self.musics = [aDecoder decodeObjectForKey:kBaseClassMusics];
    self.count = [aDecoder decodeDoubleForKey:kBaseClassCount];
    self.total = [aDecoder decodeDoubleForKey:kBaseClassTotal];
    self.start = [aDecoder decodeDoubleForKey:kBaseClassStart];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_musics forKey:kBaseClassMusics];
    [aCoder encodeDouble:_count forKey:kBaseClassCount];
    [aCoder encodeDouble:_total forKey:kBaseClassTotal];
    [aCoder encodeDouble:_start forKey:kBaseClassStart];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.musics = [self.musics copyWithZone:zone];
        copy.count = self.count;
        copy.total = self.total;
        copy.start = self.start;
    }
    
    return copy;
}


@end
