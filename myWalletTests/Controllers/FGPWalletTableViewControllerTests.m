//
//  FGPWalletTableViewControllerTests.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPBroker.h"
#import "FGPWallet.h"
#import "FGPWalletTableViewController.h"
#import <XCTest/XCTest.h>

@interface FGPWalletTableViewControllerTests : XCTestCase

@property (strong, nonatomic) FGPBroker *emptyBroker;
@property (strong, nonatomic) FGPWallet *wallet;
@property (strong, nonatomic) FGPWalletTableViewController *walletTableViewControler;

@end

@implementation FGPWalletTableViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyBroker = [FGPBroker new];
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    [self.emptyBroker addRate:3 fromCurrency:@"EUR" toCurrency:@"GBP"];
    
    self.wallet = [[[[[FGPWallet alloc] initWithAmount:1 currency:@"USD" broker:self.emptyBroker]
                       plus:[FGPMoney poundWithAmount:2]]
                        plus:[FGPMoney euroWithAmount:3]]
                        plus:[FGPMoney euroWithAmount:4]];
    
    self.walletTableViewControler = [[FGPWalletTableViewController alloc] initWithModel:self.wallet];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.wallet = nil;
    self.walletTableViewControler = nil;
    
}

- (void) testNumberOfSectionsIsEqualNumberOfCurrenciesPlusOne {
    
    NSUInteger currencies = [self.wallet currenciesCount] + 1;
    NSUInteger sections = [self.walletTableViewControler numberOfSectionsInTableView:self.walletTableViewControler.tableView];
    
    XCTAssertEqual(sections, currencies, @"Number of sections = (Number of currencies + 1)");
    
}

- (void) testNumberOfRowsForSectionIsEqualNumberOfMoneysForCurrencyPlusOne {
    
    NSUInteger sections = [self.walletTableViewControler numberOfSectionsInTableView:self.walletTableViewControler.tableView];
    
    for (NSUInteger index = 0; index < sections; index++) {
        NSUInteger numberOfMoneysForCurrency = [self.wallet moneysCountForSection: index];
        NSUInteger rows = [self.walletTableViewControler tableView:self.walletTableViewControler.tableView numberOfRowsInSection: index];
        
        XCTAssertEqual(rows, numberOfMoneysForCurrency + 1, @"Number of rows = (Moneys for currency + 1)");
    }
    
}

@end
