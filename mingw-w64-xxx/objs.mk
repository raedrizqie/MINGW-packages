# objs.mk - object lists for ATL/MFC 10.00.40219
# Included by the main Makefile. Expects X86, DEBUG, MBCS, and OUTDIR to be set.

# =============================================================================
# ATL (libatls.a)
# =============================================================================

ATLS_OBJS :=	\
	$(OUTDIR)/atl/atls/allocate.obj $(OUTDIR)/atl/atls/atlbase.obj $(OUTDIR)/atl/atls/atlcommodule.obj \
	$(OUTDIR)/atl/atls/stdafx.obj $(OUTDIR)/atl/atls/ATLComTime.obj $(OUTDIR)/atl/atls/AtlDebugAPI.obj \
	$(OUTDIR)/atl/atls/atlimage.obj $(OUTDIR)/atl/atls/atlimage2.obj $(OUTDIR)/atl/atls/atlmem.obj \
	$(OUTDIR)/atl/atls/atlstr.obj $(OUTDIR)/atl/atls/atltrace.obj $(OUTDIR)/atl/atls/AtlTraceModuleManager.obj \
	$(OUTDIR)/atl/atls/atlwinmodule.obj $(OUTDIR)/atl/atls/Externs.obj $(OUTDIR)/atl/atls/LoadNSave.obj

# Asm objects (filenames only; Makefile prepends OUTDIR)
QITHUNK   :=
STDCTHUNK :=

ifeq ($(X86), 1)
ATLS_OBJS += \
	$(OUTDIR)/atl/atls/atlfuncs.obj $(OUTDIR)/atl/atls/INTEL/atlthunk.obj
ifeq ($(DEBUG), 1)
ATLS_OBJS += \
	$(OUTDIR)/atl/atls/atltime.obj $(OUTDIR)/atl/atls/atltypes.obj
endif
else
STDCTHUNK := stdcallthunk.obj
ifeq ($(DEBUG), 1)
QITHUNK   := qithunk.obj
endif
ATLS_OBJS += \
	$(if $(QITHUNK),$(OUTDIR)/$(QITHUNK)) $(if $(STDCTHUNK),$(OUTDIR)/$(STDCTHUNK)) $(OUTDIR)/atl/atls/amd64/atlthunk.obj
endif

ifeq ($(DEBUG), 1)
ATLS_OBJS += \
	$(OUTDIR)/atl/atls/atldebuginterfacesmodule.obj
endif


# =============================================================================
# MFC - core
# =============================================================================

OBJECT :=	\
	$(OUTDIR)/mfc/objcore.obj $(OUTDIR)/mfc/except.obj $(OUTDIR)/mfc/validadd.obj $(OUTDIR)/mfc/dumpcont.obj \
	$(OUTDIR)/mfc/dumpflt.obj $(OUTDIR)/mfc/arccore.obj $(OUTDIR)/mfc/arcobj.obj $(OUTDIR)/mfc/arcex.obj \
	$(OUTDIR)/mfc/arcstrm.obj

OBJDIAG :=	\
	$(OUTDIR)/mfc/dumpout.obj $(OUTDIR)/mfc/afxasert.obj $(OUTDIR)/mfc/afxmem.obj $(OUTDIR)/mfc/afxabort.obj

FILES :=	\
	$(OUTDIR)/mfc/filecore.obj $(OUTDIR)/mfc/filetxt.obj $(OUTDIR)/mfc/filemem.obj $(OUTDIR)/mfc/fileshrd.obj \
	$(OUTDIR)/mfc/filex.obj $(OUTDIR)/mfc/filest.obj

COLL1 :=	\
	$(OUTDIR)/mfc/array_b.obj $(OUTDIR)/mfc/array_d.obj $(OUTDIR)/mfc/array_p.obj $(OUTDIR)/mfc/array_o.obj \
	$(OUTDIR)/mfc/array_s.obj $(OUTDIR)/mfc/array_u.obj $(OUTDIR)/mfc/array_w.obj \
	$(OUTDIR)/mfc/list_o.obj $(OUTDIR)/mfc/list_p.obj $(OUTDIR)/mfc/list_s.obj

COLL2 :=	\
	$(OUTDIR)/mfc/map_pp.obj $(OUTDIR)/mfc/map_pw.obj $(OUTDIR)/mfc/map_so.obj $(OUTDIR)/mfc/map_sp.obj \
	$(OUTDIR)/mfc/map_ss.obj $(OUTDIR)/mfc/map_wo.obj $(OUTDIR)/mfc/map_wp.obj $(OUTDIR)/mfc/plex.obj

MISC :=	\
	$(OUTDIR)/mfc/strcore.obj $(OUTDIR)/mfc/timecore.obj $(OUTDIR)/mfc/afxstate.obj $(OUTDIR)/mfc/afxtls.obj \
	$(OUTDIR)/mfc/fixalloc.obj $(OUTDIR)/mfc/mtcore.obj $(OUTDIR)/mfc/mtex.obj

# =============================================================================
# MFC - windows, dialogs, documents, application
# =============================================================================

WINDOWS :=	\
	$(OUTDIR)/mfc/wincore.obj $(OUTDIR)/mfc/winfrm.obj $(OUTDIR)/mfc/winfrm2.obj $(OUTDIR)/mfc/winfrmx.obj \
	$(OUTDIR)/mfc/winmdi.obj $(OUTDIR)/mfc/tooltip.obj $(OUTDIR)/mfc/winmini.obj $(OUTDIR)/mfc/winhand.obj \
	$(OUTDIR)/mfc/winmain.obj $(OUTDIR)/mfc/barcore.obj $(OUTDIR)/mfc/bartool.obj $(OUTDIR)/mfc/bardlg.obj \
	$(OUTDIR)/mfc/barstat.obj $(OUTDIR)/mfc/bardock.obj $(OUTDIR)/mfc/dockcont.obj $(OUTDIR)/mfc/dockstat.obj \
	$(OUTDIR)/mfc/dcprev.obj $(OUTDIR)/mfc/dcmeta.obj $(OUTDIR)/mfc/trckrect.obj $(OUTDIR)/mfc/barcool.obj

DIALOG :=	\
	$(OUTDIR)/mfc/winctrl1.obj $(OUTDIR)/mfc/winctrl2.obj $(OUTDIR)/mfc/winctrl3.obj $(OUTDIR)/mfc/winctrl4.obj \
	$(OUTDIR)/mfc/winctrl5.obj $(OUTDIR)/mfc/winctrl6.obj $(OUTDIR)/mfc/winctrl7.obj $(OUTDIR)/mfc/winctrl8.obj \
	$(OUTDIR)/mfc/winbtn.obj $(OUTDIR)/mfc/dlgcore.obj $(OUTDIR)/mfc/dlgdata.obj $(OUTDIR)/mfc/dlgfloat.obj \
	$(OUTDIR)/mfc/dlgprop.obj $(OUTDIR)/mfc/dlgcomm.obj $(OUTDIR)/mfc/dlgfile.obj $(OUTDIR)/mfc/dlgprnt.obj \
	$(OUTDIR)/mfc/dlgprntx.obj $(OUTDIR)/mfc/dlgclr.obj $(OUTDIR)/mfc/dlgfnt.obj $(OUTDIR)/mfc/dlgfr.obj \
	$(OUTDIR)/mfc/ccdata.obj $(OUTDIR)/mfc/dlgtempl.obj $(OUTDIR)/mfc/dlgdhtml.obj

WINMISC :=	\
	$(OUTDIR)/mfc/wingdi.obj $(OUTDIR)/mfc/wingdix.obj $(OUTDIR)/mfc/winstr.obj $(OUTDIR)/mfc/winmenu.obj \
	$(OUTDIR)/mfc/auxdata.obj $(OUTDIR)/mfc/afxcrit.obj $(OUTDIR)/mfc/afxtrace.obj $(OUTDIR)/mfc/winutil.obj \
	$(OUTDIR)/mfc/winocc.obj $(OUTDIR)/mfc/ThemeHelper.obj

DOCVIEW :=	\
	$(OUTDIR)/mfc/cmdtarg.obj $(OUTDIR)/mfc/doccore.obj $(OUTDIR)/mfc/doctempl.obj $(OUTDIR)/mfc/docsingl.obj \
	$(OUTDIR)/mfc/docmulti.obj $(OUTDIR)/mfc/docmgr.obj $(OUTDIR)/mfc/viewcore.obj $(OUTDIR)/mfc/viewprnt.obj \
	$(OUTDIR)/mfc/winsplit.obj $(OUTDIR)/mfc/viewscrl.obj $(OUTDIR)/mfc/viewform.obj $(OUTDIR)/mfc/viewedit.obj \
	$(OUTDIR)/mfc/viewprev.obj $(OUTDIR)/mfc/viewcmn.obj $(OUTDIR)/mfc/docmapi.obj

APP :=	\
	$(OUTDIR)/mfc/thrdcore.obj $(OUTDIR)/mfc/appcore.obj $(OUTDIR)/mfc/appinit.obj $(OUTDIR)/mfc/appterm.obj \
	$(OUTDIR)/mfc/appui.obj $(OUTDIR)/mfc/appui1.obj $(OUTDIR)/mfc/appui2.obj $(OUTDIR)/mfc/appui3.obj \
	$(OUTDIR)/mfc/appdlg.obj $(OUTDIR)/mfc/appprnt.obj $(OUTDIR)/mfc/apphelp.obj $(OUTDIR)/mfc/apphelpx.obj \
	$(OUTDIR)/mfc/filelist.obj

# =============================================================================
# MFC - OLE, internet, sockets, database
# =============================================================================

OLEREQ :=	$(OUTDIR)/mfc/olelock.obj

INTERNET :=	$(OUTDIR)/mfc/inet.obj $(OUTDIR)/mfc/filefind.obj

OLE :=	\
	$(OUTDIR)/mfc/oleinit.obj $(OUTDIR)/mfc/olecli1.obj $(OUTDIR)/mfc/olecli2.obj $(OUTDIR)/mfc/olecli3.obj \
	$(OUTDIR)/mfc/olecnvrt.obj $(OUTDIR)/mfc/oledobj1.obj $(OUTDIR)/mfc/oledobj2.obj $(OUTDIR)/mfc/oledisp1.obj \
	$(OUTDIR)/mfc/oledisp2.obj $(OUTDIR)/mfc/oledlgs1.obj $(OUTDIR)/mfc/oledlgs2.obj $(OUTDIR)/mfc/oledlgs3.obj \
	$(OUTDIR)/mfc/oledata.obj $(OUTDIR)/mfc/olevar.obj $(OUTDIR)/mfc/olevar1.obj $(OUTDIR)/mfc/oledoc1.obj \
	$(OUTDIR)/mfc/oledoc2.obj $(OUTDIR)/mfc/oledrop1.obj $(OUTDIR)/mfc/oledrop2.obj $(OUTDIR)/mfc/olemsgf.obj \
	$(OUTDIR)/mfc/oleenum.obj $(OUTDIR)/mfc/olefact.obj $(OUTDIR)/mfc/oleipfrm.obj $(OUTDIR)/mfc/olelink.obj \
	$(OUTDIR)/mfc/olemisc.obj $(OUTDIR)/mfc/olepset.obj $(OUTDIR)/mfc/olereg.obj $(OUTDIR)/mfc/olestrm.obj \
	$(OUTDIR)/mfc/olesvr1.obj $(OUTDIR)/mfc/olesvr2.obj $(OUTDIR)/mfc/oletsvr.obj $(OUTDIR)/mfc/oleui1.obj \
	$(OUTDIR)/mfc/oleui2.obj $(OUTDIR)/mfc/oleunk.obj $(OUTDIR)/mfc/oleverb.obj $(OUTDIR)/mfc/viewrich.obj \
	$(OUTDIR)/mfc/oledll.obj $(OUTDIR)/mfc/oletyplb.obj $(OUTDIR)/mfc/olemon.obj $(OUTDIR)/mfc/viewhtml.obj \
	$(OUTDIR)/mfc/occmgr.obj $(OUTDIR)/mfc/occevent.obj $(OUTDIR)/mfc/occcont.obj $(OUTDIR)/mfc/occsite.obj \
	$(OUTDIR)/mfc/occlock.obj $(OUTDIR)/mfc/occddx.obj $(OUTDIR)/mfc/occddxf.obj $(OUTDIR)/mfc/occdlg.obj \
	$(OUTDIR)/mfc/oledocvw.obj $(OUTDIR)/mfc/oledocob.obj $(OUTDIR)/mfc/oledoctg.obj $(OUTDIR)/mfc/oledocip.obj \
	$(OUTDIR)/mfc/oledoccl.obj $(OUTDIR)/mfc/oleasmon.obj $(OUTDIR)/mfc/olebar.obj $(OUTDIR)/mfc/olecall.obj

OLECTL :=	\
	$(OUTDIR)/mfc/ctlcache.obj $(OUTDIR)/mfc/ctlcore.obj $(OUTDIR)/mfc/ctlconn.obj $(OUTDIR)/mfc/ctldata.obj \
	$(OUTDIR)/mfc/ctlevent.obj $(OUTDIR)/mfc/ctlmodul.obj $(OUTDIR)/mfc/ctlframe.obj $(OUTDIR)/mfc/ctlfont.obj \
	$(OUTDIR)/mfc/ctlinplc.obj $(OUTDIR)/mfc/ctllic.obj $(OUTDIR)/mfc/oleconn.obj $(OUTDIR)/mfc/ctlobj.obj \
	$(OUTDIR)/mfc/ctlpict.obj $(OUTDIR)/mfc/ctlpropx.obj $(OUTDIR)/mfc/ctlppg.obj $(OUTDIR)/mfc/ctlprop.obj \
	$(OUTDIR)/mfc/ctlpset.obj $(OUTDIR)/mfc/ctlpstg.obj $(OUTDIR)/mfc/ctlpstm.obj $(OUTDIR)/mfc/ctlrefl.obj \
	$(OUTDIR)/mfc/ctlreg.obj $(OUTDIR)/mfc/ctltrack.obj $(OUTDIR)/mfc/ctlview.obj $(OUTDIR)/mfc/ctlpbag.obj \
	$(OUTDIR)/mfc/ctlquick.obj $(OUTDIR)/mfc/ctlnownd.obj

SOCKETS :=	$(OUTDIR)/mfc/sockcore.obj

DB :=		\
	$(OUTDIR)/mfc/dbcore.obj $(OUTDIR)/mfc/dbrfx.obj $(OUTDIR)/mfc/dbview.obj $(OUTDIR)/mfc/dbflt.obj \
	$(OUTDIR)/mfc/dblong.obj $(OUTDIR)/mfc/dbvar.obj $(OUTDIR)/mfc/viewoled.obj

# =============================================================================
# MFC - GUI (feature pack)
# =============================================================================

GUI :=	\
	$(OUTDIR)/mfc/afxacceleratorkey.obj $(OUTDIR)/mfc/afxacceleratorkeyassignctrl.obj \
	$(OUTDIR)/mfc/afxanimationcontroller.obj $(OUTDIR)/mfc/afxautohidebar.obj \
	$(OUTDIR)/mfc/afxautohidebutton.obj $(OUTDIR)/mfc/afxautohidedocksite.obj \
	$(OUTDIR)/mfc/afxbasepane.obj $(OUTDIR)/mfc/afxbaseribbonelement.obj \
	$(OUTDIR)/mfc/afxbasetabbedpane.obj $(OUTDIR)/mfc/afxbasetabctrl.obj \
	$(OUTDIR)/mfc/afxbasetoolbar.obj $(OUTDIR)/mfc/afxbutton.obj $(OUTDIR)/mfc/afxcaptionbar.obj \
	$(OUTDIR)/mfc/afxcaptionbutton.obj $(OUTDIR)/mfc/afxcaptionmenubutton.obj \
	$(OUTDIR)/mfc/afxcmdusagecount.obj $(OUTDIR)/mfc/afxcolorbar.obj $(OUTDIR)/mfc/afxcolorbutton.obj \
	$(OUTDIR)/mfc/afxcolordialog.obj $(OUTDIR)/mfc/afxcolormenubutton.obj \
	$(OUTDIR)/mfc/afxcolorpickerctrl.obj $(OUTDIR)/mfc/afxcolorpopupmenu.obj \
	$(OUTDIR)/mfc/afxcolorpropertysheet.obj $(OUTDIR)/mfc/afxcommandmanager.obj \
	$(OUTDIR)/mfc/afxcontextmenumanager.obj $(OUTDIR)/mfc/afxcontrolbarimpl.obj \
	$(OUTDIR)/mfc/afxcontrolrenderer.obj $(OUTDIR)/mfc/afxctrlcontainer.obj \
	$(OUTDIR)/mfc/afxcustomcolorspropertypage.obj $(OUTDIR)/mfc/afxcustomizebutton.obj \
	$(OUTDIR)/mfc/afxcustomizemenubutton.obj $(OUTDIR)/mfc/afxdatarecovery.obj \
	$(OUTDIR)/mfc/afxdesktopalertdialog.obj $(OUTDIR)/mfc/afxdesktopalertwnd.obj \
	$(OUTDIR)/mfc/afxdialogex.obj $(OUTDIR)/mfc/afxdialogimpl.obj $(OUTDIR)/mfc/afxdockablepane.obj \
	$(OUTDIR)/mfc/afxdockablepaneadapter.obj $(OUTDIR)/mfc/afxdockingmanager.obj \
	$(OUTDIR)/mfc/afxdockingpanesrow.obj $(OUTDIR)/mfc/afxdocksite.obj \
	$(OUTDIR)/mfc/afxdragframeimpl.obj $(OUTDIR)/mfc/afxdrawmanager.obj \
	$(OUTDIR)/mfc/afxdropdownlistbox.obj $(OUTDIR)/mfc/afxdropdowntoolbar.obj \
	$(OUTDIR)/mfc/afxeditbrowsectrl.obj $(OUTDIR)/mfc/afxfontcombobox.obj \
	$(OUTDIR)/mfc/afxframeimpl.obj $(OUTDIR)/mfc/afxframewndex.obj $(OUTDIR)/mfc/afxfullscreenimpl.obj \
	$(OUTDIR)/mfc/afxglobals.obj $(OUTDIR)/mfc/afxglobalutils.obj $(OUTDIR)/mfc/afxheaderctrl.obj \
	$(OUTDIR)/mfc/afximageeditordialog.obj $(OUTDIR)/mfc/afximagepaintarea.obj \
	$(OUTDIR)/mfc/afxjumplist.obj $(OUTDIR)/mfc/afxkeyboardmanager.obj \
	$(OUTDIR)/mfc/afxkeymapdialog.obj $(OUTDIR)/mfc/afxlinkctrl.obj $(OUTDIR)/mfc/afxlistctrl.obj \
	$(OUTDIR)/mfc/afxmaskededit.obj $(OUTDIR)/mfc/afxmdichildwndex.obj \
	$(OUTDIR)/mfc/afxmdiclientareawnd.obj $(OUTDIR)/mfc/afxmdiframewndex.obj \
	$(OUTDIR)/mfc/afxmenubar.obj $(OUTDIR)/mfc/afxmenubutton.obj $(OUTDIR)/mfc/afxmenuhash.obj \
	$(OUTDIR)/mfc/afxmenuimages.obj $(OUTDIR)/mfc/afxmenutearoffmanager.obj \
	$(OUTDIR)/mfc/afxmousemanager.obj $(OUTDIR)/mfc/afxmousepropertypage.obj \
	$(OUTDIR)/mfc/afxmultipaneframewnd.obj $(OUTDIR)/mfc/afxolecntrframewndex.obj \
	$(OUTDIR)/mfc/afxoledocipframewndex.obj $(OUTDIR)/mfc/afxoleipframewndex.obj \
	$(OUTDIR)/mfc/afxoleserverdocex.obj $(OUTDIR)/mfc/afxoutlookbar.obj \
	$(OUTDIR)/mfc/afxoutlookbarpane.obj $(OUTDIR)/mfc/afxoutlookbarpaneadapter.obj \
	$(OUTDIR)/mfc/afxoutlookbarpanebutton.obj $(OUTDIR)/mfc/afxoutlookbartabctrl.obj \
	$(OUTDIR)/mfc/afxpane.obj $(OUTDIR)/mfc/afxpanecontainer.obj \
	$(OUTDIR)/mfc/afxpanecontainermanager.obj $(OUTDIR)/mfc/afxpanedialog.obj \
	$(OUTDIR)/mfc/afxpanedivider.obj $(OUTDIR)/mfc/afxpaneframewnd.obj $(OUTDIR)/mfc/afxpopupmenu.obj \
	$(OUTDIR)/mfc/afxpopupmenubar.obj $(OUTDIR)/mfc/afxpreviewviewex.obj \
	$(OUTDIR)/mfc/afxpropertygridctrl.obj $(OUTDIR)/mfc/afxpropertygridtooltipctrl.obj \
	$(OUTDIR)/mfc/afxpropertypage.obj $(OUTDIR)/mfc/afxpropertysheet.obj $(OUTDIR)/mfc/afxrebar.obj \
	$(OUTDIR)/mfc/afxrebarstate.obj $(OUTDIR)/mfc/afxrecentdocksiteinfo.obj \
	$(OUTDIR)/mfc/afxregpath.obj $(OUTDIR)/mfc/afxrendertarget.obj $(OUTDIR)/mfc/afxribbonbar.obj \
	$(OUTDIR)/mfc/afxribbonbutton.obj $(OUTDIR)/mfc/afxribbonbuttonsgroup.obj \
	$(OUTDIR)/mfc/afxribboncategory.obj $(OUTDIR)/mfc/afxribboncheckbox.obj \
	$(OUTDIR)/mfc/afxribboncollector.obj $(OUTDIR)/mfc/afxribboncolorbutton.obj \
	$(OUTDIR)/mfc/afxribboncombobox.obj $(OUTDIR)/mfc/afxribboncommandslistbox.obj \
	$(OUTDIR)/mfc/afxribbonconstructor.obj $(OUTDIR)/mfc/afxribboncustomizedialog.obj \
	$(OUTDIR)/mfc/afxribbonedit.obj $(OUTDIR)/mfc/afxribboninfo.obj $(OUTDIR)/mfc/afxribboninfo2.obj \
	$(OUTDIR)/mfc/afxribboninfoloader.obj $(OUTDIR)/mfc/afxribbonkeyboardcustomizedialog.obj \
	$(OUTDIR)/mfc/afxribbonkeytip.obj $(OUTDIR)/mfc/afxribbonlabel.obj \
	$(OUTDIR)/mfc/afxribbonlinkctrl.obj $(OUTDIR)/mfc/afxribbonmainpanel.obj \
	$(OUTDIR)/mfc/afxribbonminitoolbar.obj $(OUTDIR)/mfc/afxribbonpalettegallery.obj \
	$(OUTDIR)/mfc/afxribbonpanel.obj $(OUTDIR)/mfc/afxribbonpanelmenu.obj \
	$(OUTDIR)/mfc/afxribbonprogressbar.obj $(OUTDIR)/mfc/afxribbonquickaccesstoolbar.obj \
	$(OUTDIR)/mfc/afxribbonslider.obj $(OUTDIR)/mfc/afxribbonstatusbar.obj \
	$(OUTDIR)/mfc/afxribbonstatusbarpane.obj $(OUTDIR)/mfc/afxribbonundobutton.obj \
	$(OUTDIR)/mfc/afxrichpreviewctrlimpl.obj $(OUTDIR)/mfc/afxsettingsstore.obj \
	$(OUTDIR)/mfc/afxshelllistctrl.obj $(OUTDIR)/mfc/afxshellmanager.obj \
	$(OUTDIR)/mfc/afxshelltreectrl.obj $(OUTDIR)/mfc/afxshowallbutton.obj \
	$(OUTDIR)/mfc/afxsmartdockingguide.obj $(OUTDIR)/mfc/afxsmartdockinghighlighterwnd.obj \
	$(OUTDIR)/mfc/afxsmartdockingmanager.obj $(OUTDIR)/mfc/afxsound.obj \
	$(OUTDIR)/mfc/afxspinbuttonctrl.obj $(OUTDIR)/mfc/afxsplitterwndex.obj \
	$(OUTDIR)/mfc/afxstandardcolorspropertypage.obj $(OUTDIR)/mfc/afxstatusbar.obj \
	$(OUTDIR)/mfc/afxtabbedpane.obj $(OUTDIR)/mfc/afxtabctrl.obj $(OUTDIR)/mfc/afxtabview.obj \
	$(OUTDIR)/mfc/afxtagmanager.obj $(OUTDIR)/mfc/afxtaskspane.obj \
	$(OUTDIR)/mfc/afxtaskspaneframewnd.obj $(OUTDIR)/mfc/afxtoolbar.obj \
	$(OUTDIR)/mfc/afxtoolbarbutton.obj $(OUTDIR)/mfc/afxtoolbarbuttoncustomizedialog.obj \
	$(OUTDIR)/mfc/afxtoolbarbuttonslistbutton.obj $(OUTDIR)/mfc/afxtoolbarcomboboxbutton.obj \
	$(OUTDIR)/mfc/afxtoolbardatetimectrl.obj $(OUTDIR)/mfc/afxtoolbardropsource.obj \
	$(OUTDIR)/mfc/afxtoolbardroptarget.obj $(OUTDIR)/mfc/afxtoolbareditboxbutton.obj \
	$(OUTDIR)/mfc/afxtoolbarfontcombobox.obj $(OUTDIR)/mfc/afxtoolbarimages.obj \
	$(OUTDIR)/mfc/afxtoolbarmenubutton.obj $(OUTDIR)/mfc/afxtoolbarmenubuttonsbutton.obj \
	$(OUTDIR)/mfc/afxtoolbarnamedialog.obj $(OUTDIR)/mfc/afxtoolbarscommandslistbox.obj \
	$(OUTDIR)/mfc/afxtoolbarscustomizedialog.obj \
	$(OUTDIR)/mfc/afxtoolbarskeyboardpropertypage.obj \
	$(OUTDIR)/mfc/afxtoolbarslistcheckbox.obj $(OUTDIR)/mfc/afxtoolbarslistpropertypage.obj \
	$(OUTDIR)/mfc/afxtoolbarsmenupropertypage.obj \
	$(OUTDIR)/mfc/afxtoolbarsoptionspropertypage.obj \
	$(OUTDIR)/mfc/afxtoolbarspineditboxbutton.obj \
	$(OUTDIR)/mfc/afxtoolbarstoolspropertypage.obj \
	$(OUTDIR)/mfc/afxtoolbarsystemmenubutton.obj $(OUTDIR)/mfc/afxtooltipctrl.obj \
	$(OUTDIR)/mfc/afxtooltipmanager.obj $(OUTDIR)/mfc/afxtrackmouse.obj $(OUTDIR)/mfc/afxusertool.obj \
	$(OUTDIR)/mfc/afxusertoolsmanager.obj $(OUTDIR)/mfc/afxvisualmanager.obj \
	$(OUTDIR)/mfc/afxvisualmanageroffice2003.obj $(OUTDIR)/mfc/afxvisualmanageroffice2007.obj \
	$(OUTDIR)/mfc/afxvisualmanagerofficexp.obj $(OUTDIR)/mfc/afxvisualmanagervs2005.obj \
	$(OUTDIR)/mfc/afxvisualmanagervs2008.obj $(OUTDIR)/mfc/afxvisualmanagerwindows.obj \
	$(OUTDIR)/mfc/afxvisualmanagerwindows7.obj $(OUTDIR)/mfc/afxvslistbox.obj \
	$(OUTDIR)/mfc/afxwinappex.obj $(OUTDIR)/mfc/afxwindowsmanagerdialog.obj


# =============================================================================
# MFC - build-configuration specific objects
# =============================================================================

INLINES :=
DAO     :=
OLEASM  :=
INETASM :=

ifeq ($(DEBUG), 1)
INLINES := \
	$(OUTDIR)/mfc/afxinl1.obj $(OUTDIR)/mfc/afxinl2.obj $(OUTDIR)/mfc/afxinl3.obj $(OUTDIR)/mfc/afxinl4.obj
OBJDIAG += $(OUTDIR)/mfc/dumpinit.obj
OLECTL  += $(OUTDIR)/mfc/ctlinl.obj
endif

ifeq ($(MBCS), 1)
DB      += $(OUTDIR)/mfc/afxdbcs.obj
else
GUI     += $(OUTDIR)/mfc/afxtaskdialog.obj
endif

ifeq ($(X86), 1)
DAO      := $(OUTDIR)/mfc/daocore.obj $(OUTDIR)/mfc/daodfx.obj $(OUTDIR)/mfc/daoview.obj
INTERNET += $(OUTDIR)/mfc/inetcall.obj
else
OLEASM   := $(OUTDIR)/olecall_.obj
INETASM  := $(OUTDIR)/inetcal_.obj
endif


# =============================================================================
# MFC - final list
# =============================================================================

MFC_OBJS :=	\
	$(OBJECT) $(OBJDIAG) $(INLINES) $(FILES) $(COLL1) $(COLL2) $(MISC) \
	$(WINDOWS) $(DIALOG) $(WINMISC) $(DOCVIEW) $(APP) $(OLEREQ) \
	$(INTERNET) $(INETASM) $(DAO) $(OLE) $(OLECTL) $(OLEASM) $(SOCKETS) \
	$(DB) $(GUI) \
	$(OUTDIR)/mfc/dllinit.obj $(OUTDIR)/mfc/stdafx.obj

MFCMDLL_OBJS :=	\
	$(OUTDIR)/mfcm/stdafx.obj $(OUTDIR)/mfcm/afxwfrminl.obj $(OUTDIR)/mfcm/mfcm.obj \
	$(OUTDIR)/mfcm/postdllmain.obj $(OUTDIR)/mfcm/postrawdllmain.obj

# =============================================================================
# MFC resources
# =============================================================================

MFCDLL_RES  := $(OUTDIR)/mfc/mfcdll.rc.obj
MFCMDLL_RES := $(OUTDIR)/mfcm/mfcmdll.rc.obj
MFCENU_RES  := $(OUTDIR)/mfc/mfcenu.rc.obj
