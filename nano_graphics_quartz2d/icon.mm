//
//  icon.mm
//  innate_ui_appkit
//
//  Created by Camilo Sasuke Thomas Borregaard Sørensen on 2024-09-20 18:50
//
//
//
#include "framework.h"
#include "device.h"
#ifdef APPLE_IOS
#import <UIKit/UIKit.h>
#elif defined(MACOS)
#import <AppKit/AppKit.h>
#else
#error "todo"
#endif

#include "icon.h"


namespace quartz2d
{

   namespace nano
   {

  
      namespace graphics
   {


void icon::load_image_file(const void *p, memsize size)

{
   
   //auto buffer = m_memory.data();
   //auto size = m_memory.size();
   
   NSData *imageData = [[NSData alloc] initWithBytes:p length:size];
#ifdef APPLE_IOS
    // Create NSImage from NSData
    UIImage *image = [[UIImage alloc] initWithData:imageData];
#elif defined(MACOS)
    
   // Create NSImage from NSData
   NSImage *image = [[NSImage alloc] initWithData:imageData];
   
   m_pNSImage = image;
#endif
   
}

      
      
      void icon::_draw_in_context(::quartz2d::nano::graphics::device * pdevice, int x, int y, int cx, int cy)
      {
         
         auto pnsgraphicscontext = [NSGraphicsContext graphicsContextWithCGContext:pdevice->m_pdc flipped: true];
         
         [ NSGraphicsContext setCurrentContext:pnsgraphicscontext ];
         
         NSRect nsrect;
         
         nsrect.origin.x = x;
         nsrect.origin.y = y;
         nsrect.size.width = cx;
         nsrect.size.height = cy;

         [m_pnsimage drawInRect:nsrect];
         
         
      }
//
//void icon::__icon_release()
//{
// 
//   m_pnsimage = nil;
//   
//}

      
      } // namespace graphics
      } // namespace nano
      } // namespace quartz2d



