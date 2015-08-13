//
//  NetworkConfiguration.h
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

#import "RequestBuilder.h"
#import "ServiceResult.h"

typedef void (^JsonParserHandler)(ServiceResult *result, id jsonData, Class itemDataType);

typedef void (^RequestHandler)(NSURLRequest *urlRequest, NSData *data);
typedef void (^ResponseHandler)(NSURLResponse *urlResponse, NSData *data);

@interface NetworkConfiguration : NSObject

@property (nonatomic, strong) id<RequestBuilder>	globalRequestBuilder;
@property (nonatomic, strong) RequestBuildHandler   globalRequestBuildHandler;//如果同时设置globalRequestBuilder和globalRequestBuildHandler，globalRequestBuildHandler会被覆盖

@property (nonatomic, strong) JsonParserHandler     globalJsonParserHandler;

@property (nonatomic, strong) RequestHandler        globalRequestHandler;
@property (nonatomic, strong) ResponseHandler       globalResponseHandler;

@property (nonatomic, assign) BOOL					needHandleCertificateError;

+ (NetworkConfiguration *)sharedConfiguration;

@end
