//
//  NSURL+Request.m
//  闭包代理
//
//  Created by James Bond on 2017/2/19.
//  Copyright © 2017年 James. All rights reserved.
//

#import "NSURL+Request.h"

#import <objc/message.h>

#import <UIKit/UIKit.h>

@implementation NSURL (Request)

+(void)load{

    Method urlWithString = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method requesturlWithString = class_getClassMethod([NSURL class], @selector(request_urlWithString:));
    method_exchangeImplementations(urlWithString, requesturlWithString);
}


+(instancetype)request_urlWithString:(NSString *)urlString{
    
    NSURL * url = [NSURL request_urlWithString:urlString];
    if (!url) {
        NSLog(@"这个URL有问题");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"这个URL有毛病吧" message:nil delegate:nil cancelButtonTitle:@"是的" otherButtonTitles:@"我知道了", nil];
        [alert show];
    }
    
    return url;
}

@end
