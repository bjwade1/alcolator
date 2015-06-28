//
//  ViewController.m
//  Calcuholator
//
//  Created by Brandon Wade on 4/24/15.
//  Copyright (c) 2015 Brandon Wade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UILabel *sliderLabel;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) UIButton *calculateButton;

@end

@implementation ViewController

- (void)loadView{
    
    // Allocating and initializing the all-encompassing view
    self.view = [[UIView alloc] init];
    
    //Allocating and initializing the views and gesture recognizers
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    //Adding each view and the gesture recognizer as the view's subview
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //Assigning the views and gesture recognizer to the properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Primary view's background color set to lightGray
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.beerPercentTextField.delegate = self;
    
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content Per Beer", @"Beer percent placeholder in text");
    
    //Tell self.beerCountSlider to call "[self -sliderValueDidChange:]" when its value changes
    //Same function as IBAction
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidchange:) forControlEvents:UIControlEventValueChanged];
    
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    //Tell self.calculateButton to call [self -buttonPressed] when finger is lifted within bounds of the button
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Button title
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    //Tell the tap gesture recognizer to call [self -tapGestureDidFire:] when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    //Get rid of maximum number of lines for label OR ELSE
    self.resultLabel.numberOfLines = 0;
    
    int *sliderInt = (int) [self.beerCountSlider value];
    NSString *thisTitle = @"Wine";
    self.title = [NSString stringWithFormat: NSLocalizedString(@"%@ %u glasses", "Title with current tab and number of glasses"), thisTitle, sliderInt];

    
}
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGSize viewSize = self.view.frame.size;
    CGFloat viewWidth = viewSize.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding + 50, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + 10, itemWidth, itemHeight);
    
    CGFloat bottomOfSlier = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlier + 10, itemWidth, itemHeight*2);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + 10, itemWidth, itemHeight);
    
}
     - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber ==0){
        sender.text = nil;
    }
}


- (void)sliderValueDidchange:(UISlider*)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    int *sliderInt = (int) [self.beerCountSlider value];
    NSString *sliderString = [NSString stringWithFormat:@"%u", sliderInt];
    
    self.sliderLabel.text = sliderString;
}


- (void)buttonPressed:(id)sender {
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

- (void)tapGestureDidFire:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}



@end
