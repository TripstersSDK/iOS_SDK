//
//  TripstersSDKDemoTests.m
//  TripstersSDKDemoTests
//
//  Created by TimTiger on 16/2/19.
//  Copyright © 2016年 Tripsters. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QPSApi.h"

@interface TripstersSDKDemoTests : XCTestCase

@end

@implementation TripstersSDKDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
     [QPSApi registerApp:@"test"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    QPSCountryListReq *req = [[QPSCountryListReq alloc] init];
    [QPSApi getCountryListWithBaseReq:req success:^(QPSCountryListReq *req, NSArray *responseObject) {
        
    } failure:^(QPSCountryListReq *req, NSError *error) {
        
    }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
