//
//  ViewController.m
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 5/8/2564 BE.
//

#import "ViewController.h"
#import "ListCollectionViewCell.h"
#import "BookList.h"
#import "SearchViewController.h"
#import "DetailViewController.h"

//#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

//@property IBOutlet

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property (strong, nonatomic) BookList *bookListData;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *acIndicator;



//@property (strong, nonatomic)

@property (strong, nonatomic) NSArray *listName;
@property (strong, nonatomic) NSArray<NSData* > *imageDataCache;
@property (strong, nonatomic) NSArray<NSString* > *imageUrlCache;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic, strong) BookItem *selectedBook;
@property (nonatomic, assign) BOOL isLoading;

//

@end

@implementation ViewController

- (void)viewDidLoad {
    self.isLoading = YES;
    [super viewDidLoad];
    [self setupNavBar];
    [self configureView];
    self.acIndicator.hidden = NO;
    [self.acIndicator startAnimating];
    
    [self getBookData];
//    [self fetchBookUsingJSON];
//    [self configureCollectionView];
    // Do any additional setup after loading the view.
    self.listCollectionView.delegate = self;
}



#pragma mark - Method Declaration


- (void)configureView {
    self.screenWidth = CGRectGetWidth(self.view.frame);
}

- (void)getBookData {
    [self fetchBookUsingJSON];
}
    

- (void)setupNavBar
{

    self.searchBtn.hidden = YES;


    self.navView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.navView.layer.shadowOffset = CGSizeMake(0, 1);
    self.navView.layer.shadowRadius = 4.0;
    self.navView.layer.shadowOpacity = 0.25;
    self.navView.layer.masksToBounds = false;
    
    //    [self setupButton];
    //    self.navView.layer.cornerRadius = 8.0;
    //    self.navView.layer.borderWidth = 1.0;
    //    self.navView.layer.borderColor = UIColor.clearColor.CGColor;
    //    self.navView.layer.masksToBounds = true;
    
}

//- (void)setupButton{
//    [self.searchBtn addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)searchButtonPressed:(UIButton*)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//
//
//}

#pragma mark - Segue Config

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSearchSegue"]){
            SearchViewController *controller = (SearchViewController *)segue.destinationViewController;
            controller.bookListData = self.bookListData ;
            controller.imageDataCache = self.imageDataCache ;
         }
    
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
            DetailViewController *controller = (DetailViewController *)segue.destinationViewController;

            for(BookItem* bookItem in self.bookListData.data)
            {
                if([bookItem.title isEqual: self.selectedBook.title ]){
                    controller.bookItem = self.selectedBook;
                }
             
            }
    }
//    if([segue.identifier isEqualToString:@"showSearchSegue"]){
//                UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
//                SearchViewController *controller = (SearchViewController *)navController.topViewController;
//                controller.bookListData = self.bookListData;
//            }
}




#pragma mark - UIColViewDelegate
// Implement UIColViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookItem *selectedItem = [self.bookListData.data objectAtIndex:indexPath.row];
//    NSLog(@"%@", selectedItem);
    self.selectedBook = selectedItem;
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 3, 3, 3);
}




#pragma mark - UIColViewDataSource
// Implement UIColViewDataSource



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
//
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat cellAreaWidth = (self.screenWidth - 48)/2;
    CGFloat cellAreaHeight = cellAreaWidth * 3/2;
    return CGSizeMake(cellAreaWidth, cellAreaHeight);
//    return CGSizeMake(400, 403);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookListData.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"ListCell";
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
//    [cell.cellActIndicator startAnimating];
    cell.bookColPicture.image = nil;

    cell.contentView.layer.cornerRadius = 8.0;
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.borderColor = UIColor.clearColor.CGColor;
    cell.contentView.layer.masksToBounds = true;
//
    cell.layer.shadowColor = UIColor.blackColor.CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 1);
    cell.layer.shadowRadius = 2.0;
    cell.layer.shadowOpacity = 0.3;
    cell.layer.masksToBounds = false;
    
//    cell.layer.shadowPath = UIBezierPath(rect:cell.bounds).cgPath;
//    UIBezierPath* path = [UIBezierPath bezierPathWithRect:cell.bounds];
//    cell.layer.shadowPath = path.CGPath;
//    cell.layer.shadowPath =     UIBezierPath(rect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;
//
    
    BookItem *bookData = [self.bookListData.data objectAtIndex:indexPath.row];
    NSString *bookTitle = bookData.title;

    // set Label
    cell.bookColLabel.text = bookTitle;
    

//
//

    
//    NSData * imageData = NSData.new;
//    imageData = [self.imageDataCache objectAtIndex:indexPath.row];
//    cell.bookColPicture.image = [UIImage imageWithData: imageData];
//    [cell.bookColIndicator startAnimating];

    
    //    NSString *imgUrl;
    //    BookItemMedia *media = BookItemMedia.new;
    //    for(media in bookData.multimedia){
    //        if ([media.format isEqual:@"superJumbo"])
    //        {
    //            imgUrl = media.url;
    //        }
    //    }
    //
    //    NSData * imageData = NSData.new;
    //    imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgUrl]];
    //    cell.bookColPicture.image = [UIImage imageWithData: imageData];
    
    //     set Picture
    
    NSData * imageData = NSData.new;
    
    [cell.cellActIndicator startAnimating];
    cell.cellActIndicator.hidden = NO;
    
    if(self.isLoading == YES){
        self.isLoading = NO;
        
        imageData = [self.imageDataCache objectAtIndex:indexPath.row];
        cell.bookColPicture.image = [UIImage imageWithData: imageData];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Threa
       
            [self downloadImage];

        });
    }
    
    if(self.imageDataCache == nil){
        [cell.cellActIndicator startAnimating];
        cell.cellActIndicator.hidden = NO;
    }else{
        [cell.cellActIndicator stopAnimating];
        cell.cellActIndicator.hidden = YES;
    }
        

    
    imageData = [self.imageDataCache objectAtIndex:indexPath.row];
    cell.bookColPicture.image = [UIImage imageWithData: imageData];
    

    
    //set view
    [self.acIndicator stopAnimating];
    self.acIndicator.hidden = YES;
    self.searchBtn.hidden = NO;
    return cell;
}


    
    
#pragma mark - fetchJSON
- (void)fetchBookUsingJSON
{

    NSLog(@"FetchingBook");
    
    NSString *urlString = @"https://api.nytimes.com/svc/topstories/v2/books.json?api-key=GDrQ2aBDKGj6DELALg9H4JeXLysN1peW";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            NSLog(@"Finished Fetching Book");

//        NSString *dummyJSON = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        if(error){
            NSLog(@"Cannot conect API");
        }
        else{
//            NSLog(@"%@" , dummyJSON);
            NSError *err;
            id bookJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            if (err)
            {
                NSLog(@"Failed to serealize into JSON: %@", err);
                return;
            }
            
            if([bookJSON isKindOfClass:[NSDictionary class]]){
                NSDictionary *results = bookJSON;
                BookList *bookList = BookList.new;
                bookList.status = results[@"status"];
                bookList.section = results[@"section"];
                bookList.numResults = results[@"num_results"];
        
                //   Book Data phrasing to BookList model
                
                NSMutableArray<BookItem *> *bookArray= NSMutableArray.new;
                NSMutableArray<BookItemMedia *> *mediaArray= NSMutableArray.new;
                NSMutableArray<NSString *> *imgArray= NSMutableArray.new;
                
                for (NSDictionary *bookData in results[@"results"]){
                    BookItem *bookItem = BookItem.new;
                    bookItem.title = bookData[@"title"];
                    bookItem.section = bookData[@"section"];
                    bookItem.abstract = bookData[@"abstract"];
                    bookItem.url = bookData[@"url"];
                    bookItem.byline = bookData[@"byline"];
                    
                    
                // Media Data phrasing to BookList model
                    
                    for (NSDictionary *mediaData in bookData[@"multimedia"]){
                        
                        if([mediaData[@"format"]  isEqual: @"superJumbo"] ){

                            BookItemMedia *bookItemMedia = BookItemMedia.new;
                            bookItemMedia.url = mediaData[@"url"];
                            bookItemMedia.format = mediaData[@"format"];
                            bookItemMedia.height = mediaData[@"height"];
                            bookItemMedia.width = mediaData[@"width"];

                            [imgArray addObject :bookItemMedia.url];
                            [mediaArray addObject:bookItemMedia];
                        
                        }
                        bookItem.multimedia = mediaArray;
                    }
                    
                    [bookArray addObject:bookItem];
                    self.imageUrlCache = imgArray;
                }
                bookList.data = bookArray;
                self.bookListData = bookList;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.listCollectionView reloadData];
                });

            }
            
        }

    }] resume];
    
    

}

- (void)downloadImage{
    
    NSString *imgUrl;
    NSMutableArray<NSData *> *imgArray= NSMutableArray.new;
    
    for(imgUrl in self.imageUrlCache)
    {
    
        NSData * imageData = NSData.new;
        imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgUrl]];
        [imgArray addObject: imageData];
    }
    
    self.imageDataCache = imgArray;
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self.listCollectionView reloadData];
        
    });
    
}


@end


