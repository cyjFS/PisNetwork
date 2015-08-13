//
//  NSObject+JSON.h
//  NeweggLibrary
//
//  Created by cheney on 14-1-23.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

@interface NSObject (JSON)

+ (id)dataModelWithJSONString:(NSString *)jsonString;
+ (id)dataModelWithJSONData:(NSData *)jsonData;
+ (id)dataModelWithJSONObject:(id)jsonObject;

- (NSString *)toJSONString;
- (NSData *)toJSONData;
- (id)toJSONObject;

@end
