//
//  HistoryDataViewScreenHistoryDataViewScreenDisplayNode.h
//  Weather
//
//  Created by Maksim Bunkow on 24/04/2018.
//  Copyright 2018 Bimawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASCollectionNode;

@interface HistoryDataViewScreenDisplayNode : ASDisplayNode

@property(nonatomic, strong, readonly) ASCollectionNode *collectionNode;
@end