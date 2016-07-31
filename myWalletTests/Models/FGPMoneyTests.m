//
//  FGPMoneyTests.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPMoney.h"
#import <XCTest/XCTest.h>

@interface FGPMoneyTests : XCTestCase

@end

@implementation FGPMoneyTests

-(void) testCurrencies{
    
    XCTAssertEqualObjects(@"EUR", [[FGPMoney euroWithAmount:1] currency], @"The currency of euros should be EUR");
    XCTAssertEqualObjects(@"USD", [[FGPMoney dollarWithAmount:1] currency], @"The currency of $1 should be USD");
    
}

-(void)testMultiplication{
    
    FGPMoney *euro = [FGPMoney euroWithAmount:5];
    FGPMoney *ten = [FGPMoney euroWithAmount:10];
    FGPMoney *total = [euro times:2];
    
    XCTAssertEqualObjects(total, ten, @"€5 * 2 should be €10");
    
}

-(void) testEquality{
    
    FGPMoney *five = [FGPMoney euroWithAmount:5];
    FGPMoney *ten = [FGPMoney euroWithAmount:10];
    FGPMoney *total = [five times:2];
    
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal!");
    XCTAssertEqualObjects([FGPMoney dollarWithAmount:4], [[FGPMoney dollarWithAmount:2] times:2], @"Equivalent objects should be equal!");
    
}

-(void) testDifferentCurrencies{
    
    FGPMoney *euro = [FGPMoney euroWithAmount:1];
    FGPMoney *dollar = [FGPMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
    
}


-(void) testHash{
    
    FGPMoney *a = [FGPMoney euroWithAmount:2];
    FGPMoney *b = [FGPMoney euroWithAmount:2];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([[FGPMoney dollarWithAmount:1]hash], [[FGPMoney dollarWithAmount:1] hash], @"Equal objects must have same hash" );
    
}

-(void) testAmountStorage{
    
    FGPMoney *euro = [FGPMoney euroWithAmount:2];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the stored");
    XCTAssertEqual(2, [[[FGPMoney dollarWithAmount:2]performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the stored");
    
    #pragma clang diagnostic pop
    
}

-(void) testSimpleAddition{
    
    XCTAssertEqualObjects([[FGPMoney dollarWithAmount:5] plus:[FGPMoney dollarWithAmount:5]], [FGPMoney dollarWithAmount:10], @"$5 + $5 = $10");
    
}


-(void) testThatHashIsAmount{
    
    FGPMoney *one = [FGPMoney dollarWithAmount:1];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
    
}

-(void) testDescription{
    
    FGPMoney *one = [FGPMoney dollarWithAmount:1];
    NSString *desc = @"<FGPMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
    
}

@end
