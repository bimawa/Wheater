//
//  UIControl+RACSignalSupport.m
//  ReactiveCocoa
//
//  Created by Josh Abernathy on 4/17/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "ASControlNode+RACSignalSupport.h"
#import "ReactiveCocoa/RACEXTScope.h"
#import "RACCompoundDisposable.h"
#import "RACDisposable.h"
#import "RACSignal.h"
#import "RACSubscriber.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"

@implementation ASControlNode (RACSignalSupport)

- (RACSignal *)rac_signalForControlEvents:(ASControlNodeEvent)controlEvents
{
  @weakify(self);

  return [[RACSignal
      createSignal:^(id <RACSubscriber> subscriber) {
        @strongify(self);

        [self addTarget:subscriber action:@selector(sendNext:) forControlEvents:controlEvents];
        [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
          [subscriber sendCompleted];
        }]];

        return [RACDisposable disposableWithBlock:^{
          @strongify(self);
          [self removeTarget:subscriber action:@selector(sendNext:) forControlEvents:controlEvents];
        }];
      }]
      setNameWithFormat:@"%@ -rac_signalForControlEvents: %lx", self.description, (unsigned long) controlEvents];
}

@end
