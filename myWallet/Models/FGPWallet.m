//
//  FGPWallet.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPWallet.h"
#import <UIKit/UIKit.h>

@interface FGPWallet()

@property (strong, nonatomic) FGPBroker *broker;
@property (nonatomic, readonly) NSArray *currencies;
@property (nonatomic, strong) NSMutableArray *moneys;

@end

@implementation FGPWallet

- (NSUInteger) moneysCount {
    return [self.moneys count];
}

- (NSUInteger) currenciesCount {
    return [self.currencies count];
}

- (NSArray *) currencies {
    NSMutableArray *currencies = [NSMutableArray array];
    for (FGPMoney *money in self.moneys) {
        if (![currencies containsObject:money.currency]) {
            [currencies addObject:money.currency];
        }
    }
    return currencies;
}

- (id) initWithAmount: (NSInteger) amount
             currency: (NSString *) currency
               broker: (FGPBroker *) broker {
    
    if (self = [super init]) {
        _moneys = [NSMutableArray arrayWithObject: [[FGPMoney alloc]initWithAmount:amount currency:currency]];
        _broker = broker;
    }
    
    return self;
}

- (id) initWithAmount: (NSInteger) amount currency: (NSString*) currency {
    return [self initWithAmount:amount currency:currency broker:nil];
}

- (id<FGPMoney>) plus: (FGPMoney*) money {
    
    [self.moneys addObject: money];
    return self;
    
}

- (id<FGPMoney>) times: (NSInteger) multiplier {
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity: self.moneys.count];
    
    for (FGPMoney *each in self.moneys) {
        FGPMoney *newMoney = [each times:multiplier];
        [newMoneys addObject: newMoney];
    }
    self.moneys = newMoneys;
    return self;
    
}


- (id<FGPMoney>) reduceToCurrency:(NSString*) currency
                      withBroker:(FGPBroker*) broker {
    
    FGPMoney *result = [[FGPMoney alloc] initWithAmount:0 currency:currency];
    
    for (FGPMoney *each in self.moneys) {
        result = [result plus:[each reduceToCurrency:currency withBroker:broker]];
    }
    
    return result;
    
}

- (NSString *) nameForSection: (NSUInteger) section {
    
    if (section >= [self.currencies count]) {
        return @"Total wallet";
    } else {
        return self.currencies[section];
    }
    
}

- (NSUInteger) moneysCountForSection: (NSUInteger) section {
    return [self moneysForSection:section].count;
}

- (NSArray *) moneysForSection: (NSUInteger) section {
    
    if (section >= [self.currencies count]) {
        
        return @[];
        
    } else {
        
        NSMutableArray *moneys = [NSMutableArray array];
        for (FGPMoney *money in self.moneys) {
            if (self.currencies[section] == money.currency) {
                [moneys addObject:money];
            }
        }
        return moneys;
        
    }
    
}

- (FGPMoney *) moneyForIndexPath: (NSIndexPath *) indexPath {
    
    return [self moneysForSection:indexPath.section][indexPath.row];
    
}

- (FGPMoney *) totalCurrencyForSection: (NSUInteger) section {
    
    FGPMoney *total = [[FGPMoney alloc] initWithAmount:0 currency:self.currencies[section]];
    
    for (FGPMoney *money in [self moneysForSection:section]) {
        total = [total plus:money];
    }
    
    return total;
    
}

- (FGPMoney *) totalWalletInCurrency: (NSString *) currency {
    
    FGPMoney *total = [[FGPMoney alloc] initWithAmount:0 currency:currency];
    
    for (FGPMoney *money in self.moneys) {
        total = [total plus:[money reduceToCurrency:currency withBroker:self.broker]];
    }
    
    return total;
    
}

@end
