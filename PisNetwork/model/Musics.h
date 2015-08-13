//
//  Musics.h
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//


@class Rating, Attrs;

@interface Musics : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *author;
@property (nonatomic, strong) Rating *rating;
@property (nonatomic, strong) NSString *musicsIdentifier;
@property (nonatomic, strong) NSString *altTitle;
@property (nonatomic, strong) NSString *mobileLink;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Attrs *attrs;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSArray *tags;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
