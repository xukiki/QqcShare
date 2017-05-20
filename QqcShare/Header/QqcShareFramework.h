//
//  QqcShareFramework.h
//  QqcShareFramework
//
//  Created by qiuqinchuan on 16/2/24.
//  Copyright © 2016年 Qqc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QqcIncludeShareSdk.h"
#import "QqcPlatformDef.h"
#import "QqcShareView.h"
#import "QqcShareProcess.h"
#import "QqcQRCodeView.h"
#import "QqcAuthLoginProcess.h"

@interface QqcShareFramework : NSObject

/**
 *  WOSHARE 库版本号
 *
 *  @return 库版本号
 */
- (NSString*)version;

/**
 *  WOSHARE 库版本信息
 *
 *  @return 库版本信息
 */
- (NSString*)versionInfo;

@end
