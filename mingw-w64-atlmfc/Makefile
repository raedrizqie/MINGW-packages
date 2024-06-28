
CXX=		clang++
RM=		rm
AR=		ar
AS=		uasm
RC=		windres

ATLSLIB=	libatls.a

ifeq ($(MBCS), 1)
MFCDLL=		libmfc100.dll
MFCMDLL=	libmfcm100.dll
else
MFCDLL=		libmfc100u.dll
MFCMDLL=	libmfcm100u.dll
endif

MFCENUDLL=	libmfc100enu.dll

LDFLAGS=	-shared -mwindows

LIBS=		-lmingw32 -lmingwex -luuid -luxtheme -lgdiplus -luserenv -lshlwapi -loleacc -loledlg -lhtmlhelp -ldbghelp \
			-lmsxml2 -lwinspool -lwinmm -lwininet -lurlmon -lwindowscodecs -lws2_32 -ladvapi32 -lmsimg32 -limm32 \
			-lcomctl32 -lodbc32 -lodbccp32 -lshell32 -lkernel32 -luser32 -lgdi32 -lcomdlg32 -lole32 -loleaut32

CRTLIBS=	-lmsvcr100

INCDIRS=	-I../include

CXXBASEFLAGS=	-std=c++17 -stdlib=libc++ -fuse-ld=lld -fpermissive -fno-strict-aliasing -fms-extensions -mms-bitfields

COMMONFLAGS=	-DWIN32 -DWINNT -D_WINDOWS -D_MT -DNOMINMAX

ATLS_FLAGS=	-D_ATL_STATIC_REGISTRY -D_ATL_NO_DEFAULT_LIBS

MFCDLL_FLAGS=	-D_AFXDLL -D_MFC_BLD -D_MFC_DLL_BLD -D_AFX_DISABLE_DEPRECATED -D_AFX_MONOLITHIC \
			-D_AFX_CORE_IMPL -D_AFX_OLE_IMPL -D_AFX_DB_IMPL -D_AFX_NET_IMPL -D_ATL_STATIC_REGISTRY

MFCMDLL_FLAGS=	-D_AFXEXT -DBUILD_MFCM

MFC_RCFLAGS=	-DRELEASE -DRC_INVOKED -D_AFX_MONOLITHIC

RC_DEFINES=	-DLANG=ENU -DLANGCODE=\"0409\" -DLANGID=0x0409 -DVER_LANGID=0x0409 -DVER_LANGID_HEX=0409  

EXTRAFLAGS=	-Wno-unused-result -Wno-unused-value -Wno-return-type -Wno-pointer-arith -Wno-switch \
			-Wno-int-to-pointer-cast -Wno-invalid-offsetof -Wno-narrowing -Wno-missing-exception-spec \
			-Wno-pointer-to-int-cast -Wno-nonportable-include-path -Wno-ignored-attributes \
			-Wno-tautological-undefined-compare -Wno-invalid-noreturn -Wno-extern-initializer \
			-Wno-tautological-pointer-compare -Wno-varargs -Wno-ignored-pragmas -Wno-pragma-pack


ifeq ($(DEBUG), 1)
CXXFLAGS=	-g -ggdb $(CXXBASEFLAGS) $(COMMONFLAGS) -D_DEBUG
else
CXXFLAGS=	-g -O1 $(CXXBASEFLAGS) $(COMMONFLAGS) -DNDEBUG
endif

ifeq ($(MBCS), 1)
CXXFLAGS +=	-D_MBCS
RCFLAGS +=	-D_MBCS
else
CXXFLAGS +=	-D_UNICODE -DUNICODE
RCFLAGS +=	-D_UNICODE
endif

ifeq ($(X86), 1)
CXXFLAGS +=	-D_M_IX86 -D_X86_ -D_AFX_PORTABLE
LDFLAGS +=	-m32
else
CXXFLAGS +=	-D_M_AMD64 -D_AMD64_
LDFLAGS +=	-m64
endif

ATLFLAGS=	$(CXXFLAGS) -fexceptions -frtti $(ATLS_FLAGS)
MFCFLAGS=	$(CXXFLAGS) $(MFCDLL_FLAGS)


all :	$(ATLSLIB) $(MFCDLL) $(MFCMDLL)

ifeq ($(MFCENU), 1)
all +:	$(MFCENUDLL)
endif

clean :
		$(RM) -f atl/*.obj atl/atls/*.obj atl/atls/INTEL/*.obj atl/atls/amd64/*.obj
		$(RM) -f mfc/*.obj mfc/amd64/*.obj mfcm/*.obj
		$(RM) -f *.a *.dll

.SUFFIXES: .cpp .c .rc .s
.PHONY: all clean


ATLS_OBJS=	atl/atls/allocate.obj atl/atls/atlbase.obj atl/atls/atlcommodule.obj atl/atls/stdafx.obj \
			atl/atls/ATLComTime.obj atl/atls/AtlDebugAPI.obj \
			atl/atls/atlimage.obj atl/atls/atlimage2.obj atl/atls/atlmem.obj atl/atls/atlstr.obj \
			atl/atls/AtlTraceModuleManager.obj atl/atls/atlwinmodule.obj atl/atls/Externs.obj atl/atls/LoadNSave.obj

ifneq ($(X86), 1)
ifneq ($(DEBUG), 1)
QITHUNK =	qithunk.obj
endif
STDCTHUNK =	stdcallthunk.obj
endif

ifeq ($(DEBUG), 1)
ATLS_OBJS +=	atl/atls/atldebuginterfacesmodule.obj
else
ifeq ($(X86), 1)
ATLS_OBJS +=	atl/atls/atltime.obj atl/atls/atltrace.obj atl/atls/atltypes.obj
endif
endif


ifeq ($(X86), 1)
ATLS_OBJS +=	atl/atls/atlfuncs.obj atl/atls/INTEL/atlthunk.obj
else
ATLS_OBJS +=	$(QITHUNK) $(STDCTHUNK) atl/atls/amd64/atlthunk.obj
endif

MFC_OBJS=	$(OBJECT) $(OBJDIAG) $(INLINES) $(FILES) $(COLL1) $(COLL2) $(MISC) $(WINDOWS) \
			$(DIALOG) $(WINMISC) $(DOCVIEW) $(APP) $(OLEREQ) $(INTERNET) $(INETASM) \
			$(DAO) $(OLE) $(OLECTL) $(OLEASM) $(SOCKETS) $(DB) $(GUI)  

OBJECT=		mfc/objcore.obj mfc/except.obj \
			mfc/validadd.obj mfc/dumpcont.obj mfc/dumpflt.obj \
			mfc/arccore.obj mfc/arcobj.obj mfc/arcex.obj mfc/arcstrm.obj

OBJDIAG=	mfc/dumpinit.obj mfc/dumpout.obj \
			mfc/afxasert.obj mfc/afxmem.obj mfc/afxabort.obj

FILES=		mfc/filecore.obj mfc/filetxt.obj mfc/filemem.obj mfc/fileshrd.obj \
			mfc/filex.obj mfc/filest.obj

COLL1=		mfc/array_b.obj mfc/array_d.obj mfc/array_p.obj mfc/array_o.obj \
			mfc/array_s.obj mfc/array_u.obj mfc/array_w.obj \
			mfc/list_o.obj mfc/list_p.obj mfc/list_s.obj

COLL2=		mfc/map_pp.obj mfc/map_pw.obj mfc/map_so.obj \
			mfc/map_sp.obj mfc/map_ss.obj mfc/map_wo.obj mfc/map_wp.obj mfc/plex.obj

MISC=		mfc/strcore.obj mfc/timecore.obj \
			mfc/afxstate.obj mfc/afxtls.obj mfc/fixalloc.obj \
			mfc/mtcore.obj mfc/mtex.obj

WINDOWS=	mfc/wincore.obj mfc/winfrm.obj mfc/winfrm2.obj mfc/winfrmx.obj \
			mfc/winmdi.obj mfc/tooltip.obj mfc/winmini.obj mfc/winhand.obj \
			mfc/winmain.obj mfc/barcore.obj mfc/bartool.obj mfc/bardlg.obj \
			mfc/barstat.obj mfc/bardock.obj mfc/dockcont.obj mfc/dockstat.obj \
			mfc/dcprev.obj mfc/dcmeta.obj mfc/trckrect.obj mfc/barcool.obj

DIALOG=		mfc/winctrl1.obj mfc/winctrl2.obj mfc/winctrl3.obj mfc/winctrl4.obj \
			mfc/winctrl5.obj mfc/winctrl6.obj mfc/winctrl7.obj mfc/winctrl8.obj \
			mfc/winbtn.obj mfc/dlgcore.obj mfc/dlgdata.obj mfc/dlgfloat.obj \
			mfc/dlgprop.obj mfc/dlgcomm.obj mfc/dlgfile.obj mfc/dlgprnt.obj \
			mfc/dlgprntx.obj mfc/dlgclr.obj mfc/dlgfnt.obj mfc/dlgfr.obj mfc/ccdata.obj \
			mfc/dlgtempl.obj mfc/dlgdhtml.obj

WINMISC=	mfc/wingdi.obj mfc/wingdix.obj mfc/winstr.obj mfc/winmenu.obj mfc/auxdata.obj \
			mfc/afxcrit.obj mfc/afxtrace.obj mfc/winutil.obj mfc/winocc.obj mfc/ThemeHelper.obj

DOCVIEW=	mfc/cmdtarg.obj mfc/doccore.obj mfc/doctempl.obj \
			mfc/docsingl.obj mfc/docmulti.obj mfc/docmgr.obj \
			mfc/viewcore.obj mfc/viewprnt.obj mfc/winsplit.obj mfc/viewscrl.obj \
			mfc/viewform.obj mfc/viewedit.obj mfc/viewprev.obj mfc/viewcmn.obj \
			mfc/docmapi.obj

APP=		mfc/thrdcore.obj mfc/appcore.obj mfc/appinit.obj mfc/appterm.obj \
			mfc/appui.obj mfc/appui1.obj mfc/appui2.obj mfc/appui3.obj \
			mfc/appdlg.obj mfc/appprnt.obj mfc/apphelp.obj mfc/apphelpx.obj \
			mfc/filelist.obj

OLEREQ=		mfc/olelock.obj

INTERNET=	mfc/inet.obj mfc/filefind.obj

OLE=		mfc/oleinit.obj mfc/olecli1.obj mfc/olecli2.obj \
			mfc/olecli3.obj mfc/olecnvrt.obj mfc/oledobj1.obj mfc/oledobj2.obj \
			mfc/oledisp1.obj mfc/oledisp2.obj mfc/oledlgs1.obj mfc/oledlgs2.obj \
			mfc/oledlgs3.obj mfc/oledata.obj mfc/olevar.obj mfc/olevar1.obj \
			mfc/oledoc1.obj mfc/oledoc2.obj mfc/oledrop1.obj mfc/oledrop2.obj \
			mfc/olemsgf.obj mfc/oleenum.obj mfc/olefact.obj mfc/oleipfrm.obj \
			mfc/olelink.obj mfc/olemisc.obj mfc/olepset.obj mfc/olereg.obj mfc/olestrm.obj \
			mfc/olesvr1.obj mfc/olesvr2.obj mfc/oletsvr.obj mfc/oleui1.obj \
			mfc/oleui2.obj mfc/oleunk.obj mfc/oleverb.obj \
			mfc/viewrich.obj mfc/oledll.obj mfc/oletyplb.obj mfc/olemon.obj mfc/viewhtml.obj \
			mfc/occmgr.obj mfc/occevent.obj mfc/occcont.obj mfc/occsite.obj \
			mfc/occlock.obj mfc/occddx.obj mfc/occddxf.obj mfc/occdlg.obj \
			mfc/oledocvw.obj mfc/oledocob.obj mfc/oledoctg.obj mfc/oledocip.obj \
			mfc/oledoccl.obj mfc/oleasmon.obj mfc/olebar.obj mfc/olecall.obj

OLECTL=		mfc/ctlcache.obj mfc/ctlcore.obj mfc/ctlconn.obj \
			mfc/ctldata.obj mfc/ctlevent.obj mfc/ctlmodul.obj \
			mfc/ctlframe.obj mfc/ctlfont.obj mfc/ctlinplc.obj \
			mfc/ctllic.obj mfc/oleconn.obj mfc/ctlobj.obj mfc/ctlpict.obj \
			mfc/ctlpropx.obj mfc/ctlppg.obj mfc/ctlprop.obj \
			mfc/ctlpset.obj mfc/ctlpstg.obj mfc/ctlpstm.obj \
			mfc/ctlrefl.obj mfc/ctlreg.obj mfc/ctltrack.obj \
			mfc/ctlview.obj mfc/ctlpbag.obj \
			mfc/ctlquick.obj mfc/ctlnownd.obj

SOCKETS=	mfc/sockcore.obj

DB=		mfc/dbcore.obj mfc/dbrfx.obj mfc/dbview.obj mfc/dbflt.obj \
			mfc/dblong.obj mfc/dbvar.obj mfc/viewoled.obj

GUI=		mfc/afxacceleratorkey.obj mfc/afxacceleratorkeyassignctrl.obj mfc/afxanimationcontroller.obj \
	 		mfc/afxautohidebar.obj mfc/afxautohidebutton.obj mfc/afxautohidedocksite.obj \
			mfc/afxbasepane.obj mfc/afxbaseribbonelement.obj mfc/afxbasetabbedpane.obj mfc/afxbasetabctrl.obj \
			mfc/afxbasetoolbar.obj mfc/afxbutton.obj mfc/afxcaptionbar.obj mfc/afxcaptionbutton.obj \
			mfc/afxcaptionmenubutton.obj mfc/afxcmdusagecount.obj \
			mfc/afxcolorbar.obj mfc/afxcolorbutton.obj mfc/afxcolordialog.obj mfc/afxcolormenubutton.obj \
			mfc/afxcolorpickerctrl.obj mfc/afxcolorpopupmenu.obj mfc/afxcolorpropertysheet.obj \
			mfc/afxcommandmanager.obj mfc/afxcontextmenumanager.obj mfc/afxcontrolbarimpl.obj \
			mfc/afxcontrolrenderer.obj mfc/afxctrlcontainer.obj mfc/afxcustomcolorspropertypage.obj \
			mfc/afxcustomizebutton.obj mfc/afxcustomizemenubutton.obj mfc/afxdatarecovery.obj \
			mfc/afxdesktopalertdialog.obj mfc/afxdesktopalertwnd.obj mfc/afxdialogex.obj mfc/afxdialogimpl.obj \
			mfc/afxdockablepane.obj mfc/afxdockablepaneadapter.obj mfc/afxdockingmanager.obj \
			mfc/afxdockingpanesrow.obj mfc/afxdocksite.obj mfc/afxdragframeimpl.obj mfc/afxdrawmanager.obj \
			mfc/afxdropdownlistbox.obj mfc/afxdropdowntoolbar.obj mfc/afxeditbrowsectrl.obj \
			mfc/afxfontcombobox.obj mfc/afxframeimpl.obj mfc/afxframewndex.obj mfc/afxfullscreenimpl.obj \
			mfc/afxglobals.obj mfc/afxglobalutils.obj mfc/afxheaderctrl.obj mfc/afximageeditordialog.obj \
			mfc/afximagepaintarea.obj mfc/afxjumplist.obj mfc/afxkeyboardmanager.obj mfc/afxkeymapdialog.obj \
			mfc/afxlinkctrl.obj mfc/afxlistctrl.obj mfc/afxmaskededit.obj mfc/afxmdichildwndex.obj \
			mfc/afxmdiclientareawnd.obj mfc/afxmdiframewndex.obj mfc/afxmenubar.obj mfc/afxmenubutton.obj \
			mfc/afxmenuhash.obj mfc/afxmenuimages.obj mfc/afxmenutearoffmanager.obj mfc/afxmousemanager.obj \
			mfc/afxmousepropertypage.obj mfc/afxmultipaneframewnd.obj mfc/afxolecntrframewndex.obj \
			mfc/afxoledocipframewndex.obj mfc/afxoleipframewndex.obj mfc/afxoleserverdocex.obj \
			mfc/afxoutlookbar.obj mfc/afxoutlookbarpane.obj mfc/afxoutlookbarpaneadapter.obj \
			mfc/afxoutlookbarpanebutton.obj mfc/afxoutlookbartabctrl.obj \
			mfc/afxpane.obj mfc/afxpanecontainer.obj mfc/afxpanecontainermanager.obj mfc/afxpanedialog.obj \
			mfc/afxpanedivider.obj mfc/afxpaneframewnd.obj mfc/afxpopupmenu.obj mfc/afxpopupmenubar.obj \
			mfc/afxpreviewviewex.obj mfc/afxpropertygridctrl.obj mfc/afxpropertygridtooltipctrl.obj \
			mfc/afxpropertypage.obj mfc/afxpropertysheet.obj mfc/afxrebar.obj mfc/afxrebarstate.obj \
			mfc/afxrecentdocksiteinfo.obj mfc/afxregpath.obj mfc/afxrendertarget.obj mfc/afxribbonbar.obj \
			mfc/afxribbonbutton.obj mfc/afxribbonbuttonsgroup.obj mfc/afxribboncategory.obj \
			mfc/afxribboncheckbox.obj mfc/afxribboncollector.obj mfc/afxribboncolorbutton.obj \
			mfc/afxribboncombobox.obj mfc/afxribboncommandslistbox.obj mfc/afxribbonconstructor.obj \
			mfc/afxribboncustomizedialog.obj mfc/afxribbonedit.obj mfc/afxribboninfo.obj mfc/afxribboninfo2.obj \
			mfc/afxribboninfoloader.obj mfc/afxribbonkeyboardcustomizedialog.obj mfc/afxribbonkeytip.obj \
			mfc/afxribbonlabel.obj mfc/afxribbonlinkctrl.obj mfc/afxribbonmainpanel.obj \
			mfc/afxribbonminitoolbar.obj mfc/afxribbonpalettegallery.obj mfc/afxribbonpanel.obj \
			mfc/afxribbonpanelmenu.obj mfc/afxribbonprogressbar.obj mfc/afxribbonquickaccesstoolbar.obj \
			mfc/afxribbonslider.obj mfc/afxribbonstatusbar.obj mfc/afxribbonstatusbarpane.obj \
			mfc/afxribbonundobutton.obj mfc/afxrichpreviewctrlimpl.obj mfc/afxsettingsstore.obj \
			mfc/afxshelllistctrl.obj mfc/afxshellmanager.obj mfc/afxshelltreectrl.obj mfc/afxshowallbutton.obj \
			mfc/afxsmartdockingguide.obj mfc/afxsmartdockinghighlighterwnd.obj mfc/afxsmartdockingmanager.obj \
			mfc/afxsound.obj mfc/afxspinbuttonctrl.obj mfc/afxsplitterwndex.obj mfc/afxstandardcolorspropertypage.obj \
			mfc/afxstatusbar.obj mfc/afxtabbedpane.obj mfc/afxtabctrl.obj mfc/afxtabview.obj mfc/afxtagmanager.obj \
			mfc/afxtaskspane.obj mfc/afxtaskspaneframewnd.obj mfc/afxtoolbar.obj \
			mfc/afxtoolbarbutton.obj mfc/afxtoolbarbuttoncustomizedialog.obj mfc/afxtoolbarbuttonslistbutton.obj \
			mfc/afxtoolbarcomboboxbutton.obj mfc/afxtoolbardatetimectrl.obj mfc/afxtoolbardropsource.obj \
			mfc/afxtoolbardroptarget.obj mfc/afxtoolbareditboxbutton.obj mfc/afxtoolbarfontcombobox.obj \
			mfc/afxtoolbarimages.obj mfc/afxtoolbarmenubutton.obj mfc/afxtoolbarmenubuttonsbutton.obj \
			mfc/afxtoolbarnamedialog.obj mfc/afxtoolbarscommandslistbox.obj mfc/afxtoolbarscustomizedialog.obj \
			mfc/afxtoolbarskeyboardpropertypage.obj mfc/afxtoolbarslistcheckbox.obj \
			mfc/afxtoolbarslistpropertypage.obj mfc/afxtoolbarsmenupropertypage.obj \
			mfc/afxtoolbarsoptionspropertypage.obj mfc/afxtoolbarspineditboxbutton.obj \
			mfc/afxtoolbarstoolspropertypage.obj mfc/afxtoolbarsystemmenubutton.obj mfc/afxtooltipctrl.obj \
			mfc/afxtooltipmanager.obj mfc/afxtrackmouse.obj mfc/afxusertool.obj mfc/afxusertoolsmanager.obj \
			mfc/afxvisualmanager.obj mfc/afxvisualmanageroffice2003.obj mfc/afxvisualmanageroffice2007.obj \
			mfc/afxvisualmanagerofficexp.obj mfc/afxvisualmanagervs2005.obj mfc/afxvisualmanagervs2008.obj \
			mfc/afxvisualmanagerwindows.obj mfc/afxvisualmanagerwindows7.obj mfc/afxvslistbox.obj \
			mfc/afxwinappex.obj mfc/afxwindowsmanagerdialog.obj


ifeq ($(DEBUG), 1)
INLINES=	mfc/afxinl1.obj mfc/afxinl2.obj mfc/afxinl3.obj mfc/afxinl4.obj
OLECTL +=	mfc/ctlinl.obj
endif

ifeq ($(MBCS), 1)
DB +=		mfc/afxdbcs.obj
else
GUI +=		mfc/afxtaskdialog.obj
endif

ifeq ($(X86), 1)
DAO=		mfc/daocore.obj mfc/daodfx.obj mfc/daoview.obj
else
OLEASM=		olecall_.obj
INETASM=	inetcal_.obj
endif

MFC_OBJS +=	mfc/dllinit.obj mfc/stdafx.obj

MFCMDLL_OBJS=	mfcm/stdafx.obj mfcm/afxwfrminl.obj mfcm/mfcm.obj \
		mfcm/postdllmain.obj mfcm/postrawdllmain.obj

MFCDLL_RES=	mfc/mfcdll_rc.obj
MFCMDLL_RES=	mfcm/mfcm_rc.obj
MFCENU_RES=	mfc/mfcenu_rc.obj


# Linking

$(ATLSLIB): $(ATLS_OBJS)
		$(RM) -f $@
		$(AR) rcs $@ $(ATLS_OBJS)

$(MFCDLL): $(ATLSLIB) $(MFC_OBJS) $(MFCDLL_RES)
		$(RM) -f $@ $(MFCDLL).a
		$(CXX) $(LDFLAGS) $(STRIPFLAGS) -o $@ $(EXTRA_LDFLAGS) -Wl,--out-implib,./$(MFCDLL).a \
			$(MFC_OBJS) $(MFCDLL_RES) $(ATLSLIB) $(CRTLIBS) $(LIBS)

$(MFCMDLL): $(MFCMDLL_OBJS) $(MFCMDLL_RES)
		$(RM) -f $@ $(MFCMDLL).a
		$(CXX) $(LDFLAGS) $(STRIPFLAGS) -o $@ $(EXTRA_LDFLAGS) -Wl,--out-implib,./$(MFCMDLL).a \
			$(MFCMDLL_OBJS) $(MFCMDLL_RES) $(MFCDLL).a $(CRTLIBS) $(LIBS)

$(MFCENUDLL): $(MFCENU_RES)
		$(RM) -f $@
		$(CXX) $(LDFLAGS) $(STRIPFLAGS) -o $@ $(MFCENU_RES) $(CRTLIBS) $(LIBS)


# Common recipies

atl/%.obj: atl/%.cpp
	$(CXX) $(ATLFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@

atl/atls/%.obj: atl/atls/%.cpp
	$(CXX) $(ATLFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@

mfc/%.obj: mfc/%.cpp
	$(CXX) $(MFCFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@

mfcm/%.obj: mfcm/%.cpp
	$(CXX) $(CXXFLAGS) $(MFCMDLL_FLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@


# Special treatments

ifeq ($(X86), 1)
atl/atls/atlfuncs.obj: atl/atls/atlfuncs.cpp
	$(CXX) -fasm -m32 $(CXXFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@

atl/atls/INTEL/atlthunk.obj: atl/atls/INTEL/atlthunk.cpp
	$(CXX) $(CXXFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@
else
atl/atls/amd64/atlthunk.obj: atl/atls/amd64/atlthunk.cpp
	$(CXX) $(CXXFLAGS) $(INCDIRS) $(EXTRAFLAGS) -c $< -o $@
endif


# ASM

$(QITHUNK): atl/atls/amd64/qithunk.s
	$(AS) -win64 -c atl/atls/amd64/qithunk.s

$(STDCTHUNK): atl/atls/amd64/stdcallthunk.s
	$(AS) -win64 -c atl/atls/amd64/stdcallthunk.s

$(OLEASM): mfc/amd64/olecall_.s
	$(AS) -win64 -c mfc/amd64/olecall_.s

$(INETASM): mfc/amd64/inetcal_.s
	$(AS) -win64 -c mfc/amd64/inetcal_.s


# Resource files

$(MFCDLL_RES): mfc/mfcdll.rc
	$(RM) -f $@
	$(RC) $(MFC_RCFLAGS) $(RCFLAGS) $(INCDIRS) -D_AFXDLL $< -o $@ -O coff

$(MFCMDLL_RES): mfcm/mfcm.rc
	$(RM) -f $@
	$(RC) $(MFC_RCFLAGS) $(RCFLAGS) $(INCDIRS) $< -o $@ -O coff

$(MFCENU_RES): mfc/mfcintl.rc
	$(RM) -f $@
	$(RC) $(MFC_RCFLAGS) $(RCFLAGS) $(RC_DEFINES) $(INCDIRS) -Imfc $< -o $@ -O coff
