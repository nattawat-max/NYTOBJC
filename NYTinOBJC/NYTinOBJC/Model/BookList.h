//
//  BookList.h
//  NYTinOBJC
//
//  Created by Nattawat Kanmarawanich on 5/8/2564 BE.
//

#import <Foundation/Foundation.h>
@class BookItem;
@class BookItemMedia;

NS_ASSUME_NONNULL_BEGIN

@interface BookList : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *section;
@property (nonatomic, copy) NSString *numResults;
@property (nonatomic, copy) NSArray<BookItem *> *data;
@end

@interface BookItem : NSObject
@property (nonatomic, copy) NSString *section;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *byline;
@property (nonatomic, copy) NSArray<BookItemMedia *> *multimedia;
@end

@interface BookItemMedia : NSObject
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@end





NS_ASSUME_NONNULL_END

