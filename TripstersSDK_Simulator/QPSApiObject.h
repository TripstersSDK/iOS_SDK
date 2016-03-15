//
//  TripstersObject.h
//  libTripstersSDK
//
//  Created by TimTiger on 16/2/17.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CLPlacemark;

/*!
 *  国家级别
 */
typedef NS_ENUM(NSInteger,QPSCountryLevel) {
    QPSCountryLevelHot = 1,         /**<  热门    */
    QPSCountryLevelNormal = 2,  /**<  普通    */
};

/*!
 *  城市的级别
 */
typedef NS_ENUM(NSInteger,QPSCityLevel) {
    QPSCityLevelHot = 1,        /**<  热门    */
    QPSCityLevelNormal = 2,  /**<  普通    */
};

/* 有新的回复，通知 */
FOUNDATION_EXPORT NSString *const NewAnswerRecivedNotification NS_AVAILABLE_IOS(6_0);

/*! 数据模式 */
typedef NSString QPSDataMode NS_AVAILABLE_IOS(6_0);
/*!  1.只返回自身应用生产的问题  */
FOUNDATION_EXPORT NSString *const QPSDataModeOwn    NS_AVAILABLE_IOS(6_0);
/*!  2.返回总的问题  */
FOUNDATION_EXPORT NSString *const QPSDataModeAll     NS_AVAILABLE_IOS(6_0);

/*! 用户标识  依次是：普通用户，达人，趣皮士客服，优秀用户 */
typedef NSString QPSUserIdentity NS_AVAILABLE_IOS(6_0);;
FOUNDATION_EXPORT NSString *const QPSUserIdentityNormal NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserIdentityMaster NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserIdentityService NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserIdentityStar      NS_AVAILABLE_IOS(6_0);

/*! 性别：男，女，未知 */
typedef NSString QPSUserGender NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserGenderMale        NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserGenderFemale     NS_AVAILABLE_IOS(6_0);
FOUNDATION_EXPORT NSString *const QPSUserGenderUnknown  NS_AVAILABLE_IOS(6_0);

#pragma mark - 数据模型类

/*!
 *  数据模型基类
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSBaseObject: NSObject
@property (nonatomic,getter=isSelected) BOOL selected; //是否被选中
@end

/*!
 *  图片
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSPicInfo : QPSBaseObject
/*! 高质量图片地址 */
@property (nonatomic,copy) NSString *picUrlString;
/*! 低质量图片地址 */
@property (nonatomic,copy) NSString *picSmallUrlString;
/*! 高质量图片高宽 */
@property (nonatomic,readwrite) CGFloat picHeight;
@property (nonatomic,readwrite) CGFloat picWidth;
/*! 低质量图片高宽 */
@property (nonatomic,readwrite) CGFloat picSmallHeight;
@property (nonatomic,readwrite) CGFloat picSmallWidth;
@end

/*!
 *   国家
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSCountry : QPSBaseObject
/** 国家代码，具有唯一性 */
@property (nonatomic,copy) NSString *code;
/** 国家图片 */
@property (nonatomic,copy) NSString *picUrlString;
/** 该国家的中文名 */
@property (nonatomic,copy) NSString *chineseName;
/** 该国家的英文名 */
@property (nonatomic,copy) NSString *englishName;
/** 该国家在当地的本地名称 */
@property (nonatomic,copy) NSString *localName;
/** 该国家的级别 */
@property (nonatomic,readwrite) QPSCountryLevel level;

/** 是否是热门国家 */
- (BOOL)isHot;

@end

/*!
 *  城市
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSCity : QPSBaseObject
/** 城市id ,具有唯一性 */
@property (nonatomic,copy) NSString *cityID;
/** 城市所属国家代码 */
@property (nonatomic,copy) NSString *countryCode;
/** 该城市的中文名 */
@property (nonatomic,copy) NSString *chineseName;
/** 该城市的英文名 */
@property (nonatomic,copy) NSString *englishName;
/** 该城市在当地的本地名称 */
@property (nonatomic,copy) NSString *localName;
/** 城市级别 */
@property (nonatomic,readwrite) QPSCityLevel level;

/**  是否是热门城市 */
- (BOOL)isHot;

@end

/*!
 *  用户
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSUser : QPSBaseObject
/** 用户id，昵称，头像，身份，性别 ,国籍 */
@property (nonatomic,copy) NSString *userID;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) QPSUserIdentity *identity;
@property (nonatomic,copy) QPSUserGender *gender;
@property (nullable,nonatomic,copy) NSString *country;
/** 是否是接入平台自己的用户 */
@property (nonatomic,readwrite) BOOL isOwn;
/** 第三方接入平台 自身的用户id */
@property (nullable,nonatomic,copy) NSString  *openid;
/** 用户常住地 */
@property (nullable,nonatomic,copy) NSString *location;

@end

/*!
 *  回答
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSAnswer : QPSBaseObject
/** 回答id ,所属问题id, 回答内容，回答时间*/
@property (nonatomic,copy) NSString *answerID;
@property (nonatomic,copy) NSString *questionID;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *created;
/** 回答者信息 */
@property (nonatomic,strong) QPSUser *answerer;
/** 回答所带图片*/
@property (nullable,nonatomic,strong) QPSPicInfo *picInfo;
@end

/*!
 *  问题
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSQuestion : QPSBaseObject
/** 问题id ,内容，回答数，创建时间(时间戳)  */
@property (nonatomic,copy) NSString *questionID;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *answer_num;
@property (nonatomic,copy) NSString *created;
/** 提问者信息 */
@property (nonatomic,strong) QPSUser *asker;
/** 问题所属国家 */
@property (nonatomic,strong) QPSCountry *country;
/** 提问上传的经纬度信息 */
@property (nullable,nonatomic,copy) NSString *lat;
@property (nullable,nonatomic,copy) NSString *lng;
/** 提问上传的 由经纬度解析的位置信息 */
@property (nullable,nonatomic,copy) NSString *address;
/** 提问时所选的要推送的城市 */
@property (nullable,nonatomic,copy) NSArray *citys;  //QPSCity array
/** 提问时所提交的图片 */
@property (nullable,nonatomic,strong) QPSPicInfo *picInfo;

@end

#pragma mark - 接口请求模型
#warning 所有请求中标识了nullable的 为可选参数
/*!
 *  该类为所有请求的基类, 所有请求中标识了nullable为可选参数
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSBaseReq: NSObject
@property (nonatomic,readwrite) NSInteger page; //页号,默认1
@property (nonatomic,readwrite) NSInteger pageSize; //页大小,默认20
@end

/*!
 *  获取授权
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSAuthReq: QPSBaseReq
/** 第三方平台自身识别自己用户的唯一ID  */
@property (nonatomic,copy) NSString *openid;
/** 头像，昵称，性别 */
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) QPSUserGender *gender;
/** 用户常住地 */
@property (nullable,nonatomic,copy) NSString *location;
@end

/*!
 *  获取国家列表请求
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSCountryListReq: QPSBaseReq
@end

/*!
 *  获取该国家的城市列表请求
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSCityListReq: QPSBaseReq
/** 获取该国家的城市列表  */
@property (nonatomic,strong) QPSCountry *country;
@end

/*!
 *  获取该国家的问题列表请求
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSQuestionListReq : QPSBaseReq
@property (nonatomic,strong) QPSCountry *country;
@end

/*!
 *  获取回复列表请求
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSAnswerListReq : QPSBaseReq
/** 获取该问题的回复列表  */
@property (nonatomic,strong) QPSQuestion *question;
@end

/*!
 *  提交问题
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSSendQuestionReq: QPSBaseReq
/** 问题文字内容 */
@property (nonatomic,copy) NSString *text;
/** 问题图片 最大不超过1M */
@property (nullable,nonatomic,copy) NSData *imageData;
/** 问题的位置信息 */
@property (nullable,nonatomic,strong) CLPlacemark *placeMark;
/** 问题所属国家 */
@property (nonatomic,strong) QPSCountry *country;
/** 与问题相关的城市，最多2个 （QPSCity组成的数组） */
@property (nonatomic,strong) NSArray *citys;

@end

/*!
 *  回答问题
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSSendAnswerReq: QPSBaseReq
/** 回答文字内容 */
@property (nonatomic,copy) NSString *text;
/** 回答图片 最大不超过1M */
@property (nullable,nonatomic,copy) NSData *imageData;
/** 所回答的问题 */
@property (nonatomic,strong) QPSQuestion *question;
@end

/*!
 *  对某人的答案 进行回复
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSSendReAnswerReq: QPSSendAnswerReq
/** 接收者 */
@property (nonatomic,strong) QPSUser *recipient;
@end

/*!
 *  获取问题详细信息
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSQuestionDetailReq: QPSBaseReq
/** 问题 */
@property (nonatomic,strong) QPSQuestion *question;
@end

/*!
 *  用户问题列表
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSUserQuestionListReq : QPSBaseReq
/** 用户信息 ，此参数不传 则返回当前用户的问题列表*/
@property (nullable,nonatomic,strong) QPSUser *user;
@end

/*!
 *  用户回答列表
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSUserAnswerListReq : QPSBaseReq
/** 用户信息 ，此参数不传 则返回当前用户的回答列表*/
@property (nullable,nonatomic,strong) QPSUser *user;
@end

/*!
 *  用户收到的回答列表
 */
NS_AVAILABLE_IOS(6_0)
@interface QPSUserReceivedAnswerListReq : QPSBaseReq
@end

NS_ASSUME_NONNULL_END
