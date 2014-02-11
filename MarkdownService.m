#import "MarkdownService.h"

@implementation MarkdownService

- (void)doMarkdownService:(NSPasteboard *)pboard
					  userData:(NSString *)data
						  error:(NSString **)error
{
	
	NSString *post = [pboard stringForType:NSStringPboardType];
	
	NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
	NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
	
	NSURL *url = [NSURL URLWithString:@"https://api.github.com/markdown/raw"];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setValue:@"text/plain" forHTTPHeaderField:@"Content-type"];
	[request setValue:postLength forHTTPHeaderField:@"Content-length"];
	[request setHTTPBody:postData];
	
	NSError *err = nil;
	NSURLResponse *response;
	NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
	NSString *markdown = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	
	[pboard declareTypes:[NSArray arrayWithObject:NSHTMLPboardType] owner:nil];
	[pboard setData:[markdown dataUsingEncoding:NSUTF8StringEncoding]
			  forType:NSHTMLPboardType];
	
	return;
}

@end
