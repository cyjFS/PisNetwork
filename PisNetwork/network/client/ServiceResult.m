//
//  ServiceResult.m
//  NeweggLibrary
//
//  Created by Frog Tan on 14-1-24.
//  Copyright (c) 2014年 newegg. All rights reserved.
//

#import "ServiceResult.h"

@implementation ServiceResult

@end


@implementation ServiceError

- (id)initWithLocalError:(NSError *)error message:(NSString *)message
{
    self = [self init];
    if (self) {
        self.type = ErrorTypeLocal;
        self.code = 0;
        self.message = message;
        self.data = nil;
        self.error = error;
    }
    return self;
}

- (id)initWithRemoteError:(NSError *)error message:(NSString *)message
{
    self = [self init];
    if (self) {
        self.type = ErrorTypeRemote;
        self.code = 0;
        self.message = message;
        self.data = nil;
        self.error = error;
    }
    return self;
}

- (id)initWithBusinessErrorCode:(NSInteger)code message:(NSString *)message data:(id)data
{
    self = [self init];
    if (self) {
        self.type = ErrorTypeBusiness;
        self.code = code;
        self.message = message;
        self.data = data;
        self.error = nil;
    }
    return self;
}

@end
