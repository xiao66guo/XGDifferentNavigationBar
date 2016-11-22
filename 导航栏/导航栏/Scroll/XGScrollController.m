//
//  XGScrollController.m
//  导航栏
//
//  Created by 小果 on 16/9/11.
//  Copyright © 2016年 小果. All rights reserved.
//

#import "XGScrollController.h"
#import "XGScrollModel.h"
#import "XGScrollCell.h"
@interface XGScrollController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collView;

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation XGScrollController
-(NSArray *)dataList{
    if (nil == _dataList){
        
        _dataList = [XGScrollModel arryWithContents];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createCollectionView];
    
    [self createPageControl];
}

#pragma mark - 创建分页符
-(void)createPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.dataList.count;
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.pageIndicatorTintColor = [UIColor greenColor];
    pageControl.frame = CGRectMake((ScreenW - 160) * 0.5, CGRectGetMaxY(self.collView.frame) - 50, 160, 20);
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark - 创建CollectionView
-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenW, ScreenH - 64);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:layout];
    collView.backgroundColor = [UIColor magentaColor];
    self.collView = collView;
    collView.dataSource = self;
    collView.delegate = self;
    collView.showsHorizontalScrollIndicator = NO;
    collView.pagingEnabled = YES;
    [collView registerClass:[XGScrollCell class] forCellWithReuseIdentifier:XGCellIdentifier];
    [self.view addSubview:collView];
    
    [collView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:XGMaxSections / 2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    // 添加定时器
    [self addTimer];
    
}

#pragma mark - 添加定时器
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    // 如果用户在主线程做其他操作的话，定时器不会执行，将其加到这里可以让用户在执行其他操作时，分出一些时间给定时器
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

#pragma mark - 移除定时器
-(void)removeTimer{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 重置
-(NSIndexPath *)resetIndexPath{
    // 1、计算当前正展示的位置
    NSIndexPath *currentIndexPath = [[self.collView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间的那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:XGMaxSections / 2];
    [self.collView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return currentIndexPathReset;
}

#pragma mark - 下一页
-(void)nextPage{
//    // 1、计算当前正展示的位置
//    NSIndexPath *currentIndexPath = [[self.collView indexPathsForVisibleItems] lastObject];
//    
//    // 马上显示回最中间的那组的数据
//    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:XGMaxSections / 2];
//    [self.collView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    // 3、当滚动到每一组的最后一组的最后一个时，会报错出现数组越界的错误，所以要进行判断
    if (nextItem == self.dataList.count){
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 4、通过动画滚动到下一个位置
    [self.collView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return XGMaxSections;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XGScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XGCellIdentifier forIndexPath:indexPath];
    
    cell.model = self.dataList[indexPath.item];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
/**
 *  当用户停止拖拽的时候调用
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
/**
 *  当scorllView减速完毕的时候调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self resetIndexPath];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.dataList.count;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self removeTimer];
}
@end
