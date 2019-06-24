//
//  ViewController.m
//  MainProject
//
//  Created by kyleboy on 2019/6/6.
//  Copyright © 2019 kyleboy. All rights reserved.
//

#import "ViewController.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "CTMediator+A.h"
#import "CTMediator.h"
#import "CTMediator+RNModule.h"
#import "CTMediator+D.h"

static NSString * const kCellId = @"cell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *pushAViewControllerButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
    
@property (strong, nonatomic) NSArray *data;
    
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *item = self.data[indexPath.row];
    cell.textLabel.text = item[@"name"];
    cell.detailTextLabel.text = item[@"description"];
    return cell;
}
    
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *viewController = nil;
    NSDictionary *item = self.data[indexPath.row];
    NSString *moduleName = item[@"moduleName"];
    if ([moduleName isEqualToString:@"RNModule"]) {
        viewController = [[CTMediator sharedInstance] RNModule_viewController];
    } else if ([moduleName isEqualToString:@"A"]){
        viewController = [[CTMediator sharedInstance] A_aViewController];
    } else if ([moduleName isEqualToString:@"D"]){
        viewController = [[CTMediator sharedInstance] D_viewController];
    } else {
        NSString *selecterNameStr = [NSString stringWithFormat:@"%@_viewControllerWithContentText:", item[@"moduleName"]];
        SEL selecter = NSSelectorFromString(selecterNameStr);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        viewController = [[CTMediator sharedInstance] performSelector:selecter withObject:item[@"name"]];
#pragma clang diagnostic pop
    }

    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
- (NSArray *)data {
    if (_data == nil) {
        NSURL *moduleDataUrl = [[NSBundle mainBundle] URLForResource:@"ModuleData" withExtension:@"plist"];
        NSArray *moduleDataArray = [NSArray arrayWithContentsOfURL:moduleDataUrl];
        if (moduleDataArray) {
            _data = moduleDataArray;
        } else {
            _data = @[];
        }
    }
    return _data;
}
@end
