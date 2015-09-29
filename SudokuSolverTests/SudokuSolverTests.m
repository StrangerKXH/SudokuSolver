//
//  SudokuSolverTests.m
//  SudokuSolverTests
//
//  Created by Kevin He on 12/16/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Sudoku.h"

@interface SudokuSolverTests : XCTestCase

@property (nonatomic, strong) NSArray *puzzle1;

@end

@implementation SudokuSolverTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.puzzle1 = @[@0,@9,@5,@7,@4,@3,@8,@6,@1,
                     @4,@3,@1,@8,@6,@5,@9,@2,@7,
                     @8,@7,@6,@1,@9,@2,@5,@4,@3,
                     @3,@8,@7,@4,@5,@9,@2,@1,@6,
                     @6,@1,@2,@3,@8,@7,@4,@9,@5,
                     @5,@4,@9,@2,@1,@6,@7,@3,@8,
                     @7,@6,@3,@5,@3,@4,@1,@8,@9,
                     @9,@2,@8,@6,@7,@1,@3,@5,@4,
                     @1,@5,@4,@9,@3,@8,@6,@7,@2];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThis
{
    Sudoku *testSolver = [[Sudoku alloc] initWithArray:self.puzzle1];
    [testSolver solve];
    XCTAssertEqual([testSolver isSolved], YES, "Should have been solved");
}

@end
