//
//  Point3D.h
//  JSBinding2
//
//  Created by Li  on 2016/10/11.
//  Copyright © 2016年 bjcric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol Point3DExport <JSExport>

@property double x;
@property double y;
@property double z;

-(double)length;

@end

@interface Point3D : NSObject

@end
