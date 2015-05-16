//
//  ViewController.m
//  Calcuholator
//
//  Created by Brandon Wade on 4/24/15.
//  Copyright (c) 2015 Brandon Wade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber ==0){
        sender.text = nil;
    }
}


- (IBAction)sliderValueDidchange:(UISlider*)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];

    float sliderVal = sender.value;
    NSInteger *sliderInt = (int) sliderVal;
    NSString *sliderString = [NSString stringWithFormat:@"%u", sliderInt];
    
    self.sliderLabel.text = sliderString;
}


- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    NSString *tempString = _beerPercentTextField.text;//[self.beerPercentTextField floatValue] is not supported by UITextField
    float alcoholPercentageOfBeer = [tempString floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1){
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beers");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1){
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    //CGSize size = [self.resultLabel.text sizeWithAttributes:@{NSFontAttributeName: self.resultLabel.font}];
    //CGRect frame = self.resultLabel.frame;
    //frame.size.height = size.height + 10.f;
    //self.resultLabel.frame = frame;
    
}

- (IBAction)tapGestureDidFire:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}



@end
