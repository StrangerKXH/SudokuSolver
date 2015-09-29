//
//  Cell.h
//  SudokuSolver
//
//  Created by Kevin He on 12/17/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject

- (NSUInteger) firstValidCandidate;
- (NSUInteger) possibilitiesRemaining;
- (BOOL) candidateValueAt:(NSUInteger) number;
- (BOOL) removeCandidate:(NSUInteger) number;
- (instancetype)init;
- (instancetype)initWithValue:(NSUInteger) value;

@end
