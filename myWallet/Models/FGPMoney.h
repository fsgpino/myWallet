//
//  FGPMoney.h
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FGPBroker;
@class FGPMoney;

@protocol FGPMoney <NSObject>

- (id)initWithAmount: (NSInteger) amount
            currency: (NSString *) currency;

- (id<FGPMoney>) times: (NSInteger) multiplier;

- (id<FGPMoney>) plus: (FGPMoney *) other;

- (id<FGPMoney>) reduceToCurrency: (NSString*) currency
                       withBroker: (FGPBroker*) broker;

@end


@interface FGPMoney : NSObject<FGPMoney>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

+ (id) dollarWithAmount: (NSInteger) amount;
+ (id) euroWithAmount: (NSInteger) amount;
+ (id) poundWithAmount: (NSInteger) amount;
+ (id) rupeeWithAmount: (NSInteger) amount;

@end
