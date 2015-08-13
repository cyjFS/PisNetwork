//
//  Attrs.m
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Attrs.h"


NSString *const kAttrsSinger = @"singer";
NSString *const kAttrsTracks = @"tracks";
NSString *const kAttrsPubdate = @"pubdate";
NSString *const kAttrsTitle = @"title";
NSString *const kAttrsMedia = @"media";
NSString *const kAttrsPublisher = @"publisher";
NSString *const kAttrsVersion = @"version";
NSString *const kAttrsDiscs = @"discs";


@interface Attrs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Attrs

@synthesize singer = _singer;
@synthesize tracks = _tracks;
@synthesize pubdate = _pubdate;
@synthesize title = _title;
@synthesize media = _media;
@synthesize publisher = _publisher;
@synthesize version = _version;
@synthesize discs = _discs;


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
            self.singer = [self objectOrNilForKey:kAttrsSinger fromDictionary:dict];
            self.tracks = [self objectOrNilForKey:kAttrsTracks fromDictionary:dict];
            self.pubdate = [self objectOrNilForKey:kAttrsPubdate fromDictionary:dict];
            self.title = [self objectOrNilForKey:kAttrsTitle fromDictionary:dict];
            self.media = [self objectOrNilForKey:kAttrsMedia fromDictionary:dict];
            self.publisher = [self objectOrNilForKey:kAttrsPublisher fromDictionary:dict];
            self.version = [self objectOrNilForKey:kAttrsVersion fromDictionary:dict];
            self.discs = [self objectOrNilForKey:kAttrsDiscs fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSinger = [NSMutableArray array];
    for (NSObject *subArrayObject in self.singer) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSinger addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSinger addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSinger] forKey:kAttrsSinger];
    NSMutableArray *tempArrayForTracks = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tracks) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTracks addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTracks addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTracks] forKey:kAttrsTracks];
    NSMutableArray *tempArrayForPubdate = [NSMutableArray array];
    for (NSObject *subArrayObject in self.pubdate) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPubdate addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPubdate addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPubdate] forKey:kAttrsPubdate];
    NSMutableArray *tempArrayForTitle = [NSMutableArray array];
    for (NSObject *subArrayObject in self.title) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTitle addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTitle addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTitle] forKey:kAttrsTitle];
    NSMutableArray *tempArrayForMedia = [NSMutableArray array];
    for (NSObject *subArrayObject in self.media) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMedia addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMedia addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMedia] forKey:kAttrsMedia];
    NSMutableArray *tempArrayForPublisher = [NSMutableArray array];
    for (NSObject *subArrayObject in self.publisher) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPublisher addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPublisher addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPublisher] forKey:kAttrsPublisher];
    NSMutableArray *tempArrayForVersion = [NSMutableArray array];
    for (NSObject *subArrayObject in self.version) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVersion addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVersion addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVersion] forKey:kAttrsVersion];
    NSMutableArray *tempArrayForDiscs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.discs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDiscs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDiscs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDiscs] forKey:kAttrsDiscs];

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

    self.singer = [aDecoder decodeObjectForKey:kAttrsSinger];
    self.tracks = [aDecoder decodeObjectForKey:kAttrsTracks];
    self.pubdate = [aDecoder decodeObjectForKey:kAttrsPubdate];
    self.title = [aDecoder decodeObjectForKey:kAttrsTitle];
    self.media = [aDecoder decodeObjectForKey:kAttrsMedia];
    self.publisher = [aDecoder decodeObjectForKey:kAttrsPublisher];
    self.version = [aDecoder decodeObjectForKey:kAttrsVersion];
    self.discs = [aDecoder decodeObjectForKey:kAttrsDiscs];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_singer forKey:kAttrsSinger];
    [aCoder encodeObject:_tracks forKey:kAttrsTracks];
    [aCoder encodeObject:_pubdate forKey:kAttrsPubdate];
    [aCoder encodeObject:_title forKey:kAttrsTitle];
    [aCoder encodeObject:_media forKey:kAttrsMedia];
    [aCoder encodeObject:_publisher forKey:kAttrsPublisher];
    [aCoder encodeObject:_version forKey:kAttrsVersion];
    [aCoder encodeObject:_discs forKey:kAttrsDiscs];
}

- (id)copyWithZone:(NSZone *)zone
{
    Attrs *copy = [[Attrs alloc] init];
    
    if (copy) {

        copy.singer = [self.singer copyWithZone:zone];
        copy.tracks = [self.tracks copyWithZone:zone];
        copy.pubdate = [self.pubdate copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.media = [self.media copyWithZone:zone];
        copy.publisher = [self.publisher copyWithZone:zone];
        copy.version = [self.version copyWithZone:zone];
        copy.discs = [self.discs copyWithZone:zone];
    }
    
    return copy;
}


@end
