// Copyright (c) 2015 Microsoft Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
// 
// 
// This file was generated and any changes will be overwritten.

#import "ODModels.h"
#import "ODODataEntities.h"
#import "ODURLSessionDownloadTask.h"
#import "ODURLSessionUploadTask.h"

@interface ODRequest()

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      body:(NSData *)body 
                                   headers:(NSDictionary *)headers;

@end

@implementation ODItemContentRequest

- (NSMutableURLRequest *) download
{
    return [self requestWithMethod:@"GET"
                              body:nil
                           headers:nil];
}

- (ODURLSessionDownloadTask *) downloadWithCompletion:(ODDownloadCompletionHandler)completionHandler
{
    ODURLSessionDownloadTask *task = [[ODURLSessionDownloadTask alloc] initWithRequest:[self download]
                                                                                client:self.client
                                                                     completionHandler:completionHandler];
    [task execute];
    return task;
}

- (NSMutableURLRequest *) upload 
{
    //when creating an upload task the body will be reset
    return [self requestWithMethod:@"PUT"
                              body:nil
                           headers:nil];
}

- (ODURLSessionUploadTask *) uploadFromData:(NSData *)data
                                 completion:(ODItemUploadCompletionHandler)completionHandler
{
    ODURLSessionUploadTask *task = [self uploadTaskWithRequest:[self upload]
                                                      fromData:data
                                        odobjectWithDictionary:^(NSDictionary *response){
                                                return [[ODItem alloc] initWithDictionary:response];
                                        }
                                             completionHandler:completionHandler];
    [task execute];
    return task;

}

- (ODURLSessionUploadTask *) uploadFromFile:(NSURL *)fileURL
                                 completion:(ODItemUploadCompletionHandler)completionHandler 
{
    ODURLSessionUploadTask *task = [self uploadTaskWithRequest:[self upload]
                                                      fromFile:fileURL
                                        odobjectWithDictionary:^(NSDictionary *response){
                                                return [[ODItem alloc] initWithDictionary:response];
                                        }
                                             completionHandler:completionHandler];
    [task execute];
    return task;
}

@end
