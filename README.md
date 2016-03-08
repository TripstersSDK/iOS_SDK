# iOS_SDK
趣皮士开放平台iOS SDK

# 使用说明
1.配置SDK  
  1）将libTripstersSDK.a , QPSApi.h ,QPSApiObject.h 文件加入工程。

  2）工程中target->Other linker flags 添加 -ObjC  
  
  3）info.plist 中设置允许 http网络请求  

2.初始化SDK  
  1）程序启动时调用初始化函数
    <pre><code>
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //注册应用
        [QPSApi registerApp:@"beichen" withMode:QPSDataModeAll];
        return YES;
    }
    </code></pre>
 2）注册推送，调用QPSApi的接口处理推送  
    <pre><code>
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //注册应用
        [QPSApi registerApp:@"beichen" withMode:QPSDataModeAll];
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
    </code></pre>  
3.接口的使用  
    1）账号登录和退出接口  
    被接入应用应该在账号登录和退出接口中 加入QPSApi的登录和退出 让趣皮士SDK的账号状态与接入应用账号状态一致  
    <pre><code>
    [QPSApi loginWithReq:req success:^(QPSAuthReq *req) {
        //登录成功
    } failure:^(QPSAuthReq *req, NSError *error) {
        //登录失败
    }];  
    [QPSApi logoutWithSuccessHandler:^{
        //登出成功
    } failure:^(NSError *error) {
        //登出失败    
    }];
    </code></pre>  
    2）利用QPSApi.h中的其它接口，获取数据
   

