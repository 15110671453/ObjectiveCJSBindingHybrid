//
//  main.m
//  JSBinding2
//
//  Created by Li  on 2016/10/11.
//  Copyright © 2016年 bjcric. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <Foundation/Foundation.h>


void loadScript(JSContext* context,NSString* fileName)
{
    NSString* filePath = [NSString stringWithFormat:@"%@/JS/%@",[[NSBundle mainBundle] resourcePath],fileName];
    NSString* script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [context evaluateScript:script];
}
void prepareConsole(JSContext* context)
{
   
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        //JSContext
        JSContext* context = [[JSContext alloc]init];
        context.exceptionHandler = ^(JSContext* ctx,JSValue* exception){
            NSLog(@"%@",exception);
        };
        
        JSValue* result =[context evaluateScript:@"1 + 2"];
        NSLog(@"1+2=%f",[result toDouble]);
        
        
        JSValue* sum = context[@"sum" ];
        JSValue* result2 = [sum callWithArguments:@[@1,@2]];
        
        NSLog(@"sum(1,2) return %@",[result2 toString]);
        
        JSValue* intVar = [JSValue valueWithInt32:321 inContext:context];
        context[@"bar"] = intVar;
        [context evaluateScript:@"bar++"];
        
        //another way
        [context evaluateScript:@"var bar2 = 231"];
        
        NSString* script =@"var globalVar = 2 ";
        JSValue* valResult=[context evaluateScript:script];
        NSLog(@"gloabalVar is %ld",(long)[valResult toNumber]);
        context[@"sum"] = ^(int a,int b){
            return a+b;
        };
        JSValue* result3 = [context evaluateScript:@"sum(1,2)"];
        NSLog(@"js diao yuan sheng %@",[result3 toNumber]);
        //create a js export class in objective-c
        //the instance of this class can be accessed in js context
        // no constructor in js
        context[@"sum"] = ^(int a,int b){
            JSContext* ctx = [JSContext currentContext];
            NSArray* args =[JSContext currentArguments];
            NSLog(@"args :%@",args);
            return a+b;
        };
        JSValue* result4 = [context evaluateScript:@"sum(1,2)"];
        NSLog(@"js diao yuan sheng %@",[result4 toNumber]);
        
        /*
         OC中数据类型  与 JavaScript 数据类型映射
         nil                undefined
         NSNull                 null
         NSString               string
         NSNumber               number boolean
         NSDictionary           Object object
         NSArray                array object
         NSDate                 Date object
         NSBlock                Function object
         id                         Wrapper object
         Class                  Constructor object
         */
        
        
    }
    return 0;
}
