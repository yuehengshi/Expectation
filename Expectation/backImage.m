//
//  backImage.m
//  Expectation
//
//  Created by Syh on 16/8/28.
//  Copyright © 2016年 5. All rights reserved.
//

#import "backImage.h"
#import "backImageCell.h"
#import "addNewAffairTableViewController.h"
#import "addNew.h"
@interface backImage ()

@end

@implementation backImage

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // UICollectionViewFlowLayout流水布局的内部成员属性有以下：
    /**
     @property (nonatomic) CGFloat minimumLineSpacing;
     @property (nonatomic) CGFloat minimumInteritemSpacing;
     @property (nonatomic) CGSize itemSize;
     @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
     @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
     @property (nonatomic) CGSize headerReferenceSize;
     @property (nonatomic) CGSize footerReferenceSize;
     @property (nonatomic) UIEdgeInsets sectionInset;
     */
    // 定义大小
    layout.itemSize = CGSizeMake(1000, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = 20;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置滚动方向（默认垂直滚动）
    //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    return [self initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.frame = self.view.bounds;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"本地背景库";
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([backImageCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    UIBarButtonItem *barBtn1=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTo)];
    self.navigationItem.leftBarButtonItem=barBtn1;
    
}
-(void)backTo{
    if([_current_page isEqual:@"1"])
    {
        [self performSegueWithIdentifier:@"backImage_back" sender:nil];
    }
    else if([_current_page isEqual:@"2"]){
    [self performSegueWithIdentifier:@"backImage_back2" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake(120, 170);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(15, 15, 10, 15);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 18;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    backImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
     cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 5;
    cell.pic.image=[UIImage imageNamed:[NSString stringWithFormat:@"back%ld",indexPath.row+1]];
 //   cell.name.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];

    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 5;
    _image=[NSString stringWithFormat:@"back%ld",indexPath.row+1];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"backImage_back"])
    {
    addNewAffairTableViewController *vc=segue.destinationViewController;
    vc.category=_category;
    vc.title_data=_title_data;
    vc.image=_image;
    vc.hour_data=_hour_data;
    vc.min_data=_min_data;
    vc.sec_data=_sec_data;
     vc.iftop_data=_iftop_data;
    vc.id=_id;
    vc.modelIndex=_modelIndex;
       vc.if_UISwitch_enable=_if_UISwitch_enable;
     vc.ifedit=_ifedit;
    vc.ifremind_data=_ifremind_data;
    vc.music=_music;
    vc.current_page=_current_page;
        vc.temp_imagePath=_temp_imagePath;
        vc.imgNum=_imgNum;
    }
    if ([segue.identifier isEqualToString:@"backImage_back2"])
    {
        addNew *vc=segue.destinationViewController;
        vc.category=_category;
        vc.title_data=_title_data;
        vc.image=_image;
        vc.hour_data=_hour_data;
        vc.min_data=_min_data;
        vc.sec_data=_sec_data;
        vc.iftop_data=_iftop_data;
        vc.id=_id;
        vc.modelIndex=_modelIndex;
        vc.if_UISwitch_enable=_if_UISwitch_enable;
        vc.ifedit=_ifedit;
        vc.ifremind_data=_ifremind_data;
        vc.music=_music;
        vc.current_page=_current_page;
        vc.time_data=_time_data;
        vc.time_string=_time_string;
    }
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
