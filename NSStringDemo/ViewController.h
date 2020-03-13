//
//  ViewController.h
//  NSStringDemo
//
//  Created by 杨强 on 10/5/2019.
//  Copyright © 2019 杨强. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TLog(_var) ({ NSString *name = @#_var; NSLog(@"%@ : %@ -> %p : %@, %d", name, [_var class], _var, _var, (int)[_var retainCount]); })

@interface ViewController : UIViewController


@end

