//
//  FGPBroker.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPBroker.h"
#import "FGPMoney.h"

@implementation FGPBroker

- (id) init {
    if (self = [super init]) {
        _rates = [@{}mutableCopy];
    }
    return self;
}

- (FGPMoney*) reduce: (id<FGPMoney>) money
          toCurrency: (NSString *) currency {
    
    // double dispatch
    return [money reduceToCurrency:currency
                        withBroker:self];
    
}

- (void) addRate: (NSInteger) rate
    fromCurrency: (NSString*) fromCurrency
      toCurrency: (NSString*) toCurrency {
    
    [self.rates setObject: @(rate)
                   forKey: [self keyFromCurrency: fromCurrency
                                      toCurrency: toCurrency]];
    
    NSNumber *invRate = @(1.0/rate);
    
    [self.rates setObject: invRate
                   forKey: [self keyFromCurrency: toCurrency
                                      toCurrency: fromCurrency]];
    
}


#pragma mark -  utils

- (NSString *) keyFromCurrency: (NSString *) fromCurrency
                    toCurrency: (NSString *) toCurrency {
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
}

@end
