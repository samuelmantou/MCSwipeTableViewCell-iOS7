//
//  MCTableViewController.m
//  MCSwipeTableViewCell
//
//  Created by Ali Karagoz on 24/02/13.
//  Copyright (c) 2013 Mad Castle. All rights reserved.
//

#import "MCSwipeTableViewCell.h"
#import "MCTableViewController.h"

@interface MCTableViewController () <MCSwipeTableViewCellDelegate>

@property(nonatomic, assign) NSUInteger nbItems;

@end

@implementation MCTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        _nbItems = 2;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Swipe Table View";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(reload:)];

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _nbItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    [cell setDelegate:self];
//    [cell setFirstStateIconName:@"check.png"
//                     firstColor:[UIColor colorWithRed:85.0 / 255.0 green:213.0 / 255.0 blue:80.0 / 255.0 alpha:1.0]
//            secondStateIconName:@"cross.png"
//                    secondColor:[UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0]
//                  thirdIconName:@"clock.png"
//                     thirdColor:[UIColor colorWithRed:254.0 / 255.0 green:217.0 / 255.0 blue:56.0 / 255.0 alpha:1.0]
//                 fourthIconName:@"list.png"
//                    fourthColor:[UIColor colorWithRed:206.0 / 255.0 green:149.0 / 255.0 blue:98.0 / 255.0 alpha:1.0]];
    [cell setRightNames:@[@"黑名单"] rightColors:@[[UIColor blackColor]]];

    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];

    if (indexPath.row % 2) {
        [cell.textLabel setText:@"Switch Mode Cell"];
        [cell.detailTextLabel setText:@"Swipe to switch"];
        [cell setMode:MCSwipeTableViewCellModeSwitch];
    }
    else {
        [cell.textLabel setText:@"Exit Mode Cell"];
        [cell.detailTextLabel setText:@"Swipe to delete"];
        [cell setMode:MCSwipeTableViewCellModeExit];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MCTableViewController *tableViewController = [[MCTableViewController alloc] init];
    [self.navigationController pushViewController:tableViewController animated:YES];
}

#pragma mark - MCSwipeTableViewCellDelegate

- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didTriggerState:(MCSwipeTableViewCellState)state withMode:(MCSwipeTableViewCellMode)mode {
    NSLog(@"IndexPath : %@ - MCSwipeTableViewCellState : %d - MCSwipeTableViewCellMode : %d", [self.tableView indexPathForCell:cell], state, mode);

    if (mode == MCSwipeTableViewCellModeExit) {
        _nbItems--;
        [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - 

- (void)reload:(id)sender {
    _nbItems++;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
