//
//  DetailViewController.h
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 8/8/2564 BE.
//

#import <UIKit/UIKit.h>
#import "BookList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) BookItem *bookItem;

@end

NS_ASSUME_NONNULL_END
