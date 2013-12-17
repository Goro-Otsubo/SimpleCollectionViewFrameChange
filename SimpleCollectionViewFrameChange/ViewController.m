//
//  ViewController.m
//  SimpleCollectionViewFrameChange
//
//  Created by GoroOtsubo
//  Copyright (c) 2013 NEXT Co., Ltd.
//

#import "ViewController.h"
#import "MyCollectioinViewController.h"

@interface ViewController ()

@property(nonatomic)MyCollectioinViewController* collectionViewController;
@property(nonatomic) CGRect narrowFrame;
@property(nonatomic) CGRect wideFrame;
@property(nonatomic) BOOL narrowFrameFlag; //YES if uicollectionView is vertical frame

@end

@implementation ViewController

static float CELL_GAP = 10.0f;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float viewHeight =CGRectGetHeight(self.view.frame);
    float viewWidth = CGRectGetWidth(self.view.frame);
    
    float cellSize = viewWidth/5;
    
    //Set up UICollection view
    //UICollectionViewのセットアップ
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // Size of each cell //セルのサイズ
    layout.itemSize = CGSizeMake(cellSize, cellSize);
    
    // minimum spacing between lines//行ごとのスペースの最小値
    layout.minimumLineSpacing = CELL_GAP;
    
    // minimum spacing between items//アイテムごとのスペースの最小値
    layout.minimumInteritemSpacing = CELL_GAP;
    
    //スクロール方向
    layout.scrollDirection =UICollectionViewScrollDirectionVertical;
    
    
    self.collectionViewController = [[MyCollectioinViewController alloc] initWithCollectionViewLayout:layout];
    
    
    float upperYForCollectionView = 150;
    
    self.narrowFrame = CGRectMake(0,
                                  upperYForCollectionView,
                                  cellSize,
                                  viewHeight-upperYForCollectionView);
    self.wideFrame = CGRectMake(0,
                                upperYForCollectionView,
                                cellSize*3+CELL_GAP*2,
                                viewHeight-upperYForCollectionView);
    
    self.collectionViewController.collectionView.frame =_narrowFrame;
    self.narrowFrameFlag = YES;
    
    [self.view addSubview:_collectionViewController.view];
    
    //Set up UIButtons
    //操作用ボタンの設定
    
    float buttonHeight = 20;
    float topOffset = 30;
    //button to trigger simple frame change
    UIButton* justFrameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [justFrameButton setTitle:@"Frame Change" forState:UIControlStateNormal];
    justFrameButton.frame = CGRectMake(cellSize,
                                       topOffset,
                                       viewWidth-cellSize,
                                       buttonHeight);
    
    [justFrameButton addTarget:self action:@selector(simpleChange:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:justFrameButton];
    
    //button to trigger simple frame change with UIView animation
    UIButton* animFrameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [animFrameButton setTitle:@"Frame Change+UIView animation" forState:UIControlStateNormal];
    animFrameButton.frame = CGRectMake(cellSize,
                                       topOffset+(buttonHeight*2),
                                       viewWidth-cellSize,
                                       buttonHeight);
    
    [animFrameButton addTarget:self action:@selector(animChange:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:animFrameButton];

    
    //button to trigger combo change
    UIButton* comboChangeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [comboChangeButton setTitle:@"Combo Change" forState:UIControlStateNormal];
    comboChangeButton.frame = CGRectMake(cellSize,
                                         topOffset+(buttonHeight*4),
                                         viewWidth-cellSize,
                                         buttonHeight);
    
    [comboChangeButton addTarget:self action:@selector(comboChange:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:comboChangeButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 @brief : change UICollectionView.frame. No animation.
 */
-(void) simpleChange:(UIButton*) button
{
    if(_narrowFrameFlag){
        _collectionViewController.collectionView.frame = _wideFrame;
    }
    else{
        _collectionViewController.collectionView.frame = _narrowFrame;
    }
    [_collectionViewController.collectionView.collectionViewLayout invalidateLayout];
    _narrowFrameFlag = !_narrowFrameFlag;

}

/*
 @brief : change UICollectionView.frame. With not appropirate animation.
 */
-(void) animChange:(UIButton*) button
{
    [UIView animateWithDuration:0.8
                     animations:^{
                         if(_narrowFrameFlag){
                             _collectionViewController.collectionView.frame = _wideFrame;
                         }
                         else{
                             _collectionViewController.collectionView.frame = _narrowFrame;
                         }
                     }
                     completion:nil];
    _narrowFrameFlag = !_narrowFrameFlag;
    
}

/*
 @brief : change UICollectionView.frame. With proper animation.
 */

-(void) comboChange:(UIButton*) button
{
    //このperformBatchUpdatesが重要
    [_collectionViewController.collectionView performBatchUpdates:^{
        [UIView animateWithDuration:0.8
                animations:^{
                    if(_narrowFrameFlag){
                        _collectionViewController.collectionView.frame = _wideFrame;
                    }
                    else{
                        _collectionViewController.collectionView.frame = _narrowFrame;
                    }
                }
                completion:nil];
        }
        completion:nil];

    _narrowFrameFlag = !_narrowFrameFlag;
}

@end
