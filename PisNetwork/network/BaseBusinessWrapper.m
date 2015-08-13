//
//  BaseBusinessWrapper.m
//  NeweggCNBusiness
//
//  Created by Burrows Wang on 1/25/14.
//  Copyright (c) 2014 newegg. All rights reserved.
//

#import "BaseBusinessWrapper.h"

inline static ServiceClientStartCallBack businessStartHandler(BusinessStartHandler startHandler) {
    ServiceClientStartCallBack startCallBack = ^(void) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            if (startHandler) {
                startHandler();
            }
        });
    };
    
    return startCallBack;
}

inline static ServiceClientFinishCallBack businessFinishHandler(BusinessFinishHandler finishHandler) {
    ServiceClientFinishCallBack finishCallBack = ^(ServiceClient *sender, ServiceResult *result) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            if (finishHandler) {
                finishHandler(result);
            }
        });
    };
    
    return finishCallBack;
}

inline static ServiceClientFinishCallBack businessProcessHandler(BusinessSuccessHandler successHandler, BusinessErrorHandler errorHandler) {
    ServiceClientFinishCallBack finishCallBack = ^(ServiceClient *sender, ServiceResult *result) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            if (result.error) {
                if (errorHandler) {
                    errorHandler(result.error);
                }
            } else {
                if (successHandler) {
                    successHandler(result.data);
                }
            }
        });
    };
    
    return finishCallBack;
}


@implementation BaseBusinessWrapper

+ (ServiceClient *)getWithUrl:(NSString *)url
                   resultType:(Class)resultType
                startCallBack:(BusinessStartHandler)startHandler
              successCallBack:(BusinessSuccessHandler)successHandler
                errorCallBack:(BusinessErrorHandler)errorHandler
{
    return [self getWithUrl:url
                 resultType:resultType
                   needAuth:NO
              startCallBack:startHandler
            successCallBack:successHandler
              errorCallBack:errorHandler];
}

+ (ServiceClient *)getWithUrl:(NSString *)url
                   resultType:(Class)resultType
                     needAuth:(BOOL)needAuth
                startCallBack:(BusinessStartHandler)startHandler
              successCallBack:(BusinessSuccessHandler)successHandler
                errorCallBack:(BusinessErrorHandler)errorHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessProcessHandler(successHandler, errorHandler);
    
    ServiceClient *serviceClient = [ServiceClient clientForGetWithURL:url
                                                 resultDataOrItemType:resultType
                                                             needAuth:needAuth
                                                                start:startBlockHandler
                                                               finish:finishBlockHandler];
    [serviceClient start];
    return serviceClient;
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
                finishCallBack:(BusinessFinishHandler)finishHandler
{
    return [self postWithUrl:url
                   paramData:data
                  resultType:resultType
                    needAuth:NO
               startCallBack:startHandler
              finishCallBack:finishHandler];
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
                finishCallBack:(BusinessFinishHandler)finishHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessFinishHandler(finishHandler);
    
    NSString *jsonString = data ? [data toJSONString] : @"";
    
    ServiceClient *serviceClient = [ServiceClient clientForPostWithURL:url
                                                            jsonString:jsonString
                                                  resultDataOrItemType:resultType
                                                              needAuth:needAuth
                                                                 start:startBlockHandler
                                                                finish:finishBlockHandler];
    [serviceClient start];
    
    return serviceClient;
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler
{
    return [self postWithUrl:url
                   paramData:data
                  resultType:resultType
                    needAuth:NO
               startCallBack:startHandler
             successCallBack:successHandler
               errorCallBack:errorHandler];
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                     paramData:(id)data
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessProcessHandler(successHandler, errorHandler);
    
    NSString *jsonString = data ? [data toJSONString] : @"";
    //64位下,true不会转化为1，fale不会转化为0
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"true" withString:@"1"];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"false" withString:@"0"];
    
    ServiceClient *serviceClient = [ServiceClient clientForPostWithURL:url
                                                            jsonString:jsonString
                                                  resultDataOrItemType:resultType
                                                              needAuth:needAuth
                                                                 start:startBlockHandler
                                                                finish:finishBlockHandler];
    [serviceClient start];
    return serviceClient;
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                          body:(NSString *)postBody
                    resultType:(Class)resultType
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler
{
    return [self postWithUrl:url
                        body:postBody
                  resultType:resultType
                    needAuth:NO
               startCallBack:startHandler
             successCallBack:successHandler
               errorCallBack:errorHandler];
}

+ (ServiceClient *)postWithUrl:(NSString *)url
                          body:(NSString *)postBody
                    resultType:(Class)resultType
                      needAuth:(BOOL)needAuth
                 startCallBack:(BusinessStartHandler)startHandler
               successCallBack:(BusinessSuccessHandler)successHandler
                 errorCallBack:(BusinessErrorHandler)errorHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessProcessHandler(successHandler, errorHandler);
    
    ServiceClient *serviceClient = [ServiceClient clientForPostWithURL:url
                                                                  body:postBody
                                                  resultDataOrItemType:resultType
                                                              needAuth:needAuth
                                                                 start:startBlockHandler
                                                                finish:finishBlockHandler];
    [serviceClient start];
    return serviceClient;
}

+ (ServiceClient *)deleteWithUrl:(NSString *)url
                      resultType:(Class)resultType
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler
{
    return [self deleteWithUrl:url
                    resultType:resultType
                      needAuth:NO
                 startCallBack:startHandler
               successCallBack:successHandler
                 errorCallBack:errorHandler];
}

+ (ServiceClient *)deleteWithUrl:(NSString *)url
                      resultType:(Class)resultType
                        needAuth:(BOOL)needAuth
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessProcessHandler(successHandler, errorHandler);
    
    ServiceClient *serviceClient = [ServiceClient clientForDeleteWithURL:url
                                                    resultDataOrItemType:resultType
                                                                needAuth:needAuth
                                                                   start:startBlockHandler
                                                                  finish:finishBlockHandler];
    [serviceClient start];
    return serviceClient;
}

+ (ServiceClient *)uploadWithUrl:(NSString *)url
                        postKeys:(NSDictionary *)postKeys
                        fileData:(NSData *)fileData
                      resultType:(Class)resultType
                        needAuth:(BOOL)needAuth
                   startCallBack:(BusinessStartHandler)startHandler
                 successCallBack:(BusinessSuccessHandler)successHandler
                   errorCallBack:(BusinessErrorHandler)errorHandler
{
    ServiceClientStartCallBack startBlockHandler = businessStartHandler(startHandler);
    ServiceClientFinishCallBack finishBlockHandler = businessProcessHandler(successHandler, errorHandler);

    ServiceClient *serviceClient = [ServiceClient clientForUploadWithURL:url
                                                                postKeys:postKeys
                                                                fileData:fileData
                                                    resultDataOrItemType:resultType
                                                                needAuth:needAuth
                                                                   start:startBlockHandler
                                                                  finish:finishBlockHandler];
    [serviceClient start];
    return serviceClient;
}

@end
