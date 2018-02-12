//
//  APIHandler.h
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHandler : NSObject

-(void)userLogin: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)userRegister: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_CLASS_SCHUDULE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_PROFILE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_EXAM_LIST: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_EXAM_RESULTS: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_NOTICE_BOARD: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_HOLIDAY: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_ATTENDANCE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_IN_OUT_REPORT: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_STUDENT_IN:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_STUDENT_OUT:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_REGISTER_TOKEN:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)API_PRIVATE_MESSAGE:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
@end
