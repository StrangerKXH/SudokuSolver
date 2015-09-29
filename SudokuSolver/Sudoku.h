//
//  Sudoku.h
//  SudokuSolver
//
//  Created by Kevin He on 12/17/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "SolvedCell.h"

@interface Sudoku : NSObject

- (Sudoku *)solve;

- (BOOL) eliminate:(NSInteger)row at:(NSInteger) col at: (NSInteger) val;

- (Sudoku *)init;
- (instancetype)initWithArray:(NSArray *) input;
- (instancetype)initWithPuzzle:(Sudoku *) original;

- (Sudoku *) guess;

- (void) horizontalSolve;
- (void) verticalSolve;
- (void) boxSolve;

- (NSInteger) finalize;

- (BOOL) isSolved;

@end
