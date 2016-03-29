//
//  ViewController.m
//  CCPBaseScrollView
//
//  Created by liqunfei on 16/3/29.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#define MAINSCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SIZE(a,b) CGSizeMake(a, b)
@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView1;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView2;
@property (nonatomic,strong) NSArray *colors;
@property (nonatomic,strong) NSMutableArray *Views;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildScrollView1];
    [self buildScrollView2];
}

//支持水平滚动
- (void)buildScrollView1 {
    //size的高度可以任意设置为小于等于scroll高度的值
    self.myScrollView1.contentSize = SIZE(4 * MAINSCREEN_SIZE.width, 0);
    //是否支持整页滚动
    self.myScrollView1.pagingEnabled = YES;
    //是否显示滚动条(水平)
    self.myScrollView1.showsHorizontalScrollIndicator = NO;
    for (UIView *obj in self.Views) {
        [self.myScrollView1 addSubview:obj];
        
    }
}

- (void)buildScrollView2 {
    self.myScrollView2.contentSize = SIZE(MAINSCREEN_SIZE.width, 0);
    //最小缩放
    self.myScrollView2.minimumZoomScale = 0.5;
    //最大缩放
    self.myScrollView2.maximumZoomScale = 1.5f;
    [self.myScrollView2 addSubview:self.Views[0]];
}

- (NSArray *)colors {
    if (!_colors) {
        _colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor greenColor],[UIColor grayColor]];
    }
    return _colors;
}

- (NSMutableArray *)Views {
    if (!_Views) {
         _Views = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * MAINSCREEN_SIZE.width, 0, MAINSCREEN_SIZE.width, 150)];
            view.backgroundColor = self.colors[i];
            [_Views addObject:view];
        }
    }
    return _Views;
}

#pragma mark -- UIScrollViewDelegate
/*
 此方法在scrollView滑动时会被调用多次，只要scrollView.contentOffset发生改变就会被调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

/*
 再一次拖动滑动中最后被调用，在
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView；
 之后
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

/*
 此方法在拖动结束后将要开始减速时被调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate");
}

/*此方法在手动滑动时不会调用，只有在
- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
- (void)scrollRectToVisible:(CGRect) animated:(BOOL)animated;
 调用后才调用
*/
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

/*
 此方法在开始减速时被调用,再一次拖动滑动中最先被调用
 */

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDecelerating");
}


/*
 当scale发生改变时，调用此方法，此方法会被调用多次
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidZoom");
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScrollToTop");
}

/*
 此方法在拖动开始时被调用，一次拖动抵用一次，未发生触控不会被调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}

/*
 此方法在scale开始时被调用，一次scale调用一次
 */
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"scrollViewWillBeginZooming");
}

/*
 特别注意这个方法，此方法可以获取Velocity可以用于判断滑动方向，tarContentOffset可以用于判断是否会已经滑动翻页
 具体实例请看：https://github.com/coolboy-ccp/CCPScrollWave
 希望有用的同学给个star
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"targetContentOffset");
}

/*
 zoom之后会被调用，可以用atScale得到zoom值从而进行进一步处理
 */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"atScale");
}

//此方法设置可以scale的view
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
   if (scrollView == self.myScrollView2) {
       NSLog(@"hahah");
       return self.Views[0];
    }
    return nil;
}

@end
