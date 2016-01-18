//
//  MainTableViewController.m
//  通用框架
//
//  Created by Jusive on 16/1/12.
//  Copyright © 2016年 Jusive. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableView.h"
#import "MoreViewController.h"
@interface MainTableViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) MoreViewController *moreViewController;
//@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@end

static NSString *reuseIdentifierCell = @"reuseIdentifierCell";

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainTableView *tabview = [[MainTableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = tabview;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemsButton)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tabbar_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemButton)];
    self.navigationItem.rightBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem = rightItem;
    MoreViewController *moreViewController = [MoreViewController new];
    self.moreViewController = moreViewController;
    [self addChildViewController:self.moreViewController];
//    [self panGestureRecognizer];
}
-(void)leftItemsButton{
    
}
-(void)rightItemButton{
   
}

@end
