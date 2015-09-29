//
//  Cell.m
//  SudokuSolver
//
//  Created by Kevin He on 12/17/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import "Cell.h"
@interface Cell()
@property (nonatomic) NSUInteger count; // number of candidates left
@property (nonatomic, strong) NSMutableArray * candidates; // array of booleans
@end

@implementation Cell

- (instancetype)init
{
    self = [super init];
    self.count = 9;
    for(int i = 0 ; i < 9 ; i++){
        [self.candidates insertObject:[NSNumber numberWithBool:YES] atIndex:i];
    }
    return self;
}

- (instancetype)initWithValue:(NSUInteger)value
{
    self = [super init];
    self.count = 1;
    for(int i = 0 ; i < 9 ; i++){
        if(i == value - 1){
            [self.candidates insertObject:[NSNumber numberWithBool:YES] atIndex:i];
        } else {
            [self.candidates insertObject:[NSNumber numberWithBool:NO] atIndex:i];
        }
        
    }
    return self;
}

- (NSMutableArray *) candidates
{
    if(!_candidates) _candidates = [[NSMutableArray alloc] init];
    return _candidates;
}

- (NSUInteger) firstValidCandidate
{
    for(int i = 0 ; i < 9 ; i++){
        if(self.candidates[i]){
            return i;
        }
    }
    return -1;
}

- (NSUInteger) possibilitiesRemaining
{
    return self.count;
}

- (BOOL) candidateValueAt:(NSUInteger) number
{
    return [self.candidates[number] boolValue];
}
- (BOOL) removeCandidate:(NSUInteger) number {
    if ([self.candidates[number] boolValue]) {
        self.candidates[number] = [NSNumber numberWithBool:NO];
        self.count--;
    }
    if (self.count == 0)
        return false;
    return true;
}

@end
