//
//  SavedContentManager.h
//  iNotes
//
//  Created by Matthew Prockup on 1/14/14.
//
//

#import <Foundation/Foundation.h>

@interface SavedContentManager : NSObject
+(NSString *)getDocumentsDir;
+(NSArray *)listFilesForPath:(NSString *)path;
+(NSArray *)listDocumentsDir;
+(bool) fileExistsAtPath:(NSString*) path withName:(NSString*) fileName;
+(bool) deleteFileAtPath:(NSString*) filepath;

+(bool) createFolderAtPath:(NSString*) path withName:(NSString*) folderName;
+(bool) createFolderInDocuments:(NSString*) folderName;
+(bool) copyFileAtPath:(NSString*)folderNameAndPath toPath:(NSString*)destinationPath;


+(bool) saveTextFileWithContents:(NSString*)textContent atPath:(NSString*)path withName:(NSString*) fileName;
+(bool) saveTextFileInDocumentsWithContents:(NSString*)textContent withName:(NSString*) fileName;
+(bool) saveDataFileWithContents:(NSData*)data atPath:(NSString*)path withName:(NSString*) fileName;
+(bool) saveDataFileInDocumentsWithContents:(NSData*)data withName:(NSString*) fileName;


+(NSString*) loadTextFileAtPath:(NSString*)path withName:(NSString*) fileName;
+(NSString*) loadTextFileInDocumentsWithName:(NSString*) fileName;
+(NSData*) loadDataFileAtPath:(NSString*)path withName:(NSString*) fileName;
+(NSData*) loadDataFileInDocumentsWithName:(NSString*) fileName;
+(NSData*) loadDataFileAtPath:(NSString*)path;



@end
