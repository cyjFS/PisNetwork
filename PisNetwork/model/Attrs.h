//
//  Attrs.h
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Attrs : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *singer;
@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) NSArray *pubdate;
@property (nonatomic, strong) NSArray *title;
@property (nonatomic, strong) NSArray *media;
@property (nonatomic, strong) NSArray *publisher;
@property (nonatomic, strong) NSArray *version;
@property (nonatomic, strong) NSArray *discs;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
