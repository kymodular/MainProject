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
    
    switch (indexPath.row) {
        case 0:
        {
        UIViewController *viewController = [[CTMediator sharedInstance] RNModule_viewController];
        [self.navigationController pushViewController:viewController animated:YES];
        }
        break;
        case 1:
        {
        UIViewController *viewController = [[CTMediator sharedInstance] A_aViewController];
        [self.navigationController pushViewController:viewController animated:YES];
        }
        break;
        case 2:
        {
        UIViewController *viewController = [[CTMediator sharedInstance] D_viewController];
        [self.navigationController pushViewController:viewController animated:YES];
        }
        break;
        default:
        break;
    }
}

#pragma mark - getters and setters
- (NSArray *)data {
    if (_data == nil) {
        NSURL *moduleDataUrl = [[NSBundle mainBundle] URLForResource:@"ModuleData" withExtension:@"plist"];
        NSDictionary *moduleDataDict = [NSDictionary dictionaryWithContentsOfURL:moduleDataUrl];
        if (moduleDataDict) {
            _data = [moduleDataDict objectForKey:@"modules"];
        } else {
            _data = @[];
        }
    }
    return _data;
}
@end
