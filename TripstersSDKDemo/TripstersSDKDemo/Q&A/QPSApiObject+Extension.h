//
//  QPSCountry+Extension.h
//  TripstersSDKDemo
//
//  Created by TimTiger on 16/3/1.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import "QPSApiObject.h"

#define SelectCountry (@"SelectCountry")

@interface QPSCountry (Extension)

+(instancetype)countryWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionary;

@end

@interface QPSUser (Extension)

-(NSString *)identityString;

@end

@interface QPSQuestion (Extension)

-(NSString *)citysString;

@end
