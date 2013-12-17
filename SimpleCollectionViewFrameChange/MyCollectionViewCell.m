//
//  MyCollectionViewCell.m
//  SimpleCollectionViewFrameChange
//
//  Created by GoroOtsubo
//  Copyright (c) 2013 NEXT Co., Ltd.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()


@end

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label =[[UILabel alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth(frame),CGRectGetHeight(frame))];
        _label.font = [UIFont systemFontOfSize:CGRectGetHeight(frame)*0.8];
        _label.backgroundColor = [UIColor redColor];
        _label.textColor = [UIColor blackColor];
        [self.contentView addSubview:_label];
    }
    return self;
}



@end
