//
//  RWTSearchResultsTableViewCell.m
//  FlickrSearchMVVMC
//
//  Created by niwanglong on 2018/5/10.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "RWTSearchResultsTableViewCell.h"
#import "RWTSearchResultsItemViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface RWTSearchResultsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *favouritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnFavourites;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@end
@implementation RWTSearchResultsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindViewModel:(id)viewModel{
    RWTSearchResultsItemViewModel *photo = viewModel;
    self.titleLabel.text = photo.title;
    [self.imageThumbnailView sd_setImageWithURL:photo.url];
    [RACObserve(photo, favourites) subscribeNext:^(NSNumber*  _Nullable fav) {
        self.favouritesLabel.text = fav.stringValue;
        self.btnFavourites.hidden = (fav == nil);
    }];
    [RACObserve(photo, comments) subscribeNext:^(NSNumber*  _Nullable com) {
        self.commentsLabel.text = com.stringValue;
        self.btnComment.hidden = (com == nil);
    }];
    
    photo.isVisible = YES;
    [self.rac_prepareForReuseSignal subscribeNext:^(RACUnit * _Nullable x) {
        photo.isVisible = NO;
    }];
}


- (void)setParallax:(CGFloat)value {
//    self.imageThumbnailView.transform = CGAffineTransformMakeTranslation(0, value);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
