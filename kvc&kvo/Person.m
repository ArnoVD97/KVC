//
//  Person.m
//  kvc&kvo
//
//  Created by zzy on 2023/7/31.
//

#import "Person.h"

@implementation Person
- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"设置 %@ 是空值", key);
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未定义的key——%@",key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"未定义的key——%@",key);
    return @"未定义的key";
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing  _Nullable *)outError {
    if([inKey isEqualToString:@"name"]){
        [self setValue:[NSString stringWithFormat:@"里面修改一下: %@",*ioValue] forKey:inKey];
        return YES;
    }
    *outError = [[NSError alloc]initWithDomain:[NSString stringWithFormat:@"%@ 不是 %@ 的属性",inKey,self] code:10088 userInfo:nil];
    return NO;
}


@end
