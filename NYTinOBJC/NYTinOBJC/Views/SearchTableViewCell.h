//
//  SearchTableViewCell.h
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 8/8/2564 BE.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descipLabel;
@property (weak, nonatomic) IBOutlet UIView *cellSubView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end



NS_ASSUME_NONNULL_END
