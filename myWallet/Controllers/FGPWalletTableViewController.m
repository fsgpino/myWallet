//
//  FGPWalletTableViewController.m
//  myWallet
//
//  Created by Francisco Gómez Pino on 22/7/16.
//  Copyright © 2016 Francisco Gómez Pino. All rights reserved.
//

#import "FGPWallet.h"
#import "FGPWalletTableViewController.h"

@interface FGPWalletTableViewController ()

@property (strong, nonatomic) FGPWallet *model;

@end

@implementation FGPWalletTableViewController

- (id) initWithModel: (FGPWallet *) model {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"myWallet";
    self.tableView.allowsSelection = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.model currenciesCount] + 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.model nameForSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model moneysCountForSection:section] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@CELL_ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@CELL_ID];
    }
    
    if (indexPath.row == [self.model moneysCountForSection:indexPath.section] && (indexPath.section != [self.model currenciesCount]) ) {
        cell.textLabel.text = [self.model totalCurrencyForSection:indexPath.section].amount.stringValue;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Total %@",[self.model nameForSection:indexPath.section]];
        cell.backgroundColor = [[UIColor alloc] initWithRed:0 green:1 blue:0 alpha:0.1];
    } else if (indexPath.section == [self.model currenciesCount]) {
        cell.textLabel.text = [self.model totalWalletInCurrency:@TOTAL_CURRENCY].amount.stringValue;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Total wallet in %s", TOTAL_CURRENCY];
        cell.backgroundColor = [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:0.1];
    } else {
        FGPMoney *money = [self.model moneyForIndexPath:indexPath];
        cell.textLabel.text = money.amount.stringValue;
        cell.detailTextLabel.text = money.currency;
        cell.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1];
    }
    
    return cell;
    
}

@end
