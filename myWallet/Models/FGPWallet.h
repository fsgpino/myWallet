//
//  FGPWallet.h
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPMoney.h"
#import <Foundation/Foundation.h>

@interface FGPWallet : NSObject<FGPMoney>

@property (nonatomic, readonly) NSUInteger moneysCount;
@property (nonatomic, readonly) NSUInteger currenciesCount;

- (id) initWithAmount: (NSInteger) amount
             currency: (NSString *) currency
               broker: (FGPBroker *) broker;

- (NSString *) nameForSection: (NSUInteger) section;
- (NSUInteger) moneysCountForSection: (NSUInteger) section;
- (FGPMoney *) moneyForIndexPath: (NSIndexPath *) indexPath;
- (FGPMoney *) totalCurrencyForSection: (NSUInteger) section;
- (FGPMoney *) totalWalletInCurrency: (NSString *) currency;

@end
