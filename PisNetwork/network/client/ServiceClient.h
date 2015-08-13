//
//  ServiceClient.h
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

@class ServiceResult;
@class ServiceClient;

#import "NetworkConfiguration.h"

typedef void (^ServiceClientStartCallBack)(void);
typedef void (^ServiceClientFinishCallBack)(ServiceClient *sender, ServiceResult *result);

@interface ServiceClient : NSObject
@property (nonatomic, strong) NSString	*identifier;
@property (nonatomic, strong) ServiceClientStartCallBack	startCallBack;
@property (nonatomic, strong) ServiceClientFinishCallBack	finishCallBack;

@property (nonatomic, assign) BOOL		isStarted;
@property (nonatomic, assign) BOOL		isCancelled;
@property (nonatomic, assign) BOOL		isFinished;
@property (nonatomic, assign) BOOL		isTerminated;

//GET
+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
							  needAuth:(BOOL)needAuth
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish;

+ (ServiceClient *)clientForGetWithURL:(NSString *)url
				  resultDataOrItemType:(Class)resultDataOrItemType
							  needAuth:(BOOL)needAuth
						requestHandler:(RequestBuildHandler)requestHandler
								 start:(ServiceClientStartCallBack)start
								finish:(ServiceClientFinishCallBack)finish;

//POST
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
								needAuth:(BOOL)needAuth
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
								   body:(NSString *)body
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
						 requestHandler:(RequestBuildHandler)requestHandler
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;


+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForPostWithURL:(NSString *)url
							 jsonString:(NSString *)jsonString
				   resultDataOrItemType:(Class)resultDataOrItemType
							   needAuth:(BOOL)needAuth
						 requestHandler:(RequestBuildHandler)requestHandler
								  start:(ServiceClientStartCallBack)start
								 finish:(ServiceClientFinishCallBack)finish;



+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData
					 resultDataOrItemType:(Class)resultDataOrItemType
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForUploadWithURL:(NSString *)url
								 postKeys:(NSDictionary *)postKeys
								 fileData:(NSData *)fileData
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
						   requestHandler:(RequestBuildHandler)requestHandler
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;

//DELETE
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;
+ (ServiceClient *)clientForDeleteWithURL:(NSString *)url
					 resultDataOrItemType:(Class)resultDataOrItemType
								 needAuth:(BOOL)needAuth
						   requestHandler:(RequestBuildHandler)requestHandler
									start:(ServiceClientStartCallBack)start
								   finish:(ServiceClientFinishCallBack)finish;


//Reqeust Service
- (void)start;
- (void)cancel;
/*!
 * client的开始和完成回调会被释放，如果需要继续调用服务，需要重新创建client
 */
- (void)invalidate;
- (void)retry;
@end
