# ATL/MFC 10.00.40219 for MSYS2 MinGW-w64 (CLAN64, UCRT64 & MINGW64 environments)
# with Clang and LLVM lld.
# Usage: make -j$(nproc) [X86=1] [DEBUG=1] [MBCS=1] [MFCENU=1] [V=1]

CXX  := clang++
AR   := llvm-ar
AS   := uasm
RC   := llvm-windres
RM   := rm -f

ifeq ($(V),1)
Q :=
else
Q := @
endif

ifeq ($(DEBUG),1)
OUTDIR := debug
else
OUTDIR := release
endif

# ---- Architecture -----------------------------------------------------------

ifeq ($(X86),1)
TARGET     := i686-w64-mingw32
ARCHFLAGS  := -D_M_IX86 -D_X86_ -D_AFX_PORTABLE
ASFMT      := -win32
PROC       := X86
else
TARGET     := x86_64-w64-mingw32
ARCHFLAGS  := -D_M_AMD64 -D_AMD64_
ASFMT      := -win64
PROC       := X64
endif

# ---- Charset ----------------------------------------------------------------

ifeq ($(MBCS),1)
SUFFIX     :=
CHARFLAGS  := -D_MBCS
RCFLAGS    := -D_MBCS
else
SUFFIX     := u
CHARFLAGS  := -D_UNICODE -DUNICODE
RCFLAGS    := -D_UNICODE
endif

# ---- Outputs ----------------------------------------------------------------

ATLSLIB    := $(OUTDIR)/libatl10.a

ifeq ($(DEBUG),1)
MFCDLL     := $(OUTDIR)/libmfc100$(SUFFIX)d.dll
MFCMDLL    := $(OUTDIR)/libmfcm100$(SUFFIX)d.dll
else
MFCDLL     := $(OUTDIR)/libmfc100$(SUFFIX).dll
MFCMDLL    := $(OUTDIR)/libmfcm100$(SUFFIX).dll
endif
MFCENUDLL  := $(OUTDIR)/libmfc100enu.dll

# ---- Flags ------------------------------------------------------------------

INCDIRS    := -Iinclude

CXXBASE    := -std=c++17 -fno-delete-null-pointer-checks -fno-implicit-templates -fno-omit-frame-pointer \
              -fno-strict-aliasing -fms-extensions -mms-bitfields

COMMON     := -DNOMINMAX -DWIN32 -DWINNT -D_WINDOWS -D_MT

DEPFLAGS    = -MMD -MP -MF $(@:.obj=.d)

ifndef CXX_STDLIB
CXX_STDLIB := $(shell $(CXX) --target=$(TARGET) -std=c++17 -x c++ -include cstddef \
                -dM -E - < /dev/null 2>/dev/null | grep -q __GLIBCXX__ && echo libstdc++ || echo libc++)
endif
$(info CXX_STDLIB = $(CXX_STDLIB))

ifeq ($(CXX_STDLIB),libstdc++)
# libstdc++ uses '__in' etc. as identifiers, which collide with the SAL macros (sal.h),
# so we must load this header first to avoid error.
CXXBASE += -include atluuid.h -include bits/stdc++.h
else
CXXBASE += -include atluuid.h
endif

ifndef CRT_TYPE
  CRT_CHECK := $(shell $(CXX) -x c++ -include _mingw.h -E -dM /dev/null 2>/dev/null | grep -E '^\#define _UCRT([[:space:]]|$$)')
  ifneq ($(CRT_CHECK),)
    CRT_TYPE := UCRT
  else
    CRT_TYPE := MSVCRT
  endif
endif
$(info CRT_TYPE = $(CRT_TYPE) $(PROC))

ifeq ($(CRT_TYPE),MSVCRT)
COMMON += -D__MSVCRT_VERSION__=0x1000
endif

ifeq ($(DEBUG),1)
OPT        := -g -ggdb -D_DEBUG
else
OPT        := -g -O0 -DNDEBUG
endif

CXXFLAGS   := $(CXXBASE) $(OPT) $(COMMON) $(ARCHFLAGS) $(CHARFLAGS)

ATLS_FLAGS := -D_ATL_STATIC_REGISTRY -D_ATL_NO_DEFAULT_LIBS
MFC_FLAGS  := -D_AFXDLL -D_MFC_BLD -D_MFC_DLL_BLD -D_AFX_DISABLE_DEPRECATED -D_AFX_MONOLITHIC \
              -D_AFX_CORE_IMPL -D_AFX_OLE_IMPL -D_AFX_DB_IMPL -D_AFX_NET_IMPL -D_ATL_STATIC_REGISTRY
MFCM_FLAGS := -D_AFXDLL -D_AFXEXT -D_AFX_ENABLE_INLINES -DBUILD_MFCM

ATLFLAGS   := $(CXXFLAGS) -fexceptions -frtti $(ATLS_FLAGS)
MFCFLAGS   := $(CXXFLAGS) $(MFC_FLAGS)
MFCMFLAGS  := $(CXXFLAGS) $(MFCM_FLAGS)

WARNFLAGS  := -Wno-unused-result -Wno-unused-value -Wno-return-type -Wno-pointer-arith \
              -Wno-int-to-pointer-cast -Wno-invalid-offsetof -Wno-narrowing -Wno-undefined-var-template \
              -Wno-missing-exception-spec -Wno-pointer-to-int-cast -Wno-nonportable-include-path \
              -Wno-ignored-attributes -Wno-tautological-undefined-compare -Wno-invalid-noreturn \
              -Wno-extern-initializer -Wno-tautological-pointer-compare -Wno-tautological-constant-out-of-range-compare \
              -Wno-ignored-pragmas -Wno-microsoft-pure-definition -Wno-pragma-pack -Wno-switch -Wno-varargs

LIBLDFLAGS := 

ifeq ($(CXX_STDLIB),libstdc++)
LIBLDFLAGS += -Wl,-Bstatic -lwinpthread -Wl,-Bdynamic
endif

LDFLAGS    := -fuse-ld=lld -shared -mwindows -Wl,--export-all-symbols $(LIBLDFLAGS)

ifeq ($(CRT_TYPE),UCRT)
CRTLIBS := -lucrt
else
CRTLIBS := -lmsvcr100 -lmsvcrt
endif

LIBS       := -luuid -luxtheme -lgdiplus -luserenv -lshlwapi -loleacc -loledlg \
              -lhtmlhelp -ldbghelp -lmsxml2 -lwinspool -lwinmm -lwininet -lurlmon -lws2_32 \
              -lwindowscodecs -ladvapi32 -lmsimg32 -limm32 -lcomctl32 -lodbc32 -lodbccp32 \
              -lshell32 -lkernel32 -luser32 -lgdi32 -lcomdlg32 -lole32 -loleaut32

RC_COMMON  := -DRELEASE -DRC_INVOKED -D_AFX_MONOLITHIC
RC_LANG    := -DLANG=ENU -DLANGCODE=\"0409\" -DLANGID=0x0409 -DVER_LANGID=0x0409 -DVER_LANGID_HEX=0409

# ---- Object lists (ATLS_OBJS, MFC_OBJS, MFCMDLL_OBJS, *_RES, asm objs, ...) --

include objs.mk

ALL_OBJS := $(ATLS_OBJS) $(MFC_OBJS) $(MFCMDLL_OBJS)

# ---- Top-level --------------------------------------------------------------

.SUFFIXES:
.DELETE_ON_ERROR:
.PHONY: all clean

all: $(ATLSLIB) $(MFCDLL) $(MFCMDLL)
ifeq ($(MFCENU),1)
all: $(MFCENUDLL)
endif

clean:
	$(Q)$(RM) -r $(OUTDIR)

# ---- Link -------------------------------------------------------------------

$(ATLSLIB): $(ATLS_OBJS)
	@echo "  AR      $@"
	@mkdir -p $(dir $@)
	$(Q)$(RM) $@
	$(Q)$(AR) rcs $@ $^

$(MFCDLL): $(MFC_OBJS) $(MFCDLL_RES) $(ATLSLIB)
	@echo "  LD      $@"
	@mkdir -p $(dir $@)
	$(Q)$(RM) $@ $@.a
	$(Q)$(CXX) $(LDFLAGS) -o $@ -Wl,--out-implib,$@.a \
		$(MFC_OBJS) $(MFCDLL_RES) $(ATLSLIB) $(CRTLIBS) $(LIBS)

$(MFCMDLL): $(MFCMDLL_OBJS) $(MFCMDLL_RES) $(MFCDLL)
	@echo "  LD      $@"
	@mkdir -p $(dir $@)
	$(Q)$(RM) $@ $@.a
	$(Q)$(CXX) $(LDFLAGS) -o $@ -Wl,--out-implib,$@.a \
		$(MFCMDLL_OBJS) $(MFCMDLL_RES) $(MFCDLL).a $(CRTLIBS) $(LIBS)

$(MFCENUDLL): $(MFCENU_RES)
	@echo "  LD      $@"
	@mkdir -p $(dir $@)
	$(Q)$(CXX) $(LDFLAGS) -o $@ $^ $(CRTLIBS) $(LIBS)

# ---- Compile ----------------------------------------------------------------

define COMPILE
	@echo "  CXX     $@"
	@mkdir -p $(dir $@)
	$(Q)$(CXX) $(1) $(INCDIRS) $(WARNFLAGS) $(DEPFLAGS) -c $< -o $@
endef

$(OUTDIR)/atl/%.obj:      src/atl/%.cpp
	$(call COMPILE,$(ATLFLAGS))
$(OUTDIR)/atl/atls/%.obj: src/atl/atls/%.cpp
	$(call COMPILE,$(ATLFLAGS))
$(OUTDIR)/mfc/%.obj:      src/mfc/%.cpp
	$(call COMPILE,$(MFCFLAGS))
$(OUTDIR)/mfcm/%.obj:     src/mfcm/%.cpp
	$(call COMPILE,$(MFCMFLAGS))

# Special cases
ifeq ($(X86),1)
$(OUTDIR)/atl/atls/atlfuncs.obj: src/atl/atls/atlfuncs.cpp
	$(call COMPILE,-fasm $(ATLFLAGS))
endif

$(OUTDIR)/atl/atls/INTEL/atlthunk.obj: src/atl/atls/INTEL/atlthunk.cpp
	$(call COMPILE,$(CXXFLAGS))

$(OUTDIR)/atl/atls/amd64/atlthunk.obj: src/atl/atls/amd64/atlthunk.cpp
	$(call COMPILE,$(CXXFLAGS))

# ---- Assembly ---------------------------------------------------------------

define ASM
	@echo "  ASM     $@"
	@mkdir -p $(dir $@)
	$(Q)$(AS) $(ASFMT) -nologo -Cp -c -Fo$@ $< > $@.log 2>&1 || { cat $@.log; rm -f $@.log; exit 1; }
	$(Q)rm -f $@.log
endef

ifneq ($(X86),1)
$(OUTDIR)/qithunk.s: Makefile
	@mkdir -p $(dir $@)
	@echo "  GEN     $@"
	$(Q)awk 'BEGIN { print "\t.text"; \
	  for (i = 3; i <= 1023; i++) { \
	    n = "_ZN3ATL9_QIThunk" length("f" i) "f" i "Ev"; \
	    printf "\t.globl %s\n\t.p2align 4\n%s:\n", n, n; \
	    printf "\tcmpq $$0, 16(%%rcx)\n\tjg 1f\n\tint3\n"; \
	    printf "1:\tmovq 8(%%rcx), %%rax\n\tmovq %%rax, %%rcx\n"; \
	    printf "\tmovq (%%rax), %%rax\n\tjmp *%d(%%rax)\n", 8*i; } }' > $@

ifneq ($(QITHUNK),)
$(OUTDIR)/$(QITHUNK): $(OUTDIR)/qithunk.s
	@mkdir -p $(dir $@)
	@echo "  ASM     $@"
	$(Q)$(CXX) --target=$(TARGET) -c $< -o $@
endif

ifneq ($(STDCTHUNK),)
$(OUTDIR)/$(STDCTHUNK): src/atl/atls/amd64/stdcallthunk.s
	$(ASM)
endif

$(OUTDIR)/olecall_.obj: src/mfc/amd64/olecall_.s
	$(ASM)

$(OUTDIR)/inetcal_.obj: src/mfc/amd64/inetcal_.s
	$(ASM)
endif

# ---- Resources --------------------------------------------------------------

define RCBUILD
	@echo "  RC      $@"
	@mkdir -p $(dir $@)
	$(Q)$(RC) $(RC_COMMON) $(RCFLAGS) $(1) $(INCDIRS) $< -o $@ -O coff
endef

$(MFCDLL_RES):  src/mfc/mfcdll.rc
	$(call RCBUILD,-D_AFXDLL)
$(MFCMDLL_RES): src/mfcm/mfcmdll.rc
	$(call RCBUILD,)
$(MFCENU_RES):  src/mfc/mfcintl.rc
	$(call RCBUILD,$(RC_LANG) -Imfc)

# ---- Auto dependencies ------------------------------------------------------

-include $(patsubst %.obj,%.d,$(ALL_OBJS))
