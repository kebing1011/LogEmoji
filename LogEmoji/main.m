//
//  main.m
//  LogEmoji
//
//  Created by Mao on 12/2/15.
//  Copyright (c) 2015 00000. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL emoji2hex(NSString *emoji) {
	NSData* data = [emoji dataUsingEncoding:NSUTF16BigEndianStringEncoding];
	NSMutableString* outString = [NSMutableString string];
	
	
	//Unicode:
	[outString appendString:@"Unicode:"];

	for (int i = 0; i < data.length; ++i) {
		if (i % 2 == 0) {
			[outString appendString:@" U+"];
		}
		
		UInt8 value = 0x00;
		[data getBytes:&value range:NSMakeRange(i, 1)];
		
		[outString appendFormat:@"%02X", value];
	}
	
	//utf-8
	[outString appendString:@", UTF-8: "];
	data = [emoji dataUsingEncoding:NSUTF8StringEncoding];
	
	for (int i = 0; i < data.length; ++i) {
		UInt8 value = 0x00;
		[data getBytes:&value range:NSMakeRange(i, 1)];
		
		[outString appendFormat:@"%02X ", value];
	}
	
	if (data) {
		printf("%s\n", [outString cStringUsingEncoding:NSUTF8StringEncoding]);
		return YES;
	}else {
		return NO;
	}
}

void loghelp() {
	printf("usage: emoji2hex emoji\n");
}


int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		
		if (argc != 2) {
			loghelp();
			
			return 0;
		}
		
		NSString* emoji = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
		
		//输出
		if (!emoji2hex(emoji)) {
			loghelp();
		}
	}
    return 0;
}


