//
//  FGPWalletTests.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPBroker.h"
#import "FGPMoney.h"
#import "FGPWallet.h"
#import <XCTest/XCTest.h>

@interface FGPWalletTests : XCTestCase

@property (strong, nonatomic) FGPBroker *emptyBroker;
@property (strong, nonatomic) FGPWallet *wallet;

@end

@implementation FGPWalletTests

- (void) setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    
    self.emptyBroker = [FGPBroker new];
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    [self.emptyBroker addRate:3 fromCurrency:@"EUR" toCurrency:@"GBP"];
    
    self.wallet = [[[[[FGPWallet alloc] initWithAmount:1 currency:@"USD" broker:self.emptyBroker]
                        plus:[FGPMoney poundWithAmount:2]]
                         plus:[FGPMoney euroWithAmount:3]]
                         plus:[FGPMoney euroWithAmount:4]];
    
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.wallet = nil;
}


- (void) testAdditionWithReduction {
    
    FGPWallet *wallet = [[FGPWallet alloc] initWithAmount:40 currency:@"EUR"];
    [wallet plus: [FGPMoney dollarWithAmount:20]];
    
    FGPMoney *reduced = [self.emptyBroker reduce:wallet toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [FGPMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
    
}

- (void) testTotalUSD {
    
    FGPMoney *total = [self.wallet totalCurrencyForSection:0];
    FGPMoney *one = [FGPMoney dollarWithAmount:1];
    
    XCTAssertEqualObjects(total, one, @"Total USD = 1 USD");
    
}

- (void) testTotalWalletReducedToEUR {
    
    FGPMoney *total = [self.wallet totalWalletInCurrency:@"EUR"];
    FGPMoney *seven = [FGPMoney euroWithAmount:7];
    
    XCTAssertEqualObjects(total, seven, @"Total Wallet = 7 EUR");
    
}

@end
