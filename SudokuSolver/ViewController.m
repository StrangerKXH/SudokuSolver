//
//  ViewController.m
//  SudokuSolver
//
//  Created by Kevin He on 12/16/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import "ViewController.h"
#import "Sudoku.h"
#import "SudokuCollectionViewCell.h"

@interface ViewController ()

@property (strong, nonatomic) Sudoku *model;
@property (weak, nonatomic) SudokuCollectionViewCell *currentlySelectedCell;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gridCollectionView.backgroundColor = [UIColor blueColor];
//    [self sudokuToView:solvedPuzzle];
    [self.gridCollectionView registerNib:[UINib nibWithNibName:@"SudokuCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"Cell"];
}

- (IBAction)didPressSolve:(id)sender
{
    
}

- (IBAction)didPressNumber:(id)sender
{
    
}

- (void)viewsToArray
{
    
}

- (void)sudokuToView:(Sudoku *)solvedSudoku
{
    
}

#pragma mark - UICollectionViwDelegate & UICollectionViewDatasource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.currentlySelectedCell){
//        self.currentlySelectedCell.highlighted = NO;
    }
    self.currentlySelectedCell = (SudokuCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    self.currentlySelectedCell.highlighted = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SudokuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.digitLabel.text = [NSString stringWithFormat:@"%d", rand()%10];
    return cell;
}



@end
