//
// Created by camilo on 19/01/2021. --<33ThomasBS!!
//
#include "framework.h"
#include "node.h"
#include "acme/filesystem/filesystem/acme_directory.h"
#include "acme/parallelization/synchronous_lock.h"
#include "acme/platform/system.h"
#include "aura/graphics/image/context_image.h"
#include "aura/platform/context.h"


bool apple_get_file_image(::image * pimage, const char * pszFilePath);
bool apple_get_file_image_by_type_identifier(::image * pimage, const char * pszTypeIdentifier);

namespace aura_apple
{



      node::node()
      {

         //m_pGtkSettingsDefault = nullptr;

         //m_pAuraPosix = this;

      }


      node::~node()
      {

         //      if(m_pGtkSettingsDefault)
         //      {
         //
         //         g_object_unref(m_pGtkSettingsDefault);
         //
         //      }

      }

//
//      ::extended::transport<appindicator> node::new_appindicator()
//      {
//
//         auto pappindicator = __create<appindicator>();
//
//         if (!pappindicator)
//         {
//
//            return pappindicator;
//
//         }
//
//         return pappindicator;
//
//      }


      //   int node::node_init_check(int *pi, char ***ppz)
      //   {
      //
      //      auto iResult = gtk_init_check(pi, ppz);
      //
      //      return iResult;
      //
      //   }


//      ::e_status node::start()
//      {
//
//
//         //      if (System.m_bGtkApp)
//         //      {
//         //
//         //         apex_application_run(System.m_XstrAppId, System.m_strProgName);
//         //
//         //      }
//         //      else
//         //      {
//         //      //
//         //      ////      g_set_application_name(psystem->m_XstrAppId);
//         //      ////
//         //      ////      g_set_prgname(psystem->m_strProgName);
//         //      ////
//         //      ////      //auto idle_source = g_idle_source_new();
//         //      ////
//         //      ////      //g_source_set_callback(idle_source, &linux_start_system, (::apex::system *) m_psystem, nullptr);
//         //      ////
//         //      ////      //g_source_attach(idle_source, g_main_context_default());
//         //      ////
//         //      ////      //int c = 2;
//         //      ////
//         //      ////      //const char * argv[]={"app", "--g-fatal-warnings"};
//         //      ////
//         //      ////#if !defined(__SANITIZE_ADDRESS__)
//         //      ////
//         //      ////      gtk_init_check(&psystem->m_argc, &psystem->m_argv);
//         //      ////
//         //      ////#endif
//         //
//         //         node_fork([this]()
//         //                   {
//         //
//         //                      //x11_add_idle_source();
//         //
//         //                      //x11_add_filter();
//         //
//         //                      auto pgtksettingsDefault = gtk_settings_get_default();
//         //
//         //                      if(pgtksettingsDefault)
//         //                      {
//         //
//         //
//         //                         m_pGtkSettingsDefault = G_OBJECT(pgtksettingsDefault);
//         //
//         //                         g_object_ref (m_pGtkSettingsDefault);
//         //
//         //                         gchar *theme_name = nullptr;
//         //
//         //                         g_object_get(m_pGtkSettingsDefault, "gtk-theme-name", &theme_name, NULL);
//         //
//         //                         m_strTheme = theme_name;
//         //
//         //                         g_free(theme_name);
//         //
//         //                         auto preturn = g_signal_connect_data(
//         //                            m_pGtkSettingsDefault,
//         //                            "notify::gtk-theme-name",
//         //                            G_CALLBACK(gtk_settings_gtk_theme_name_callback),
//         //                            this,
//         //                            NULL,
//         //                            G_CONNECT_AFTER);
//         //
//         //                         //g_object_ref(preturn);
//         //
//         //                         //printf("return %" PRIiPTR, preturn);
//         //
//         //                         //printf("return %" PRIiPTR, preturn);
//         //
//         //                      }
//         //
//         //
//         //                   });
//         //
//         //
//         //         //x11_add_filter();
//         //
//         //System.fork([]()
//         //     {
//         //
//         //      x11_main();
//         //
//         //     });
//         //
//         //         gtk_main();
//         //
//         //         //x11_main();
//         //
//         //      }
//         //      //
//         //      //::parallelization::post_quit_and_wait(get_context_system(), one_minute());
//
//         return ::success;
//
//      }


      void node::initialize(::particle * pparticle)
      {

         //auto estatus =
         
         ::aura_darwin::node::initialize(pparticle);
         
         ::apex_apple::node::initialize(pparticle);

//         if (!estatus)
//         {
//
//            return estatus;
//
//         }
//
//         return estatus;

      }



::image_pointer node::get_file_image_by_type_identifier(int iSize, const ::scoped_string & scopedstrTypeIdentifier)
{

   auto pimage = m_pcontext->m_pauracontext->create_image( { iSize, iSize } );

   _synchronous_lock synchronouslock(this->synchronization());

   if(!apple_get_file_image_by_type_identifier(pimage, scopedstrTypeIdentifier))
   {

      return nullptr;

   }

   return pimage;

}


::image_pointer node::get_file_image(int iSize, const ::file::path & path)
{
   

   auto pimage = m_pcontext->m_pauracontext->create_image( { iSize, iSize } );

_synchronous_lock synchronouslock(this->synchronization());

   if(!apple_get_file_image(pimage, path))
   {

      return nullptr;

   }

   return pimage;

}

void node::on_start_system()
{
   
   system()->on_branch_system_from_main_thread_startup();
   
}


void node::on_system_main()
{
   
   auto papp = platform()->application();

   void * pApplication = (void *) (::acme::application *) papp;

   defer_create_windowing_application_delegate(pApplication, papp->application_menu(), papp);
   
   ns_app_run();

}


} // namespace aura_apple



