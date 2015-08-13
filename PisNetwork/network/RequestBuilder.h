//
//  RequestBuilder.h
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

typedef void (^RequestBuildHandler)(NSMutableURLRequest *request, BOOL needAuth);

@protocol RequestBuilder <NSObject>
- (void)buildRequest:(NSMutableURLRequest *)request needAuth:(BOOL)needAuth;
@end
