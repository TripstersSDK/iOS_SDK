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

