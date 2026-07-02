Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED3C2D7DCE;
	Thu,  2 Jul 2026 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971617; cv=fail; b=AojOWyvnKqRYVlTSyH41zIwgbAuQn3CnQC7S3sJmF1ibJr+kn2aLn259a//lrN8dwh/1+v7I3jd+aIzdbMJKXypllK5U1pjFWn4yIw68aFkPGiqrI7FOUrtZXKOD5D3m1Yct1n+/knV/+OpiwIOzFlfCFhwtMr7Sg8+QJ2F1Y0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971617; c=relaxed/simple;
	bh=cOdLS7qynVx5qbIAsngMbYIdi3IKvAPMm2l2g3d+PZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/hHEA/5NgFbusR0nGSv/QqhVNUa83Cu852zLccPugILz30xmvDTEdsl1rjPcjGP0nt9uyxwYA1Sc4dTWWbVUsRC1XcbIEJ6boOLo9h6cQbm7rNbLrPrW55WXDAqw2PyQB+lT1gYSNwcciVj5q7N5hMKflzybA/4Fo3elUZiBCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAQYsn6p; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAQYsn6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782971614; x=1814507614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOdLS7qynVx5qbIAsngMbYIdi3IKvAPMm2l2g3d+PZM=;
  b=kAQYsn6pitKaLgOrg4qZj/qarc8phs3fHrfE0VSrT1vFgVxHkuwtySnO
   yll9getBVtrUOlnX6Oi5acVrnyBljoL618xco57WmnZ3I83wpxCcyqVXg
   dkQJWA9Kj8GBVW9MTT4UF4Obnpq4VMg0JV2P4uIM7WCCatK5DqRvAaaVm
   NlGS5PEBu4R9NsSQXfoq8PtN83YWSJukD/q7tnh72gFH/WDlrEMGpduMz
   EO+LUPloA+w/N2COzBVHSGT5jeMt3eXVDcIlbdU8f37UgD0bqW+cteIVB
   B/ImKPFEXiYr5IzAncPhfaKNVU1JVshAf6O0c1GZoBsAEMYkYh3zS277p
   g==;
X-CSE-ConnectionGUID: aWxdgmlXRaOyHqFzXdnxng==
X-CSE-MsgGUID: l8hPUMnwREOQKvf9ByzfcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="82828457"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="82828457"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 22:53:33 -0700
X-CSE-ConnectionGUID: 2QgCP8GCTVGibH7oZ9AHwA==
X-CSE-MsgGUID: 7uo8NE7QSHe+X2BG6C9LHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="252328265"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 22:53:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 22:53:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 22:53:32 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 22:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVQ7RnDyPbX9w8uazOFLesiSUHO2wkGJKuTvhrOAf7Ept0sVHUa7K3eOeQBSwawSJ5sInIDlC958s6DeOEtj5PHfabWmP3j0jGVLj0obbtAEfqcBXQVTVPHUNJK0noSZaXe+WjrpxnGH0x13kykHer0zB6q932GOU78dIqGgatnH5He1DoeojCwCEI/1nPudIt3CvoIsiToDr0BXa0tPsbAu1DS9Z/ilnEVzNuZXXoeP03D7yT7EHbdqCFwuXStgAHtR8YnDCR7r43BDlqJV4Jx+B9Vb4kF4T8Y4+0iedyVNjQGrg2ZbSRZHTQC0Tj+CdCL83OLNfLUVCzXcvvzHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOdLS7qynVx5qbIAsngMbYIdi3IKvAPMm2l2g3d+PZM=;
 b=DPGH03hFkl8J6dxcWzdRRKMMjSeXkKGwM+Ayqs4+TIukIWX2CyMSggrRcjtequrNNunfZqnzNDSAtkVm64rJffxSdXsEb6UfePVsn3lUqOY43f6Iy/UP+5ki4ep1+XOfvCddZXnUqROb/1dW9G8m6AVPI0hjijpR5xiJ2Et72+wifS3OXRq3z5Ncjp3jargZ5NktAAYOi5pct2At6fYvh8v8C/Fl8FOvEXV6ULkMGM5mMWa9uS5ToSZ27Ayabof1Mc6uUNNG9QGduOZcbroZXhqshUhRTPBRN3U63g3IlBD4IHybHRt0SS/Fz+V8ATHGD1NqFGEtp8Awi3K+qTjyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 05:53:29 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 05:53:29 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Adin, Menachem" <menachem.adin@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [char-misc] mei: replace spinlock with mutex for kvfree
Thread-Topic: [char-misc] mei: replace spinlock with mutex for kvfree
Thread-Index: AQHdAYEpOHbmKWeBt0u6ZyXd/iq1LrZZytEQ
Date: Thu, 2 Jul 2026 05:53:29 +0000
Message-ID: <CY5PR11MB6366CD523C1E675A0A344E48EDF52@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20260621130007.1314562-1-alexander.usyskin@intel.com>
In-Reply-To: <20260621130007.1314562-1-alexander.usyskin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DM4PR11MB7205:EE_
x-ms-office365-filtering-correlation-id: 8fa06191-6420-4f2c-a517-08ded7fe3e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: jkDHvF1JX2NvwKpghKy7VZdviUjeeGtWvObnnOkE4Mb0vbkwHC3FsfoLw2mOHCs9eEhMAmo1X/i0Y3NHy/gzPXOo6AExZqV8cQEQuLAbR6LxMoyrRh9+LaXMYmYK7E8YXtRNtgdPyxyx4PT5FpQXJ8pPtZErFkLCIzBruiNQ2SSyFw+Nr881GzZj5XfuX/P4gOzPK803HXS6gE1pRgW/yDPcLWRCEPnuBPl3Q/3TwNxp0CCYHzGAbsb7a9cVNfCKMTB4FFcHvVwd4Gw495Ls6CWl9yqmw91Z29va58wESl+KGSksY7mIMp3Req+bj3p/els2OF8jPQ2ZlYtGWQZ+D0Wj8WT3Nt27mrVZLPxWJ6qEQSUOooM3T8NPcdQfS/kYcDMY8IGmpvMbVJ87lhpNQoK3Ik5IXc22obAYylMh2ZaGMBWKR22lvCY8QZ8EmzLg+D+1WlWALORbRlWpTRpD7RYqDvtcO9FrQHuQrDCXbdsQZ1amU8ARn5ZNz9L6bajH8vUNAPxltwDLCBJ6NnBUSYKSLTzf6TtUnkIVeCTPX4v83pCsfZhxnePick18NxWPsAe8fQwWVMKkndQloGKxPjOedOJCH4A8zMith5Hfp9SlsOpQc0pclH7Rsu6UejLH76k93M0RBHop0uxBimY5XRztE2iCWW2y073hsjX4SxSltHngTUBc56QyNQKPfnMDn6DfUl8KTIAsalaODl+m6X9fhk9x/B8R9+hpBnL7xMU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1VTQ2YrQ1NMUnZzNHU0QTcrTXp6VmJ0VVY0VEJRSjU1STYwSktuUm1HSzN4?=
 =?utf-8?B?Z1pVS1MxeFMwQ1FkbVpUSHR4OEpia0orREFiZDlwTWZMTjFEM1QwaUNxcE9U?=
 =?utf-8?B?ZFhkTWg0Um1sNnFDS24vK3JEN255ZmpzVys1UnQ5d3VmNUVTL1NWNEJqS3Er?=
 =?utf-8?B?TDIyMGhONzhsdWdwdmdWUnBuejBnYUxKejNYRTBRTUZ4VjYzTFpGUkViaEtZ?=
 =?utf-8?B?a0UvTlJlM0pjcUhTQ1pQSzRTYjdlYSttckhNZWloUUJzK1JXdGVaU3N4L3ha?=
 =?utf-8?B?ZGxldGY4WDBTRTU5SUJJN2pMREZPK2N3ZWxpN0pCcmI0a09laUVESkhKU3VN?=
 =?utf-8?B?N2I0cms1U1FuRTRoVTBEUVVBVC9TUmxEOGVkUldvai9GTGZRM25pdzdoQ2dB?=
 =?utf-8?B?dHFPcXl4QlN2Yi95TzNLY01XTGMxSTIzZnJYY0hyOWNRWVhOdTF4RjRxZHZS?=
 =?utf-8?B?MjlMVFZTeDFzSytyZWRhamZzWk9Mc1VhdU5RcElmSjR0aUFFM1NHd1NlZ0dn?=
 =?utf-8?B?ZEIzZ3RpUFVQWUkwemtjWVcwZHFYckVNc0xJdDJyQjV4LzZvRmNmVzZsYXdl?=
 =?utf-8?B?R3dQWkZhU2FPOWdZbWFuNlJNVjRRdXB3b1VpdmhEdm9UK1FKdy9ZcHNKNE9u?=
 =?utf-8?B?dVdFYUVrd2RwUENKalJVcHFjZGFjMTcvMzJlSTZGVURZL3hvUng2RGxmWjVH?=
 =?utf-8?B?enZCd0VXK2FQRi9rVWlTVDl4WWJVNXFFeVF2aGZ3djl2dy9yZXZxYm11MEd3?=
 =?utf-8?B?MjhocU1ObGZja0NybDJnNSt0bDVPRndVSFRSaUFDZ0cyTE9WRTRuS0M1WVFx?=
 =?utf-8?B?MzBuYlliQVJSUTh5dEU1QTNsN1kzZk5mOEdZc1VTUzBJZEZyc3g1MW5LQ1Fm?=
 =?utf-8?B?Y0RBK0k1T0FpcjZOcG54RTVOcVBod3VsVXdKTzQ1ZFgwRWdwbmcyd2FRWFpt?=
 =?utf-8?B?NjVHVEJTZXdPaVdTWlV3VlE4ejRiN3VsNXVOSGZURnVXNTF1MWlidEtYQTFN?=
 =?utf-8?B?T2NtY0p1Q0dKVTE1azZ5cWFvcTB3aWU2bU9DakdGbFBCemh0U3J5Q0F3elVE?=
 =?utf-8?B?NmpFTU0relVoOXRSYXFoc0pzSnZuVzdsejdrZjh0Nkd2bnkwRW10YzRSQnZK?=
 =?utf-8?B?L2RSbmpFcVd2MlFiQ3BsWjRTTUg3WWRpVXVFaDFHaStOUnN0WGFnTnBFRWZo?=
 =?utf-8?B?RS9kM21HaDNkQVB2V3lLa2ZQMXdldlhkVkVYYk16UERpdVB0ZVZSbzIreDFS?=
 =?utf-8?B?UFRoL1JUWW05cVVVSUZ5YStqcnpPdFk0ZlBFMldFOC8rT3RMVzgzS1l2Ym5P?=
 =?utf-8?B?REoyNHh4Y2svaHFseEx1cjE1dUFvL3M1aW5IaWJlMEh1SjFaOXRJRlZobDFF?=
 =?utf-8?B?cW9kbjZRSWZOeGN2MFhXamFiUWFrRStKZ0t0cEdNS0ZvNFZjelNqdDc3UFdv?=
 =?utf-8?B?Qk9QY3hmalNkT3BNTmdoUlY5eUFhaThGdFRmYUNaVXRtZzlEeVNkcld5V2J5?=
 =?utf-8?B?ZEQwZXJaRms4WTZ0ckdhbUdFa09Cb0RudWRFblpDYXcwVEd6cVpUelVtUVpN?=
 =?utf-8?B?QmxSUFM4MXFESTRaUHliSTdwRExUUjQ0QWJ2ZHg0ZDRwTENpM2EzcXNmcHFL?=
 =?utf-8?B?ZndCYWg3eDk5bDc1SU5jK0p3alRDdUpEQTlOZXJKNDRoc3ZqZXNoSWUxU0FD?=
 =?utf-8?B?ZDhIU0wrN0ZjcWFsc3Zoelc1QUVoZk5oSDJHS1AwOVExS2JYZnkyY0Zlc1I3?=
 =?utf-8?B?Uk5ObjcralhLWWpsS2ZvRTM3WEl2eVgwRGtzWTZGdmo1ZFAxdTB3Qnk4ejNk?=
 =?utf-8?B?dDBkbUptRHU5dGkxUG5oMW1FN0VQWjlMQmhnMVFDNWRmcWNJbXQyMks0N3VX?=
 =?utf-8?B?K3YzMVh2SHpRVjZMTTJrMDNqNlkyWmtRdGZjM2pDQmNxUmZwRDY5bHhPUENj?=
 =?utf-8?B?K01zT3BFMGJXRitlN0NVVU82NVZZLzVtbnpHU3MyYmpOZmI5YU1JV2NxaU5O?=
 =?utf-8?B?OGRQRUd1SytOeVFycHU3aW1KaDlYWDdhWFg5UWNxcGR6MGlZanhGWUY5dm9o?=
 =?utf-8?B?Mm84U2JYZDVjVjRTM3pVZjlPNDNUSzQ1cEpIMlpPSlhDdnk0MjZvOXdJZDNS?=
 =?utf-8?B?Z0F1VUR6NlNGLy85V3dlMU8vVTFvWlluZVdnVkJYYytITDlBUC83UXNyWnZB?=
 =?utf-8?B?eVdYaDFHV0ozc3FYN0s4NFFjVC9PSEdQNmEzWm1Pa1dCdDZsa1p6NmpYNTZx?=
 =?utf-8?B?SUtpMFZadkxmdW8wRklCZXZXeU04V1d4Z2Znd3dKdVROQnJLck4vcVZWejBz?=
 =?utf-8?B?Mk9zdFE1bWt2V0JkNU5KekR1ZWtDUDhkRzhKbktHalZaa29jVXVqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DLxrkVsrhGkg8Ss6T5lEaHaLvHl6/kOcvn16iMfsnIG/kS8bRdT9m2xjLQqQQJHqgJlF+/IpHEJth9qZg02dP2pRC46K+R/MnvQ9qJEy5W/7yQ7FX6LPlBkI+G07FTVelreIsAPwsnLSEdN3erkensQleFrdItag+bInK7pS/6MnisGOmpoaOuYgZGVA+Cj4Fh6VaQCmIVqsXrQV+DS9RPIp7UdJx0lJE7sEMjsCQlpVgBHKDi/qb7kP/MvPODc6inF12/azLR6XJWqD29wr6cWk7z1VMJnfsR/JeCpVLHkMz5lnrHv6PnKvh5yAkbFp+2n4K6Ant7TDEG0qzCj9YA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa06191-6420-4f2c-a517-08ded7fe3e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 05:53:29.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKsYX4OjUsSK+9SII/sSq4plkDumLRvf6R2FR5uYMxYkiy80QYx067N63Zw2eSkp3W9vPbzJams/keo0jXeLs4OwTJ8Ll7gJqssbmnvxeMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbY2hhci1taXNjXSBtZWk6IHJlcGxhY2Ugc3BpbmxvY2sgd2l0aCBtdXRleCBm
b3Iga3ZmcmVlDQo+IA0KPiBUaGUgcmVhZCBidWZmZXIgYWxsb2NhdGlvbiB0aGF0IHByb3RlY3Rl
ZCBieSBzcGlubG9jayB3YXMNCj4gY2hhbmdlZCBmcm9tIGttYWxsb2MoKSB0byBrdm1hbGxvYygp
Lg0KPiBUaGlzIGJ1ZmZlciBpcyBwYXJ0IG9mIHN0cnVjdHVyZSBwcm90ZWN0ZWQgYnkgc3Bpbmxv
Y2suDQo+IFRoYXQgbGVhZHMgdG8gZXJyb3JzIGxpa2UgYmVsb3cgd2hlbiBmcmVlaW5nIGJ1ZmZl
cg0KPiB0aGF0IGFsbG9jYXRlZCBub24tY29udGlndW91czoNCj4gDQo+IEJVRzogc2xlZXBpbmcg
ZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0IG1tL3ZtYWxsb2MuYzozNDQ4
DQo+IA0KPiBSZXBsYWNlIHNwaW5sb2NrIHdpdGggbXV0ZXggdG8gYWxsb3cgbm9uLWNvbnRpZ3Vv
dXMgZnJlZSB0aGF0IGNhbiB3YWl0Lg0KPiANCg0KR3JlZywgcGxlYXNlIGRvIG5vdCBtZXJnZSB0
aGlzLg0KVGhlcmUgaXMgYSBwcm9ibGVtIHdpdGggdGhpcyBhcHByb2FjaCwgbWF5IGxlYWQgdG8g
YnVnY2hlY2suDQpXaWxsIHByb3ZpZGUgYW5vdGhlciBwYXRjaCB0byBmaXggdGhpcy4NCg0KLSAt
IA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=
