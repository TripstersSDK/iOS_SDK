//
//  QPSApi.h
//  libTripstersSDK
//
//  Created by TimTiger on 16/2/15.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPSApiObject.h"

/*! @brief 趣皮士Api接口函数类
 *
 * 该类封装了趣皮士终端SDK的所有接口
 */
@interface QPSApi : NSObject

/*!
 *  @brief 应用注册 ,应用启动后调用
 *
 *  @attention 请保证在主线程中调用此函数
 * @param
 *     launchOptions - App 启动时系统提供的参数，表明了 App 是通过什么方式启动的
 *  @param appid 开放平台应用id
 *  @param mode 数据获取模式 QPSDataModeOwn ，QPSDataModeAll
 *  @param debug 调试时请设置YES, 发布时应用设置NO
 *
 */
+(BOOL)registerApp:(NSDictionary *)launchOptions appId:(NSString *)appid withMode:(QPSDataMode *)mode isDebug:(BOOL)debug;

/*!
 *  用户认证
 *  接入平台需要传入一些用户必要信息,获得使用提问和回复功能的授权
 *  在接入平台的登陆操作中使用
 *
 *  @param req     请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)loginWithReq:(QPSAuthReq *)req success:(void (^)(QPSAuthReq *req))success failure:(void (^)(QPSAuthReq *req,NSError *error))failure;

/*!
 *  取消授权
 *  在接入平台的退出登陆操作中使用
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)logoutWithSuccessHandler:(void (^)())success failure:(void (^)(NSError *error))failure;

#pragma mark - Notification
/*!
 * 注册 device token，只有在注册deviceToken后才可以推送
 *
 * @param deviceToken - 通过 AppDelegate 中的 didRegisterForRemoteNotificationsWithDeviceToken 回调获取
 */
+(void)registerDeviceToken:(NSData *)deviceToken;

/*!
 *  处理推送消息
 *
 *  @param userinfo - 通过 AppDelegate 中的 didReceiveRemoteNotification 回调获取
 */
+(void)handleNotification:(NSDictionary *)userinfo;

#pragma mark - Q&A
/*!
 *  获取国家列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSCountry组成的数组
 *  @param failure 失败回调
 */
+(void)getCountryListWithBaseReq:(QPSCountryListReq *)req success:(void (^)(QPSCountryListReq *req,NSArray* responseObject))success failure:(void (^)(QPSCountryListReq *req,NSError *error))failure;

/*!
 *  获取城市列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSCity组成的数组
 *  @param failure 失败回调
 */
+(void)getCityListWithCityReq:(QPSCityListReq *)req success:(void (^)(QPSCityListReq *req,NSArray* responseObject))success failure:(void (^)(QPSCityListReq *req,NSError *error))failure;

/*!
 *  获取问题列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSQuestion组成的数组
 *  @param failure 失败回调
 */
+(void)getQuestionListWithReq:(QPSQuestionListReq *)req success:(void (^)(QPSQuestionListReq *req,NSArray* responseObject))success failure:(void (^)(QPSQuestionListReq *req,NSError *error))failure;

/*!
 *  获取回答列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSAnswer组成的数组
 *  @param failure 失败回调
 */
+(void)getAnswerListWithReq:(QPSAnswerListReq *)req success:(void (^)(QPSAnswerListReq *req,NSArray* responseObject))success failure:(void (^)(QPSAnswerListReq *req,NSError *error))failure;

/*!
 *  提交问题
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回问题ID
 *  @param failure 失败回调
 */
+(void)sendQuestionWithReq:(QPSSendQuestionReq *)req success:(void (^)(QPSSendQuestionReq *req,NSString *questionID))success failure:(void (^)(QPSSendQuestionReq *req,NSError *error))failure;

/*!
 *  提交回答
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回回答ID
 *  @param failure 失败回调
 */
+(void)sendAnswerWithReq:(QPSSendAnswerReq *)req success:(void (^)(QPSSendAnswerReq *req,NSString *answerID))success failure:(void (^)(QPSSendAnswerReq *req,NSError *error))failure;

/*!
 *  给某个用户一条回答
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回回答ID
 *  @param failure 失败回调
 */
+(void)sendReAnswerWithReq:(QPSSendReAnswerReq *)req success:(void (^)(QPSSendReAnswerReq *req,NSString *answerID))success failure:(void (^)(QPSSendReAnswerReq *req,NSError *error))failure;

/*!
 *  获取问题详细信息
 *
 *  @param req     请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getQuestionDetailWithReq:(QPSQuestionDetailReq *)req success:(void (^)(QPSQuestionDetailReq *req,QPSQuestion *question))success failure:(void (^)(QPSQuestionDetailReq *req,NSError *error))failure;

#pragma mark - Account

/*!
 *  获取当前用户的信息
 *
 *  @return QPSUser
 */
+(QPSUser *)getUserInfo;

/*!
 *  获取用户回答列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSAnswer数组
 *  @param failure 失败回调
 */
+(void)getUserAnswerListWithReq:(QPSUserAnswerListReq *)req success:(void (^)(QPSUserAnswerListReq *req,NSArray *responseObject))success failure:(void (^)(QPSUserAnswerListReq *req,NSError *error))failure;

/*!
 *  获取用户问题列表
 *
 *  @param req     请求参数
 *  @param success 成功回调 返回QPSQuestion数组
 *  @param failure 失败回调
 */
+(void)getUserQuestionListWithReq:(QPSUserQuestionListReq *)req success:(void (^)(QPSUserQuestionListReq *req,NSArray *responseObject))success failure:(void (^)(QPSUserQuestionListReq *req,NSError *error))failure;

/*!
 *  获取用户收到的回答列表
 *
 *  @param req     请求参数
 *  @param success 成功回调, 返回QPSAnswer数组
 *  @param failure 失败回调
 */
+(void)getUserReceivedAnswerListWithReq:(QPSUserReceivedAnswerListReq *)req success:(void (^)(QPSUserReceivedAnswerListReq *req,NSArray *responseObject))success failure:(void (^)(QPSUserReceivedAnswerListReq *req,NSError *error))failure;

@end
