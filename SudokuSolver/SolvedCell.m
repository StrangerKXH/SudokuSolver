//
//  SolvedCell.m
//  SudokuSolver
//
//  Created by Kevin He on 12/18/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import "SolvedCell.h"

@implementation SolvedCell

-(instancetype) initWithVals: (NSUInteger)row : (NSUInteger)col : (NSUInteger)value{
    self = [super init];
    if (self) {
        self.row = row;
        self.col = col;
        self.value = value;
    }
    return self;
}

@end
