//
//  Person.m
//  闭包代理
//
//  Created by James Bond on 2017/2/19.
//  Copyright © 2017年 James. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person


- (void)encodeWithCoder:(NSCoder *)aCoder{
    //调用NSCoder的方法归档该对象的每一个属性
//    [aCoder encodeObject:_username forKey:@"_username"];
//    [aCoder encodeObject:_userage forKey:@"_userage"];
//    [aCoder encodeObject:_userheight forKey:@"_userheight"];
    
    //runtime 归档
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([Person class], &count);
    for (int i = 0 ; i< count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}
//解归档
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        //使用NSCoder的方法从归档中依次恢复该对象的每一个属性
//        _username=[[aDecoder decodeObjectForKey:@"_username"] copy];
//        _userage=[[aDecoder decodeObjectForKey:@"_userage"] copy];
//        _userheight=[[aDecoder decodeObjectForKey:@"_userheight"] copy];
        
        
        //runtime 解归档
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([Person class], &count);
        for (int i = 0 ; i< count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


+(void)eatAction{

    NSLog(@"这是个 runtime 类方法 消息发送机制");
    
}
-(void)eatAction{

    NSLog(@"这是个 runtime 消息发送机制");
}

-(void)eatTwice:(NSString *)food foodOne:(NSString *)foodOne{

    NSLog(@"这一次吃的是：%@ 还有 %@",food,foodOne);

}

@end
