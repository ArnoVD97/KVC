//
//  Person.h
//  kvc&kvo
//
//  Created by zzy on 2023/7/31.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
NS_ASSUME_NONNULL_BEGIN
typedef struct {
    float x, y, z;
}ThreeFloats;
@interface Person : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, copy) NSArray *family;
@property(nonatomic) ThreeFloats threeFloats;
@property(nonatomic, strong) Friend *friends;
@end


NS_ASSUME_NONNULL_END
