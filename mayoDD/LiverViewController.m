//
//  LiverViewController.m
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import "LiverViewController.h"

@interface LiverViewController ()

@end


@implementation LiverViewController
@synthesize liverSegButtonStates=_liverSegButtonStates;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] rangeOfString:@"Liver"].location!=NSNotFound){
        //we are dealing with liver
        NSLog(@"Liver vc needed...");
        LiverSegViewController* vc = [segue destinationViewController];
        vc.delegate=self;
        vc.segueName=[segue identifier];
        //        vc.lblLiverSegment.text=[segue identifier];
        [vc setButtonStates:[[self getliverSegButtonStates] objectForKey:[segue identifier]]];
    }
}

/*
 - (int) getNumberFromSegueName:(NSString*) segueName{
 // Intermediate
 NSString *numberString;
 NSScanner *scanner = [NSScanner scannerWithString:segueName];
 NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"12345678"];
 
 // Throw away characters before the first number.
 [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
 
 // Collect numbers.
 [scanner scanCharactersFromSet:numbers intoString:&numberString];
 
 // Result.
 int number = [numberString integerValue];
 return number;
 }
 */

- (void) setliverSegButtonStates:(NSMutableDictionary *)segStates{
    _liverSegButtonStates = segStates;
    
}

- (NSMutableDictionary*) getliverSegButtonStates{
    if (!_liverSegButtonStates){
        
        NSArray* defaultSegStates = @[@"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"000000000000000|||",
                                      @"",
                                      @"",
                                      @"",
                                      @"",
                                      ];
        
        NSArray* segmentNames = @[@"Liver Segment 1 Lower",
                                  @"Liver Segment 1 Mid",
                                  @"Liver Segment 1 Upper",
                                  @"Liver Segment 3 Lower",
                                  @"Liver Segment 3 Upper",
                                  @"Liver Segment 4B Lower",
                                  @"Liver Segment 4B Upper",
                                  @"Liver Segment 5 Lower",
                                  @"Liver Segment 5 Upper",
                                  @"Liver Segment 6 Lower",
                                  @"Liver Segment 6 Upper",
                                  @"Liver Segment 2 Lower",
                                  @"Liver Segment 2 Upper",
                                  @"Liver Segment 4A Lower",
                                  @"Liver Segment 4A Upper",
                                  @"Liver Segment 8 Lower",
                                  @"Liver Segment 8 Upper",
                                  @"Liver Segment 7 Lower",
                                  @"Liver Segment 7 Upper",
                                  @"Fatty",
                                  @"Coarse",
                                  @"CirrhoticM",
                                  @"NodularC"
                                  ];
        _liverSegButtonStates=[[NSMutableDictionary alloc] initWithObjects:defaultSegStates forKeys:segmentNames];
        
        [[NSUserDefaults standardUserDefaults] setObject:(NSDictionary*)_liverSegButtonStates.copy forKey:@"liverDictionary"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    return _liverSegButtonStates;
}

- (void) updateLiverSeg: (NSString*)segState segueName:(NSString*)segueName{
    [self.liverSegButtonStates setObject:segState forKey:segueName];
}

-(IBAction)updateLiverReport:(UIButton*)sender{
    switch (sender.tag) {
        case 101:
            if (sender.isSelected){
                [self updateLiverReport:@"" segueName:@"Fatty"];
                [sender setSelected:NO];
            } else {
                [self updateLiverReport:@"Fatty" segueName:@"Fatty"];
                [sender setSelected:YES];
            }
            break;
        case 102:
            if (sender.isSelected){
                [self updateLiverReport:@"" segueName:@"Coarse"];
                [sender setSelected:NO];
            } else {
                [self updateLiverReport:@"Coarse" segueName:@"Coarse"];
                [sender setSelected:YES];
            }
            break;
        case 103:
            if (sender.isSelected){
                [self updateLiverReport:@"" segueName:@"CirrhoticM"];
                [sender setSelected:NO];
            } else {
                [self updateLiverReport:@"Cirrhotic" segueName:@"CirrhoticM"];
                [sender setSelected:YES];
            }
            break;
        case 104:
            if (sender.isSelected){
                [self updateLiverReport:@"" segueName:@"NodularC"];
                [sender setSelected:NO];
            } else {
                [self updateLiverReport:@"Nodular" segueName:@"NodularC"];
                [sender setSelected:YES];
            }
            break;
            
        default:
            break;
    }
}


- (void) updateLiverReport:(NSString*)s segueName:(NSString *)segueName{
    NSLog(@"String: %@, Segue: %@",s,segueName);
    [self updateLiverSeg:s segueName:segueName];
    //save dictionary
    [[NSUserDefaults standardUserDefaults] setObject:(NSDictionary*) self.liverSegButtonStates.copy forKey:@"liverDictionary"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
    if (myDictionary)
        [self setliverSegButtonStates:myDictionary.mutableCopy];
    
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[[self presentingViewController] viewWillAppear:YES];
    
    NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
    if (myDictionary)
        self.liverSegButtonStates=myDictionary.mutableCopy;
    
    for (NSString* key in [self getliverSegButtonStates]){
        if ([key isEqualToString:@"Liver Segment 1 Lower"]){
            self.lblSeg1Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 1 Mid"]){
            self.lblSeg1Mid.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 1 Upper"]){
            self.lblSeg1Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 3 Lower"]){
            self.lblSeg3Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 3 Upper"]){
            self.lblSeg3Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 4B Lower"]){
            self.lblSeg4BLower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 4B Upper"]){
            self.lblSeg4BUpper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 5 Lower"]){
            self.lblSeg5Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 5 Upper"]){
            self.lblSeg5Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 6 Lower"]){
            self.lblSeg6Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 6 Upper"]){
            self.lblSeg6Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 2 Lower"]){
            self.lblSeg2Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 2 Upper"]){
            self.lblSeg2Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 4A Lower"]){
            self.lblSeg4ALower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 4A Upper"]){
            self.lblSeg4AUpper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 8 Lower"]){
            self.lblSeg8Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 8 Upper"]){
            self.lblSeg8Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 7 Lower"]){
            self.lblSeg7Lower.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Liver Segment 7 Upper"]){
            self.lblSeg7Upper.text=[self lblLiverSegString:key dictionary:[self getliverSegButtonStates]];
        }
        if ([key isEqualToString:@"Fatty"]){
            if ( [(NSString*)[[self getliverSegButtonStates] objectForKey:key] isEqualToString:@"Fatty"]){
                [self.btnFatty setSelected:YES];
            } else {
                [self.btnFatty setSelected:NO];
            }
        }
        if ([key isEqualToString:@"Coarse"]){
            if ( [(NSString*)[[self getliverSegButtonStates] objectForKey:key] isEqualToString:@"Coarse"]){
                [self.btnCoarse setSelected:YES];
            } else {
                [self.btnCoarse setSelected:NO];
            }
        }
        if ([key isEqualToString:@"CirrhoticM"]){
            if ( [(NSString*)[[self getliverSegButtonStates] objectForKey:key] isEqualToString:@"Cirrhotic"]){
                [self.btnCirrhoticM setSelected:YES];
            } else {
                [self.btnCirrhoticM setSelected:NO];
            }
        }
        if ([key isEqualToString:@"NodularC"]){
            if ( [(NSString*)[[self getliverSegButtonStates] objectForKey:key] isEqualToString:@"Nodular"]){
                [self.btnNodularC setSelected:YES];
            } else {
                [self.btnNodularC setSelected:NO];
            }
        }
        
        
    }
}

- (NSString*) lblLiverSegString: (NSString*) seg dictionary:(NSDictionary*)dict{
    NSMutableString *returnMe = [[NSMutableString alloc]init];
    NSArray *lesionTypes=@[@"C",@"H",@"M"];
    NSMutableArray *dictParseResult = [[NSMutableArray alloc] init];
    
    for (NSString* lt in lesionTypes){
        [dictParseResult addObjectsFromArray:[self liverDictionaryParser:seg lesion:lt dictionary:dict]];
    }
    //now we have dictParseResult as an array with 6 elements, all strings, with 0, 2, 4 being 1 or 0 and 1,3,5 being "sizes"
    //build string to return
    int j=0;
    for (int idx=0; idx<5; idx+=2){
        if ([dictParseResult[idx] isEqualToString:@"1"]){
            [returnMe appendString:lesionTypes[j]];
            //pardon my sloppiness; I'm not checking on input into liver lesion size field to be _certain_ a string is a valid float, so, look for various representations of 0 here
            if ( !(([dictParseResult[idx+1] isEqualToString:@""]) || ([dictParseResult[idx+1] isEqualToString:@"0"]) || ([dictParseResult[idx+1] isEqualToString:@"0."]) || ([dictParseResult[idx+1] isEqualToString:@"0.0"]) || ([dictParseResult[idx+1] isEqualToString:@"0.00"])) ){
                [returnMe appendString:dictParseResult[idx+1]];
            }
        }
        j++;
    }
    return returnMe;
}

- (NSArray*) liverDictionaryParser: (NSString*)seg lesion:(NSString*) lesionType dictionary:(NSDictionary*)dict{
    
    NSArray* tmp = [[dict objectForKey:seg] componentsSeparatedByString:@"|"];
    NSMutableArray* returnMe = [[NSMutableArray alloc]initWithArray:@[@"0",@"0"]];
    if (tmp.count<4)
        return returnMe;
    
#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT
    
    SWITCH(lesionType.uppercaseString) {
        CASE(@"C") {
            returnMe[0]=[NSString stringWithFormat:@"%c",[tmp[0] characterAtIndex:0]];//[NSString stringWithCharacters:[tmp[0] characterAtIndex:1] length:1];
            returnMe[1]=tmp[1];
            break;
        }
        CASE(@"H") {
            returnMe[0]=[NSString stringWithFormat:@"%c",[tmp[0] characterAtIndex:3]];
            returnMe[1]=tmp[2];
            break;
        }
        CASE(@"M") {
            returnMe[0]=[NSString stringWithFormat:@"%c",[tmp[0] characterAtIndex:6]];
            returnMe[1]=tmp[3];
            break;
        }
        DEFAULT {
            break;
        }
    }
    return (NSArray*)returnMe.copy;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)tapLiverTop:(UITapGestureRecognizer *)sender {
 CGPoint tapPoint = [sender locationInView:sender.view];
 float w = sender.view.frame.size.width;
 float h = sender.view.frame.size.height;
 
 NSLog(@"tapPoint x: %f, y: %f", tapPoint.x/w, tapPoint.y/h);
 }
 
 - (IBAction)tapLiverBottom:(UITapGestureRecognizer *)sender {
 self.labelTapped.text=@"Tapped: Bottom";
 
 }
 */


@end
