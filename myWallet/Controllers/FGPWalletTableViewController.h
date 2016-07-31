//
//  FGPWalletTableViewController.h
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_ID "MoneyCell"
#define TOTAL_CURRENCY "EUR"

@interface FGPWalletTableViewController : UITableViewController

- (id) initWithModel: (FGPWallet *) model;

@end
