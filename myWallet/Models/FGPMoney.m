//
//  FGPMoney.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPBroker.h"
#import "FGPMoney.h"
#import "NSObject+GNUStepAddons.h"

@interface FGPMoney()

@property (nonatomic, strong) NSNumber *amount;

@end

@implementation FGPMoney

+ (id) dollarWithAmount: (NSInteger) amount {
    return [[FGPMoney alloc] initWithAmount:amount currency:@"USD"];
}

+ (id) euroWithAmount: (NSInteger) amount {
    return [[FGPMoney alloc] initWithAmount:amount currency:@"EUR"];
}

+ (id) poundWithAmount: (NSInteger) amount {
    return [[FGPMoney alloc] initWithAmount:amount currency:@"GBP"];
}

+ (id) rupeeWithAmount: (NSInteger) amount {
    return [[FGPMoney alloc] initWithAmount:amount currency:@"INR"];
}

- (id) initWithAmount:(NSInteger) amount currency: (NSString *) currency {
    if (self = [super init]) {
        _amount = @(amount);
        _currency = currency;
    }
    return self;
}

- (id<FGPMoney>) times: (NSInteger) multiplier {
    
    FGPMoney *newMoney = [[FGPMoney alloc]
                          initWithAmount:[self.amount integerValue] * multiplier currency:self.currency] ;
    
    return newMoney;
    
}

- (id<FGPMoney>) plus: (FGPMoney *) other {
    
    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    
    FGPMoney *total = [[FGPMoney alloc] initWithAmount:totalAmount
                                              currency:self.currency];
    
    return total;
    
}

- (id<FGPMoney>) reduceToCurrency: (NSString*) currency
                       withBroker: (FGPBroker*) broker {
    
    FGPMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency
                                                           toCurrency:currency]] doubleValue];
    
    if ([self.currency isEqual:currency]) {
        result = self;
    }else if (rate == 0){
        [NSException raise:@"NoConversionRateException"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];
        
    }else{
        
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[FGPMoney alloc] initWithAmount:newAmount
                                         currency:currency];
        
    }
    
    return result;
    
}

#pragma mark - Overwritten

- (NSString *) description {
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
}

- (BOOL) isEqual: (id) object {
    if ([self.currency isEqual: [object currency]]) {
        return [self.amount isEqual: [object amount]];
    }else{
        return NO;
    }
}

- (NSUInteger) hash {
    return [self.amount integerValue];
}

@end
