//
//  FGPBroker.h
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPMoney.h"
#import <Foundation/Foundation.h>

@interface FGPBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

- (FGPMoney*) reduce: (id<FGPMoney>) money toCurrency: (NSString *) currency;

- (void) addRate: (NSInteger) rate
    fromCurrency: (NSString*) fromCurrency
      toCurrency: (NSString*) toCurrency;

- (NSString *) keyFromCurrency: (NSString *) fromCurrency
                    toCurrency: (NSString *) toCurrency;

@end
