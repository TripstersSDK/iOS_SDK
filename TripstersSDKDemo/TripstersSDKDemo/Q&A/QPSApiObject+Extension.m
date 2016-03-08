//
//  QPSCountry+Extension.m
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "QPSApiObject+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSArray+Extension.h"

@implementation QPSCountry (Extension)

+(instancetype)countryWithDictionary:(NSDictionary *)dictionary {
    QPSCountry *country = [[QPSCountry alloc] init];
    country.code = [dictionary stringForKey:@"country_code"];
    country.chineseName = [dictionary stringForKey:@"country_name_cn"];
    country.englishName = [dictionary stringForKey:@"country_name_en"];
    country.localName = [dictionary stringForKey:@"country_name_local"];
    country.level = [dictionary integerForKey:@"level"];
    country.picUrlString = [dictionary stringForKey:@"pic"];
    return country;
}

-(NSDictionary *)dictionary {
    NSMutableDictionary *countryDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [countryDic addValue:self.code forKey:@"country_code"];
    [countryDic addValue:self.chineseName forKey:@"country_name_cn"];
    [countryDic addValue:self.englishName forKey:@"country_name_en"];
    [countryDic addValue:self.localName forKey:@"country_name_local"];
    [countryDic setIntValue:self.level forKey:@"level"];
    [countryDic addValue:self.picUrlString forKey:@"pic"];
    return countryDic;
}

@end

@implementation QPSUser (Extension)

-(NSString *)identityString {
    if (self.identity == QPSUserIdentityMaster || self.identity == QPSUserIdentityService) {
        return [NSString stringWithFormat:@"%@达人",self.country];
    } else if (self.identity == QPSUserIdentityStar) {
        return @"旅行达人";
    } else {
        return @"旅行者";
    }
}

@end

@implementation QPSQuestion (Extension)

-(NSString *)citysString {
    NSMutableString *citysNameString = [NSMutableString string];
    if ([NSArray hasContent:self.citys]) {
        for (QPSCity *city in self.citys) {
            [citysNameString appendFormat:@"#%@#",city.chineseName];
        }
    }
    return citysNameString;
}

@end
