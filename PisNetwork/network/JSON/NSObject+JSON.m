//
//  NSObject+JSON.m
//  NeweggLibrary
//
//  Created by cheney on 14-1-23.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

#import "NSObject+JSON.h"
#import "NSMutableArray+JSON.h"
#import <objc/runtime.h>

@implementation NSObject (JSON)

static const NSString *S_VALUE_TYPES = @"cislqCISLQfdB";

+ (id)dataModelWithJSONString:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self dataModelWithJSONData:data];
}

+ (id)dataModelWithJSONData:(NSData *)jsonData
{
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    return [self dataModelWithJSONObject:jsonObject];
}

+ (id)dataModelWithJSONObject:(id)jsonObject
{
    id dataModel = nil;
    
    Class itemType = [self class];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        dataModel = [NSMutableArray arrayWithItemType:itemType];
        
        [dataModel fillWithJSONObejct:jsonObject];
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        dataModel = [[itemType alloc] init];
        
        [dataModel fillWithJSONObejct:jsonObject];
    } else if ([jsonObject isKindOfClass:itemType]) {
        dataModel = jsonObject;
    }
    
    return dataModel;
}


- (void)fillWithJSONObejct:(NSDictionary *)jsonObject
{
    Class class = [self class];
    NSArray *keys = [jsonObject allKeys];
    
    for (NSString *key in keys) {
        objc_property_t property = class_getProperty(class, [key UTF8String]);
        
        if (property != nil) {
            NSString *attribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            NSRange range = NSMakeRange(1, [attribute rangeOfString:@","].location - 1);
            NSString *attrType = [attribute substringWithRange:range];
            
            id value = [jsonObject objectForKey:key];
            id newValue = nil;
            
            BOOL allowSetNil = NO;
            
            if ([attrType hasPrefix:@"@\""]) {
                attrType = [attrType substringWithRange:NSMakeRange(2, [attrType length] - 3)];
                
                Class class = NSClassFromString(attrType);
                
                if ([class isSubclassOfClass:[NSDecimalNumber class]]) {
                    if ([value isKindOfClass:[NSDecimalNumber class]]) {
                        newValue = value;
                    } else if ([value isKindOfClass:[NSNumber class]]) {
                        newValue = [NSDecimalNumber decimalNumberWithDecimal:[value decimalValue]];
                    }
                } else if ([class isSubclassOfClass:[NSNumber class]]) {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        newValue = value;
                    }
                } else if ([class isSubclassOfClass:[NSString class]]) {
                    if ([value isKindOfClass:[NSString class]]) {
                        newValue = value;
                    }
                } else if ([class isSubclassOfClass:[NSDate class]]) {
                    if ([value isKindOfClass:[NSString class]]) {
                        NSDate *date = nil;
                        
                        NSRange intervalRange = [value rangeOfString:@"(?<=/Date\\()(\\d+)(?=([\\+\\-]\\d+)?\\)/)" options:NSRegularExpressionSearch];
                        if (intervalRange.location != NSNotFound) {
                            NSString *strTimeInterval = [value substringWithRange:intervalRange];
                            double timeInterval = [strTimeInterval doubleValue] / 1000;
                            
                            date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
                        }
                        
                        newValue = date;
                    }
                } else if ([class isSubclassOfClass:[NSDictionary class]]) {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        newValue = value;
                    }
                } else if ([class isSubclassOfClass:[NSArray class]]) {
                    newValue = [self valueForKey:key];
                    
                    if ([value isKindOfClass:[NSArray class]]) {
                        if ([newValue isKindOfClass:[NSMutableArray class]]) {
                            [newValue fillWithJSONObejct:value];
                        } else {
                            newValue = value;
                        }
                    }
                } else {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        newValue = [[class alloc] init];
                        
                        [newValue fillWithJSONObejct:value];
                    }
                }
                
                allowSetNil = YES;
            } else if ([S_VALUE_TYPES rangeOfString:attrType].location != NSNotFound) {
                newValue = value;
                
                allowSetNil = NO;
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                newValue = value;
                
                allowSetNil = YES;
            }
            
            if (newValue == [NSNull null]) {
                newValue = nil;
            }
            
            if (newValue != nil || allowSetNil) {
                [self setValue:newValue forKey:key];
            }
        }
    }
}


- (NSString *)toJSONString
{
    NSData *jsonData = [self toJSONData];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSData *)toJSONData
{
    NSDictionary *jsonObject = [self toJSONObject];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:&error];
    
    return jsonData;
}

- (id)toJSONObject
{
    NSMutableDictionary *jsonDictionary = [NSMutableDictionary dictionary];
    
    Class class = [self class];
    
    while (class != [NSObject class]) {
        uint count;
        objc_property_t *properties = class_copyPropertyList(class, &count);
        
        for (int i = 0; i < count; i++) {
            NSString *key = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
            id value = [self valueForKey:key];
            id newValue = nil;
            
            if ([value isKindOfClass:[NSString class]]) {
                newValue = value;
            } else if ([value isKindOfClass:[NSNumber class]]) {
                newValue = value;
            } else if ([value isKindOfClass:[NSNull class]]) {
                newValue = value;
            } else if ([value isKindOfClass:[NSDate class]]) {
                newValue = [NSString stringWithFormat:@"/Date(%.f)/", [value timeIntervalSince1970] * 1000];
            } else if ([value isKindOfClass:[NSArray class]]) {
                newValue = [(NSArray *)value toJSONObject];
            } else {
                newValue = [value toJSONObject];
            }
            
            if (newValue == nil) {
                newValue = [NSNull null];
            }
            
            [jsonDictionary setObject:newValue forKey:key];
        }
        
        class = class_getSuperclass(class);
        
        free(properties);
    }
    
    return jsonDictionary;
}

@end



@implementation NSArray (JSON)

- (id)toJSONObject {
    NSMutableArray *jsonArray = [NSMutableArray array];
    
    for (id item in self) {
        if ([item isKindOfClass:[NSString class]]) {
            [jsonArray addObject:item];
        } else if ([item isKindOfClass:[NSNumber class]]) {
            [jsonArray addObject:item];
        } else if ([item isKindOfClass:[NSNull class]]) {
            [jsonArray addObject:item];
        } else {
            [jsonArray addObject:[item toJSONObject]];
        }
    }
    
    return jsonArray;
}

@end
