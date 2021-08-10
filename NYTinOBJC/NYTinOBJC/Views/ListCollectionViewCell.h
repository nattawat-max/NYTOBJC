//
//  ListCollectionViewCell.h
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 5/8/2564 BE.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookColLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookColPicture;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cellActIndicator;


@end

NS_ASSUME_NONNULL_END
