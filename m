Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED73AFCE6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781237; cv=fail; b=tEbANPWEwi6EFqdUg8ApMpmlbFIHGwdCZ4JTFwls21QSjonHflwxtljsglTHeF4tpZWUnIgJbtnbyIRESIh38Z3gdpK6mlpB274kkDajMJuLLl/raFDJ5eSYFn/LNCb7Jn+rjLem37ppZ/T1mzEQlxOh538KwhSdxypoqrg1P9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781237; c=relaxed/simple;
	bh=NHtXM923WuY/i59Vz7F6JUnmQ2lfn9q+cztd0NOePU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GZQxoS3ntj5mVwTHbN9HEytZTUg9XZTwrOQe4w4ZE9QASmUvBYTkpisNcZCtfzFmpLvSJogMEVMLl4DpjzA86PVDd5PHEgES0h6Zg6enbbr2ft7yd9QoNsLowsbgywZfYeCKTOzPsF1UX0Y5G5U7d3KiJ+VdPLEbgZmWaeFIO7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPBVRj00; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPBVRj00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791781233; x=1823317233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NHtXM923WuY/i59Vz7F6JUnmQ2lfn9q+cztd0NOePU0=;
  b=aPBVRj00rbcYfYjmZMoQUyYcg6q5vt4fZAMkvyzgU5YFUoUQNaIcdKBY
   1VwW7w6++H/x3PtE/35eE4Y1re3d4WSMpiYoT0Rzy61LxG5ftdAVIBHtv
   ugIeflHU7ZgA7CQpJgUWfOgdVOD55UNPiPL+XTREoXZ+qoNYhd6v32nRa
   wAHZ8EAcaIr0/u6weUR/RnPDop12sNxdoGm0jBkiQvAzV/dbVBTiVnq8R
   JQ2J9+AJumP0X+u/4JoQELLpR35D9k8YGtss9Yw/iMDYTAvOyOkmghyk0
   ry6xJ8V2+fyrT+HJ/L5HlMSqhiOiHd+wzAaimUo2o1keWVdSNd9bUq3aP
   w==;
X-CSE-ConnectionGUID: Z5vxjaLqQeGZmq1L59xORA==
X-CSE-MsgGUID: RgOsqaiGQ1GAe0iqCwkELw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="489213"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="489213"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 22:00:33 -0700
X-CSE-ConnectionGUID: u2RIdUg0QU6Sr4Amh1421w==
X-CSE-MsgGUID: IDvKWnf7SZaM8Vkk79dAlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1128075"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 22:00:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 22:00:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 22:00:31 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 22:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCQNysXy9r984J8M5MZM3P1CtK0C1WJ8SKhPFIDimgPFciiNNxFZoYLBlajmG7IWqNWyDhGuYQudUnIdkxr4faKpGGwPuM1Oj2ERyu0O9VaI8oLnWfCHkUWwd5AaUu4Pv47qxBDs1Ro5aHGbuqCiZJX8PxL4nv5AXjsvGUhVvSmwBlniUhbvZcQpQeJlzQZ+2eeDL6f61UyPngWEfVugwMgPCmVyYChgnE7nSoivlr14vdkqF7i8xq0QOK4vmDOo+1H9WOT//aHSnnpJhfVi+FB2aY2u++YW05vygkNlm68+S4QmuV9dPrFApAMbGoWRYP56IaxvtsaqsL2DTHKNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXABab1uwLpiap80Ikv6a0r+6bvSnw8sOj0zGCaH5fI=;
 b=Xq3x4CKYGEh7czSm87ii/gfh7rGNjRMX31+ioOtPyHa3YNglYjtx2jpr10PVJ+2P1zjv6z4D9O/6OfAWx9EtqcqIbWOHB8KiWJ/2lffDCqhW9ISidGE3Ew8jUTlHDgWdEHifgK2KCajGD/HtdWSXZgsIlljn8tmrCU59bVKpAH6bkVqCp1eX5gAOQuTa5hPItY45cHOvEwVFjxZP5DdmaroNxrmaBzUw3n8+l/TlNYmCxX47z8zWhPw8seJI5W0eX5Gizn8p7wb9XP0MoTtM4Z2LV8WGx0n96Gdd4cHYvrPay/Epuqg3rMBzTF6F31r7R5j/xqQytir2lNhp33VBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by CY5PR11MB6463.namprd11.prod.outlook.com
 (2603:10b6:930:31::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 05:00:29 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 05:00:29 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Golani, Mitulkumar Ajitkumar" <mitulkumar.ajitkumar.golani@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1] drm/i915/display: Allow port sync on PTL
Thread-Topic: [PATCH v1] drm/i915/display: Allow port sync on PTL
Thread-Index: AQHdWgAYpHoy9l+YTU61BIdlDVpxOLb5VA7Q
Date: Mon, 12 Oct 2026 05:00:29 +0000
Message-ID: <DS4PPFE901A304F863A95A27770071C6901E39F2@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261012040402.3332398-1-mitulkumar.ajitkumar.golani@intel.com>
In-Reply-To: <20261012040402.3332398-1-mitulkumar.ajitkumar.golani@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|CY5PR11MB6463:EE_
x-ms-office365-filtering-correlation-id: 4f76a46d-7ce2-41d5-b68c-08df281dbc7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|38070700021|56012099006|260925021311599003|260925022911599003|260925021911599003|11063799006|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: vNQkeGC5QZoL2m2bxsgzZ/N3KcaSUd0qEtuF5KMtnvteeATKT6Tt0YLIyG+cpQqeOsL616sHkIPSNYt3wuiyqWafE9LXBWrk4ZXoYXmkHjgIqTKhqCsfnbDRmV9Vod8zeNfIF4tpYCoB/pDx7GnZgEaG4F+sMQvvVlbwcFJ7Im+6zO5ex9B2v2nFrVsQOkG/ZOnzJY6jHbDFSXtrFYHKqASp6p34nxpMdwKX0NEys+p3+Rq16kBXQi3ops8HQsXevIPiueCGMep9GtlsVTVrQFk3CzzPmH4pHfvhcJESyLgZ0yn3Fc9dnbeNsNPpz9k19ca4w2khjn2PSStBqw8mNNQ5kbPz2heYkjFFHrCxlyCo/SJGZ/9rl5xrdUdVi+0RqjnrGCNEO8Cd2yFv2PGhIMrlRW2crP8qNpqvxDNnFMVN5RewSBZcpzMOsF98S97kqURQin/izlUq1ty8nOc7z/zf4i7jTLz0eVovwMJIIWWr0L/QToodJNyJYTUbv39I5xWfkIL0sCN0kuftxAZGph/EKSO4fv968s7yGkAncU3bZuAA2VzAGN72Z2WL0sK14xqps8REqN8nmc4cGxR5kDtVxhPvnRAZe+4ei0PFaIk7tpb/5fIPktXpEgvDomJQ37XJAkXi64D8dNMNxQV/UwGU1yHbRgqB0vswLvOvP9Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(38070700021)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZycpueTBk6GrtT/zfj4H1q/vNoIzOKdDxLOF0yPi3p6GQePDif/YjZwWGTe9?=
 =?us-ascii?Q?nSGcLthdzMFzGJy/FYEvISSXrBfdfD/kBRHqi3rrpO31nxlOT6AKpedjktz6?=
 =?us-ascii?Q?+KM5kFe8mr8jU4b8NBZQCOgyxT9hQf8KS42WGP9qjwaJVtCZjN8F9dHrFjb1?=
 =?us-ascii?Q?wOo5Bg6Udj83/WUpi7zQPjpV46HNIn0NUU0cba3JWtkNbHWdpx7QMf055MUY?=
 =?us-ascii?Q?Qg8s9KlftekvBEM8LCawm1guW2gh8t5MgZZh0OuNZKNV1v/RegRYqN/jyTf0?=
 =?us-ascii?Q?8tYRZfiffo2oJuf0vyJFL1wMPs55iqjxTFQPE/mhzwG64BDAQ+FDmhDULEsJ?=
 =?us-ascii?Q?E+P9xKf6Y9vHO5by0Ab/W8J8mDLnICHjA6FZMoMmkeS7RTdI7Yvmcn068AMw?=
 =?us-ascii?Q?l9Qr4ddTT6xpvY+EewBZZPPJjbjOPOvbHqX7+TGpLQRrzUElgYUbmWih8mSw?=
 =?us-ascii?Q?bs2KiRwyUc6ZwvnAsSW1MjoljKcAzVZFU050KZDao1ut7fYybnyp04LSZHxk?=
 =?us-ascii?Q?TltwVr4LXKARQP8yJEnmLef725IKMZAGyY+gvMf8OIrJIaDlcDMO2NEYwXCj?=
 =?us-ascii?Q?nGlk9Ojpc67q4qI8D3ddtx6mZe8YhWwG1mPlo240Ooj4l6MwEIpvWhhr/BbV?=
 =?us-ascii?Q?3ZU5lElbZKy2hGF2VXmYTxxBJezTCXWKaIIcWWA+T6pBEFr1TU8tPmeWs4aS?=
 =?us-ascii?Q?RCT6rlqfkWMTB14bumx3X4ljGPtIFHkjoNyHAMYJfyRiilYbSOUcZmpwL62X?=
 =?us-ascii?Q?m2HSswqCCqwvBoUOIaK5xeX16rJcgw73f0o1aVCaz7VD3XC1IAJLnPXGkC2Z?=
 =?us-ascii?Q?1PBVTtxUszXz1cVbNQjZ7Uh80o7B1RXMcq0Qxut0qBTj/LVcC+Cu5OpTCTTU?=
 =?us-ascii?Q?qjMMlZuDAqbyW8VeaV1o7eazqIwFD0CDqpll5ECxNaCv1sZ8TtJf4Vim+2ga?=
 =?us-ascii?Q?Jnddmi8/Q2E9w08HJv+5A+IZlGVdSG+tizg4vHAf2EdfByuO/jagukzuADam?=
 =?us-ascii?Q?yvOSBt0cGWpuvcz8xNZ0msCJuePiHO9fOdOWr0+81WaNMNvJCsXJwLd0hfFA?=
 =?us-ascii?Q?f5WY142B8qXmd6ksoO9Yxkv/znf0xH0oziVohVIfKmaLh0xwPORd7tqG1jGb?=
 =?us-ascii?Q?8psGN5/O3ozhNQa2W4yY6Fxx8PU2mQb6TJDKjy0RykluNaO/Ng3qg6jxyrne?=
 =?us-ascii?Q?sSq70V83nHmkhxwASzoesMMU1tgw8LC5QQDDp25pGvhH/S/sg/o1Ju8qVrjc?=
 =?us-ascii?Q?RrxqEvtU3LBEqCZlowkdmYSuD3//uWTDgOswuIw1TCEmosSeQnfne0w0pnCN?=
 =?us-ascii?Q?CrDKOm+uQ0o02llhql7BMxPHAAEaNEfHY3QTtvpstpYy/EECH6Qs977SaANL?=
 =?us-ascii?Q?5G8j2Vg4mgcLgOgI2sN6pxbjVwdJGnlLnGUt3RiUUH9+3yC/uxLPz2tErGTE?=
 =?us-ascii?Q?uxEDsxjyqZIpqvWOYy35O925K3a7lESN/0UpmKqZ88BiUmA26atEgr/M0qfr?=
 =?us-ascii?Q?XxuCfzN9bLW0aPVMZ58+kKxMPC5xqwm5z4psnOysRj3W974tm/l20KdgJKoQ?=
 =?us-ascii?Q?G+PrmJZoUpR0A+3or70/iXhnuhXToS5kjlzv412AOW4Qu5vg7IyPeB3MVL71?=
 =?us-ascii?Q?2ISRL+gk+vX3IOfeynwb45zHLejOMsZpiwpqr5qnmyKx4b6ucZQ+NfXC6iiP?=
 =?us-ascii?Q?xSPvtGHCBtSeKRcuTHvKQ6TF3eA0DebcaC9LKFLA8UHg4ZYqCyHh9eBsv3G4?=
 =?us-ascii?Q?H8uVssnChQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: II9Iw6JRNfUM1mdw30U+k5yBFH+vtpHXOHMHW+8m5SsBnCIHCel66BiZbFrsStfnDsMok2u27vMbrw1p2tdq+HytpIsMlNhE1Ale5J6dtofEDR5jUDK+jIMz5bsZjfN8nKcGwN3Ejq4BR4D60mE9UTpYc5HLsTiZMSxIhadiNw23x1aB9LtjzvRL9kGVoeqEzR57R9OBvbiwEjI4cNpniDQmHPqygpmlMUcyy/erA8yylSafB5j+NZCEBwaLoORmJEkgI/SaWz3xo96/5m2AvVYub+cyWn1M3UHc1t41AcPV/lti614xN2YiwMhkmcpBywisV/JNuApnIMoUiaUpEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f76a46d-7ce2-41d5-b68c-08df281dbc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 05:00:29.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1a5cEDCqvXbU4OCisyLBJIs79MIhq05TZdAIO2CG2jB/UGD2ekWWx8HzTW5YkmTz44JNvoolfODUWa1Qt3HaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6463
X-OriginatorOrg: intel.com

> Subject: [PATCH v1] drm/i915/display: Allow port sync on PTL
>=20
> Some dual-SST tiled displays exhibit visual corruption on PTL, with one t=
ile's
> image vertically shifted or wrapped by a random amount that changes on
> every hotplug.
>=20
> PTL supports port sync, so allow it to be used to avoid these display iss=
ues.
>=20
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8991
> Fixes: 05cffc074938 ("drm/i915/display: Implement Wa_16024710867")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c
> b/drivers/gpu/drm/i915/display/intel_ddi.c
> index a46ab5d3d70f..a0aff087fafa 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4629,7 +4629,7 @@ intel_ddi_port_sync_transcoders(const struct
> intel_crtc_state *ref_crtc_state,
>  	 * From, xe3lpd onwards we have defeatured this with reference to
>  	 * Wa_16024710867
>  	 */
> -	if (!IS_DISPLAY_VER(display, 9, 20))
> +	if (!IS_DISPLAY_VER(display, 9, 30))

I am guessing you may need to update the above comment too.

Other than that
LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>


>  		return 0;
>=20
>  	if (!intel_crtc_has_type(ref_crtc_state, INTEL_OUTPUT_DP))
> --
> 2.48.1

