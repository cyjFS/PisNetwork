//
//  NSMutableArray+JSON.m
//  NeweggLibrary
//
//  Created by cheney on 14-1-23.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

#import "NSMutableArray+JSON.h"
#import <objc/runtime.h>

#define kItemType   @"__ItemType"

@implementation NSMutableArray (JSON)

- (Class)itemType {
    Class itemType = objc_getAssociatedObject(self, kItemType);
    
    return itemType;
}

+ (id)arrayWithItemType:(Class)itemType
{
    NSMutableArray *array = [NSMutableArray array];
    
    objc_setAssociatedObject(array, kItemType, itemType, OBJC_ASSOCIATION_ASSIGN);
    
    return array;
}

- (void)fillWithJSONObejct:(NSArray *)jsonObject {
    Class itemType = self.itemType;
    
    for (id jsonItem in jsonObject) {
        id modelItem = nil;
        
        if ([jsonItem isKindOfClass:[NSDictionary class]]) {
            modelItem = [[itemType alloc] init];
            
            [modelItem fillWithJSONObejct:jsonItem];
        } else if ([jsonItem isKindOfClass:itemType]) {
            modelItem = jsonItem;
        }
        
        if (modelItem != nil) {
            [self addObject:modelItem];
        }
    }
}

@end
