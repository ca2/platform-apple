// Create on 2021-03-21 20:00 <3ThomasBS_ // at Linux(quest.)
// Recreated on 2021-05-16 15:06 <3ThomasBS_ // for macOS
// From windowing_ios by camilo on 2022-05-11 06:19 PM <3ThomasBorregaardSorensen!!
#pragma once


#include "acme_darwin/directory_system.h"


namespace acme_apple
{


   class CLASS_DECL_ACME directory_system :
      virtual public ::acme_darwin::directory_system
   {
   public:
      
      
      ::pointer < file_listing_handler >     m_pfilelistinghandler_iCloudContainer;



      directory_system();
      ~directory_system() override;


//      virtual ::file::path install() override;
//      virtual ::file::path default_install() override;
//      virtual ::file::path beforeca2() override;
//      virtual ::file::path module() override;
//      virtual ::file::path relative(::file::path path) override;
//      virtual ::file::path app_relative() override;
//      virtual ::file::path appdata() override; // appdata
//      virtual ::file::path archive() override;
//      virtual ::file::path tool() override;
//      virtual ::file::path public_system() override;
//      virtual ::file::path system() override;
//      virtual ::file::path config() override;
//      virtual ::file::path local() override;
//      virtual ::file::path sensitive() override;
//      virtual ::file::path localconfig() override; // #vcs C:\\Users\\user\\AppData\\Roaming\\ca2\\localconfig
//      virtual ::file::path ca2roaming() override; // writable root (non-bin, non-exe)
//      virtual ::file::path ca2appdata() override; // writable root (non-bin, non-exe)
//      virtual ::file::path roaming() override;
//      virtual ::file::path program_data() override;
//      virtual ::file::path public_root() override; // writable common root (non-bin, non-exe)
//      virtual ::file::path bookmark() override;
//      virtual ::file::path home() override;
//      virtual ::file::path pathfind(const string& pszEnv, const string& pszTopic, const string& pszMode) override;
//      virtual ::file::path program_files_x86() override;
//      virtual ::file::path program_files() override;
//      //virtual ::file::path program_data() override;
//      virtual ::file::path stage(string strAppId, string strPlatform, string strConfiguration) override;
//      virtual ::file::path sys_temp() override;
//      virtual ::string dir_root() override;
//      //virtual ::file::path home() override;
//      //virtual ::file::path program_data() override;
//      //virtual ::file::path roaming() override;
//      virtual ::file::path get_memory_map_base_folder_path() override;
//      //virtual ::file::path ca2appdata() override;
//      //virtual ::file::path ca2roaming() override;
//      //virtual ::file::path localconfig() override;
//      virtual string system_short_name() override;
//
//
//      //::file::path inplace_install(string strAppId, string strPlatform, string strConfiguration) override;
//      //virtual ::file::path inplace_install(string strAppId, string strPlatform, string strConfiguration) override;
//      virtual ::file::path inplace_install(string strAppId, string strPlatform, string strConfiguration) override;
//      virtual ::file::path inplace_matter_install(string strAppId, string strPlatform, string strConfiguration) override;
//
//
//      virtual void set_path_install_folder(const ::string & strPath) override;
//
//      //virtual  bool        _shell_get_special_folder_path(HWND hwnd, ::file::path& str, int csidl, bool fCreate);
//      //virtual ::file::path _shell_get_special_folder_path(int csidl, bool fCreate = true, ::windowing::window* pwindow = nullptr);
//      //virtual ::file::path _get_known_folder(REFKNOWNFOLDERID kfid);
//
//      //virtual ::file::path pathfind(const string& pszEnv, const string& pszTopic, const string& pszMode) override;
//
//      virtual ::file::path user_appdata_local() override;
      
      bool has_icloud_container(const char * pszAppId = nullptr) override;
      
      bool defer_enumerate_protocol(::file::listing& listing) override;

      ::file::path icloud_container2_final(const char * psz_iCloudContainerIdentifier = nullptr) override;
      

   };


} // namespace acme_ios



