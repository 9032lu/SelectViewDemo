//
//  NY_SelectCView.m
//  中安生态商城
//
//  Created by LanSha on 2017/7/25.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import "SelectView.h"
#import "UIButton+ImageTitleStyle.h"
#import "NY_SelectCollectionViewCell.h"
#import "Masonry.h"
#import <objc/runtime.h>


#define KImageHeight 30.f
#define KImageMargin 20.f
//#define KImageCount  4.f
#define KBtnHeigth  40.0f


// 屏幕尺寸
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height


static NSString  *const NY_SelectCollectionViewCellID = @"NY_SelectCollectionViewCell";

@interface SelectView()<UICollectionViewDelegate,UICollectionViewDataSource,LZDBottomViewDelegate>
{
    BOOL show;
    UIButton *oldBtn;
}
@property (nonatomic, strong) UICollectionView *collect;
/**
 <#Description#>
 */
@property (nonatomic,strong) LZDBottomView *selectBottomView;
/**
 选择的数组
 */
@property (nonatomic,strong) NSMutableArray *selectDataA;
/**
 <#Description#>
 */
@property (nonatomic,strong) NSArray  *titleArr;

@end
@implementation SelectView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArr = titleArray;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.cloumCount = 4.0f;
    [self createCollectionView];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    UIView *mainView = [[UIView alloc]init];
    mainView.backgroundColor = RGBA(255, 255, 255, 1);
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.top.equalTo(self);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = RGBA(222, 222, 222, 1);
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.equalTo(mainView);
        make.top.mas_equalTo(mainView.mas_bottom);
    }];
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(toggleViewWith:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:_titleArr[i] forState:UIControlStateNormal ];
        button.titleLabel.font = [UIFont systemFontOfSize:13*FIT_WIDTH];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        [mainView addSubview:button];
        button.tag = 100+i;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainView).offset(SCREEN_WIDTH/self.titleArr.count*i);
            make.top.bottom.equalTo(mainView);
            make.width.mas_equalTo(SCREEN_WIDTH/self.titleArr.count);
        }];

        [button setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateSelected];
        [button setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:2];
        
    }
    
    
    self.selectBottomView = [[LZDBottomView alloc]init];
    self.selectBottomView.frame = CGRectMake(0, CGRectGetMaxY(self.collect.frame), SCREEN_WIDTH, 1);
    [self addSubview:self.selectBottomView];
    self.selectBottomView.delegata = self;

    
    
}
-(void)setSelectItmeArr:(NSArray *)selectItmeArr{
    _selectItmeArr = selectItmeArr;
    _defasultSelectIndex = 0;
    self.selectBottomView.hidden = self.isSingleSelect;
 
    [self.selectDataA removeAllObjects];
    for (LzdItemModel *model in selectItmeArr) {
        
        if (model.selected) {
            _defasultSelectIndex = [selectItmeArr indexOfObject:model];
            [_selectDataA addObject:model];
        }
    }

    
    [UIView performWithoutAnimation:^{
        NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
        [self.collect reloadSections:index];
        
    }];
   
    
    
}
- (void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat tableViewHeight =[self getCollectionHeight];

    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -KBtnHeigth-tableViewHeight, SCREEN_WIDTH, tableViewHeight) collectionViewLayout:layout];
    self.collect.showsVerticalScrollIndicator = NO;
    self.collect.delegate = self;
    self.collect.dataSource = self;
    self.collect.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collect];
    
    [self.collect registerNib:[UINib nibWithNibName:@"NY_SelectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NY_SelectCollectionViewCellID];
    
}
#pragma mark UICollectionViewDelegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _selectItmeArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isSingleSelect) {

        LzdItemModel *model = _selectItmeArr[self.defasultSelectIndex];
        model.selected = NO;
        
        NSIndexPath *oldindexpath = [NSIndexPath indexPathForItem:self.defasultSelectIndex inSection:0];
        
        NY_SelectCollectionViewCell *oldCell = (NY_SelectCollectionViewCell *)[collectionView cellForItemAtIndexPath:oldindexpath];
        [oldCell.Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.selectDataA removeObject:model];
        oldCell.selectCell = NO;
        
        self.defasultSelectIndex = indexPath.item;


    }
        NY_SelectCollectionViewCell *selCell = (NY_SelectCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        LzdItemModel *model = _selectItmeArr[indexPath.row];
        model.selected = !model.selected;
        if (model.selected) {
            [selCell.Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            selCell.selectCell = YES;
            [self.selectDataA addObject:model];
        }else{
            [selCell.Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self.selectDataA removeObject:model];
            selCell.selectCell = NO;
            
        }
    
    
    

   

    
    if ([self.delegate respondsToSelector:@selector(selectItme:withIndex:)]) {
        [self.delegate selectItme:self withIndex:indexPath.row];
    }

        if (self.isSingleSelect) {
           
            
            [self LZDBottomViewButtonClick:1];
            
        }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NY_SelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NY_SelectCollectionViewCellID forIndexPath:indexPath];
   

    LzdItemModel *model = _selectItmeArr[indexPath.row];
    if ([self.selectDataA containsObject:model]) {
//        if (model.selected) {
            [cell.Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.selectCell = YES;
        }else{
            [cell.Btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            cell.selectCell = NO;

//        }
    }
   
    [cell.Btn setTitle:model.name forState:UIControlStateNormal];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - (self.cloumCount-1) * KImageMargin - (self.cloumCount-1) * KImageMargin)/self.cloumCount,KImageHeight * FIT_WIDTH);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return KImageMargin;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(KImageMargin, KImageMargin, 0, KImageMargin);
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return KImageMargin;
}



- (void)toggleViewWith:(UIButton *)btn{
    
    ButtonClickType type = ButtonClickTypeNormal;

    
   
    if (btn) {
        if ([self.delegate respondsToSelector:@selector(selectTopButton:withIndex:withButtonType:)]) {
            [self.delegate selectTopButton:self withIndex:btn.tag withButtonType:type];
        }
        if (btn != oldBtn) {
            if (!show) {
                show = YES;
            }
        }else{
           show = !show;
        }
        
        oldBtn = btn;
    }else{
        show = NO;
    }
    
   

    if (show) {
        self.frame = CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT);
        NSLog(@"-----------");
        self.collect.hidden = NO;
    }else{
      self.frame = CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, 40);

    }
    
    
    CGFloat tableViewHeight = [self getCollectionHeight];

    
    float frameY = show?40:-tableViewHeight-(self.isSingleSelect?1: KBtnHeigth);
    
  
    
    [UIView animateWithDuration:0.5 animations:^{
        self.collect.frame = CGRectMake(0, frameY, SCREEN_WIDTH, tableViewHeight);
        
        self.selectBottomView.frame = CGRectMake(0, CGRectGetMaxY(self.collect.frame),SCREEN_WIDTH, (self.isSingleSelect?1: KBtnHeigth));
     
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:show?0.3:0.0];

    } completion:^(BOOL finished) {
        self.selectBottomView.frame = CGRectMake(0, CGRectGetMaxY(self.collect.frame),SCREEN_WIDTH, show?(self.isSingleSelect?1: KBtnHeigth):1);
        self.collect.hidden = !show;
    }];
}

-(CGFloat)getCollectionHeight{
    
//    NSInteger count = 0;
//    if ((_selectItmeArr.count / KImageCount)) {
//
//    }
    CGFloat heigth = (KImageHeight * FIT_WIDTH +KImageMargin)* ceil(_selectItmeArr.count / self.cloumCount)   + KImageMargin;
    NSLog(@"----%lf",ceil(_selectItmeArr.count / self.cloumCount));
    return MIN(heigth, 300);
}
-(void)LZDBottomViewButtonClick:(NSInteger)btnTag;{


    if (btnTag==0) {
        
        [self.selectDataA removeAllObjects];
        
      
        
        
        [UIView performWithoutAnimation:^{
            NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
            [self.collect reloadSections:index];

        }];
    }else{
        NSString *string = @"";
        for (LzdItemModel *mode in self.selectDataA) {
            if (!string.length) {
                string = mode.name;
            }else{
                string = [NSString stringWithFormat:@"%@,%@",string,mode.name];
            }
        }
        
        if (!self.selectDataA.count) {
            [self.selectItmeArr enumerateObjectsUsingBlock:^(LzdItemModel*   obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.selected = NO;
            }];
            
            string = self.titleArr[oldBtn.tag-100];

        }
        [oldBtn setTitle:string forState:0];
        [oldBtn setTitle:string forState:UIControlStateSelected];
        oldBtn.selected = self.selectDataA.count;

         [oldBtn setButtonImageTitleStyle:ButtonImageTitleStyleRight padding:2];

        if (self.delegate &&[self.delegate respondsToSelector:@selector(LZdBottomSureBtnClick: withTopIndex:WithDataA:)]) {
            [self.delegate LZdBottomSureBtnClick:self withTopIndex:oldBtn.tag-100 WithDataA:self.selectDataA];
        }
        [self toggleViewWith:nil];

    }
}
-(void)setIsSingleSelect:(BOOL)isSingleSelect{
    _isSingleSelect = isSingleSelect;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self toggleViewWith:nil];
}

-(NSMutableArray *)selectDataA{
    if (!_selectDataA) {
        _selectDataA = [NSMutableArray array];
    }
    return _selectDataA;
}
@end


@implementation LZDBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubviews];
        self.backgroundColor = RGBA(234, 234, 234, 1);
    }
    return self;
}
-(void)creatSubviews{
    
    NSArray *buttonA = @[@"重置",@"确定"];
    for (int i = 0; i<buttonA.count; i ++) {
        
        UIButton *buttom = [UIButton buttonWithType:UIButtonTypeCustom];
        //        buttom.frame = CGRectMake(i*SCREEN_WIDTH/2, 1, SCREEN_WIDTH/2, self.frame.size.height-1);
        [buttom setTitle:buttonA[i] forState:UIControlStateNormal];
        [buttom setTitle:buttonA[i] forState:UIControlStateHighlighted];
        buttom.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:buttom];
        
        [buttom addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        buttom.tag = i;
        if (i==0) {
            [buttom setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            [buttom setTitleColor:MAINCOLOR forState:UIControlStateHighlighted];
            buttom.backgroundColor = [UIColor whiteColor];
            [buttom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(1);
                make.width.mas_equalTo(SCREEN_WIDTH/2);
                make.bottom.left.mas_equalTo(0);
                
            }];
        }else{
            buttom.backgroundColor = MAINCOLOR;
            [buttom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(1);
                make.width.mas_equalTo(SCREEN_WIDTH/2);
                make.bottom.right.mas_equalTo(0);
                
            }];
        }
        
        
        
    }
}
-(void)buttonClick:(UIButton*)sender{
    if (self.delegata &&[self.delegata respondsToSelector:@selector(LZDBottomViewButtonClick:)]) {
        [self.delegata LZDBottomViewButtonClick:sender.tag];
    }
    
}

@end

@implementation LzdItemModel



@end
