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

