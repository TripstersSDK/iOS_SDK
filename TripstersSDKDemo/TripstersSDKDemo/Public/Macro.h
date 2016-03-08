//
//  macro.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/2/20.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#ifndef macro_h
#define macro_h

#import <UIKit/UIKit.h>

#undef Declare_ShareInstance
#define Declare_ShareInstance(__class) +(__class *)shareInstance

#undef Realize_ShareInstance
#define Realize_ShareInstance(__class) \
+(__class *)shareInstance { \
static dispatch_once_t onceToken; \
static __class *_instance_; \
dispatch_once(&onceToken, ^{ \
_instance_ = [[__class alloc]init]; \
});   \
return _instance_;\
}

#define  AVAILABLE_IOS9 ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define  AVAILABLE_IOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define  AVAILABLE_IOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define  AVAILABLE_IOS6 ([UIDevice currentDevice].systemVersion.floatValue >= 6.0)

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define COUNTRYCHANGED (@"CountryChanged")
#define CITYSELECTED (@"CitySelected")
#define QUESTIONSENDSUCCESS (@"QuestionSendSuccess")
#define ANSWERSENDSUCCESS (@"AnswerSendSuccess")

#endif /* macro_h */
