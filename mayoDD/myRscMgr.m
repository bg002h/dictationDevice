//
//  myRscMgr.m
//  mayoDD
//
//  Created by Brian Goss on 11/12/13.
//
//

#import "myRscMgr.h"
#import "RscMgr.h"

@implementation myRscMgr


-(myRscMgr*) init{
    self = [super init];
    [self open];
    [self setBaud:9600];
    [self setTxMode:YES];
    [self setDelegate:self];
    begin=0;
    end=0;
    chunkSize=64;
    return self;
}
- (void)sendString:(NSString *)text {
    NSLog(@"text from myRscMrg.m sendstring: %@",text);
    if (text.length==0) return;
    for (long k=0; k<LONG_MAX/100; k++){
        if (YES==NO) ;
        
    }
    //    [self.textEntry resignFirstResponder];
    int modemStatus = [self getModemStatus];
	static serialPortStatus portStat;
    [self getPortStatus:&portStat];
    
    
    int bytesToWrite=0;
    
    
    //    NSString *text = self.textEntry.text;
    if (begin == 0){
        //need to check for buffer overflow here
        for (int i=0; i<text.length;i++){
            txBuffer[i]=(int)[text characterAtIndex:i];
        }
        
        end=text.length;
    }
    if (portStat.txAck>0||begin==0){//assume ready to write if 1st time writing
        if (begin+chunkSize<end && end >0 && begin+chunkSize<BUFFER_LEN){
            bytesToWrite = chunkSize;
            int bytesWritten = [self write:txBuffer+begin Length:chunkSize];
            begin+=chunkSize;
        } else {
            bytesToWrite = end-begin;
            int bytesWritten = [self write:txBuffer+begin Length:bytesToWrite];
            // self.textEntry.text = @"";
            begin=0;
            end=0;
        }
    }
    
    
}

- (void) portStatusChanged {
    for (long k=0; k<LONG_MAX/100; k++){
        if (YES==NO) ;
        
    }
    
    NSString *text=[[NSString alloc] initWithCharacters:txBuffer length:end];
    NSLog(@"text from myRscMrg.m portStatusChanged: %@",text);
    
    
    int modemStatus = [self getModemStatus];
	static serialPortStatus portStat;
    [self getPortStatus:&portStat];
    
    int bytesToWrite=0;
    
    
    
    if (end > 0){
        //ie, if something left to write
        //        [self sendString:NULL];
        if (portStat.txAck>0){ //if ready to write more
            if (begin+chunkSize<end && begin+chunkSize<BUFFER_LEN){
                // if we can write a whole chunk, do it
                bytesToWrite = chunkSize;
                int bytesWritten = [self write:txBuffer+begin Length:chunkSize];
                begin+=chunkSize;
            } else {
                //if there's not a whole chunk left to write, just write the last bit and reset
                bytesToWrite = end-begin;
                int bytesWritten = [self write:txBuffer+begin Length:bytesToWrite];
                //serialView.text=[serialView.text stringByAppendingString:self.textEntry.text];
                //self.textEntry.text = @"";
                begin=0;
                end=0;
            }
        }
        return;
    } else {
        //end==0, so nothing left to write
        return;
    }
    
    
    
}

- (void) readBytesAvailable:(UInt32)numBytes{
    int bytesRead = [self read:rxBuffer Length:numBytes];
    NSString *incoming = [[NSString alloc] initWithBytes:rxBuffer length:bytesRead encoding:NSUTF8StringEncoding ];
    
    
    NSLog(@"Read %d bytes from serial cable.",bytesRead);
    
    // self.serialView.text=[self.serialView.text stringByAppendingString:[@"\n" stringByAppendingString:incoming] ];
    //[serialView scrollRangeToVisible:NSMakeRange(serialView.text.length, 0)];
    
}

- (void) didReceivePortConfig {
    
}



- (void) cableConnected:(NSString *)protocol{
    [self open];
    [self setBaud:9600];
    [self setTxMode:YES];
}

- (void) cableDisconnected{
    // [rscMgr release];
}

- (void)setTxMode:(BOOL)on
{
    serialPortConfig portCfg;
	[self getPortConfig:&portCfg];
    
    if(on == YES)
    {
        if(portCfg.txAckSetting == 1) return;
        portCfg.txAckSetting = 1;
    }
    else
    {
        if(portCfg.txAckSetting == 0) return;
        portCfg.txAckSetting = 0;
    }
    
    [self setPortConfig:&portCfg requestStatus: NO];
    
}

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

@end
