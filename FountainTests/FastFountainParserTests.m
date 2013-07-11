//
//  FastFountainParserTests.m
//  Fountain
//
//  Created by Steve Shepard on 7/11/13.
//  Copyright (c) 2013 Nima Yousefi. All rights reserved.
//

#import "FastFountainParserTests.h"
#import "FastFountainParser.h"
#import "FNElement.h"

@implementation FastFountainParserTests

- (void)testSectionsAndSynopses
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"SynopsisTest" ofType:@".fountain"];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    STAssertNotNil(path, @"Couldn't find test file");
    STAssertNotNil(string, @"Couldn't load string");
    
    FastFountainParser *parser = [[FastFountainParser alloc] initWithString:string];
    
//    # Act 1
//    = Synopsis 1
//    
//    INT. LOCATION - DAY
//    
//    Action
//    
//    # Act 2
//    ## Sequence 1
//
//    INT. LOCATION - DAY

    NSArray *elements = parser.elements;
    
    STAssertTrue(elements.count == 7, @"");
    
    FNElement *section1 = elements[0];
    STAssertEqualObjects(section1.elementText, @" Act 1", @"");
    STAssertTrue(section1.sectionDepth == 1, @"");

    FNElement *synopsis = elements[1];
    STAssertEqualObjects(synopsis.elementText, @" Synopsis 1", @"");
    
    FNElement *sceneHeading1 = elements[2];
    STAssertEqualObjects(sceneHeading1.elementText, @"INT. LOCATION - DAY", @"");

    FNElement *action = elements[3];
    STAssertEqualObjects(action.elementText, @"Action", @"");

    FNElement *section2 = elements[4];
    STAssertEqualObjects(section2.elementText, @" Act 2", @"");
    STAssertTrue(section2.sectionDepth == 1, @"");

    FNElement *section3 = elements[5];
    STAssertEqualObjects(section3.elementText, @" Sequence 1", @"");
    STAssertTrue(section3.sectionDepth == 2, @"");

}

@end
