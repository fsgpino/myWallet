//
//  FGPBrokerTests.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPBroker.h"
#import "FGPMoney.h"
#import <XCTest/XCTest.h>

@interface FGPBrokerTests : XCTestCase

@property (nonatomic, strong) FGPBroker *emptyBroker;
@property (nonatomic, strong) FGPMoney *oneDollar;

@end

@implementation FGPBrokerTests

- (void) setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    
    self.emptyBroker = [FGPBroker new];
    self.oneDollar = [FGPMoney dollarWithAmount:1];
    
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.oneDollar = nil;
    
}

-(void) testSimpleReduction{
    
    FGPMoney *sum = [[FGPMoney dollarWithAmount:5] plus:[FGPMoney dollarWithAmount:5]];
    FGPMoney *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
    
}

-(void) testReduction{
    
    [self.emptyBroker addRate: 2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    FGPMoney *dollars = [FGPMoney dollarWithAmount:10];
    FGPMoney *euros = [FGPMoney euroWithAmount:5];
    FGPMoney *converted = [self.emptyBroker reduce:dollars
                                        toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
    
}


-(void) testThatNoRateRaisesException{
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar
                                  toCurrency:@"EUR"], @"No rates should cause exception");
    
}


-(void) testThatNilConversionDoesNotChangeMoney{
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar
                                                        toCurrency:@"USD"], @"A nil conversion should have no effect");
    
}

@end
