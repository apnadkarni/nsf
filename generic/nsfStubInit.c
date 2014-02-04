/* 
 * nxStubInit.c --
 *
 *	This file contains the initializers for the stub vectors of the Next
 *	Scripting Framework.
 *
 * Copyright (c) 1998-1999 by XXX
 *
 * See the file "tcl-license.terms" for information on usage and redistribution
 * of this file, and for a DISCLAIMER OF ALL WARRANTIES.
 *
 */

#include "nsfInt.h"

/*
 * Remove macros that will interfere with the definitions below.
 */

/*
 * WARNING: The contents of this file is automatically generated by the
 * tools/genStubs.tcl script. Any modifications to the function declarations
 * below should be made in the generic/tcl.decls script.
 */

#if defined(PRE86)
EXTERN NsfStubs nsfStubs;
# else
MODULE_SCOPE const NsfStubs nsfStubs;
#endif




/* !BEGIN!: Do not edit below this line. */

NsfIntStubs nsfIntStubs = {
    TCL_STUB_MAGIC,
    NULL,
};

static NsfStubHooks nsfStubHooks = {
    &nsfIntStubs
};

NsfStubs nsfStubs = {
    TCL_STUB_MAGIC,
    &nsfStubHooks,
    Nsf_Init, /* 0 */
    NULL, /* 1 */
    NsfIsClass, /* 2 */
    NsfGetObject, /* 3 */
    NsfGetClass, /* 4 */
    NsfDeleteObject, /* 5 */
    NsfRemoveObjectMethod, /* 6 */
    NsfRemoveClassMethod, /* 7 */
    Nsf_ObjSetVar2, /* 8 */
    Nsf_ObjGetVar2, /* 9 */
    Nsf_UnsetVar2, /* 10 */
    NsfDStringPrintf, /* 11 */
    NsfPrintError, /* 12 */
    NsfErrInProc, /* 13 */
    NsfObjErrType, /* 14 */
    NsfStackDump, /* 15 */
    NsfSetObjClientData, /* 16 */
    NsfGetObjClientData, /* 17 */
    NsfSetClassClientData, /* 18 */
    NsfGetClassClientData, /* 19 */
    NsfRequireObjNamespace, /* 20 */
    NsfCallMethodWithArgs, /* 21 */
    NsfAddObjectMethod, /* 22 */
    NsfAddClassMethod, /* 23 */
    NsfCreate, /* 24 */
    Nsf_ArgumentParse, /* 25 */
    NsfLog, /* 26 */
    Nsf_PointerAdd, /* 27 */
    Nsf_PointerDelete, /* 28 */
    Nsf_PointerTypeRegister, /* 29 */
    Nsf_ConvertToBoolean, /* 30 */
    Nsf_ConvertToClass, /* 31 */
    Nsf_ConvertToInt32, /* 32 */
    Nsf_ConvertToInteger, /* 33 */
    Nsf_ConvertToObject, /* 34 */
    Nsf_ConvertToPointer, /* 35 */
    Nsf_ConvertToString, /* 36 */
    Nsf_ConvertToTclobj, /* 37 */
};

/* !END!: Do not edit above this line. */

/*
 * Local Variables:
 * mode: c
 * c-basic-offset: 2
 * fill-column: 78
 * End:
 */
