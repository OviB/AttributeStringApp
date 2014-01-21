//
//  DetailViewController.m
//  AttributeStringApp
//
//  Created by Ovi Bortas on 1/21/14.
//  Copyright (c) 2014 Ovi Bortas. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString*)charactersWithAttributes:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc]init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        // While index is less than textToAnalyze go thought textToAnalyze and find all the characters with the specified attribute name and store it into value and store the range that it applies at
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        
        // If you find a character with that attribute store those characters in "characters"
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            // Increase the index from the current location and the length of the characters
            index = range.location + range.length;
            
            // If you dont find a character with the specified attribute name then increase the index by 1
        } else {
            index++;
        }
    }
    
    return characters;
}

- (void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%lu colorful characters", (unsigned long)[[self charactersWithAttributes:NSForegroundColorAttributeName] length]];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%lu outline characters", (unsigned long)[[self charactersWithAttributes:NSStrokeWidthAttributeName] length]];
    

}

#pragma  mark - Custome Getters/Setters
- (void)setTextToAnalyze:(NSMutableAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI]; // Only gets hit if your on screen
}

@end
