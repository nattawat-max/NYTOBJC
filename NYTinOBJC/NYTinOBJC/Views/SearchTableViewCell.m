//
//  SearchTableViewCell.m
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 8/8/2564 BE.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellSubView.layer.cornerRadius = 8;
    self.cellSubView.layer.borderWidth = 1.0;
    self.cellSubView.layer.borderColor = UIColor.clearColor.CGColor;
    self.cellSubView.layer.masksToBounds = false;
    
    self.cellSubView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.cellSubView.layer.shadowOffset = CGSizeMake(0, 1);
    self.cellSubView.layer.shadowRadius = 2.0;
    self.cellSubView.layer.shadowOpacity = 0.3;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
