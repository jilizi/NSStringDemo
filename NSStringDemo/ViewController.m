//
//  ViewController.m
//  NSStringDemo
//
//  Created by 杨强 on 10/5/2019.
//  Copyright © 2019 杨强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     在objc的retainCount中.如果对象的retainCount为-1，就意味着“无限的retainCount”，这个对象是不能被释放的。
     所有的 __NSCFConstantString对象的retainCount都为-1，这就意味着 __NSCFConstantString不会被释放，使用第一种方法创建的NSString，如果值一样，无论写多少遍，都是同一个对象。而且这种对象可以直接用 == 来比较
     
     * 1、第一种方式和第二种方式创建出来的NSString时一模一样的，isa是__NSCFConstantString，内存地址一样，retainCount是-1.
     * 2、第三种方式创建的NSString和创建其他objc对象类似的，isa是__NSCFString, 在堆上分配内存，初始retainCount为1.
     * 3、第四种方式创建方式和第三种一样, 但是由于值的长度不一样而存储的位置不一样, 可以参考唐巧的iOS进阶中介绍的TaggedPointer, iphone5S之后采用了64位的系统, 对于短的值是直接存储在指针里面, 也就是说TaggedPointer这个指针不但存储着自身的地址还存储着值
     */
    
    //__NSCFConstantString(常量区)
    NSString *str0 = @"0123456789";
    TLog(str0);
    NSString *str1 = [NSString stringWithString:@"0123456789"];
    TLog(str1);
    //__NSCFString(堆区)
    NSString *str2 = [NSString stringWithFormat:@"0123456789"];
    TLog(str2);
    //NSTaggedPointerString(栈区)
    NSString *str3 = [NSString stringWithFormat:@"abcd"];
    TLog(str3);
    
//    [self test__NSCFConstantString];
    
//    [self test__NSCFString];
    
//    [self testTaggedPointerString];
    
//    [self compareStringPointer];
    
    NSMutableString *mutStr0 = [NSMutableString stringWithFormat:@"01"];
    TLog(mutStr0);
    
    NSMutableString *mutStr = [NSMutableString stringWithString:@"0123456789"];
    TLog(mutStr);
    
    
}

/* 常量区字符串
 * 1、对一个__NSCFConstantString进行retain和copy操作都还是自己，没有任何变化
 * 2、对其mutableCopy操作,就别变成了__NSCFString, 将其拷贝到堆上，retainCount为1.
 * 3、对__NSCFString copy 在堆区拷贝一份, retainCount为1
 */
- (void)test__NSCFConstantString {
    NSString *str = @"0123456789";
    TLog(str);
    
    NSString *str1 = [str retain];
    TLog(str1);
    
    NSString *str2 = [str copy];
    TLog(str2);
    
    NSString *str3 = [str mutableCopy];
    TLog(str3);
    
    NSString *str4 = [str3 copy];
    TLog(str4);
}

/* 堆区字符串
 * 1、对__NSCFString进行retain和mutableCopy操作时，其特性符合正常的对象特性。
 * 2、
 * 3、
 */
- (void)test__NSCFString {
    NSString *str0 = [NSString stringWithFormat:@"0123456789"];
    TLog(str0);
    
    NSString *str = [str0 mutableCopy];
    TLog(str);
    
    NSString *str1 = [str retain];
    TLog(str1);
    
    NSString *str2 = [str copy];
    TLog(str2);
    
    NSString *str3 = [str mutableCopy];
    TLog(str3);
    
    NSString *str4 = [str3 copy];
    TLog(str4);
}

/* NSTaggedPointerString
 * 1、对栈区字符串copy, 也还是栈区字符串, retainCount是-1
 * 2、对栈区字符串mutableCopy, 拷贝到了堆区, retainCount为1
 * 3、对堆区的短的字符串进行copy, 又回到了栈区,变回了NSTaggedPointerString, retainCount为-1
 */
- (void)testTaggedPointerString {
    NSString *shortStr = [NSString stringWithFormat:@"abcd"];
    TLog(shortStr);
    
    NSString *copyShortStr = [shortStr copy];
    TLog(copyShortStr);
    
    NSString *mutableCopyStr = [shortStr mutableCopy];
    TLog(mutableCopyStr);
    
    NSString *copyMutCopyStr = [mutableCopyStr copy];
    TLog(copyMutCopyStr);
}


- (void)compareStringPointer {
    NSString *string = @"string";
    NSMutableString *mutableStr = [NSMutableString stringWithString:string];
    NSString *copyString = [string copy];
    NSString *mutaleCopyStr = [mutableStr mutableCopy];
    NSString *copyMutableStr = [mutableStr copy];
    NSLog(@"%d\n%d\n%d\n", string == mutableStr, string == copyString, mutableStr == mutaleCopyStr);
    NSLog(@"%p, %p, %p, %p, %p", string, mutableStr, copyString, mutaleCopyStr, copyMutableStr);
    
    NSString *str = [NSString stringWithString:string];
    NSString *copyStr = [str copy];
    NSLog(@"%p, %p", str, copyStr);
}


@end
