//
//  SolvedCell.h
//  SudokuSolver
//
//  Created by Kevin He on 12/18/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolvedCell : NSObject

@property (nonatomic) NSUInteger row;
@property (nonatomic) NSUInteger col;
@property (nonatomic) NSUInteger value;

-(instancetype) initWithVals: (NSUInteger)row : (NSUInteger)col : (NSUInteger)val;
@end
