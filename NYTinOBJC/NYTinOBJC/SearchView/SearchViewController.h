//
//  SearchViewController.h
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 6/8/2564 BE.
//

#import <UIKit/UIKit.h>
#import "BookList.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) BookList *bookListData;
@property (strong, nonatomic) NSArray<NSData* > *imageDataCache;


@end

NS_ASSUME_NONNULL_END
