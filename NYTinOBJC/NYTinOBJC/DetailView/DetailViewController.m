//
//  DetailViewController.m
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 8/8/2564 BE.
//

#import "DetailViewController.h"
#import "BookList.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property (weak, nonatomic) IBOutlet UILabel *descipLabel;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *webView;

@property (weak, nonatomic) NSString *websiteUrl;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavView];
    [self setupButton];
    [self configView];
    [self setupData];
    

    
}

- (void)setUpNavView{
    self.navView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.navView.layer.shadowOffset = CGSizeMake(0, 1);
    self.navView.layer.shadowRadius = 4.0;
    self.navView.layer.shadowOpacity = 0.25;
    self.navView.layer.masksToBounds = false;
}


- (void)configView{
    
    self.descipLabel.textColor = [UIColor colorWithRed: 0.31 green: 0.31 blue: 0.31 alpha: 1.00];
    self.descipLabel.numberOfLines = 0;
    [self.descipLabel sizeToFit];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    
    
}

- (void)setupData{
    NSString *imgUrl;
    BookItemMedia *media = BookItemMedia.new;
    for(media in _bookItem.multimedia){
        if ([media.format isEqual:@"superJumbo"])
        {
            imgUrl = media.url;
        }
    }
    NSData * imageData = NSData.new;
    imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgUrl]];
    
    self.bookImg.image = [UIImage imageWithData: imageData];
    
    self.titleLabel.text = _bookItem.title;
    self.descipLabel.text = _bookItem.abstract;
    
    self.websiteUrl = _bookItem.url;
}

- (void)setupButton
{
//    self.websiteButton
    
    self.webView.layer.cornerRadius = 8.0;
    self.webView.layer.borderWidth = 1.0;
    self.webView.layer.borderColor = UIColor.clearColor.CGColor;
    self.webView.layer.masksToBounds = true;

    self.webView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.webView.layer.shadowOffset = CGSizeMake(0, 1);
    self.webView.layer.shadowRadius = 4.0;
    self.webView.layer.shadowOpacity = 0.25;
    self.webView.layer.masksToBounds = false;


    [self.backBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.websiteButton addTarget:self action:@selector(websiteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backButtonPressed:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)websiteButtonPressed:(UIButton*)sender {
        
//    NSURL* url = [[NSURL alloc] initWithString: self.websiteUrl];
//    [[UIApplication sharedApplication] openURL: url];
//
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString: self.websiteUrl];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
             NSLog(@"Opened url");
        }
    }];
}



@end
