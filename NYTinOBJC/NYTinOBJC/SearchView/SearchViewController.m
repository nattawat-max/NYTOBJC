//
//  SearchViewController.m
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 6/8/2564 BE.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "BookList.h"
#import "DetailViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UILabel *noresultLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *acIndicator;

@property (assign, nonatomic) BOOL isFiltered;
@property (nonatomic, strong) NSArray<BookItem *> *filteredBook;
@property (nonatomic, strong) NSArray<NSData *> *filteredImg;
@property (nonatomic, strong) BookItem *selectedBook;

@end

@implementation SearchViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.noresultLabel.hidden = YES;
    self.acIndicator.hidden = YES;
    [self setUpTable];
    [self setupButton];
    [self setUpNavView];
    [self setupSearchBar];
    

    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate

- (void)setUpNavView{
    self.navView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.navView.layer.shadowOffset = CGSizeMake(0, 1);
    self.navView.layer.shadowRadius = 4.0;
    self.navView.layer.shadowOpacity = 0.25;
    self.navView.layer.masksToBounds = false;
}

- (void)setUpTable
{
    self.searchBar.delegate = self;
    self.searchTableView.delegate = self;
    self.searchTableView.contentInset = UIEdgeInsetsMake(8, 0, 8, 0);
    self.searchTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    self.searchTableView.scrollEnabled = NO;
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupButton
{
    [self.backBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backButtonPressed:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Segue Config

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
             DetailViewController *controller = (DetailViewController *)segue.destinationViewController;
        if(self.isFiltered){
            for(BookItem* bookItem in self.filteredBook)
            {
                if([bookItem.title isEqual: self.selectedBook.title ]){
                    controller.bookItem = self.selectedBook;
                }
            
            }
        }
        else{
            for(BookItem* bookItem in _bookListData.data)
            {
                if([bookItem.title isEqual: self.selectedBook.title ]){
                    controller.bookItem = self.selectedBook;
                }
            
            }
        }
    }

}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isFiltered){
        BookItem *selectedItem = [self.filteredBook objectAtIndex:indexPath.row];
        self.selectedBook = selectedItem;
    }
    else{
        BookItem *selectedItem = [_bookListData.data objectAtIndex:indexPath.row];
        self.selectedBook = selectedItem;
    }
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screenWidth = CGRectGetWidth(self.view.frame);
    CGFloat tableCellHeight = screenWidth/3;
    return tableCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isFiltered){
        if(self.filteredBook.count > 0){
            return self.filteredBook.count;
        }
        else{
            self.noresultLabel.hidden = NO;
            return 0;
  
            
        }
    }
    else{
        return _bookListData.data.count;
//        return 6;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchTableCell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.descipLabel.numberOfLines = 0;
    [cell.descipLabel sizeToFit];
    cell.descipLabel.textColor = [UIColor colorWithRed: 0.50 green: 0.50 blue: 0.50 alpha: 1.00];
    cell.titleLabel.numberOfLines = 0;
    [cell.titleLabel sizeToFit];
    cell.authorLabel.textColor = [UIColor colorWithRed: 0.50 green: 0.50 blue: 0.50 alpha: 1.00];
    
    if(self.isFiltered){
        if(self.filteredBook.count >0){
            BookItem *bookData = [self.filteredBook objectAtIndex:indexPath.row];
            NSString *imgUrl;
            BookItemMedia *media = BookItemMedia.new;
            for(media in bookData.multimedia){
                if ([media.format isEqual:@"superJumbo"])
                {
                    imgUrl = media.url;
                }
            }
            
            cell.titleLabel.text = bookData.title;
            NSData * imageData = NSData.new;
//            imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgUrl]];
            imageData = [self.filteredImg objectAtIndex:indexPath.row];
            cell.imgView.image = [UIImage imageWithData: imageData];
            cell.descipLabel.text = bookData.abstract;
            cell.authorLabel.text = bookData.byline;

            
        }
        else{
            cell.titleLabel.text = @"No result";
            cell.descipLabel.text = @"";
            cell.authorLabel.text = @"";
        }
        
    }
    else{
        BookItem *bookData = [self.bookListData.data objectAtIndex:indexPath.row];
        
        NSData * imageData = NSData.new;
        imageData = [self.imageDataCache objectAtIndex:indexPath.row];
        cell.imgView.image = [UIImage imageWithData: imageData];
        
        cell.titleLabel.text = bookData.title;
        cell.descipLabel.text = bookData.abstract;
        cell.authorLabel.text = bookData.byline;
        
    }
    return cell;
    
}


#pragma mark - SearchBar Config

- (void)setupSearchBar {
    
    
    [self.searchBar setBackgroundColor:[UIColor whiteColor]];
    [self.searchBar setBarTintColor:[UIColor whiteColor]];
    self.searchBar.layer.backgroundColor = UIColor.clearColor.CGColor;
    [self.searchBar.searchTextField setBackgroundColor:[UIColor whiteColor]];
    
    //    [self.searchBar setTintColor :[UIColor blackColor]];
    //    self.searchBar.layer.borderWidth = 0;
    //    self.searchBar.layer.borderColor = UIColor.whiteColor.CGColor;
    
    
    //Alternate way
    //    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    //    searchField.backgroundColor = [UIColor whiteColor];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.acIndicator.hidden = NO;
    [self.acIndicator startAnimating];
    self.noresultLabel.hidden = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchingText:) object:searchText];
    [self performSelector:@selector(searchingText:) withObject:searchText afterDelay:0.5];
    
 

}

- (void)searchingText: (NSString *)searchText{
    searchText = searchText.uppercaseString;
    
    if(searchText.length == 0){
        self.isFiltered = NO;
        self.filteredImg = nil;
        self.filteredBook = nil;
    }
    else{
        self.isFiltered = YES;
        
        NSMutableArray<NSData *> *searchImg = NSMutableArray.new;
        NSMutableArray<BookItem *> *searchBook = NSMutableArray.new;

        // Search by title
        NSData *bookImg = NSData.new;
        NSUInteger index = 0;
        for(BookItem *bookItem in _bookListData.data){
            
            NSRange nameRange = [bookItem.title.uppercaseString rangeOfString: searchText];
            if(nameRange.location != NSNotFound){
                [searchBook addObject:bookItem];
                bookImg = [self.imageDataCache objectAtIndex:index];
                [searchImg addObject:bookImg];
            }
            index += 1;
        }

        // Search by Author
        index = 0;
        for(BookItem *bookItem in _bookListData.data){
            NSRange nameRange = [bookItem.byline.uppercaseString rangeOfString: searchText];
            if(nameRange.location != NSNotFound){
                //check duplicate item
                bool checkDup = true;
                for(BookItem *dupBook in searchBook){
                    if([dupBook.title isEqual:bookItem.title]){
                        checkDup = false;
                    }
                }
                if(checkDup)
                {
                    [searchBook addObject:bookItem];
                    bookImg = [self.imageDataCache objectAtIndex:index];
                    [searchImg addObject:bookImg];
                }
                // next exclude "by" from byline
            }
            index += 1;
        }
        self.filteredImg = searchImg;
        self.filteredBook = searchBook;
    }
    [self.acIndicator stopAnimating];
    self.acIndicator.hidden = YES;
    [self.searchTableView reloadData];

}


@end
