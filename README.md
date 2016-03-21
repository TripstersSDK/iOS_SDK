# iOS SDK

一个便于第三方应用使用趣皮士问答API的SDK  

TripstersSDK_Device：真机上可运行的SDK，发布应用时使用  
TripstersSDK_Simulator：模拟器和真机都可运行SDK， 调试时使用  
TripstersSDKDemo：demo工程  
TripstersSDK_ClassDoc：类文档

##iOS接入指南
注：本文为趣皮士SDK的新手使用教程，只涉及教授SDK的使用方法，默认读者已经熟悉XCode开发工具的基本使用方法，以及具有一定的编程知识基础等。  

###1.向趣皮士注册你的应用程序id  
请发送邮件到wendong.li@tripsters.cn 进行登记，邮件内容包括：  
公司名称：xxxx  
申请人姓名：xxxx    
联系电话：xxxx  
联系邮箱：xxxx  
iOS端 需要将开发推送证书和发布推送证书两个.pem文件添加成附件一并发送过来。  
趣皮士审核后会回复邮件将AppID发送过来,获得AppID后，可立即用于开发。

###2.下载趣皮士SDK文件  
SDK文件包括 libTripstersSDK.a，QPSApi.h，QPSApiObject.h 三个。  
请在GitHub下载最新SDK包  

###3.搭建开发环境
[1] 在XCode中建立你的工程。  
[2] 将SDK文件中包含的 libTripstersSDK.a，QPSApi.h，QPSApiObject.h 三个文件添加到你所建的工程中（如下图所示，建立了一个名为Test 的工程，并把以上三个文件添加到Test文件夹下）。  
(注：请使用xCode4.5及以上版本)  
![image](https://github.com/TripstersSDK/tripsters-open-source/blob/master/Picture/tripsters-ios-sdk-1.png?raw=true)

[3] 在Xcode中，选择你的工程设置项，选中“TARGETS”一栏，选择Build Setting，在Search Paths中添加 libTripstersSDK.a ，QPSApi.h，QPSApiObject.h 三个文件所在位置（如下图所示）。  
![image](https://github.com/TripstersSDK/tripsters-open-source/blob/master/Picture/tripsters-ios-sdk-2.png?raw=true)

[4] 在Xcode中，选择你的工程设置项，选中“TARGETS”一栏，在“Build Setting”标签栏的“Other linker flags“添加“-ObjC”（如下图所示）。  
![image](https://github.com/TripstersSDK/tripsters-open-source/blob/master/Picture/tripsters-ios-sdk-3.png?raw=true)

[5]Xcode7.0及其以上版本，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“Custom iOS Target Properties”中设置允许发送http请求（如下图所示）。  
![image](https://github.com/TripstersSDK/tripsters-open-source/blob/master/Picture/tripsters-ios-sdk-4.png?raw=true)

###4.在代码中使用SDK
[1] 要使你的程序启动后能使用趣皮士SDK，必须在代码中注册你的id。（如下代码所示，在 AppDelegate 的 didFinishLaunchingWithOptions 函数中向趣皮士注册id）。  
```objc
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //注册应用
        [QPSApi registerApp:launchOptions appId:@"test" dataMode:QPSDataModeAll pushMode:QPSPushModeDevelopment isDebug:YES];
        return YES;
    }
```

[2] 要使你的程序能收到趣皮士的推送，必须在代码中注册推送，并用趣皮士SDK接口上传推送Token  (如下代码所示)
```objc
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //注册应用
        [QPSApi registerApp:launchOptions appId:@"test" dataMode:QPSDataModeAll pushMode:QPSPushModeDevelopment isDebug:YES];
        //iOS8+ register APNS
        if (AVAILABLE_IOS8) {
            UIUserNotificationType notificationTypes = (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
            UIUserNotificationSettings *settings  = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        } else {
            UIRemoteNotificationType notificationTypes  = (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert);
            [application registerForRemoteNotificationTypes:notificationTypes];
        }
        return YES;
    }  

    - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
        [application registerForRemoteNotifications];
    }  

    - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
        [QPSApi registerDeviceToken:deviceToken];
    }  

    - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        [QPSApi handleNotification:userInfo];
    }
```

### 5.接口的使用  
[1] 趣皮士SDK的接口，都是通过构造一个请求体，发起请求获得数据。  
[2] 例如账号登录和退出接口，接入应用应该在账号登录和退出接口中 加入QPSApi的登录和退出 让趣皮士SDK的账号状态与接入应用账号状态一致  
```objc
    //1.假设接入应用调用自家登陆接口 获得了用户信息DemoUserInfo  
    DemoUserInfo *userInfo = [DemoAccountManager loginFunc];

    //2.使用用户信息调趣皮士接口，获取问答接口的授权  
    QPSAuthReq *req = [QPSAuthReq new];
    req.openid = userInfo.userID; //必填  /** 接入平台自身用户的唯一ID  */
    req.avatar = userInfo.avatar; //必填
    req.nickname = userInfo.nickname; //必填
    if ([userInfo.gender isEqualToString:@"m"]) {
        req.gender = QPSUserGenderMale; //必填
    } else {
        req.gender = QPSUserGenderFemale; //必填
    }
    req.location = userInfo.location; //可选

    [QPSApi loginWithReq:req success:^(QPSAuthReq *req,QPSUser *user) {
        //获得授权后，保存部分趣皮士返回的用户信息
        userInfo.country = user.country;
        userInfo.identity = user.identity;
        [DemoUserInfo saveUserInfo:userInfo];
    } failure:^(QPSAuthReq *req, NSError *error) {
        [self showNotificationWithText:error.localizedDescription];
    }];

    //3退出登陆，在接入应用调用自身退出登陆接口后，调用趣皮士SDK的退出登陆接口。  
    [QPSApi logoutWithSuccessHandler:^{
        //登出成功
    } failure:^(NSError *error) {
        //登出失败    
    }];
```

[3] 利用QPSApi.h中的其它接口，获取数据。具体使用请见demo
   

