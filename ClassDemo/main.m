//
//  main.m
//  ClassDemo
//
//  Created by Nasy on 2020/5/19.
//  Copyright © 2020 nasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "YNPerson.h"


void isaPointerFunction(id self,SEL _cmd) {
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
//    for (Class currentClass = [self class]; currentClass !=  object_getClass(currentClass); currentClass = object_getClass(currentClass)) {
//        NSLog(@"Following the isa pointer %@ and Memory address is %p",currentClass ,currentClass);
//    }
    Class currentClass = [self class];
    while ([[currentClass superclass]superclass] !=  nil) {
        
        NSLog(@"Following the isa pointer %@ and Memory address is %p,isMetaClass:%d",currentClass ,currentClass,class_isMetaClass(currentClass));
        if (class_isMetaClass(object_getClass(currentClass)) && object_getClass(currentClass) == object_getClass([NSObject class])) {
            NSLog(@"%@(%p) is Meta Class %@(%p)'s Class", object_getClass(currentClass),object_getClass(currentClass),currentClass,currentClass);
        }
        currentClass = object_getClass(currentClass);
        
    }

    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
    
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        YNPerson *p = [[YNPerson alloc] init];
        //输出1
        NSLog(@"%d", [p class] == [YNPerson class]);
        //输出0
        NSLog(@"%d", class_isMetaClass(object_getClass(p)));
        //输出1
        NSLog(@"%d", class_isMetaClass(object_getClass([YNPerson class])));
        //输出0
        NSLog(@"%d", object_getClass(p) == object_getClass([YNPerson class]));
        
        Class YNStudent = objc_allocateClassPair([YNPerson class], "YNStudent", 0);
        class_addMethod(YNStudent, @selector(getIsaPointer), (IMP)isaPointerFunction, "v@:");
        id stu = [[YNStudent alloc]init];
        [stu performSelector:@selector(getIsaPointer)];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}


