//
//  Musics.m
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Musics.h"
#import "Author.h"
#import "Rating.h"
#import "Attrs.h"
#import "Tags.h"


NSString *const kMusicsAuthor = @"author";
NSString *const kMusicsRating = @"rating";
NSString *const kMusicsId = @"id";
NSString *const kMusicsAltTitle = @"alt_title";
NSString *const kMusicsMobileLink = @"mobile_link";
NSString *const kMusicsImage = @"image";
NSString *const kMusicsTitle = @"title";
NSString *const kMusicsAttrs = @"attrs";
NSString *const kMusicsAlt = @"alt";
NSString *const kMusicsTags = @"tags";


@interface Musics ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Musics

@synthesize author = _author;
@synthesize rating = _rating;
@synthesize musicsIdentifier = _musicsIdentifier;
@synthesize altTitle = _altTitle;
@synthesize mobileLink = _mobileLink;
@synthesize image = _image;
@synthesize title = _title;
@synthesize attrs = _attrs;
@synthesize alt = _alt;
@synthesize tags = _tags;


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
    NSObject *receivedAuthor = [dict objectForKey:kMusicsAuthor];
    NSMutableArray *parsedAuthor = [NSMutableArray array];
    if ([receivedAuthor isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAuthor) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAuthor addObject:[Author modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAuthor isKindOfClass:[NSDictionary class]]) {
       [parsedAuthor addObject:[Author modelObjectWithDictionary:(NSDictionary *)receivedAuthor]];
    }

    self.author = [NSArray arrayWithArray:parsedAuthor];
            self.rating = [Rating modelObjectWithDictionary:[dict objectForKey:kMusicsRating]];
            self.musicsIdentifier = [self objectOrNilForKey:kMusicsId fromDictionary:dict];
            self.altTitle = [self objectOrNilForKey:kMusicsAltTitle fromDictionary:dict];
            self.mobileLink = [self objectOrNilForKey:kMusicsMobileLink fromDictionary:dict];
            self.image = [self objectOrNilForKey:kMusicsImage fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMusicsTitle fromDictionary:dict];
            self.attrs = [Attrs modelObjectWithDictionary:[dict objectForKey:kMusicsAttrs]];
            self.alt = [self objectOrNilForKey:kMusicsAlt fromDictionary:dict];
    NSObject *receivedTags = [dict objectForKey:kMusicsTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAuthor = [NSMutableArray array];
    for (NSObject *subArrayObject in self.author) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAuthor addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAuthor addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAuthor] forKey:kMusicsAuthor];
    [mutableDict setValue:[self.rating dictionaryRepresentation] forKey:kMusicsRating];
    [mutableDict setValue:self.musicsIdentifier forKey:kMusicsId];
    [mutableDict setValue:self.altTitle forKey:kMusicsAltTitle];
    [mutableDict setValue:self.mobileLink forKey:kMusicsMobileLink];
    [mutableDict setValue:self.image forKey:kMusicsImage];
    [mutableDict setValue:self.title forKey:kMusicsTitle];
    [mutableDict setValue:[self.attrs dictionaryRepresentation] forKey:kMusicsAttrs];
    [mutableDict setValue:self.alt forKey:kMusicsAlt];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kMusicsTags];

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

    self.author = [aDecoder decodeObjectForKey:kMusicsAuthor];
    self.rating = [aDecoder decodeObjectForKey:kMusicsRating];
    self.musicsIdentifier = [aDecoder decodeObjectForKey:kMusicsId];
    self.altTitle = [aDecoder decodeObjectForKey:kMusicsAltTitle];
    self.mobileLink = [aDecoder decodeObjectForKey:kMusicsMobileLink];
    self.image = [aDecoder decodeObjectForKey:kMusicsImage];
    self.title = [aDecoder decodeObjectForKey:kMusicsTitle];
    self.attrs = [aDecoder decodeObjectForKey:kMusicsAttrs];
    self.alt = [aDecoder decodeObjectForKey:kMusicsAlt];
    self.tags = [aDecoder decodeObjectForKey:kMusicsTags];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kMusicsAuthor];
    [aCoder encodeObject:_rating forKey:kMusicsRating];
    [aCoder encodeObject:_musicsIdentifier forKey:kMusicsId];
    [aCoder encodeObject:_altTitle forKey:kMusicsAltTitle];
    [aCoder encodeObject:_mobileLink forKey:kMusicsMobileLink];
    [aCoder encodeObject:_image forKey:kMusicsImage];
    [aCoder encodeObject:_title forKey:kMusicsTitle];
    [aCoder encodeObject:_attrs forKey:kMusicsAttrs];
    [aCoder encodeObject:_alt forKey:kMusicsAlt];
    [aCoder encodeObject:_tags forKey:kMusicsTags];
}

- (id)copyWithZone:(NSZone *)zone
{
    Musics *copy = [[Musics alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.rating = [self.rating copyWithZone:zone];
        copy.musicsIdentifier = [self.musicsIdentifier copyWithZone:zone];
        copy.altTitle = [self.altTitle copyWithZone:zone];
        copy.mobileLink = [self.mobileLink copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.attrs = [self.attrs copyWithZone:zone];
        copy.alt = [self.alt copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
    }
    
    return copy;
}


@end
