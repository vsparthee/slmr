//
//  APIHandler.m
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "APIHandler.h"
#import <AFNetworking/AFNetworking.h>
@implementation APIHandler

#pragma mark CATAEGORY
-(void)userLogin: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:LOGIN,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)userRegister: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:REGISTER,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)API_CLASS_SCHUDULE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
{
    NSString * url = [NSString stringWithFormat:CLASS_SCHUDULE,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
}

-(void)API_PROFILE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
{
    NSString * url = [NSString stringWithFormat:PROFILE,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];

}

-(void)API_EXAM_LIST: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:EXAM_LIST,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];

}

-(void)API_EXAM_RESULTS: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:EXAM_RESULTS,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
}


-(void)API_NOTICE_BOARD: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:NOTICE_BOARD,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         NSLog(@"Error:%@",error.localizedDescription);
         failure(operation, error);
     }];

}


-(void)API_HOLIDAY: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:HOLIDAY,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)API_ATTENDANCE: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:ATTENDANCE,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)API_IN_OUT_REPORT:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:IN_OUT_REPORT,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)API_STUDENT_IN:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:STUDENT_IN,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     }
    failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)API_STUDENT_OUT:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:STUDENT_OUT,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)API_REGISTER_TOKEN:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:REGISTER_TOKEN,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)API_PRIVATE_MESSAGE:(NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:PRIVATE_MESSAGE,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}



@end
