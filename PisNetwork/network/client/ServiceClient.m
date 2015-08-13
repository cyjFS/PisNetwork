//
//  ServiceClient.m
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

#import "ServiceClient.h"
#import "ServiceLoader.h"
#import "ServiceLoaderUtil.h"
#import "Consts.h"
#import "RequestBuilder.h"
#import "NetworkConfiguration.h"
#import "ServiceResult.h"
#import "NSString+Utils.h"

@interface ServiceClient ()
@property (nonatomic, strong) ServiceLoader *loader;

@property (nonatomic, strong) Class			resultDataOrItemType;
@end

@implementation ServiceClient
#pragma mark -
#pragma mark - init

- (id)init{
	self = [super init];
	
	if( self ){
		self.identifier = [NSString UUIDString];
	}
	
	return self;
}

#pragma mark -
#pragma mark - public methods
//GET
+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish{
	return [self clientForGetWithURL:url
				resultDataOrItemType:resultDataOrItemType
							needAuth:NO
							   start:start
							  finish:finish];
}

+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
							  needAuth:(BOOL)needAuth
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish{
	return [self clientForGetWithURL:url
				resultDataOrItemType:resultDataOrItemType
							needAuth:needAuth
					  requestHandler:nil
							   start:start
							  finish:finish];
}

+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
							  needAuth:(BOOL)needAuth
						requestHandler:(RequestBuildHandler)requestHandler
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish{
	ServiceClient *client = [[self alloc] init];
	client.startCallBack = start;
	client.finishCallBack = finish;
	client.resultDataOrItemType = resultDataOrItemType;
	
	NSMutableURLRequest *request = [client requestWithUrl:url
												 needAuth:needAuth
										   requestHandler:requestHandler];
	
	client.loader = [ServiceLoaderUtil loaderForGetWithRequest:request
														 start:^(NSURLRequest *request){
                                                             [self client:client startWithRequest:request];
                                                         }
														finish:^(NSData *data, NSURLResponse *response, NSError *error) {
															[self client:client
														finishedWithData:data
																response:response
																   error:error];
														}];
	
	return client;
}

//POST
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	return [self clientForPostWithURL:url
								 body:body
				 resultDataOrItemType:resultDataOrItemType
							 needAuth:NO
								start:start
							   finish:finish];
}
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	return [self clientForPostWithURL:url
								 body:body
				 resultDataOrItemType:resultDataOrItemType
							 needAuth:needAuth
					   requestHandler:nil
								start:start
							   finish:finish];
}
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
						 requestHandler:(RequestBuildHandler)requestHandler
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	ServiceClient *client = [[self alloc] init];
	client.startCallBack = start;
	client.finishCallBack = finish;
	client.resultDataOrItemType = resultDataOrItemType;
	
	NSMutableURLRequest *request = [client requestWithUrl:url
												 needAuth:needAuth
										   requestHandler:requestHandler];
	[request setValue:kContentTypeFormURLEncoded
   forHTTPHeaderField:kContentTypeKey];
	
	NSData *formData = [body dataUsingEncoding:NSUTF8StringEncoding];
	
	client.loader = [ServiceLoaderUtil loaderForPostWithRequest:request
													   formData:formData
														  start:^(NSURLRequest *request){
                                                              [self client:client startWithRequest:request];
                                                          }
														 finish:^(NSData *data, NSURLResponse *response, NSError *error) {
															 [self client:client
														 finishedWithData:data
																 response:response
																	error:error];
														 }];
	
	return client;
}


+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	return [self clientForPostWithURL:url
						   jsonString:jsonString
				 resultDataOrItemType:resultDataOrItemType
							 needAuth:NO
								start:start
							   finish:finish];
}
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	return [self clientForPostWithURL:url
						   jsonString:jsonString
				 resultDataOrItemType:resultDataOrItemType
							 needAuth:needAuth
					   requestHandler:nil
								start:start
							   finish:finish];
}
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
						 requestHandler:(RequestBuildHandler)requestHandler
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish{
	ServiceClient *client = [[self alloc] init];
	client.startCallBack = start;
	client.finishCallBack = finish;
	client.resultDataOrItemType = resultDataOrItemType;
	
	NSMutableURLRequest *request = [client requestWithUrl:url
												 needAuth:needAuth
										   requestHandler:requestHandler];
	[request setValue:kContentTypeJSON
   forHTTPHeaderField:kContentTypeKey];
	
	NSData *formData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	
	client.loader = [ServiceLoaderUtil loaderForPostWithRequest:request
													   formData:formData
														  start:^(NSURLRequest *request){
                                                              [self client:client startWithRequest:request];
                                                          }
														 finish:^(NSData *data, NSURLResponse *response, NSError *error) {
															 [self client:client
														 finishedWithData:data
																 response:response
																	error:error];
														 }];
	
	return client;

}

+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData
					 resultDataOrItemType:(Class)resultDataOrItemType
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	return [self clientForUploadWithURL:url
							   postKeys:postKeys
							   fileData:fileData
				   resultDataOrItemType:resultDataOrItemType
							   needAuth:NO
								  start:start
								 finish:finish];
}
+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	return [self clientForUploadWithURL:url
							   postKeys:postKeys
							   fileData:fileData
				   resultDataOrItemType:resultDataOrItemType
							   needAuth:needAuth
						 requestHandler:nil
								  start:start
								 finish:finish];
}
+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
						   requestHandler:(RequestBuildHandler)requestHandler
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	ServiceClient *client = [[self alloc] init];
	client.startCallBack = start;
	client.finishCallBack = finish;
	client.resultDataOrItemType = resultDataOrItemType;
	
	NSMutableURLRequest *request = [client requestWithUrl:url
												 needAuth:needAuth
										   requestHandler:requestHandler];
	[request setValue:kContentTypeFile
   forHTTPHeaderField:kContentTypeKey];
	
	NSMutableData *postData = [NSMutableData data];
	[postData appendData:[[NSString stringWithFormat:@"--%@\r\n", KFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	// Add form data to request
	if (postKeys) {
		NSEnumerator *keys = [postKeys keyEnumerator];
		int i;
		for (i = 0; i < [postKeys count]; i++) {
			NSString *tempKey = [keys nextObject];
			[postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempKey] dataUsingEncoding:NSUTF8StringEncoding]];
			[postData appendData:[[NSString stringWithFormat:@"%@",[postKeys objectForKey:tempKey]] dataUsingEncoding:NSUTF8StringEncoding]];
			[postData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",KFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	NSString *fileName = [postKeys objectForKey:@"fileName"];
	
	if(!fileName){
		fileName = @"test.jpg";
	}
	
	// Add file data to request
	[postData appendData:[[NSString stringWithFormat:@"Content-Disposition: file; name=\"uploadfile\";filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
	[postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[postData appendData:fileData];
	[postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",KFormBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	client.loader = [ServiceLoaderUtil loaderForPostWithRequest:request
													   formData:postData
														  start:^(NSURLRequest *request){
                                                              [self client:client startWithRequest:request];
                                                          }
														 finish:^(NSData *data, NSURLResponse *response, NSError *error) {
															 [self client:client
														 finishedWithData:data
																 response:response
																	error:error];
														 }];
	
	return client;
}

//DELETE
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	return [self clientForDeleteWithURL:url
				   resultDataOrItemType:resultDataOrItemType
							   needAuth:NO
								  start:start
								 finish:finish];
}
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	return [self clientForDeleteWithURL:url
				   resultDataOrItemType:resultDataOrItemType
							   needAuth:needAuth
						 requestHandler:nil
								  start:start
								 finish:finish];
}
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
						   requestHandler:(RequestBuildHandler)requestHandler
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish{
	ServiceClient *client = [[self alloc] init];
	client.startCallBack = start;
	client.finishCallBack = finish;
	client.resultDataOrItemType  = resultDataOrItemType;
	
	NSMutableURLRequest *request = [client requestWithUrl:url
												 needAuth:needAuth
										   requestHandler:requestHandler];
	
	client.loader = [ServiceLoaderUtil loaderForDeleteWithRequest:request
															start:^(NSURLRequest *request){
                                                                [self client:client startWithRequest:request];
                                                            }
														   finish:^(NSData *data, NSURLResponse *response, NSError *error) {
															   [self client:client
														   finishedWithData:data
																   response:response
																	  error:error];
														   }];
	
	return client;
}

//Request Service
- (void)start{
    [ServiceClient setNetworkIndicatorShown:YES];
    
	[self.loader cancel];
	[self.loader start];
	
	self.isStarted = YES;
	self.isFinished = NO;
	self.isCancelled = NO;
}

- (void)cancel{
	[self.loader cancel];
	
	self.isCancelled = YES;
	self.isFinished = YES;
	self.isStarted = NO;
    
    [ServiceClient setNetworkIndicatorShown:NO];
}

- (void)invalidate{
	[self.loader cancel];
	[self clear];
	
	self.isTerminated = YES;
    
    [ServiceClient setNetworkIndicatorShown:NO];
}

- (void)retry{
    [ServiceClient setNetworkIndicatorShown:YES];
    
	[self.loader retry];
	
	self.isStarted = YES;
	self.isFinished = NO;
	self.isCancelled = NO;
}

#pragma mark -
#pragma mark - utility methods
- (NSMutableURLRequest *)requestWithUrl:(NSString *)url
						needAuth:(BOOL)needAuth
						 requestHandler:(RequestBuildHandler)requestHandler{
	url = [url urlEncodedUsingUTF8Encoding];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	
	id<RequestBuilder> globalRequestBuilder = [NetworkConfiguration sharedConfiguration].globalRequestBuilder;
	RequestBuildHandler globalRequestBuildHandler = [NetworkConfiguration sharedConfiguration].globalRequestBuildHandler;
	
	if(globalRequestBuilder){
		[globalRequestBuilder buildRequest:request needAuth:needAuth];
	}
	else if(globalRequestBuildHandler){
		globalRequestBuildHandler(request, needAuth);
	}
	
	if(requestHandler){
		requestHandler(request, needAuth);
	}
	
	return request;
}

- (void)clear{
	self.startCallBack = nil;
	self.finishCallBack = nil;
	
	[self.loader invalidate];
	self.loader = nil;
}

+ (void)setNetworkIndicatorShown:(BOOL)isShow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = isShow;
    });
}

+ (void)client:(ServiceClient *)client startWithRequest:(NSURLRequest *)urlRequest {
    RequestHandler globalRequestHandler = [NetworkConfiguration sharedConfiguration].globalRequestHandler;
    
    if (globalRequestHandler) {
        globalRequestHandler(urlRequest, client.loader.formData);
    }
    
    if (client.startCallBack) {
        client.startCallBack();
    }
}

+ (void)client:(ServiceClient *)client processCancelInError:(NSError *)error{
	client.isCancelled = error.code == NSURLErrorCancelled;
	
	client.isFinished = YES;
	client.isStarted = NO;
}

+ (void)client:(ServiceClient *)client
	finishedWithData:(NSData *)data
			response:(NSURLResponse *)response
				error:(NSError *)error{
	[self client:client processCancelInError:error];
	
	if(!client.isCancelled){
        ServiceResult *result = [[ServiceResult alloc] init];
        
        result.response = response;
        result.originData = data;
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            
            switch (statusCode) {
                case 200: {
                    if ([data length] > 0) {
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                        
                        if (error != nil) {
                            NSString *message = @"服务器返回数据格式错误，请稍候再试";
                            
                            result.error = [[ServiceError alloc] initWithRemoteError:error message:message];
                        } else {
                            JsonParserHandler globalJsonParserHandler = [NetworkConfiguration sharedConfiguration].globalJsonParserHandler;
                            Class itemDataType = client.resultDataOrItemType;
                            
                            if (globalJsonParserHandler) {
                                globalJsonParserHandler(result, jsonObject, itemDataType);
                            } else {
                                //result.data = [itemDataType dataModelWithJSONObject:jsonObject];
                                result.data = jsonObject;
                            }
                        }
                    } else {
                        result.data = nil;
                    }
                }
                    break;
                default: {
                    NSString *message = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
                    
                    result.error = [[ServiceError alloc] initWithRemoteError:error message:message];
                }
                    break;
            }
        } else if (error) {
            result.error = [[ServiceError alloc] initWithLocalError:error message:[error localizedDescription]];
        }
        
        ResponseHandler globalResponseHandler = [NetworkConfiguration sharedConfiguration].globalResponseHandler;
        
        if (globalResponseHandler) {
            globalResponseHandler(response, data);
        }
        
        if (client.finishCallBack) {
			client.finishCallBack(client, result);
		}
		
		[client clear];
	}
    
    [ServiceClient setNetworkIndicatorShown:NO];
}
@end
