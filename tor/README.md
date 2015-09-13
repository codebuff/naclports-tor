Tor for NaCl
=================
This is a port of Tor(core) to NaCl platform.
For details visit : https://www.torproject.org

**The port is functional albeit with some quirks, this document lists and
keeps track of all those.**

1. **Currently there is no reliable way of checking if another tor process is 
   running.**

   **Reason:** Lack of support for file locking(yet) on NaCl.

   **Details:** Since Chrome 34, by default multiple windows per Chrome app 
      is not allowed,this should take care of the problem. 
      In the code, file locking is commented out altogether,
      see /src/or/config.c [line 1379]

2. **Maximum file descriptors are hard coded to 15000**
   
   **Reason:** getrlimit not implemented

3. **UID mismatch is ignored**

   **Reason:** On NaCl, the UIDs are not preserved(properly)
  
   **Details:** To debug/see implementation see /src/common/util.c [line 2195]

4. **Callbacks due to signals are NOT supported.**

   **Reason:** No support for POSIX signals on NaCl.io.

   **Details:** sigaction(...) and signal(...) are not(yet) implemented on 
     NaCl.io,thus the calls evsignal_add,evsignal_del,evsignal_pending should 
     be avoided,also event_add/event_del when passed with EV_SIGNAL will 
     also fail.

  For details about these functions visit :
  http://www.wangafu.net/~nickm/libevent-book/Ref4_event.html

  To debug/see implementation (see libevent port)
  Look for /event.c, /signal.c and /evmap.c
  In /signal.c see function _evsig_set_handler and _evsig_restore_handler

  Typical function call
  event_add > event_add_internal > (if signal) evmap_signal_add > evsig_add

5. **Post build tests are skipped.**

  **Reason:** There are some unresolved dependencies when compiled against 
  glibc + i686. For now they are altogether skipped for every 
  toolchain + architecture.[they work fine against clang-newlib]

6. **Build against glibc is not functional.**
  
   **Reason:** unknown (issue de-prioritized,glibc disabled in pkg_info)

**Notes**

 - Socket api is only allowed in chrome apps, remember to load 
   published directory as chrome app instead of make run / make serve
 - The default port is 9999 instead of usual 9150, 
   thus point your (socks)proxy to 127.0.0.1:9999
 - Once the GUI is ready, parameters can be generated/modified as per the user
