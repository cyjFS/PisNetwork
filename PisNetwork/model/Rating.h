//
//  Rating.h
//
//  Created by newegg  on 15/8/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Rating : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double min;
@property (nonatomic, strong) NSString *average;
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double numRaters;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
