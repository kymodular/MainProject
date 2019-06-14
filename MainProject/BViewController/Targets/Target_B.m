//
//  Target_B.m
//  MainProject
//
//  Created by kyleboy on 2019/6/14.
//  Copyright © 2019 kyleboy. All rights reserved.
//

#import "Target_B.h"
#import "BViewController.h"

@implementation Target_B

- (UIViewController *)Action_viewController:(NSDictionary *)params
{
    NSString *contentText = params[@"contentText"];
    BViewController *viewController = [[BViewController alloc] initWithContentText:contentText];
    return viewController;
}
    
@end
