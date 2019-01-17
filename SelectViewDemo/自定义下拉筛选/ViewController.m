//
//  ViewController.m
//  SelectViewDemo
//
//  Created by LanSha on 2017/8/8.
//  Copyright © 2017年 LanSha. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"

@interface ViewController ()<NY_SelectViewDelegate>
@property (nonatomic, strong) SelectView *selectView;
@property (nonatomic, copy) NSArray *dataArr;
/**
 
 */
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArr = @[@[@{@"name":@"全部",@"count":@"50"},
                 @{@"name":@"零食",@"count":@"10"},
                 @{@"name":@"生鲜",@"count":@"10"},
                 @{@"name":@"手机",@"count":@"10"},
                 @{@"name":@"服饰",@"count":@"10"},
                 @{@"name":@"玩具",@"count":@"10"},
                 @{@"name":@"全部",@"count":@"50"},
                 @{@"name":@"零食",@"count":@"10"},
                 @{@"name":@"生鲜",@"count":@"10"},
                 @{@"name":@"手机",@"count":@"10"},
                 @{@"name":@"服饰",@"count":@"10"},
                 @{@"name":@"玩具",@"count":@"10"},
                 @{@"name":@"全部",@"count":@"50"},
                 @{@"name":@"零食",@"count":@"10"},
                 @{@"name":@"生鲜",@"count":@"10"},
                 @{@"name":@"手机",@"count":@"10"},
                   @{@"name":@"服饰",@"count":@"10"},
                   @{@"name":@"零食",@"count":@"10"},
                   @{@"name":@"生鲜",@"count":@"10"},
                   @{@"name":@"手机",@"count":@"10"},
                   @{@"name":@"服饰",@"count":@"10"},
                   @{@"name":@"玩具",@"count":@"10"},
                   @{@"name":@"全部",@"count":@"50"},
                   @{@"name":@"零食",@"count":@"10"},
                   @{@"name":@"生鲜",@"count":@"10"},
                   @{@"name":@"手机",@"count":@"10"},
                   @{@"name":@"服饰",@"count":@"10"},
                   @{@"name":@"玩具",@"count":@"10"},
                   @{@"name":@"全部",@"count":@"50"},
                   @{@"name":@"零食",@"count":@"10"},
                   @{@"name":@"生鲜",@"count":@"10"},
                   @{@"name":@"手机",@"count":@"10"},
                   @{@"name":@"服饰",@"count":@"10"},
                   @{@"name":@"玩具",@"count":@"10"}],
            @[@{@"name":@"生鲜",@"count":@"10"},
                @{@"name":@"玩具",@"count":@"10"}],
                 @[
                     @{@"name":@"生鲜",@"count":@"10"},
                     @{@"name":@"手机",@"count":@"10"},
                     @{@"name":@"服饰",@"count":@"10"},
                     @{@"name":@"玩具",@"count":@"10"}],
                 @[
                     @{@"name":@"生鲜",@"count":@"10"},
                     @{@"name":@"手机",@"count":@"10"},
                     @{@"name":@"服饰",@"count":@"10"},
                     @{@"name":@"手机",@"count":@"10"},
                     @{@"name":@"手机",@"count":@"10"},
                     @{@"name":@"手机",@"count":@"10"},
                     @{@"name":@"玩具",@"count":@"10"}]
                 
                 ];
    for (NSArray *arr in _dataArr) {
        
        NSMutableArray *mu_A = [NSMutableArray array];
        
        for (NSDictionary*dic in arr) {
            LzdItemModel *model = [[LzdItemModel alloc]init];
            
            model.name = dic[@"name"];
            model.selected = NO;
            [mu_A addObject:model];
        }
      
        [self.dataArray addObject:mu_A];
    }
    
    
    [self.view addSubview:self.selectView];
}
#pragma mark NY_SelectViewDelegate
-(void)selectItme:(SelectView *)selectView withIndex:(NSInteger)index{
    //index代表选中的品类，0是全部。
    if (index == 0) {
        NSLog(@"分类中的全部");
    }else{
        NSLog(@"分类中的其他");
    }
}
-(void)selectTopButton:(SelectView *)selectView withIndex:(NSInteger)index withButtonType:(ButtonClickType)type1{
    if (index-100 ==3) {
        _selectView.cloumCount = 3.0f;
    }else{
        _selectView.cloumCount = 4.0f;

    }
    _selectView.selectItmeArr = _dataArray[index-100];

    //价格
    if (index == 100){//综合
        NSLog(@"综合");
    }else if (index == 101){//促销
        NSLog(@"促销");
    }else if (index == 102) {
        NSLog(@"综合");
        
    }else{//全部
        NSLog(@"全部");
    }
}

-(void)LZdBottomSureBtnClick:(SelectView *)selectView withTopIndex:(NSInteger)topIndex WithDataA:(NSArray *)dataA{
    NSLog(@"-----%ld===%@",topIndex,dataA);
    
}

#pragma mark 懒加载
-(SelectView *)selectView{
    if (!_selectView) {
        
        _selectView = [[SelectView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40) withTitleArray:@[@"综合",@"价格",@"销量",@"橙色"]];
        _selectView.delegate = self;
        _selectView.selectItmeArr = _dataArray.firstObject;
        _selectView.isSingleSelect = YES;

    }
    return _selectView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
