//
//  SWTeamMasterCollectionView.m
//  MonitizeCreate
//
//  Created by Samuel Ward on 13/09/2014.
//  Copyright (c) 2014 Samuel Ward. All rights reserved.
//

#import "Kiwi.h"

#import "SWAlbumCollectionViewController.h"

#import "SWAlbum.h"
#import "SWAlbumListingCell.h"
#import "SWWebsiteScrapper.h"

@interface SWAlbumCollectionViewController ()

@property (nonatomic, copy) NSArray *teamMembers;

- (void)refresh;

@end

SPEC_BEGIN(SWTeamMasterCollectionViewSpec)

describe(@"SWTeamMasterCollectionView", ^{
   
    context(@"Initialisation", ^{
        
        SWAlbumCollectionViewController __block  *teamMasterCollectionViewController;
        
        beforeEach(^{
            
            teamMasterCollectionViewController = [[SWAlbumCollectionViewController alloc] init];
        });
        
        it(@"should have be non-nil", ^{
            
            [[teamMasterCollectionViewController should] beNonNil];
        });
        
        it(@"should have a class of UICollectionViewController", ^{
           
            [[teamMasterCollectionViewController should] beKindOfClass:[SWAlbumCollectionViewController class]];
        });
    
        it(@"should have an array of team members", ^{
            
            [[teamMasterCollectionViewController should] respondToSelector:@selector(teamMembers)];
        });
        
        it(@"should call refresh", ^{
            
            SWAlbumCollectionViewController *refreshTestController = [SWAlbumCollectionViewController alloc];
            [[refreshTestController should] receive:@selector(refresh)];
            
            id __unused initialisedRefreshController = [refreshTestController init];
        });
    });
    
    context(@"Initialising from storyboard", ^{
       
        SWAlbumCollectionViewController __block *teamMasterCollectionViewController;
        
        beforeEach(^{
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            
             teamMasterCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"teamMasterViewController"];
        });
        
        it(@"should load from the storyboard and have a datasource and delegate", ^{
           
            [[(id)teamMasterCollectionViewController.collectionView.dataSource should] beNonNil];
            [[(id)teamMasterCollectionViewController.collectionView.delegate should] beNonNil];
        });
        
        it(@"should have 1 section", ^{
           
            [[theValue([teamMasterCollectionViewController.collectionView numberOfSections]) should] equal:theValue(1)];
        });
        
        it(@"should have a cell for each team member in section", ^{
            
            teamMasterCollectionViewController.teamMembers = @[
                                                               [[SWAlbum alloc] init],
                                                               [[SWAlbum alloc] init],
                                                               [[SWAlbum alloc] init]
                                                               ];
           
            [[theValue([teamMasterCollectionViewController.collectionView numberOfItemsInSection:0]) should] equal:theValue(3)];
        });
        
        it(@"should have cells of type teamMemberHeadShotCell", ^{
           
            id cell = [teamMasterCollectionViewController.collectionView.dataSource
                       collectionView:teamMasterCollectionViewController.collectionView
                       cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            
            [[cell should] beKindOfClass:[SWAlbumListingCell class]];
        });
    });
    
    context(@"Refreshing", ^{
        
        SWAlbumCollectionViewController __block *teamMasterCollectionViewController;
        
        beforeEach(^{
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            
            teamMasterCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"teamMasterViewController"];
        });
        
        it(@"should start downloading the html page", ^{
           
            [SWWebsiteScrapper stub:@selector(downloadDataWithCompletionBlock:)];
            [[SWWebsiteScrapper should] receive:@selector(downloadDataWithCompletionBlock:)];
            
            [teamMasterCollectionViewController refresh];
        });
        
        it(@"should refresh when the refresh button is pressed", ^{
           
            [[teamMasterCollectionViewController should] receive:@selector(refresh)];
            [teamMasterCollectionViewController refreshButtonPressed:nil];
        });
    });
});

SPEC_END
