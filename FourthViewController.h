//
//  FourthViewController.h
//  mayoDD
//
//  Created by Brian Goss on 11/12/13.
//
//

#import <UIKit/UIKit.h>
#import "myRscMgr.h"
#import "LiverViewController.h"

@interface FourthViewController : UIViewController<abdReportDelegate>{
    myRscMgr *rscMgr;
}
@property (weak, nonatomic) IBOutlet UIButton *seg1Button;
@property (weak, nonatomic) IBOutlet UIButton *seg3Button;
@property (weak, nonatomic) IBOutlet UIButton *seg2Button;
@property (weak, nonatomic) IBOutlet UIButton *seg4BButton;
@property (weak, nonatomic) IBOutlet UIButton *seg4AButton;
@property (weak, nonatomic) IBOutlet UIButton *seg5Button;
@property (weak, nonatomic) IBOutlet UIButton *seg6Button;
@property (weak, nonatomic) IBOutlet UIButton *seg8Button;
@property (weak, nonatomic) IBOutlet UIButton *seg7Button;
@property (weak, nonatomic) IBOutlet UIButton *liverDescriptorButton;
@property (strong, nonatomic) NSMutableString *strTypeThis;

@property (nonatomic,strong) NSDictionary* liverDictionary;

- (IBAction)btnLiver:(id)sender;
- (IBAction)sendString:(id)sender;

-(void) updateAbdReport:(NSString*)s segueName:(NSString *) segueName;


@end
