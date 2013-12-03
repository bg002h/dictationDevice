//
//  FourthViewController.m
//  mayoDD
//
//  Created by Brian Goss on 11/12/13.
//
//

#import "FourthViewController.h"
#import "myRscMgr.h"
#import "ReportViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController
@synthesize strTypeThis;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] rangeOfString:@"DisplayAbdReport"].location!=NSNotFound){
        //we are dealing with DisplayAbdReport
        //NSLog(@"Liver vc needed...");
        ReportViewController* vc = [segue destinationViewController];
        
        NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
        if (myDictionary)
            self.liverDictionary=myDictionary.mutableCopy;
        
        vc.reportString = [self getMeMyReportNow:self.liverDictionary];
        //vc.delegate=self;
        //vc.segueName=[segue identifier];
        //        vc.lblLiverSegment.text=[segue identifier];
        //[vc setButtonStates:[[self getliverSegButtonStates] objectForKey:[segue identifier]]];
    }
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
    self.strTypeThis = [[NSMutableString alloc]init];
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
    if (myDictionary)
        self.liverDictionary=myDictionary.mutableCopy;
    //do liver sentence extraction here and on update (probably should repeat on viewdidappear
    //[rscMgr setDelegate:rscMgr];
	// Do any additional setup after loading the view.
}


-(NSString *) getLiverLesionSizeDescriptionAndLocationInStringFromDictionary: (NSDictionary*) dict forLesionType: (NSString*)lt restrictingToModifyingFeature1or2orNone:(NSString*)mf{
    NSMutableString *returnMe = [[NSMutableString alloc] init];
    //[returnMe appendString:@""];
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSString* tmpStr=@"";
    
    NSMutableSet *oneSet = [[NSMutableSet alloc]init];
    NSMutableSet *twoSet = [[NSMutableSet alloc]init];
    NSMutableSet *allSet = [[NSMutableSet alloc]init];
    NSMutableSet *setToUse = [[NSMutableSet alloc]init];
    
#define CASE(str)                       if ([__s__ rangeOfString:(str)].location!=NSNotFound)
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT
    
    for (id key in dict){
        if ([key rangeOfString:@"Segment"].location!=NSNotFound){
            [allSet addObject:key];
        }
    }
    
    if ([[mf uppercaseString] isEqualToString:@"NONE"]){
        setToUse=allSet;
    }
    
    if ([[mf uppercaseString] isEqualToString:@"1"]){
        for (id key in allSet){
            if ([[dict objectForKey:key] characterAtIndex:1]=='1'){
                [oneSet addObject:key];
            }
            if ([[dict objectForKey:key] characterAtIndex:4]=='1'){
                [oneSet addObject:key];
            }
        }
        setToUse=oneSet;
    }
    if ([[mf uppercaseString] isEqualToString:@"2"]){
        for (id key in allSet){
            if ([[dict objectForKey:key] characterAtIndex:2]=='1'){
                [twoSet addObject:key];
            }
            if ([[dict objectForKey:key] characterAtIndex:5]=='1'){
                [twoSet addObject:key];
            }
        }
        setToUse=twoSet;
    }
    
    if ([[lt uppercaseString] isEqualToString:@"C"]){
        for (id key in setToUse){
            if ([key rangeOfString:@"Segment"].location!=NSNotFound){
                //we are dealing with a liver segment & looking for lt
                if ([[dict objectForKey:key] characterAtIndex:0]=='1'){
                    //cyst found
                    tmp = [[dict objectForKey:key]
                           componentsSeparatedByString:@"|"].copy;
                    tmpStr=tmp[1];
                    if (tmpStr.length>0){
                        if (returnMe.length>0){
                            [returnMe appendFormat:@", %@",tmp[1]];
                        } else {
                            [returnMe appendFormat:@" %@",tmp[1]];
                        }
                        [returnMe appendString:@" cm"];
                    } else {
                        if (returnMe.length>0){
                            [returnMe appendString:@","];
                        } else {
                            [returnMe appendString:@""];
                        }
                    }
                    if ([[dict objectForKey:key] characterAtIndex:2]=='1'){
                        [returnMe appendString:@" complex"];
                    } else {
                        if ([[dict objectForKey:key]characterAtIndex:1]=='1'){
                            [returnMe appendString:@" simple"];
                        }
                    }
                    
                    [returnMe appendString:@" cyst in the "];
                    
                    SWITCH(key) {
                        CASE(@"8 Upper") {
                            [returnMe appendString:@"right hepatic dome"];
                            break;
                        }
                        CASE(@"8 Lower") {
                            [returnMe appendString:@"upper right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"7 Upper") {
                            [returnMe appendString:@"high in the posterior right hepatic lobe"];
                            break;
                        }
                        CASE(@"7 Lower") {
                            [returnMe appendString:@"mid-upper right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"6 Upper") {
                            [returnMe appendString:@"mid-lower right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"6 Lower") {
                            [returnMe appendString:@"lower right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"5 Upper") {
                            [returnMe appendString:@"mid-lower right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"5 Lower") {
                            [returnMe appendString:@"lower right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"4A Upper") {
                            [returnMe appendString:@"high medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4A Lower") {
                            [returnMe appendString:@"mid-upper medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4B Upper") {
                            [returnMe appendString:@"mid-lower medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4B Lower") {
                            [returnMe appendString:@"low medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"3 Upper") {
                            [returnMe appendString:@"mid-lower lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"3 Lower") {
                            [returnMe appendString:@"low lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"2 Upper") {
                            [returnMe appendString:@"high lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"2 Lower") {
                            [returnMe appendString:@"mid-upper lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"1 Lower") {
                            [returnMe appendString:@"lower caudate lobe"];
                            break;
                        }
                        CASE(@"1 Mid") {
                            [returnMe appendString:@"mid caudate lobe"];
                            break;
                        }
                        CASE(@"1 Upper") {
                            [returnMe appendString:@"upper caudate lobe"];
                            break;
                        }
                        DEFAULT {
                            break;
                        }
                    }
                    
                    //asdf here
                }
            }
        }
    }
    if ([[lt uppercaseString] isEqualToString:@"H"]){
        for (id key in setToUse){
            if ([key rangeOfString:@"Segment"].location!=NSNotFound){
                //we are dealing with a liver segment & looking for lt
                if ([[dict objectForKey:key] characterAtIndex:3]=='1'){
                    //cyst found
                    tmp = [[dict objectForKey:key]
                           componentsSeparatedByString:@"|"].copy;
                    tmpStr=tmp[1];
                    if (tmpStr.length>0){
                        if (returnMe.length>0){
                            [returnMe appendFormat:@", %@",tmp[2]];
                        } else {
                            [returnMe appendFormat:@" %@",tmp[2]];
                        }
                        [returnMe appendString:@" cm"];
                    } else {
                        if (returnMe.length>0){
                            [returnMe appendString:@","];
                        } else {
                            [returnMe appendString:@""];
                        }
                    }
                    if ([[dict objectForKey:key] characterAtIndex:5]=='1'){
                        [returnMe appendString:@" atypical"];
                    } else {
                        if ([[dict objectForKey:key]characterAtIndex:4]=='1'){
                            [returnMe appendString:@" probable"];
                        }
                    }
                    
                    [returnMe appendString:@" hemangioma in the "];
                    
                    SWITCH(key) {
                        CASE(@"8 Upper") {
                            [returnMe appendString:@"right hepatic dome"];
                            break;
                        }
                        CASE(@"8 Lower") {
                            [returnMe appendString:@"upper right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"7 Upper") {
                            [returnMe appendString:@"high in the posterior right hepatic lobe"];
                            break;
                        }
                        CASE(@"7 Lower") {
                            [returnMe appendString:@"mid-upper right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"6 Upper") {
                            [returnMe appendString:@"mid-lower right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"6 Lower") {
                            [returnMe appendString:@"lower right hepatic lobe posteriorly"];
                            break;
                        }
                        CASE(@"5 Upper") {
                            [returnMe appendString:@"mid-lower right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"5 Lower") {
                            [returnMe appendString:@"lower right hepatic lobe anteriorly"];
                            break;
                        }
                        CASE(@"4A Upper") {
                            [returnMe appendString:@"high medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4A Lower") {
                            [returnMe appendString:@"mid-upper medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4B Upper") {
                            [returnMe appendString:@"mid-lower medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"4B Lower") {
                            [returnMe appendString:@"low medial segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"3 Upper") {
                            [returnMe appendString:@"mid-lower lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"3 Lower") {
                            [returnMe appendString:@"low lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"2 Upper") {
                            [returnMe appendString:@"high lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"2 Lower") {
                            [returnMe appendString:@"mid-upper lateral segment of the left hepatic lobe"];
                            break;
                        }
                        CASE(@"1 Lower") {
                            [returnMe appendString:@"lower caudate lobe"];
                            break;
                        }
                        CASE(@"1 Mid") {
                            [returnMe appendString:@"mid caudate lobe"];
                            break;
                        }
                        CASE(@"1 Upper") {
                            [returnMe appendString:@"upper caudate lobe"];
                            break;
                        }
                        DEFAULT {
                            break;
                        }
                    }
                    
                    //asdf here
                }
            }
        }
    }
    
    return returnMe.copy;
}
-(int) countLiverLesionsInDictionary: (NSDictionary *)dict forLesionType:(NSString*)lt consideringLesionsInTheLeftRightOrBothHepaticLobes: (NSString*)lrcb restrictingToModifyingFeature1or2orNone:(NSString*)mf{
    
    int c=0;
    int h=0;
    int m=0;
    int returnMe=0;
    
    NSString *s;
//    NSEnumerator *lrbEnum;
  //  NSEnumerator *tmpSet=[dict keyEnumerator];
    NSMutableSet *bSet = [[NSMutableSet alloc] init];
    NSMutableSet *lSet = [[NSMutableSet alloc]init];
    NSMutableSet *rSet = [[NSMutableSet alloc]init];
    NSMutableSet *cSet = [[NSMutableSet alloc]init];
    NSMutableSet *setToUse=[[NSMutableSet alloc]init];
    
    for (id key in dict){
        [bSet addObject:key];
        if ([key rangeOfString:@"8"].location!=NSNotFound)
            [rSet addObject:key];
        if ([key rangeOfString:@"7"].location!=NSNotFound)
            [rSet addObject:key];
        if ([key rangeOfString:@"6"].location!=NSNotFound)
            [rSet addObject:key];
        if ([key rangeOfString:@"5"].location!=NSNotFound)
            [rSet addObject:key];
        if ([key rangeOfString:@"2"].location!=NSNotFound)
            [lSet addObject:key];
        if ([key rangeOfString:@"3"].location!=NSNotFound)
            [lSet addObject:key];
        if ([key rangeOfString:@"4"].location!=NSNotFound)
            [lSet addObject:key];
        if ([key rangeOfString:@"1"].location!=NSNotFound)
            [cSet addObject:key];
    }
    
    
    if ([[lrcb uppercaseString] isEqualToString:@"R"]){
        setToUse=rSet;
    }
    if ([[lrcb uppercaseString] isEqualToString:@"L"]){
        setToUse=lSet;
    }
    if ([[lrcb uppercaseString] isEqualToString:@"C"]){
        setToUse=cSet;
    }
    if ([[lrcb uppercaseString] isEqualToString:@"B"]){
        setToUse=bSet;
    }
    
    
   
    
    
    for (id key in setToUse){
        //count the number of cysts, hemang,masses in the liver
//        NSLog(@"key in sendString: %@",key);
        s=[dict objectForKey:key];
        
        if ([key rangeOfString:@"Liver"].location!=NSNotFound){//found liver segment entry to make sentence out of
            if ([s characterAtIndex:0]=='1'){
                if ([[mf uppercaseString] isEqualToString:@"NONE"]){
                    c++;
                } else if ([[mf uppercaseString] isEqualToString:@"1"]){
                    if ([s characterAtIndex:1]=='1'){
                        c++;
                    }
                } else if ([[mf uppercaseString] isEqualToString:@"2"]){
                    if ([s characterAtIndex:2]=='1'){
                        c++;
                    }
                }
            }
            if ([s characterAtIndex:3]=='1'){
                if ([[mf uppercaseString] isEqualToString:@"NONE"]){
                    h++;
                } else if ([[mf uppercaseString] isEqualToString:@"1"]){
                    if ([s characterAtIndex:4]=='1'){
                        h++;
                    }
                } else if ([[mf uppercaseString] isEqualToString:@"2"]){
                    if ([s characterAtIndex:5]=='1'){
                        h++;
                    }
                }
            }
            if ([s characterAtIndex:6]=='1')
                m++;
        }
    }
    if ([[lt uppercaseString] isEqualToString:@"C"]){
        returnMe=c;
    }
    if ([[lt uppercaseString] isEqualToString:@"H"]){
        returnMe=h;
    }
    if ([[lt uppercaseString] isEqualToString:@"M"]){
        returnMe=m;
    }
    return returnMe;
}

-(NSString *) getLiverDescriptorInDictionary:(NSDictionary*)dict{
    NSString *returnMe = [[NSMutableString alloc] init];
    NSMutableString *s = [[NSMutableString alloc] init];
    int cirrhotic = 0;
    int nodular = 0;
    
    for (id key in dict){
        if ([[dict objectForKey:key] rangeOfString:@"Fatty"].location!=NSNotFound){
            if (s.length>0){
                [s appendString:@" Fatty liver."];
            } else {
                [s appendString:@"Fatty liver."];
            }
        }
        if ([[dict objectForKey:key] rangeOfString:@"Coarse"].location!=NSNotFound){
            if (s.length>0){
                [s appendString:@" Coarse echotexture consistent with chronic parenchymal disease."];
            } else {
                [s appendString:@"Coarse echotexture consistent with chronic parenchymal disease."];
            }
        }
        if ([[dict objectForKey:key] rangeOfString:@"Cirrhotic"].location!=NSNotFound){
            cirrhotic++;
        }
        if ([[dict objectForKey:key] rangeOfString:@"Nodular"].location!=NSNotFound){
            nodular++;
        }
    }
    if (nodular*cirrhotic>0){
        if (s.length>0){
            [s appendString:@" Cirrhotic liver morphology with nodular contour."];
        } else {
            [s appendString:@"Cirrhotic liver morphology with nodular contour."];
        }
    } else {
        if (cirrhotic>0){
            if (s.length>0){
                [s appendString:@" Cirrhotic liver morphology."];
            } else {
                [s appendString:@"Cirrhotic liver morphology."];
            }
        }
        if (nodular>0){
            if (s.length>0){
                [s appendString:@" Nodular hepatic contour."];
            } else {
                [s appendString:@"Nodular hepatic contour."];
            }
        }
    }
    returnMe=s.copy;
    return returnMe;
}

- (NSString *) getMeMyReportNow:(NSDictionary *)dict{
    NSMutableString *returnMe = [[NSMutableString alloc]initWithString:@""];
    NSMutableString *preamble = [[NSMutableString alloc]initWithString:@""];
    NSMutableString *liverFindings = [[NSMutableString alloc]initWithString:@""];
    NSMutableString *postamble = [[NSMutableString alloc]initWithString:@""];
    
    [preamble appendString:@"EXAM: US abdomen complete.\n\nINDICATION: [autofill]\n\nCOMPARISON: [autofill]\n\nLIVER: ".mutableCopy];
    
    [liverFindings appendString:[self getLiverDescriptorInDictionary:self.liverDictionary]];
    
    int h=[self countLiverLesionsInDictionary:dict forLesionType:@"H" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B" restrictingToModifyingFeature1or2orNone:@"None"];
    int c=[self countLiverLesionsInDictionary:dict forLesionType:@"C" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B" restrictingToModifyingFeature1or2orNone:@"None"];
    
    int hR=[self countLiverLesionsInDictionary:dict forLesionType:@"H" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"R" restrictingToModifyingFeature1or2orNone:@"None"];
    int cR=[self countLiverLesionsInDictionary:dict forLesionType:@"C" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"R" restrictingToModifyingFeature1or2orNone:@"None"];
    
    int hL=[self countLiverLesionsInDictionary:dict forLesionType:@"H" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"L" restrictingToModifyingFeature1or2orNone:@"None"];
    int cL=[self countLiverLesionsInDictionary:dict forLesionType:@"C" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"L" restrictingToModifyingFeature1or2orNone:@"None"];
    
    int hC=[self countLiverLesionsInDictionary:dict forLesionType:@"H" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"C" restrictingToModifyingFeature1or2orNone:@"None"];
    int cC=[self countLiverLesionsInDictionary:dict forLesionType:@"C" consideringLesionsInTheLeftRightOrBothHepaticLobes:@"C" restrictingToModifyingFeature1or2orNone:@"None"];
    
    
    
    if (h>1){
        [liverFindings appendString:@" There are "];
        [liverFindings appendString:[NSString stringWithFormat:@"%d", h]];
        [liverFindings appendString:@" lesions, most likely representing hemangiomas,"];
        if (hC*hR*hL>0){
            [liverFindings appendString:@" throughout the liver"];
        } else if (hR*hL>0){
            [liverFindings appendString:@" with lesions in both the right and left hepatic lobes"];
        } else if (hR==h){
            [liverFindings appendString:@" in the right hepatic lobe"];
        } else if (hL==h){
            [liverFindings appendString:@" in the left hepatic lobe"];
        } else if (hC==h){
            [liverFindings appendString:@" in the caudate lobe"];
        } else if (hC*hR>0){
            [liverFindings appendString:@" in the right liver, including the caudate lobe"];
        } else if (hC*hL>0){
            [liverFindings appendString:@" in the left hepatic lobe as well as the caudate lobe"];
        }
        int atypical = [self countLiverLesionsInDictionary:dict
                                             forLesionType:@"H"
        consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B"
                   restrictingToModifyingFeature1or2orNone:@"2"];
        int probable=[self countLiverLesionsInDictionary:dict
                                           forLesionType:@"H"
      consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B"
                 restrictingToModifyingFeature1or2orNone:@"1"];
        
        if (atypical>1){
            [liverFindings appendString:@", including an"];
            [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                               forLesionType:@"H"
                                                                     restrictingToModifyingFeature1or2orNone:@"2"]];
            
            [liverFindings appendString:@"."];
            
        } else if (atypical>0){
            [liverFindings appendString:@", including an"];
            [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                               forLesionType:@"H"
                                                                     restrictingToModifyingFeature1or2orNone:@"2"]];
            [liverFindings appendString:@"."];
            
        } else if (atypical==0 && probable<h){
            [liverFindings appendString:@". None of these hemangiomas are atypical."];
        } else if (h==probable){
            [liverFindings appendString:@". All of these lesions have imaging characteristics consistent with hemangioma and are most likely benign."];
        }
        
    }
    if (h==1){
        [liverFindings appendString:@" There is a single"];
        [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                           forLesionType:@"H"
                                                                 restrictingToModifyingFeature1or2orNone:@"NONE"]];
        [liverFindings appendString:@"."];
        
    }
    
    
    if (c>1){
        [liverFindings appendString:@" There are "];
        [liverFindings appendString:[NSString stringWithFormat:@"%d", c]];
        [liverFindings appendString:@" cysts"];
        
        if (cC*cR*cL>0){
            [liverFindings appendString:@" throughout the liver"];
        } else if (cR*cL>0){
            [liverFindings appendString:@" with cysts in both the right and left hepatic lobes"];
        } else if (cR==c){
            [liverFindings appendString:@" in the right hepatic lobe"];
        } else if (cL==c){
            [liverFindings appendString:@" in the left hepatic lobe"];
        } else if (cC==h){
            [liverFindings appendString:@" in the caudate lobe"];
        } else if (cC*cR>0){
            [liverFindings appendString:@" in the right liver, including the caudate lobe"];
        } else if (cC*cL>0){
            [liverFindings appendString:@" in the left hepatic lobe as well as the caudate lobe"];
        }
        
        
        int cmplx = [self countLiverLesionsInDictionary:dict
                                          forLesionType:@"C"
     consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B"
                restrictingToModifyingFeature1or2orNone:@"2"];
        int smpl=[self countLiverLesionsInDictionary:dict
                                       forLesionType:@"C"
  consideringLesionsInTheLeftRightOrBothHepaticLobes:@"B"
             restrictingToModifyingFeature1or2orNone:@"1"];
        
        if (cmplx>1){
            [liverFindings appendString:@", including a"];
            [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                               forLesionType:@"C"
                                                                     restrictingToModifyingFeature1or2orNone:@"2"]];
            [liverFindings appendString:@"."];
            
        } else if (cmplx>0){
            [liverFindings appendString:@", including a"];
            [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                               forLesionType:@"C"
                                                                     restrictingToModifyingFeature1or2orNone:@"2"]];
            [liverFindings appendString:@"."];
            
        } else if (cmplx==0 && smpl<c){
            [liverFindings appendString:@". None of these cysts are complex."];
        } else if (c==smpl){
            [liverFindings appendString:@". All of these are simple cysts and should be benign."];
        }
        
        
    }
    if (c==1){
        [liverFindings appendString:@" There is a single"];
        //find out where
        [liverFindings appendString:[self getLiverLesionSizeDescriptionAndLocationInStringFromDictionary:dict
                                                                                           forLesionType:@"C"
                                                                 restrictingToModifyingFeature1or2orNone:@"NONE"]];
        [liverFindings appendString:@"."];
    }

    
    if (liverFindings.length==0){
        [liverFindings appendString:@"Normal."];
    }
    
    [postamble appendString:@"\nSPLEEN: Normal.\nGALLBLADDER: Normal.\nINTRAHEPATIC DUCTS: Not dilated.\nCOMMON DUCT: Not dilated.\nPANCREAS: Normal where seen.\nRIGHT KIDNEY: Normal parenchymal echogenicity. No hdyronephrosis. Survey views negative for mass. Length [autofill].\nLEFT KIDNEY: Normal parenchymal echogenicity. No hdyronephrosis. Survey views negative for mass. Length [autofill].\nAORTA: Normal caliber.\nIVC: Normal where seen.\nASCITES: None."];
    
    [returnMe appendString:preamble];
    [returnMe appendString:liverFindings];
    [returnMe appendString:postamble];
    
    //NSLog(@"strTypeThis is: %@",strTypeThis);
    //NSLog(self.strTypeThis.copy);

    
    
    return (NSString*)returnMe.copy;
}
- (IBAction)sendString:(id)sender {
    //if (strTypeThis.length==0) return;
    NSMutableString *liverFindings = [[NSMutableString alloc]initWithString:@""];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
    if (myDictionary){
        self.liverDictionary=myDictionary;
    }

    self.strTypeThis=[self getMeMyReportNow:self.liverDictionary];
    
    
    NSLog(@"strTypeThis is: %@",strTypeThis);
    NSLog(self.strTypeThis.copy);
    
    
    [rscMgr sendString:self.strTypeThis];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"liverDictionary"];
    UIButton *b;
    NSString *s = @"";


    if (myDictionary){
        //worst code ever; beware! What I'm trying to do is take the dictionary and make a string that has letters and numbers describing the liver masses per segment (stored as upper and lower) in dictionary.  I make a temporary place to store the string (mutable) that will go on the label and put it in an array and append it as I go through the keys in the Dictionary. I am abusing this to also do the fatty liver, coarse echotexture stuff too...This relies on lblLiverSegString: and liverDictonaryParser: ; these also are great examples of terrible code. All I can say is this is what happens when you work for short periods of time with lots of interruptions and little sleep.
        self.liverDictionary=myDictionary;
        
        NSMutableArray *titleStr = [[NSMutableArray alloc] initWithArray:@[@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy,@"".mutableCopy]];
        
        self.liverDictionary=myDictionary.mutableCopy;
        
        //put annotations on liver
        /*[(UIButton*)[self.view viewWithTag:1] setTitle:@"C2H1" forState:UIControlStateNormal];*/

        for (NSString* key in self.liverDictionary){
            if ([key rangeOfString:@"Liver Segment 1"].location != NSNotFound){
                //append string to mutable string in array
                [(UIButton*)[self.view viewWithTag:10] setTitle:titleStr[0] forState:UIControlStateNormal];
                [(NSMutableString*)titleStr[0] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:10] setTitle:titleStr[0] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
               /* b=(UIButton*)[self.view viewWithTag:10];
                s=(NSString*)b.titleLabel.text;
                NSLog(@"key=%@; val=%@; titleStr[0]=%@ ", key, [self lblLiverSegString:key dictionary:self.liverDictionary], s);*/
            }
            if ([key rangeOfString:@"Liver Segment 3"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[1] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:2] setTitle:titleStr[1] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:2] setTitle:titleStr[1] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 2"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[2] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:3] setTitle:titleStr[2] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:3] setTitle:titleStr[2] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
              //  NSLog(@"seg 2 label: %@", [self lblLiverSegString:key dictionary:self.liverDictionary]);

            }
            if ([key rangeOfString:@"Liver Segment 4B"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[3] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:4] setTitle:titleStr[3] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:4] setTitle:titleStr[3] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 4A"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[4] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:5] setTitle:titleStr[4] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:5] setTitle:titleStr[4] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 5"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[5] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:6] setTitle:titleStr[5] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:6] setTitle:titleStr[5] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 8"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[6] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:7] setTitle:titleStr[6] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:7] setTitle:titleStr[6] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 6"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[7] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:8] setTitle:titleStr[7] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:8] setTitle:titleStr[7] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Liver Segment 7"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[8] appendString:[self lblLiverSegString:key dictionary:self.liverDictionary]];
                [(UIButton*)[self.view viewWithTag:9] setTitle:titleStr[8] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:9] setTitle:titleStr[8] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Fatty"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[9] appendString:[self.liverDictionary objectForKey:key]];
                s=[self.liverDictionary objectForKey:key];
                if (s.length>1)
                    [(NSMutableString*)titleStr[9] appendString:@" "];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Coarse"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[9] appendString:[self.liverDictionary objectForKey:key]];
                s=[self.liverDictionary objectForKey:key];
                if (s.length>1)
                    [(NSMutableString*)titleStr[9] appendString:@" "];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Cirrhotic"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[9] appendString:[self.liverDictionary objectForKey:key]];
                s=[self.liverDictionary objectForKey:key];
                if (s.length>1)
                    [(NSMutableString*)titleStr[9] appendString:@" "];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
            if ([key rangeOfString:@"Nodular"].location != NSNotFound){
                //append string to mutable string in array
                [(NSMutableString*)titleStr[9] appendString:[self.liverDictionary objectForKey:key]];
                s=[self.liverDictionary objectForKey:key];
                if (s.length>1)
                    [(NSMutableString*)titleStr[9] appendString:@" "];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal];
                [(UIButton*)[self.view viewWithTag:1001] setTitle:titleStr[9] forState:UIControlStateNormal|UIControlStateSelected|UIControlStateReserved|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateApplication];
            }
        }
    }
    /*for (int i=1; i<11; i++){
        [(UIButton*)[self.view viewWithTag:i] setNeedsDisplay];
        b=[self.view viewWithTag:i];
        s=b.titleLabel.text;
        NSLog(@"view title %d: %@",i,s);
    }*/
//    [self updateAbdReport:<#(NSString *)#> segueName:<#(NSString *)#>]
    [self appendReport:@"Liver: " dict:myDictionary];
    
}

-(void) appendReport: (NSString*) section dict:(NSDictionary*)d{
    
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
    NSMutableArray* returnMe = [[NSMutableArray alloc]initWithArray:@[@"0".mutableCopy,@"0".mutableCopy]];
//    NSSet *liverDescriptorsSet = [[NSSet alloc]initWithArray:@[@"Fatty", @"Coarse", @"CirrhoticM", @"NodularC"]];
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
  /*      CASE(@"LD") {
            for (NSString* key in dict){
                if ([liverDescriptorsSet containsObject:key]){
                    [(NSMutableString*)returnMe[0] appendString:[dict objectForKey:key]];
                    returnMe[1]=@"";
                }
            }
   
            break;
   
        }*/
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


- (IBAction)btnLiver:(id)sender {
    NSLog(@"liver touched");
}

-(void) updateAbdReport:(NSString*)s segueName:(NSString *) segueName{
    
}


@end
