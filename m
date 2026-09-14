Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4A26A0A7;
	Mon, 14 Sep 2026 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346482; cv=fail; b=k4R/gCr2pNRk+ZEf2fJDuYIRb3kERRe47uLJtTWbK6X/6kIjECYyZVENp1zvbbrucXRNDax5j8Yboq8Zvo8VSjhHM1UcwqnSmIuQ3w2od3YOSwVTQ4g+ubotLsLDEPc20iSQnahyIRiAIdjhkgD/dCMpNixcOw+HOAVaP4ZyP0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346482; c=relaxed/simple;
	bh=/OrFlBqrdT6PwKf9p4S30Plz3Vh4wBblht12WF8vFuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fU7MbEhA9t9x1slB8EkWKk0zAArg5RvrpJgT2oxJ38dGSQiaSmGnxC5rPsE9BlZgcznK2UIfZpxzhT9y1Q+nPdm/Z75xPjClrw5ZM6aW9qI5yRhvJTSsIT6EPoiuo+xssAe7qyQX8wZh83nC5ekDGy+CrmUIZBDinv7z4GdvoTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WokfFaaz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WokfFaaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789346481; x=1820882481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/OrFlBqrdT6PwKf9p4S30Plz3Vh4wBblht12WF8vFuo=;
  b=WokfFaazWcjGM/UfVQi1Er7G18LZfNX8hTJAabEe0LkxYcped8ts+DOD
   lSc0RHNeKFgqPPqf7LSG7hYP31ENTeQJKeQQkFjshSClfx4PTloqlcpwd
   xYkGRypYF37vjqFCPYgR+Hidf9bZqmxwdxYZ99J/kv1WfhZ1dfq7VWydm
   Or1dIp5F12Ni0rLs4xL47rxieY4bqrUNOXuRQCEMGpanbErjFDG/MT9J1
   irvtpXXI1TR0gYx8ikEbelhoJVCTjt/gukVmPxIwh6Yk4Qo4VS2AWlBmu
   6HnwQfVoqTJ0rOGL3IxBC4XVy22gppFNjUsPlxB0QQ+p7VPfckDXSosbw
   g==;
X-CSE-ConnectionGUID: 7eVEueXbTLiUnpTll5JedQ==
X-CSE-MsgGUID: DJLoMcARQnqpCV3M980q7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88645488"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="88645488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 17:41:20 -0700
X-CSE-ConnectionGUID: kdchkdhKRdyPGUo4dfwKNg==
X-CSE-MsgGUID: LFRLEH8ASnKNF1N0uyjwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="269862455"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 17:41:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 17:41:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 13 Sep 2026 17:41:19 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 17:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1qp5DEE9k5ZLg8w2GFzkhbt2I5Bo9otW3Za/Nfc1pGX2FPzznj8zLlkrx2w3onuXncZoWA9lsew9PjN/ZFVozXXBYfKtJjmQaXtCJcpQth/mMnFarB28bnJ0FP+NbHs7JeBtH2bO1OQNGc4kccz1Wm5sVRae4bRm5ArhweHQufk9hBcrikUNhkSjS288qHbrxWt/WiMZVDNWAOim0stNuEnK5lWBK8bBlOUTxCSCWNE7jjViga+NWc+wxN8FtIh2fzlGu6SklWqtvmFwP0Vq+9MqMfyns6EqdCd9a1BSt1RpLNJ6VGIM4+L4MURsMdB/v3ApDbWg7iR12q7QOk9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P68euCaUySmHRVL+8iyITAmgO52RAnu9wiuM6a938Us=;
 b=iXRNf0ykgiGlERW9Fh6AUIHgMelLnpVIhq4je7Nxyg/Az4fRE//HG78oxzsqJI3vknYVSOKNjd6A6NLtUDgzICVBqiPERURdOMLBEG/FQyUaDnZXqkqtXoAvIvzwNo93rAKec+5A3W5Fgcc377q9EGb4O+9J1x1mMv7nsm9RhjlKqtbzHP2nedFtdubF7s709da2EsGeudeC/itoKrUxU1L7g4cUsojxClrUVWuhcEyhDlLh5qtoPw22swAOYuNPk7MCaEZLkdmj1B3efghmpuf7oMTHWnGgjnPfmwwM2E5/QNL0FSth3eEVe6Cg1fC5MuhVNEJXVDiViGr8a3VOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 00:41:16 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 00:41:16 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Jiri Kosina <jikos@kernel.org>, HyeongJun An <sammiee5311@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Benjamin Tissoires
	<bentiss@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 0/2] HID: intel-thc-hid: intel-quickspi: two DMA buffer
 overflows
Thread-Topic: [PATCH 0/2] HID: intel-thc-hid: intel-quickspi: two DMA buffer
 overflows
Thread-Index: AQHdMJVZZCoWysqO7026rpLYvXmXjLbJrokAgAOzpGA=
Date: Mon, 14 Sep 2026 00:41:16 +0000
Message-ID: <SJ0PR11MB77046AB5B386A2AC2DCA98DFF4BB2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <43o49041-0nr0-2298-s10r-032r566s3ps7@xreary.bet>
In-Reply-To: <43o49041-0nr0-2298-s10r-032r566s3ps7@xreary.bet>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|SJ0PR11MB4848:EE_
x-ms-office365-filtering-correlation-id: a1f14ef4-7386-4e52-30a7-08df11f8e2c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: 7Gd6R/P7v+z+Q8ixBkyaPIKyQathnEYwyxTTlZyl+y4v/ZiVFmpbFqH3zc44h5JfITV3dqlvtvJoLhJbCs2ZNA/BFoHimniREAounQuqTOgVgtwmA06Wx8Gb5CrxiYANyx0pgMdygjcogxmBDJnJnDQAVdhzX93UwfqWSFGv4rRZB6VtymjPVdJ2BbzHgdj13X4mn2p2JeeUWSrsBW40KFiWgwyKfbOckP2z/55pHlVqkUzSZiW/GJTRCYxNEcgcZX3IAubMhX5j+oSDHgfVaWt+F4PjjRFejqlB4D3H/eN0eUeMY2raWgey4vYpJ6DslntUbj9SgPOQ7Es6f+3e0CjddLnl2H2/yTEIYbrjgyNKwPOeC/ovVjL2ym4+BzKgovsIwMWfJ6HH3zEAr4yYSdslqGh+K/U8GyQ4haxyNWA/vCqUAa4/vMYkHfrq4GYXh+o1wYd56mgd9vlsAGrA1jrguAF1oWZKo9RxIbE8zVYoy0a6oDly0OBNMSXLAzbR2T0xF0qj+UVdF7S4jdXnPMbFjlRPq0zmpLyHBK5WNkixG/RNFHkhYZDP2PcS9FDqQbLHN/kCY3CbC18b6DB8zBcT0wdrIiOudFXY7geNflHKVThu5A8FyDshCKy94JDkIk2CLUMEhd2Navd1LyWKDce4Hzhelnfaqa7xFGt7mPF9jvt2aASDfS2ZXrEcYqothsJq5XRTyAKkUFsFs5Lk41rRUnyozRunNBVahO8Iqsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P4bY/hD0HIkPx+9JR7PxvJUKmQveYtimtoSBWtHCBUAy99T2Kq6irZra3oD1?=
 =?us-ascii?Q?fFs1eh/U5nT6ZtDCgcGkBjG7/owcIKf2BcZfMXrUEc/UNWXZIIKDCPLcWTZz?=
 =?us-ascii?Q?hYZMN8Y+iae3W7AngeVMfjuATJ4mEsW81AP21leo4jOHvDSSgKMndxHqwmFz?=
 =?us-ascii?Q?bRNBCKKA2LQHiRri0e0uqf2V0TlB/AV40u5McsOGBCLo2WzmjQ3DiPvky9KU?=
 =?us-ascii?Q?9RP6g4dxNChJXBx17E0Xn5GmqSA0wSHTxj6DDbyUizVGmyjKkn1El9CJNN78?=
 =?us-ascii?Q?iPIsb9lstGDBoOR/2aNyVYINJRfhBvr3US3B2rM9RoQe6lYAjCE0A7xxb5to?=
 =?us-ascii?Q?gTQ+GmyAerZ/53oUs/Ahn/JrMiYe4SH4NRpnhhEzHyKMgdBBUHv3kiZ2G2+C?=
 =?us-ascii?Q?7VuyfVatuRmkN4eVr9ZSDk3PT/kFFnb5lqv6xdEGJk+9rQsL4mL9UcbOXYTF?=
 =?us-ascii?Q?MoxWaQJip9X1wk5bNGmRsRqNptAD+y687rC8YsPW/XCBNiJrEi5zOKinORkP?=
 =?us-ascii?Q?gFMmdPWz1XMRoQnVAigCPKqcRptUzPBylAKz9TejOShUsLjmf8tnZIzrFxlq?=
 =?us-ascii?Q?PXYFAQwXPjaBlT1+5YnPqnkO3bpSq2/DQ1y7SLYipqQSSfqcKgnWaDA6tGhf?=
 =?us-ascii?Q?gc8Uj+Ceu0vidEcqKerk3LYbQPptSD0RKr1Q9P2cNZjGxEYR4SRaLyKJVvaW?=
 =?us-ascii?Q?DUNb1IuUSl+3bTrIl/opdIDFD9fyltktqL9bPAPz2dX+HN1wg1RSIcXLWW13?=
 =?us-ascii?Q?Gsoky6H9C7n/oJRR1C1ExdYK73iNnOhKiR0q9beetVr9g061vurpWhXURBfC?=
 =?us-ascii?Q?4CgtaF4vXa7B9UcfGHdABSF3vf4pDU0DtMxXGgrVxqeHdkfkDSvRMiyTk2t9?=
 =?us-ascii?Q?JQMPxM84wXoAmV8FW0VOeXcPFvNE5MVMojTsJUhV1s1n6kbUgj/okmmZFpOU?=
 =?us-ascii?Q?jrUS5L+Hf7lp8BncCURvWjVClaSW2o9cWlrSrkFK77xFzCNTcvUd9bmXsN92?=
 =?us-ascii?Q?qVwnY6x+4j+1IU/uJzz9gAa4x5WaPvUx5feCRClFYVtvCTovjugTZYt7yR8O?=
 =?us-ascii?Q?GKw0chCeSiOnnL1l3/lwp0VPL4b+j/jqWgGVvAu8U3Nnc8ahMj85QMspRaSG?=
 =?us-ascii?Q?/dFEz2gt2BkcGcwLzup/pZwZJFZKakO+JCl3xwrMTwZYGslMtJhXhP7k033N?=
 =?us-ascii?Q?cyEzUDEy+aWGAOQC82IsE9HossFupZGj0gNxX2UlXizBWyJ4Hf9QL98z4CY3?=
 =?us-ascii?Q?CuWeb7YWxwVDRFZHEseICGgXYR06gy47f7jyMwVKSGZk+ifIDNTSscM/c6uO?=
 =?us-ascii?Q?B51iWm5mQcLAFQTOuKJqyXxnpm756llzhRnQNfSgEUFnmM3i9HHkYuGHd6S6?=
 =?us-ascii?Q?EHkskciZpud6n1PS4r1U6KyTtCrLG+iDvlwHMX8p5s5N02Ks0JH69icMZaPr?=
 =?us-ascii?Q?MGyOaigmNw09BAhOCdeZrXyYIQj5yaUyn5ICdWh+iOTxQfzdqHHJmF3u0NHL?=
 =?us-ascii?Q?jKju99uV25WisXhqJCvbuMXOvDwqEObrG6v96pu+PklEPqBpRq3iyynzsTmq?=
 =?us-ascii?Q?l43aTrmWmnPDIMpxtXIOHcn9Cws77oQq4NAQk9MZT3JHUAioIlucGdfEB5Xs?=
 =?us-ascii?Q?yXK/R7gh1w4wlBKY9HupfaSWTEELAG175HBhGyCJBHBKuSooaavLL3s3G2W1?=
 =?us-ascii?Q?VQngvHWxkF5qmncsQp9T5+4mTHKve1nD2cZZ0fiHgkGI3bCl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V40UC4O6CW04y+ioH1QCigOsgRtRXkgUD8QEGhpZ84ibDLI/uSC0uU8sjIBJhLRJcBLJ78IDjm27nLwhuSfk8sTKvEW46wmqKiE2nFfZvGAgaAj+ozGQ/vrLh1Gdb8FX9cwopCOon+vr+9JVd6+1gW55hQxDxqlKtiSzDPpf487YkmWXpwLfMnGcurg6LwVsEYhJI67/D9J3/5qk8a99HEo2LzeLdpE7OvoCn1mVNX26H8vX7r5QPEH6JuBgpStq5zjvsbz4jP6eNPbpUKf77ZdpQwyFc8NZpmhFaRs8JNMXL9mXF9zXtY+b2l3ojS7yVDEGE0TXn53S6gvdWqF03A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f14ef4-7386-4e52-30a7-08df11f8e2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 00:41:16.3113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfue98l36NKFxXQHkeI0FTP2Ua8Cg4ZtzA1tKYdlsBlgYN+E+R4EoZbvr1P6fHM2FlDXusLko1Jh7hEtB1rLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com

Sure, sorry for missing these.

Best Regards,
Even Xu

> -----Original Message-----
> From: Jiri Kosina <jikos@kernel.org>
> Sent: Saturday, September 12, 2026 12:09 AM
> To: HyeongJun An <sammiee5311@gmail.com>
> Cc: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> Benjamin Tissoires <bentiss@kernel.org>; linux-input@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 0/2] HID: intel-thc-hid: intel-quickspi: two DMA buff=
er
> overflows
>=20
> On Thu, 20 Aug 2026, HyeongJun An wrote:
>=20
> > Two heap overflows on the QuickSPI receive path, both from a
> > controller that declares one length and sends another.
> >
> > The first is the DMA landing buffer, sized from the device descriptor
> > while the THC DMA rounds its packet size up to 4K.  The second is the
> > GET REPORT response, whose length is checked against what the DMA
> > delivered and never against report_buf.  Each has a sibling in-tree
> > that already gets it right, named in the patch.
> >
> > Neither was reproduced on hardware.  Both turned up while working on
> > commit 035ec4a71cb8 ("HID: intel-thc-hid: intel-quickspi: bound
> > GET_REPORT response to the caller buffer"), which covers neither.
> >
> > A fuller fix for the first would give thc_rxdma_read() a capacity
> > argument, but that changes a shared API and touches intel-quicki2c, so
> > this keeps to the driver.
> >
> > HyeongJun An (2):
> >   HID: intel-thc-hid: intel-quickspi: size the input buffer for the DMA
> >   HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to
> >     report_buf
>=20
> Even Xu, can you please review this? Thanks,
>=20
> --
> Jiri Kosina
> SUSE Labs

