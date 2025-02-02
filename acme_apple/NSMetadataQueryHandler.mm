//
//  NSMetaDataQuery+Synchronous.m
//  acme_apple
//
//  Created by Camilo Sasuke Thomas Borregaard Sørensen on 2024-02-06. - I love you Thomas Borregaard Sørensen!!
//

#import "NSMetadataQueryHandler.h"
#include "ns_metadata_query_callback.h"
#include "acme/constant/status.h"


enum_status ns_defer_initialize_icloud_container_access();


@implementation NSMetadataQueryHandler

-(id)init
{
   
   self = [super init];

   m_bFinished = false;
   
   
   return self;
   
}


-(void)dealloc
{
   
   NSLog(@"NSMetadataQueryHandler dealloc");
   
}


- (void)installCallback:(ns_metadata_query_callback *) pcallback
{
   
   m_pcallback = pcallback;
   
   void * p = (__bridge_retained void *) self;
   
   m_pcallback->m_pNSMetadataQueryHandler = (void *) p;
   
   NSMetadataQuery * pquery = self.metadata_query;
   
   NSNotificationCenter * center = [ NSNotificationCenter defaultCenter] ;
   
   [
      
      center
      addObserverForName : NSMetadataQueryDidUpdateNotification
      object : pquery
      queue : pquery.operationQueue
      usingBlock : ^(NSNotification * _Nonnull notification)
      {
         
         [self metadataQueryDidUpdate : notification];
         
      }
      
   ];

   
   [
      
      center
      addObserverForName : NSMetadataQueryDidFinishGatheringNotification
      object: pquery
      queue: pquery.operationQueue
      usingBlock:^(NSNotification * _Nonnull notification)
      {
         
         [self metadataQueryDidFinishedGathering : notification];
         
      }
      
   ];
   
   
}


- (void) metadataQueryDidFinishedGathering : (NSNotification *)notification
{
   
   //[ self metadataQueryDidUpdate : notification ];
   
   [ self fetchResults ];
   
   //[ self.metadata_query stopQuery];
   
   //m_bFinished = true;
   
   m_pcallback->ns_metadata_query_callback_finished();
   
   NSLog(@"NSMetadataQueryWithCallback metadataQueryDidFinishedGathering!!!");
   NSLog(@"NSMetadataQueryWithCallback metadataQueryDidFinishedGathering!!");
   
}


-(void)uninstallCallback
{
   
   [[NSNotificationCenter defaultCenter] removeObserver : self name:NSMetadataQueryDidFinishGatheringNotification object:self.metadata_query];

   [[NSNotificationCenter defaultCenter] removeObserver : self name:NSMetadataQueryDidUpdateNotification object : self.metadata_query];
   
   self.metadata_query = nil;
   
   m_pcallback = nullptr;

}


-(void)metadataQueryDidUpdate:(NSNotification *)notification
{
   
   [ self fetchResults ];
   
}


-(void) fetchResults
{
   
   NSMetadataQuery * pquery = self.metadata_query;
   
   [ pquery disableUpdates ];

   NSLog(@"NSMetadataQueryWithCallback metadataQueryDidUpdate!!!");

   
   
   // Look at each element returned by the search
   // - note it returns the entire list each time this method is called, NOT just the changes
   long long ll = [ pquery resultCount ];

   const char ** psza = (const char **) malloc(sizeof(const char *) * ll);
   int * ia=(int *) malloc(sizeof(int) * ll);
   for (long long i = 0; i < ll; i++)
   {
      
      NSMetadataItem * item = [ pquery resultAtIndex : i ];
      
      NSString * path = [ item valueForAttribute : NSMetadataItemPathKey ];
      
      psza[i] = (const char *) strdup([ path UTF8String ]);
      
      NSString * contentType = [ item valueForAttribute : NSMetadataItemContentTypeKey ];
      
      ia[i] = 0;
      
      if([ contentType isEqual:@"public.folder"])
      {
       
         ia[i] |= 1;
         
      }
      
   }

   m_pcallback->ns_metadata_query_callback_listing(ll, psza, ia);
   
   [ pquery enableUpdates ];
   
}

//
//- (void)onMetadataItem:(NSMetadataItem *)item
//{
//   
//   NSNumber *isUbiquitous = [item valueForAttribute:NSMetadataItemIsUbiquitousKey];
//   NSNumber *hasUnresolvedConflicts = [item valueForAttribute:NSMetadataUbiquitousItemHasUnresolvedConflictsKey];
//   NSString *downloadingStatus = [item valueForAttribute:NSMetadataUbiquitousItemDownloadingStatusKey];
//   NSNumber *isDownloading = [item valueForAttribute:NSMetadataUbiquitousItemIsDownloadingKey];
//   NSNumber *isUploaded = [item valueForAttribute:NSMetadataUbiquitousItemIsUploadedKey];
//   NSNumber *isUploading = [item valueForAttribute:NSMetadataUbiquitousItemIsUploadingKey];
//   NSNumber *percentDownloaded = [item valueForAttribute:NSMetadataUbiquitousItemPercentDownloadedKey];
//   NSNumber *percentUploaded = [item valueForAttribute:NSMetadataUbiquitousItemPercentUploadedKey];
//   NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
//   NSString *path = [item valueForAttribute:NSMetadataItemPathKey];
//   long lPathComponentsCount = path.pathComponents.count;
//
//   BOOL documentExists = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
//
//   NSLog(@"isUbiquitous:%@ hasUnresolvedConflicts:%@ downloadinStatus:%@ isDownloading:%@ isUploaded:%@ isUploading:%@ %%downloaded:%@ %%uploaded:%@ pathComponentsCount:%ld, documentExists:%i - %@", isUbiquitous, hasUnresolvedConflicts, downloadingStatus, isDownloading, isUploaded, isUploading, percentDownloaded, percentUploaded, lPathComponentsCount, documentExists, url);
//   
//   m_pcallback->ns_metadata_query_callback_listing([path UTF8String]);
//   
//}


- (NSString *)calculateBasePathWithCallback:(ns_metadata_query_callback*) pcallback and_iCloudContainerIdentifier: (const char *) psz_iCloudContainerIdentifier
{
   
   NSString * str_iCloudContainerIdentifier = [ [ NSString alloc ] initWithUTF8String : psz_iCloudContainerIdentifier ];
   
   NSURL * urlContainer = [ [ NSFileManager defaultManager ] URLForUbiquityContainerIdentifier: str_iCloudContainerIdentifier ];
   
   if(!urlContainer)
   {
      
      throw "failed container identifier";
      
      return nil;
      
   }
   
   NSURL * urlBase;
//   
//   if(pcallback->m_bPublic)
//   {
//      
//      urlBase = [urlContainer URLByAppendingPathComponent:@"Documents"];
//      
//   }
//   else
//   {
    
      urlBase = urlContainer;
      
   //}

   m_strBasePath = [ urlBase path ];

   return m_strBasePath;
   
}


 -(void)startMetadataQueryWithCallback:(ns_metadata_query_callback*) pcallback and_iCloudContainerIdentifier: (const char *) psz_iCloudContainerIdentifier
{

   [ self calculateBasePathWithCallback: pcallback and_iCloudContainerIdentifier : psz_iCloudContainerIdentifier ];
   
   //long lPathComponentsCount = [ [ url pathComponents ] count ];
      
   //NSString * strPath = [ url path ];

   
   //   // Add a predicate for finding the documents
   //   NSString* filePattern = [ NSString stringWithFormat : @"*.%@", @"*" ];
      
//      
//      NSMetadataQueryWithCallback * metadataQuery = [ [ NSMetadataQueryWithCallback alloc ] init ];
//      
   
   // Before starting to query, it is required to set the search scope.
   //arrayWithObject:NSMetadataQueryUbiquitousDataScope]];
   
   //   NSString * predicateFormat = @"((%K BEGINSWITH[cd] 'h') AND (%K BEGINSWITH %@)) AND (%K.pathComponents.@count == %d)"
   //NSString * predicateFormat = @"(%K BEGINSWITH[cd] 'h') AND (%K BEGINSWITH %@) AND (%K.pathComponents.@count == %d)";

   pcallback->ns_metadata_query_callback_on_base_path([m_strBasePath UTF8String]);
   
   
   self.metadata_query_handler_hold = self;
   
   //ns_main_post(^()
   {
      
      {
         
         id token = [ [ NSFileManager defaultManager ] ubiquityIdentityToken ];
         
         if (token == nil)
         {
            
            NSLog(@"ICloud Is not LogIn");
            
            throw "failed icloud is not login";
            
            return;
            
         }
         
      }

      NSMetadataQuery * pquery = [ NSMetadataQuery new ];
      
      self.metadata_query = pquery;

      self->m_bFinished = false;

      //NSString * predicateFormat = @"(%K like '*')";
      
      NSString * predicateFormat = @"(%K BEGINSWITH %@)";
      
      // Control the directory depth through the number of pathComponents
         
   //      NSPredicate * predicate = [ NSPredicate predicateWithFormat : predicateFormat,
   //                                 NSMetadataItemFSNameKey,
   //                                 NSMetadataItemPathKey,
   //                                 strPath,
   //                                 NSMetadataItemPathKey,
   //                                 lPathComponentsCount + 1 ];

      NSPredicate * predicate = [ NSPredicate predicateWithFormat : predicateFormat,
                              NSMetadataItemPathKey,
                              self->m_strBasePath

      ];

      pquery.predicate =predicate;
         //NSArray *dirs = [[NSArray alloc] initWithObjects:urlContainer, nil] ;

      NSArray * searchScopes = [NSArray arrayWithObject : NSMetadataQueryUbiquitousDocumentsScope];
   //   NSArray * searchScopes = [NSArray arrayWithObject:url];

      pquery.searchScopes = searchScopes;
      
      //[self setSearchScopes:NSMetadataQueryUbiquitousDataScope];

      NSString * sPred = [ predicate predicateFormat ];
         
      NSLog(@"MetaDataQuery predicateFormat %@", sPred);
         
      NSOperationQueue * pqueue = [ NSOperationQueue new ];
      
      pqueue.maxConcurrentOperationCount = 1;
      
      pquery.operationQueue = pqueue;
      
      [ pquery.operationQueue addOperationWithBlock:
      ^{
         
         [ self installCallback : pcallback];
         
         [ pquery enableUpdates ];
         
         if([ pquery startQuery ])
         {
             
            NSLog(@"MetaDataQuery seems ok");
            NSLog(@"MetaDataQuery query finished?!?");

         }
         else
         {
            
            NSLog(@"MetaDataQuery failed");

         }
         
      }];
         
//      if([ pquery startQuery ])
//      {
//         
//         while( !self->m_bFinished )
//          {
//            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:30]];
//          }
//
//         //CFRunLoopRun();
//         
//      }
//      else{
//         
//
//      }
      
   }
   
}

@end


void ns_metadata_query_callback::ns_metadata_query_callback_uninstall()
{
   
   auto p = (__bridge_transfer NSMetadataQueryHandler *) m_pNSMetadataQueryHandler;
   
   [ p uninstallCallback ];
   
}


void ns_app_cloud_start_metadata_query(ns_metadata_query_callback * pcallback, const char * psz_iCloudContainerIdentifier)
{
   
   NSMetadataQueryHandler * queryhandler = [ [ NSMetadataQueryHandler alloc ] init ];
   
   [ queryhandler startMetadataQueryWithCallback : pcallback and_iCloudContainerIdentifier : psz_iCloudContainerIdentifier];
   
}



