//
//  BLCWhiskeyViewController.m
//  Calcuholator
//
//  Created by Brandon Wade on 5/29/15.
//  Copyright (c) 2015 Brandon Wade. All rights reserved.
//

#import "BLCWhiskeyViewController.h"
#import "ViewController.h"


@interface BLCWhiskeyViewController ()

@end

@implementation BLCWhiskeyViewController

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", "Whiskey");
    }
    
    return self;
}

-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.992 green:0.992 blue:0.588 alpha:1];
}

- (void) buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1){
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shots");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ cotains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    
    self.resultLabel.text = resultText;
}

//- (void)sliderValueDidchange:(UISlider*)sender {
//   NSLog(@"Slider value changed to %f", sender.value);
//    [self.beerPercentTextField resignFirstResponder];
    
    //self.title = [NSString stringWithFormat:NSLocalizedString(@"%@ %u glasses", @"Current tab with slider value"), self.title, numberOfWhiskeyGlassesForEquivalentAlcoholAmount];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
