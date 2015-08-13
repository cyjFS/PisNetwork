//
//  ServiceResult.h
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

typedef enum {
    ErrorTypeLocal,
    ErrorTypeRemote,
    ErrorTypeBusiness
} ErrorType;

@class ServiceError;

@interface ServiceResult : NSObject

@property (nonatomic, strong) NSURLResponse	*response;
@property (nonatomic, strong) NSData		*originData;
@property (nonatomic, strong) ServiceError  *error;
@property (nonatomic, strong) id			data;

@end

@interface ServiceError : NSObject

@property (nonatomic, assign) ErrorType type;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString  *message;
@property (nonatomic, strong) id        data;
@property (nonatomic, strong) NSError   *error;

- (id)initWithLocalError:(NSError *)error message:(NSString *)message;
- (id)initWithRemoteError:(NSError *)error message:(NSString *)message;
- (id)initWithBusinessErrorCode:(NSInteger)code message:(NSString *)message data:(id)data;

@end
