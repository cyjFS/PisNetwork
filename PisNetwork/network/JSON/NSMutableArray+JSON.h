//
//  NSMutableArray+JSON.h
//  NeweggLibrary
//
//  Created by cheney on 14-1-23.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

@interface NSMutableArray (JSON)

@property(nonatomic,readonly) Class itemType;

+ (id)arrayWithItemType:(Class)itemType;

@end
