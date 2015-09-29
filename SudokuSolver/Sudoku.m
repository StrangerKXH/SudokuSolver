//
//  Sudoku.m
//  SudokuSolver
//
//  Created by Kevin He on 12/17/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import "Sudoku.h"
@interface Sudoku() {
    Cell * puzzle[9][9];
}

@property (nonatomic, strong) NSMutableArray * finalStack;

@end

@implementation Sudoku

- (instancetype) initWithPuzzle:(Sudoku *)original
{
    self = [super init];
    self.finalStack = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 9 ; i++) {
        for(int j = 0 ; j < 9 ; j++) {
            if (1 == [original->puzzle[i][j] possibilitiesRemaining]) {
                puzzle[i][j] = [[Cell alloc] initWithValue:[original->puzzle[i][j] firstValidCandidate]];
            } else {
                for(int k = 1 ; k < 10 ; k++) {
                    if( ![self->puzzle[i][j] candidateValueAt:k] ) {
                        [puzzle[i][j] removeCandidate:k];
                    }
                }
            }
        }
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *) input
{
    self = [super init];
    self.finalStack = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < 81 ; i++){
        if( [[input objectAtIndex:i] isEqualToNumber:[NSNumber numberWithInt:0]]){
            Cell * newCell = [[Cell alloc] init];
            puzzle[i/9][i%9] = newCell;
        } else {
            Cell * newCell = [[Cell alloc] initWithValue:[input[i] intValue]];
            puzzle[i/9][i%9] = newCell;
//            SolvedCell * newSolvedCell = [[SolvedCell alloc] initWithVals:i/9 :i%9 :[input[i] intValue]];
//            [self.finalStack addObject:newSolvedCell];
        }
    }
    return self;
}

- (NSMutableArray *) puzzleMatrix
{
    NSMutableArray * matrix = [NSMutableArray array];
    for(int i = 0 ; i < 9 ; i++ ){
        for(int j = 0 ; j < 9 ; j++){
            [matrix addObject:[NSNumber numberWithInteger:[puzzle[i][j] firstValidCandidate]]];
        }
    }
    return matrix;
}

- (Sudoku *) solve {
    [self horizontalSolve];
    [self verticalSolve];
    [self boxSolve];
    NSInteger state = [self finalize];
    
    if (state == -1) {
        return nil;
    } else if ( [self isSolved] ){
        return self;
    } else if (state == 0) { // otherwise if there are no solvable cells left, take a guess
        Sudoku * newPuzzle = [self guess];
        [newPuzzle solve];
        if(![newPuzzle solve]) { // if it fails, solve for the next guess candidate
            return [self solve];
        }
        return newPuzzle;
    } else {
        return [self solve]; // return the guess puzzle
    }
}

- (id)guess
{
    int fewestC = 0, fewestR = 0;
	NSInteger numCandidates = 9;
	for(int i = 0 ; i < 9 ; i++ ){
		for(int j = 0 ; j < 9 ; j++){
			if( [puzzle[i][j] possibilitiesRemaining] > 1 && [puzzle[i][j] possibilitiesRemaining] < numCandidates){
				numCandidates = [puzzle[i][j] possibilitiesRemaining];
				fewestC = i;
				fewestR = j;
			}
		}
	}
	NSInteger guessNum = [puzzle[fewestR][fewestC] firstValidCandidate];
	Sudoku * version = [[Sudoku alloc] initWithPuzzle:self];
	[puzzle[fewestR][fewestC] removeCandidate:guessNum];
	if(numCandidates == 2){
        if( [self eliminate:fewestR at:fewestC at:[puzzle[fewestR][fewestC] firstValidCandidate]] == NO ){
			while(![self.finalStack count]){
				[self.finalStack removeLastObject];
			}
			return nil;
		}
	}
	[version.finalStack addObject:[[SolvedCell alloc] initWithVals:fewestR :fewestC :guessNum]]; // push the guessed solved cell the the new puzzle's stack
	return version;
}

- (BOOL)eliminate:(NSInteger)row at:(NSInteger) col at: (NSInteger) val
{
    for(int i = 0 ; i < 9 ; i++){
        if (i != col){
            NSInteger oldCand = [puzzle[row][i] possibilitiesRemaining];
            if(![puzzle[row][i] removeCandidate:val]){
                return NO;
            }
            if ( [puzzle[row][i] possibilitiesRemaining] == 1 && oldCand != 1){
                SolvedCell * scell = [[SolvedCell alloc] initWithVals:row
                                                                     :i
                                                                     :[puzzle[row][i] firstValidCandidate]];
                [self.finalStack addObject:scell];
            }
        }
        
    }
    for (int j = 0; j < 9; j++) {
		if (j != row) {
			NSInteger oldCand = [puzzle[j][col] possibilitiesRemaining];
			if (![puzzle[j][col] removeCandidate:val]) {
				return NO;
			}
			if ( [puzzle[j][col] possibilitiesRemaining] == 1 && oldCand != 1) {
				SolvedCell * scell = [[SolvedCell alloc] initWithVals:j
                                                                     :col
                                                                     :[puzzle[j][col] firstValidCandidate]];
                [self.finalStack addObject:scell];
			}
		}
	}
    NSInteger x = (col/3)*3;
	NSInteger y = (row/3)*3;
    for(NSInteger i = y ; i < y + 3 ; i++){
        for( NSInteger j = x ; j < x + 3 ; j++){
            if( !(i == row && j == col)){
                NSInteger oldCand = [puzzle[i][j] possibilitiesRemaining];
                if(![puzzle[i][j] removeCandidate:val]){
                    return NO;
                }
                if( [puzzle[i][j] possibilitiesRemaining] && oldCand != 1){
                    SolvedCell * scell = [[SolvedCell alloc] initWithVals:i
                                                                         :j
                                                                         :[puzzle[i][j] firstValidCandidate]];
                    [self.finalStack addObject:scell];
                }
            }
        }
    }
    return YES;
}

- (void) horizontalSolve
{
    for ( int i = 0 ; i < 9 ; i++){
        for ( int k = 0 ; k < 9 ; k++ ){
            NSInteger remainingCandidateCount = 0;
            NSInteger row;
            NSInteger col;
            for (int j = 0 ; j < 9 ; j++){
                if( [puzzle[i][j] candidateValueAt:k] ){
                    remainingCandidateCount++;
                    row = i;
                    col = j;
                }
            }
            if(1 == remainingCandidateCount && 1 != [puzzle[row][col] possibilitiesRemaining]){
                SolvedCell * scell = [[SolvedCell alloc] initWithVals:row
                                                                     :col
                                                                     :k];
                [self.finalStack addObject:scell];
            }
        }
    }
}

- (void) verticalSolve
{
    for ( int i = 0 ; i < 9 ; i++){
        for ( int k = 0 ; k < 9 ; k++ ){
            NSInteger isUnique = 0;
            NSInteger row;
            NSInteger col;
            for (int j = 0 ; j < 9 ; j++){
                if( [puzzle[j][i] candidateValueAt:k] ){
                    isUnique++;
                    row = j;
                    col = i;
                }
            }
            if(1 == isUnique && 1 != [puzzle[row][col] possibilitiesRemaining]){
                SolvedCell * scell = [[SolvedCell alloc] initWithVals:row
                                                                     :col
                                                                     :k];
                [self.finalStack addObject:scell];
            }
        }
    }
}

- (void) boxSolve
{
    for ( int i = 0 ; i < 9 ; i++){
        for ( int k = 0 ; k < 9 ; k++ ){
            NSInteger isUnique = 0;
            NSInteger row;
            NSInteger col;
            for (int j = 0 ; j < 9 ; j++){
                if( [puzzle[j][i] candidateValueAt:k] ){
                    isUnique++;
                    row = j;
                    col = i;
                }
            }
            if(isUnique == 1 && 1 != [puzzle[row][col] possibilitiesRemaining]){
                SolvedCell * scell = [[SolvedCell alloc] initWithVals:row
                                                                     :col
                                                                     :k];
                [self.finalStack addObject:scell];
            }
        }
    }
}

-(BOOL)isSolved
{
    for (int i = 0 ; i < 81 ; i++) {
        if(1 != [puzzle[i/9][i%9] possibilitiesRemaining]) {
            return NO;
        }
    }
    return YES;
}

- (NSInteger) finalize
{
    if (0 == [self.finalStack count]) {
        return 0;
    }
    while ([self.finalStack count] > 0) {
        SolvedCell *lastCell = [self.finalStack lastObject];
        NSInteger k = lastCell.value;
        NSInteger theRow = lastCell.row;
        NSInteger theCol = lastCell.col;
        for (int i = 0; i < 9; i++) {
            if (i != k) {
                if (![puzzle[theRow][theCol] removeCandidate:i]) {
                    return -1;
                }
            }
        }
        [self.finalStack removeLastObject];
        
        if (![self eliminate:theRow at:theCol at:k]) {
            return -1;
        }
    }
    return 1;
}

@end
