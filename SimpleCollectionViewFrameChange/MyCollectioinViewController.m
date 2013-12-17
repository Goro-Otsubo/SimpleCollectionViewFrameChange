//
//  MyCollectioinViewController.m
//  SimpleCollectionViewFrameChange
//
//  Created by GoroOtsubo
//  Copyright (c) 2013 NEXT Co., Ltd.
//

#import "MyCollectioinViewController.h"
#import "MyCollectionViewCell.h"

@interface MyCollectioinViewController()

@property(strong)NSMutableArray* dataArray; //Array to hold dummy data

@end

@implementation MyCollectioinViewController

static NSString* CellIndetifier = @"Cell"; //Cell identidifier used for UICollectionView


- (id) initWithCollectionViewLayout:(UICollectionViewLayout*)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // Custom initialization
        self.collectionView.backgroundColor = [UIColor blackColor];
        
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        
        //fill up dummy data
        self.dataArray = [[NSMutableArray alloc]init];
        for(int i=0;i<100;i++){
            [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        [self.collectionView registerClass:[MyCollectionViewCell class]forCellWithReuseIdentifier:CellIndetifier];
    }
    return self;
}


#pragma mark - Collection delegate and datasource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:CellIndetifier forIndexPath:indexPath];
    
    //set dummy string data to cell. just identify each cell.
    cell.label.text =_dataArray[indexPath.row];
    
    return cell;
}



@end
