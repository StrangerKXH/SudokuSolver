//
//  ViewController.h
//  SudokuSolver
//
//  Created by Kevin He on 12/16/2013.
//  Copyright (c) 2013 Kevin He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
- (IBAction)didPressNumber:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *gridCollectionView;

@end
