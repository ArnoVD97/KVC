//
//  ViewController.m
//  kvc&kvo
//
//  Created by zzy on 2023/7/31.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property(nonatomic, strong)NSDictionary *myDict;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myDict  = @{@"name":@"zzy", @"sex":@"1", @"age":@"21"};
    NSArray *oneArray = [NSArray arrayWithObjects:@"123", @"345", @"asd", nil];
    NSDictionary *values = [_myDict dictionaryWithValuesForKeys:oneArray];
//    [self foundation];
//    [self aSet];
//    [self aStruct];
//    [self aSetSign];
//    [self layerByLayer];
    [self KVCTips];
    [self KVCSetnil];
    [self keyValueCheck];
}
//kvc常用的方法
- (void)oftenMethod {
    NSObject *obj  = [[NSObject alloc] init];
    [obj setValue:@"obj1" forKey:@"name"];
    [obj setValue:@"obj2" forKey:@"nickName"];
}
/*
 // 通过 key 设值
 - (void)setValue:(nullable id)value forKey:(NSString *)key;
 // 通过 key 取值
 - (nullable id)valueForKey:(NSString *)key;
 // 通过 keyPath 设值
 - (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;
 // 通过 keyPath 取值
 - (nullable id)valueForKeyPath:(NSString *)keyPath;
 
 // 默认为YES。 如果返回为YES,如果没有找到 set<Key> 方法的话, 会按照_key, _isKey, key, isKey的顺序搜索成员变量, 返回NO则不会搜索
 + (BOOL)accessInstanceVariablesDirectly;
 // 键值验证, 可以通过该方法检验键值的正确性, 然后做出相应的处理
 - (BOOL)validateValue:(inout id _Nullable * _Nonnull)ioValue forKey:(NSString *)inKey error:(out NSError **)outError;
 // 如果key不存在, 并且没有搜索到和key有关的字段, 会调用此方法, 默认抛出异常。两个方法分别对应 get 和 set 的情况
 - (nullable id)valueForUndefinedKey:(NSString *)key;
 - (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;
 // setValue方法传 nil 时调用的方法
 // 注意文档说明: 当且仅当 NSNumber 和 NSValue 类型时才会调用此方法
 - (void)setNilValueForKey:(NSString *)key;
 // 一组 key对应的value, 将其转成字典返回, 可用于将 Model 转成字典
 - (NSDictionary<NSString *, id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys;

 */
//基本类型
- (void)foundation {
    Person *son = [Person new];
    [son setValue:@"Arno" forKey:@"name"];
    [son setValue:@(21) forKey:@"age"];
    NSLog(@"名字%@，年龄%@", [son valueForKey:@"name"], [son valueForKey:@"age"]);
}
//集合类型，两种方法对数组进行赋值，更推荐第二种
- (void)aSet {
    Person *son = [Person new];
    son.family = @[@"person", @"father"];
    //直接用新的数组进行赋值
    NSArray *tmp1 = @[@"person", @"father", @"mother"];
    [son setValue:tmp1 forKey:@"family"];
    NSLog(@"弟一次改变%@", [son valueForKey:@"family"]);
    NSLog(@"%@", [son.family class]);

    
    //取出数组以可变数组的形式保存，再修改
    NSMutableArray *tmp2 = [son mutableArrayValueForKeyPath:@"family"];
    [tmp2 addObject:@"child"];
    NSLog(@"第二次改变%@", [son valueForKey:@"family"]);
    NSLog(@"%@", [son.family class]);
}
//非对象类型：结构体
- (void)aStruct {
    Person *son = [Person new];
    //set
    ThreeFloats floats = {180,180,18};
    NSValue *value = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
                    [son setValue:value forKey:@"threeFloats"];
    //get
    ThreeFloats thr;
    NSValue *currValue = [son valueForKey:@"threeFloats"];
    [currValue getValue:&thr];
    NSLog(@"%f%f%f", thr.x, thr.y, thr.z);
}
//集合操作符
- (void)aSetSign {
    Person *son = [Person new];
    NSMutableArray *friendArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        Friend *f = [Friend new];
        NSDictionary* dict = @{
            @"name":@"Felix",
            @"age":@(18+i),
        };
        [f setValuesForKeysWithDictionary:dict];
        [friendArray addObject:f];
    }
    NSLog(@"%@", [friendArray valueForKey:@"age"]);
    float avg = [[friendArray valueForKeyPath:@"@avg.age"] floatValue];
    NSLog(@"平均年龄%f", avg);
    
    int count = [[friendArray valueForKeyPath:@"@count.age"] intValue];
    NSLog(@"调查人口%d", count);
    
    int sum = [[friendArray valueForKeyPath:@"@sum.age"] intValue];
    NSLog(@"年龄总和%d", sum);
    
    int max = [[friendArray valueForKeyPath:@"@max.age"] intValue];
    NSLog(@"最大年龄%d", max);
    
    int min = [[friendArray valueForKeyPath:@"@min.age"] intValue];
    NSLog(@"最小年龄%d", min);
}
- (void)layerByLayer {
    Person *son = [Person new];
    Friend *fri = [[Friend alloc] init];
    fri.name = @"arno's friend";
    fri.age = 18;
    son.friends = fri;
    [son setValue:@"feng" forKeyPath:@"friends.name"];
    NSLog(@"%@", [son valueForKeyPath:@"friends.name"]);
}
- (void)KVCTips {
    Person *son = [[Person alloc] init];
    ThreeFloats floats = {1.0, 2.0, 3.0};
    NSValue *value  = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
    [son setValue:value forKey:@"threeFloats"];
    NSLog(@"%@-%@", [son valueForKey:@"threeFloats"], [[son valueForKey:@"threeFloats"] class]);

}
- (void)KVCSetnil {
    Person *person = [[Person alloc] init];
    // Int类型设置nil
    [person setValue:nil forKey:@"age"];
    // NSString类型设置nil
    [person setValue:nil forKey:@"sub"];


}
- (void)keyValueCheck {
    Person *person = [[Person alloc] init];
    NSError *error;
    NSString *name = @"Felix";
    if (![person validateValue:&name forKey:@"names" error:&error]) {
        NSLog(@"%@",error);
    }else{
        NSLog(@"%@", [person valueForKey:@"name"]);
    }
}
@end
