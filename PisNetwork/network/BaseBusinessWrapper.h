//
//  BaseBusinessWrapper.h
//  NeweggCNBusiness
//
//  Created by Burrows Wang on 1/25/14.
//  Copyright (c) 2014 newegg. All rights reserved.
//

typedef void(^BusinessStartHandler)(void);
typedef void(^BusinessFinishHandler)(ServiceResult *result);
typedef void(^BusinessErrorHandler)(ServiceError *error);
typedef void(^BusinessSuccessHandler)(id data);

@interface BaseBusinessWrapper : NSObject

+ (ServiceClient *)getWithUrl:(NSString *)url
                   resultType:(Class)resultType
                startCallBack:(BusinessStartHandler)startHandler
              successCallBack:(BusinessSuccessHandler)successHandler
                errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)getWithUrl:(NSString *)url
                   resultType:(Class)resultType
                     needAuth:(BOOL)needAuth
                startCallBack:(BusinessStartHandler)startHandler
              successCallBack:(BusinessSuccessHandler)successHandler
                errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
               finishCallBack:(BusinessFinishHandler)finishHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
               finishCallBack:(BusinessFinishHandler)finishHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                          body:(NSString *)postBody
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)postWithUrl:(NSString *)url
                          body:(NSString *)postBody
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)deleteWithUrl:(NSString *)url
                      resultType:(Class)resultType
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)deleteWithUrl:(NSString *)url
                      resultType:(Class)resultType
                        needAuth:(BOOL)needAuth
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler;

+ (ServiceClient *)uploadWithUrl:(NSString *)url
                        postKeys:(NSDictionary *)postKeys
                        fileData:(NSData *)fileData
                      resultType:(Class)resultType
                        needAuth:(BOOL)needAuth
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler;

@end
