//
//  HomeController.m
//  通用框架
//
//  Created by Jusive on 16/1/11.
//  Copyright © 2016年 Jusive. All rights reserved.
//

//#define KScreenBounds         [UIScreen mainScreen].bounds
//#define kScreenSize           [[UIScreen mainScreen] bounds].size
//#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
//#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
//#define kMorePageDistance  80   //打开左侧窗时，中视图(右视图)露出的宽度
//#define kMoreCenterX 30 //左侧初始偏移量
//#define maxY 60
//#define kMainPageCenter  CGPointMake(kScreenWidth + kScreenWidth  / 2.0 - kMorePageDistance, kScreenHeight / 2)  //打开左侧窗时，中视图中心点
//
//#define vCouldChangeDeckStateDistance  (kScreenWidth - kMorePageDistance) / 2.0  //滑动距离大于此数时，状态改变（关--》开，或者开--》关）

#import "HomeController.h"
#import "HomeTableViewCell.h"
#import "MainTableView.h"
#import "MoreViewController.h"
#import "UIView+setFrame.h"
@interface HomeController ()<UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGFloat _scalef;  //实时横向位移
}

@property (nonatomic,weak) MoreViewController *moreViewController;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic,weak) UIViewController *VC;
//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (nonatomic, assign) CGFloat speedf;
@property (nonatomic,assign) BOOL isDranging;
@property (nonatomic, assign) BOOL closed;
@end
static NSString *HomeCell = @"HomeCell";
@implementation HomeController
- (void)viewDidLoad {
//    self.speedf = 0.5;
//    self.closed = YES;//初始时侧滑窗关闭
    [super viewDidLoad];
    MainTableView *mainTableView = [MainTableView new];
    self.tableView = mainTableView;
    [mainTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:HomeCell];
    [self PanGestureRecognizer];
    
    
}
//注册滑动效果
-(void)PanGestureRecognizer{
    [self.view addObserver:self forKeyPath:@"Kframe" options:NSKeyValueObservingOptionNew context:nil];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    [self.panGestureRecognizer setCancelsTouchesInView:YES];
     self.panGestureRecognizer.delegate = self;
    self.moreViewController.view.hidden = YES;
    [self.view addSubview:self.moreViewController.view];
}
//响应滑动事件
-(void)PanGesture:(UIPanGestureRecognizer *)PanGRecognizer{
    MoreViewController *more = [MoreViewController new];
    more.view.frame = [UIScreen mainScreen].bounds;
    more.view.backgroundColor = [UIColor orangeColor];
    [self presentViewController:more animated:YES completion:^{
        
    }];
}
//    self.moreViewController.view = PanGRecognizer.view;
//  CGPoint point = [PanGRecognizer translationInView:self.view];
//    _scalef = (point.x *self.speedf + _scalef);
//    BOOL needMoveWihtPan = YES;
//    if (((self.view.x <= 0) && (_scalef <= 0)) ||((self.view.x >= (kScreenWidth - kMorePageDistance))&&(_scalef >= 0))){
//        //边界值管控
//        _scalef = 0;
//        needMoveWihtPan = NO;
//    }if (needMoveWihtPan && (PanGRecognizer.view.frame.origin.x >= 0)&&(PanGRecognizer.view.frame.origin.x <= (kScreenWidth - kMorePageDistance))) {
//        CGFloat recCenterX = PanGRecognizer.view.center.x + point.x * self.speedf;
//        if (recCenterX < kScreenWidth * 0.5 - 2) {
//            recCenterX = kScreenWidth * 0.5;
//        }
//        
//        CGFloat recCenterY = PanGRecognizer.view.center.y;
//        
//        PanGRecognizer.view.center = CGPointMake(recCenterX,recCenterY);
//    }
//    //手势结束后修正位置,超过约一半时向多出的一半偏移
//    if (PanGRecognizer.state == UIGestureRecognizerStateEnded) {
//        if (fabs(_scalef - 40) > vCouldChangeDeckStateDistance)
//        {
//            if (self.closed)
//            {
//                [self openLeftView];
//            }
//            else
//            {
//                [self closeLeftView];
//            }
//        }
//        else
//        {
//            if (self.closed)
//            {
//                [self closeLeftView];
//            }
//            else
//            {
//                [self openLeftView];
//            }
//        }
//        _scalef = 0;
//    }

//}


//#pragma mark - 修改视图位置
///**
// @brief 关闭左视图
// */
//- (void)closeLeftView
//{
//    [UIView beginAnimations:nil context:nil];
//    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//    self.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
//    self.closed = YES;
//    
//    self.moreViewController.view.center = CGPointMake(kMoreCenterX, kScreenHeight * 0.5);
//    
//    [UIView commitAnimations];
//}
//
///**
// @brief 打开左视图
// */
//- (void)openLeftView;
//{
//    [UIView beginAnimations:nil context:nil];
//    self.view.center = kMainPageCenter;
//    self.closed = NO;
//    
//    self.moreViewController.view.center = CGPointMake((kScreenWidth - kMorePageDistance) * 0.5, kScreenHeight);
//    self.moreViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//     [UIView commitAnimations];
//}
//    //时刻监听主视图的变化
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (self.view.frame.origin.x < 0) {
//        self.moreViewController.view.hidden = YES;
//    }else if(self.view.frame.origin.x > 0){
//        self.moreViewController.view.hidden = NO;
//    }
//}


////视图偏移
//- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
//    // 获取手指每偏移一点,Y轴需要偏移多少o
//    CGFloat offsetY = offsetX * maxY / screenW;
//    
//    // 获取缩放比例
//    CGFloat scale = (screenH - 2 * offsetY)/screenH;
//    
//    if (self.view.frame.origin.x < 0) {
//        scale = (screenH + 2 * offsetY)/screenH;
//    }
//    // 计算当前视图的frame
//    CGRect frame = self.view.frame;
//    frame.origin.x += offsetX;
//    frame.size.height = frame.size.height * scale;
//    frame.size.width = frame.size.width *scale;
//    frame.origin.y = (screenH - frame.size.height) * 0.5;
//    
//    return frame;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *VC = [[UIViewController alloc]init];
    VC.view.frame = [UIScreen mainScreen].bounds;
    VC.view.backgroundColor = [UIColor redColor];
    self.VC = VC;
     [self presentViewController:VC animated:YES completion:^{
     
     }];
}


@end
