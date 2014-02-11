#import <Foundation/Foundation.h>
#import "MarkdownService.h"

int main (int argc, const char *argv[]) {
	MarkdownService *serviceProvider = [[MarkdownService alloc] init];
	
	NSRegisterServicesProvider(serviceProvider, @"MarkdownService");
	
	NS_DURING
		[[NSRunLoop currentRunLoop] run];
	NS_HANDLER
		NSLog(@"%@", localException);
	NS_ENDHANDLER
	
	exit(0);       // insure the process exit status is 0
	return 0;     // ...and make main fit the ANSI spec.
}
