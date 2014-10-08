//
//  SWTeamMasterCollectionView.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 14/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "SWAlbumTableViewController.h"

#import "SWAlbum.h"
#import "SWRequest.h"
#import "SWAlbumDetailViewController.h"
#import "SWCircularImageView.h"
#import "SWAlbumTableViewCell.h"

@interface SWAlbumTableViewController () <UITableViewDataSource, UISearchDisplayDelegate>

@property (nonatomic, copy) NSArray *albums;
@property (nonatomic) UILabel *error;
@property (nonatomic) NSArray *searchResults;
@property (nonatomic) NSTimer *timer;

@end

@implementation SWAlbumTableViewController

#pragma mark - Initialisation 

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self refresh];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self refresh];
    }
    
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"iTunes Search";
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Refreshing

- (void)loadImagesForAlbums {
    
    for (int i = 0; i < self.albums.count; ++i) {
        
        SWAlbum *album = self.albums[i];
        
        [album getImageWithCompletionBlock:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
                SWAlbumTableViewCell *cell = (SWAlbumTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                
                [self.tableView reloadData];
                
                cell.albumImageView.alpha = 1.0f;
            });
        }];
    }
}

- (void)refresh {
    
    [SWRequest downloadDataForSearchTerm:self.searchDisplayController.searchBar.text
                             withCompletionBlock:^(BOOL success, NSArray *albums) {
       
        if (success) {
            
            self.albums = albums;
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.tableView reloadData];
                [self.searchDisplayController.searchResultsTableView reloadData];
                [self.searchDisplayController setActive:NO animated:YES];
            });
            
            [self loadImagesForAlbums];
            
        } else {
            
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                       message:NSLocalizedString(@"An internet connection is needed initally, press Refresh when you have data access", nil)
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                             otherButtonTitles:nil] show];
        }
    }];
}

- (IBAction)refreshBarButtonPressed:(id)sender {
    
    [self refresh];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return [self.searchResults count];
    }
    else {
        
        return [self.albums count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"albumTableViewCell";
    SWAlbumTableViewCell *cell = (SWAlbumTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[SWAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        SWAlbum *album = [self.searchResults objectAtIndex:indexPath.row];
        cell.albumNameLabel.text = album.albumName;
        cell.artistLabel.text = album.artistName;
        cell.trackName.text = album.trackName;
        cell.albumImageView.image = album.image;
    }
    else {
        
        SWAlbum *album = [self.albums objectAtIndex:indexPath.row];
        cell.albumNameLabel.text = album.albumName;
        cell.artistLabel.text = album.artistName;
        cell.trackName.text = album.trackName;
        cell.albumImageView.image = album.image;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SWAlbumDetailViewController *vc = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    SWAlbum *album = self.albums[indexPath.item];
    vc.trackName = album.trackName;
    vc.albumName = album.albumName;
    vc.artistName = album.artistName;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-dd-MM'T'HH:mm:ss'Z'";
    NSDate *utc = [fmt dateFromString:album.releaseDateString];
    fmt.timeZone = [NSTimeZone systemTimeZone];
    
    [fmt setDateFormat:@"M/d/yy"];
    NSString *local = [fmt stringFromDate:utc];
    
    NSLog(@"%@", local);
    
    vc.releaseDate = local;
    vc.priceName = album.priceString;
    vc.headshotImage = album.image;
    vc.title = album.trackName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

#pragma mark - Search

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"artistName contains[c] %@", searchText];
    self.searchResults = [self.albums filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range
  replacementText:(NSString *)text {
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(refresh)
                                                userInfo:nil
                                                 repeats:NO];
    
    return YES;
}

@end
