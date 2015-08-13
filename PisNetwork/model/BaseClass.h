//
//  BaseClass.h
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *musics;
@property (nonatomic, assign) double count;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) double start;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
