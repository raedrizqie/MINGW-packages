// atluuid.h - MSVC-compatible __uuidof for Clang on MingW-w64.
//
// Purpose
//   Gives ATL/MFC sources the MSVC spelling __uuidof(T) for both kinds of type:
//     * types declared with __declspec(uuid("...")) : resolved by clang's built-in
//     * types registered through mingw's __CRT_UUID_DECL (IUnknown, IDispatch, ...)
//   It keeps  &__uuidof(T)  usable as a constant expression (template arguments),
//   and accepts expression forms such as __uuidof(**pp) (used by IID_PPV_ARGS).
//
// Usage
//   This header must be parsed BEFORE any Windows/COM header, so force-include it:
//       clang++ -include atluuid.h ...
//   It is a no-op on MSVC and on non-clang compilers.
//
// Known limits
//   * __uuidof(0) (GUID_NULL on MSVC) is not supported.
//   * A type with no GUID anywhere produces a link error naming guid_v<T>.

#ifndef __ATLUUID_H__
#define __ATLUUID_H__

#if __cplusplus < 201703L
#error atluuid.h requires C++17 or later for inline variables.
#endif

#pragma once

#if defined(__clang__) && !defined(_MSC_VER) && defined(__cplusplus)

#include <_mingw.h>
#include <guiddef.h>
#include <type_traits>

// Minimal forward declaration of GUID so atluuid.h can be included anytime
#ifndef _GUID_DEFINED
#define _GUID_DEFINED
struct _GUID;
typedef struct _GUID GUID;
#endif

#ifdef __uuidof
#undef __uuidof
#endif

namespace ATL {
namespace _atl_uuid {

// Table of GUIDs for types registered through __CRT_UUID_DECL.
// Only explicit specializations exist; there is no primary definition.
template <class T>
extern const GUID guid_v;

// Types that carry __declspec(uuid) resolve through clang's built-in;
// everything else falls back to the table.
template <class T, class = void>
struct of
{
	static constexpr const GUID& value = guid_v<T>;
};

template <class T>
struct of<T, std::void_t<decltype(__uuidof(T))>>
{
	static constexpr const GUID& value = __uuidof(T);
};

// Strip references, one pointer level and cv-qualifiers, like MSVC does.
template <class T>
using strip = std::remove_cv_t<std::remove_pointer_t<std::remove_reference_t<T>>>;

} // namespace _atl_uuid
} // namespace ATL

// MSVC spelling, expression and type forms.
#define __uuidof(...) ::ATL::_atl_uuid::of< ::ATL::_atl_uuid::strip<__typeof(__VA_ARGS__)> >::value

// Capture GUIDs that the system headers declare, so they land in the table.
#ifdef __CRT_UUID_DECL
#undef __CRT_UUID_DECL
#endif

#define __CRT_UUID_DECL(type, l, w1, w2, b1, b2, b3, b4, b5, b6, b7, b8)       \
	extern "C++" {                                                           \
	namespace ATL { namespace _atl_uuid {                                    \
	template <> inline const GUID guid_v<type> =                             \
		{ l, w1, w2, { b1, b2, b3, b4, b5, b6, b7, b8 } };                 \
	} }                                                                      \
	}

#define ATL_REGISTER_UUID(type, iid)                                           \
	extern "C++" { namespace ATL { namespace _atl_uuid {                     \
	template <> inline const GUID guid_v< ::type > = (iid);                  \
	} } }

#endif // __clang__ && !_MSC_VER && __cplusplus

#endif // __ATLUUID_H__
