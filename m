Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793971348;
	b=ezpanU1vvWJl+ShrA/B4cYyF0+e40T1Q3bVAa4AQopLTF7pDJ6ySuz6mtMGuSQq+RotE
	 CjiaJ3ntAbqxjWgDW6wHCS+pvU1bN6GVaD+KZ4H95f+AqRv83oTrgxbfYFy1yKW+1fAuv
	 svklRMJcCbyK0KhNEnEO8YroUsoL6FK0m2GQBwWiCvYqDg6PpsfSKKpAuFe7Np/QwFu/d
	 RbAUTQlF0GT38JNnaNx7TV6PKWqmBUhQ3cFJ7GvAi1Th1QCjyF6ULP61PGGaju1bmTGhL
	 nsCStj/cSmgf8coWVWErws65y2mWa13qH9BNiPZU3A9ZgxLBZIeGjP+wBHa1zox6fpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971348;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=lFH+wtluprtiQJiwar+6y7l9IsNXDrMLDYWLswYcrbA=;
	b=4FqncaxqYTfUHTqJQ3ndS0dCSPj8yHieCBs1ZZim++63DBO8S18+JpQd0fHztG3AjZMu
	 tAXQE1D17Z/S9ap7c694zSkQK2Qq5QJGvabnDy1Q5xfaap+uDljNSr3JEPzAajOr29Hcq
	 cgt8PmcsNR0kHj7/3gafUC3jVetcsmyez901oxjI+bgL2a9QnKicfegIIXmU2oSDrBUfr
	 qGIruSVpRxM+TUmceNVamWzHJjPcCsw8rUmomCWh8CDOKPt4GT4l6WCJGEcQYZOO8erL0
	 WmBgPGpmoWLBS2/ZvXv7ke0h2bjGf+DBxKpUVVdHW160ISwlNnLQ+nOqcQlNwX880Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lOK9MHCJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AC606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lOK9MHCJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793971348; x=1825507348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lFH+wtluprtiQJiwar+6y7l9IsNXDrMLDYWLswYcrbA=;
  b=lOK9MHCJUAydpV9poEkD3pTablFjjvLKVYaGmSvIY0vdctJa2s4K8HD8
   /BpD5XaFW+bm7VsvQdSeu7YbiY8Zj+8ZVr0HaEyhLLpL3rlKdi/bWk7/T
   TTUDaYgLN/vS3s7ro12Phoh1mIKV9N4/bKAzZNJ7Ik+oEP7zmEISFF54y
   O/e5A2x3vpRiv8PSdtd1Mpa1bBXPRFtwZ1lyxXK+py3rniS2f8EvkWv7k
   hntp/sc0zHMzSqh5tVHDUp9uCOyfl425K4aUblh73rolWDZG4iVXWNliW
   OakgdLNT+TPf2WNR3+sLsJnyTy+/tmyU2ILTwK6c3CWWy/QCx3jF8l6MZ
   A==;
X-CSE-ConnectionGUID: TvXiiHnIS+OKoZIrFmYNeA==
X-CSE-MsgGUID: YWJce335SgGdgyYj5YdF3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2823676"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2823676"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:22:27 -0800
X-CSE-ConnectionGUID: Jw3ZX34ESO+S2SiJ7pSOlA==
X-CSE-MsgGUID: fEHoii22TAmO2yTiVZrXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7177696"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:22:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:22:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 05:22:26 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:22:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPFvnI7TWCrzZS38PabdrkPc3rlqKmJM7/+I57T0Gk3byoVn1EblQAh8mPMLWRE5vJnQVgQRnVOqoXc6l75WZ60N8Ilonm4WOxsox4mG28n7Z6uJeP6RCcUPcASpdS+rcnXoZOu0AQHougOCJ7UVDMGHjDePOwZIdnFpiM8JV4zCnho1n4jAXFpRO/DMS37fSyXej8RG7WVFCR4LlAqU5nkcbQ6jG9BfuxHwo/ByD0OWoGqUA5a1nf58XpjditOww/kls2dD4ZCc1QuTcwD7l0R1hHHI6GzkKKflagcfZXzvi1gPRjgsxMExrLOTorN5m+GCCWhN9dDsd4Y2Dm7JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFH+wtluprtiQJiwar+6y7l9IsNXDrMLDYWLswYcrbA=;
 b=wHkgCMqKkMXSN6irATXRXOFEuTfI/yW6w+Mo9Fr1hxX2OLovekHxtgrJN0m5822o7PH6RyOPMZ4Vay+dBpKrmnKmPjVFv8V/dnWfzRA3iyReQhV+o/XaESQqtFbCBopjG2wNrCA4Q47uAh2e9u/sTNqPvRp9VbM/MhIrz6PNQ/ErzIQlNoeX7q9H4DV500463HiattQboPMPycrEEJGngWXMZg3bfUsjHJyJzyZeX/72fGmp0mllBPNi6q78wsVku+RsIttLlktPyrcb23h19Spwt1DDciLtftADkkui8C4LvaWh6xaCpAJLcPmG0cdPmndRCQnkWyg5mix4Il2aFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by MW4PR11MB6837.namprd11.prod.outlook.com
 (2603:10b6:303:221::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 13:22:18 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 13:22:18 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] drm/i915/psr: Clear CFF state on flip flush
Thread-Topic: [PATCH v2 3/4] drm/i915/psr: Clear CFF state on flip flush
Thread-Index: AQHdarErJ8KDg1L12kmWOghiuldMzrchDjoA
Date: Fri, 6 Nov 2026 13:22:18 +0000
Message-ID: <DS4PPF69154114FE44F8BD652A9D2E8767EEF762@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261102100051.272137-1-jouni.hogander@intel.com>
 <20261102100051.272137-4-jouni.hogander@intel.com>
In-Reply-To: <20261102100051.272137-4-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|MW4PR11MB6837:EE_
x-ms-office365-filtering-correlation-id: 84b08318-8a95-4414-49d6-08df3c08fb28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|10070799003|1800799024|22082099003|18002099003|6133799003|10067099003|38070700021|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003|260925022911599003|260925021911599003|260925021311599003;
x-microsoft-antispam-message-info: 4VdgLkHsiNlXgdFB7m44YxnHeDbnDfG4bjExkjQrjPiNGKptAsg/fzLHaGwmowJ6DQAoOGknL4E2nTd/oIc908aPCIj9IDEhxgi6/P8D1RrG2R/gYZAxr2ly2eKigC7EFbrNCD3XgcB4uRwW7sKI55n1RwcJvp24TQEt+IaGFhukV+q7PtAR6lvRMRuVxpx0iHWKf6UwHlm5HP+jT/acv1dQwIZWr35w/4jbl0ftJknuLG8GDJsKb3n/IM/qWCWIykeqiGqV506FANbaPqKGdH4FBDdcU6QloOOBktQTY9G6zzrgd0wBDobMAu1E5wUftTgQiPo4axSWTWX4ScjtEA5Y7JABI06XhAVHSwT8m4IFwd5Tbqj1OeFyaw9hr7pXOCijFiz5a9mXun5KeXBNH57fsM+REX+KKaguDok0veUhOWxA7xkRLF9ncg0QBsKcDw9OEsSqDQmEfd0B8HXIqo9qBddHm2bpg5IMGJBZSlI9tMz7PpWH7ONFnJtXIPxDzKXqDlQjc+BuYSIEwoZttanIuDIiAz/GFkeh6hEaUVSusssH2hXfpYpmCHu+y9HhDNQIlnfV8uWFSCX5eRFlalYn/UZ1ujipy1PLlePvf99XOAYPRxioKSjZj3BYucxGPqv2NQ1ueQcxRg6spY/vtr8tWRXff19ZM/sxt38N2q5DSZNihaNVnoIM92cki/1+CPkCRhIYb10nL0r0mmz8UCK9Szy+VFJsPPbR0532QFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(38070700021)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1BnTXloRW01M2dERExPT2taclVGL3VZQnp6YkZHalBFVndRcDdZTXJjWVMv?=
 =?utf-8?B?NksyY2dubFdpczdCNG4vOGIzdGdHS3FNcjNqWkpvT1lvTVNtMGtVMVRQTDl5?=
 =?utf-8?B?THRORU1uTjRPNU5YcW13dyt2Mi9iYTdtRW5QOVQwaWo3b0Y0WHh3UDAzQUY5?=
 =?utf-8?B?dlhQZW1NZjYyOVUrL3FQOE9pU0VZRE9NWXpGNXZJRmhpQlJ1RW1ab2sraTEv?=
 =?utf-8?B?czQrcDQ0WXZXM20rVEdlYVJCOWlEczBNYlJkNGt0amVQNkJmT1hFb29FUVhW?=
 =?utf-8?B?eThSV25OUkZZSHB3NDZLY1UrOEg4eFRFczZsMldURmhOcGVQSmlmSFN0S2RJ?=
 =?utf-8?B?VFlxMUtEbUhjZzJXYjdxa2Nsc3hhVUU2Nm5ZYkxKeWR2Snd2MVZrZnk2RXZT?=
 =?utf-8?B?Zzc3ZUd0RVhXQVFJRFNENW1hN0llbisxYWRPTWxveWxYc21wcVQ3WmR5UUZZ?=
 =?utf-8?B?TGUzNjhHdk5lbHVacUJQS3BDdkFiY2ZxOUw5Zjk2Rm0zZEExU0V0aHNtZjJG?=
 =?utf-8?B?Nkp6aG55WGh6SlFKUVJ5bEVSamRQS3RoNHd3eGpWYmJDbWY0UDBTWTdRcFJo?=
 =?utf-8?B?aW8yOFEyL1FQUVpZOXEzcllpRWpoNmlRelYyZW8vNk9HSC9NNEpteU1HN0xM?=
 =?utf-8?B?KzhkRVZpUTdkNDZlVDRKMjQwa21OYVA2VVZjUEpmYnV3a1prZFZhKzRDb1hB?=
 =?utf-8?B?RFZCN1kzUjhxN3ZLZ2pvamdyYk9uK2I2cTA2Y1JubHprVzRFaDUyQk9JNmRD?=
 =?utf-8?B?dkIxVmlmczc4cGxJVUlxNFYxc2NFc0RnbkRlZE1sQUVvVTZZcnhPS0tpWUk4?=
 =?utf-8?B?Tnh2LzJLcjExNXRpc0ZxZGszNmtjUTdjcTlQT2didHg1clJrNDNONlI0bFBn?=
 =?utf-8?B?Wm9BWVpQanlkSlRqblBra0x3VTBvRnZCTFY0SW5NNlR0ODI5enNQTmpxRVBh?=
 =?utf-8?B?YXdwS2lVWVFGc25odTRzSFRKbTBiaTlOcW9PcjdZY1NpQlowY3k5Zi9NQXlY?=
 =?utf-8?B?dTdCeFZkOEdwRzUybWMrSEN2OXlWNkZsUmpydVhVME1XYXJBZCtWcXFydjRM?=
 =?utf-8?B?dEkxK3JJMW5aNUVpSHczQzUwODliV1hnSFZKb1ROczVuQ1dNdDdrRmJPZTF0?=
 =?utf-8?B?eDZMTm9qbTdyalZQYkJyMFQyOE0zQThON1laWHN2QmJkdzhEZ1ZhcFVKTExL?=
 =?utf-8?B?RWFBWnYwSGx1QjY1citzZWNSc0xNWmpDNW5wWEdCdEMrM0JsRGxrbWZpVkFT?=
 =?utf-8?B?RnIwMElCa1J1ajJZSzVDdGJzL2NkV3dSTzV5NWpQRHpSRlZUK2FtbVZEWER5?=
 =?utf-8?B?REdkeXZhVE9wQ3NmTHBpZHg3NlIwMjNzN05sdnZFR0Vxa1dsWkJVYnE3MjNU?=
 =?utf-8?B?OEJVdDc0U2pjamphMVhGa0d3ejJrd1NHV3d3QitpM0FOM1R4MFhIUU9kZjI0?=
 =?utf-8?B?Q0VjRzU2K2ZWWDh0UjRwMm1OUUhGSzVhQjFUV2FMSkEzV2g4SGZQb1JhaHUx?=
 =?utf-8?B?V2xmNkx1SVdhR1ZQVDRLNG5YeEZBNWNxY0tBMkIxZDVVdm15UVloTGV4a29W?=
 =?utf-8?B?NHdVYnU0ZloyUUVFNjVURlFYUzkxanFtYzYvVmIxZ3VxNFlhWWpWcTRweVlW?=
 =?utf-8?B?eG5ITVV4UWFtUWhSNlFGWW5WNlNHYVpOOWJ6Qmd5Y2FNcndzOHp3QWFqOVJw?=
 =?utf-8?B?VnR5RkhtNFZISE9OMGM5RXFFeW1adi8wdHNLZTJDUFJRZGpBUU9JQTYwbEli?=
 =?utf-8?B?eS9HOE1hNSt6SzdFUHkvMzdLckJKNDVIekFDVGRPSEhGQjgrZ3hEcXNWME9G?=
 =?utf-8?B?ZUZGL3VhNGNpcDh4cloxZllQS25MOFUyNG9rVDJsdGdQTlB2Zm5QbnU3NGNo?=
 =?utf-8?B?dS8wSzBwWWo5czVQQlRZVUtKcG56Rm5sWWJTL3BzeGZGWmNpcXlVVjJBcDFB?=
 =?utf-8?B?bVFiaXVZVFYvQlY4OTZRZzRRVi9mb2k0QTFMY1pRcVNLQmJPRUhzUVYrOXBD?=
 =?utf-8?B?OFJYY1ZXNllNMVViWEhiL0JTZ3Q5cFBSVjF1eDRMZTJyOWhoR1VVYW0ra0JG?=
 =?utf-8?B?UkcwWFdES1RxZGxodnJWc0hNYllpdGtmQlZrOTlwMTZOQnhZbnBnUjZIN05G?=
 =?utf-8?B?NGxCZkdjeFlWYVc4NlFFSWRUN0k2WVZ6UGRtNFQ0SlpMbHQ3cDBIZzlvaHpI?=
 =?utf-8?B?MENjaVBkN092RGdrM1V3VW4yYStRWlB1dnN2S3FPWGFGb3RqQXFDMFUzZDBK?=
 =?utf-8?B?YjA0bVIxZm1NeUYrRmx5Vk9tekQ0Z1NEcG5PckZzRDUzbjlySFhBYkxHZXNS?=
 =?utf-8?B?YXYvZHlzc2JUSDVVZUF0VldJelN5engzZE5kV0VHbkx4WnNMWFIzckhDcWxO?=
 =?utf-8?Q?Bcn1BWQiXkp8p8HblpQ2NVQZVxjGRB+y3onkH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mx4EjMXdlCQd6UU5akFRHRj5O/KDop81GBY/2gED8NH1GW1sMyN4MyiWaBVF9hNNrrkJuxxUZl5iSA3ivUGuNl0KRzpjmsuzzpVtTNIk5gpIAg3ouO2YbaKBMQsdwf7Td7RzIY1vMasumt3G24ij6V73ldiJOFPzXqexwsH1Vyr4lWSjoWRyExU3UU6uIJ6VnLnCnIQ5i6dP8xpaJhj5QXEe0JP3HYToqSAK8OGxQAUHEt+xfthnoWQJURfQHL+ExD9lUMcKrmlsi+thoKZ1ah+yV8ga7kJc8O+x3NBcsw4zpOgDP/etjDHVc9vYau6+CnTzS2pxy9sEmWpGRmFIMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b08318-8a95-4414-49d6-08df3c08fb28
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 13:22:18.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fT/aTdmQWtyVZ2MK35E/W64tgIaWV/It0wQeJsxGuvZ2iaD9eXTIN+7lUQFusM/rIWZdoi9I3MtW8j4/mIE40Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC1nZnggPGludGVsLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEpvdW5pIEjDtmdh
bmRlcg0KPiBTZW50OiBNb25kYXksIDIgTm92ZW1iZXIgMjAyNiAxMi4wMQ0KPiBUbzogaW50ZWwt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBIb2dhbmRlciwgSm91bmkgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT47IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyIDMvNF0gZHJtL2k5MTUvcHNy
OiBDbGVhciBDRkYgc3RhdGUgb24gZmxpcCBmbHVzaA0KPiANCj4gQW4gT1JJR0lOX0ZMSVAgZmx1
c2ggY2FuIGNsZWFyIHRoZSBsYXN0IGJ1c3kgZnJvbnRidWZmZXIgYml0cyB3aXRob3V0DQo+IHJ1
bm5pbmcgX3Bzcl9mbHVzaF9oYW5kbGUoKSwgbGVhdmluZyB0aGUgQ0ZGIHN0YXRlIGZsYWcgc2V0
Lg0KPiANCj4gQ2xlYXIgQ0ZGIHN0YXRlIHdoZW4gbm8gZnJvbnRidWZmZXIgYml0cyByZW1haW4g
YnVzeSwgYW5kIHF1ZXVlIFBTUg0KPiB3b3JrIG9ubHkgd2hlbiBpbmFjdGl2ZSBhbmQgbm90IHBh
dXNlZC4NCj4gDQo+IEZpeGVzOiA4MDVmMDRkNDJhNmIgKCJkcm0vaTkxNS9kaXNwbGF5L3Bzcjog
VXNlIGNvbnRpbnVvcyBmdWxsIGZyYW1lIHRvIGhhbmRsZSBmcm9udGJ1ZmZlciBpbnZhbGlkYXRp
b25zIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY1LjE5Kw0KDQpSZXZpZXdl
ZC1ieTogTWlrYSBLYWhvbGEgPG1pa2Eua2Fob2xhQGludGVsLmNvbT4NCg0KPiBTaWduZWQtb2Zm
LWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jIHwgMjkgKysrKysrKysr
KysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9wc3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNy
LmMNCj4gaW5kZXggYmUxZWRkOTA5OWZiMy4uYmQxNjU2MzYwMzI0OSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bzci5jDQo+IEBAIC0zNzk4LDEyICszNzk4LDYg
QEAgc3RhdGljIHZvaWQgX3Bzcl9mbHVzaF9oYW5kbGUoc3RydWN0IGludGVsX2RwICppbnRlbF9k
cCkNCj4gIAkJaW50ZWxfcHNyX2V4aXQoaW50ZWxfZHApOw0KPiAgCX0gZWxzZSBpZiAoaW50ZWxf
ZHAtPnBzci5wc3IyX3NlbF9mZXRjaF9lbmFibGVkKSB7DQo+ICAJCS8qIFNlbGVjdGl2ZSBmZXRj
aCBwcmlvciBMTkwgKi8NCj4gLQkJaWYgKGludGVsX2RwLT5wc3IucHNyMl9zZWxfZmV0Y2hfY2Zm
X2VuYWJsZWQpIHsNCj4gLQkJCS8qIGNhbiB3ZSB0dXJuIENGRiBvZmY/ICovDQo+IC0JCQlpZiAo
aW50ZWxfZHAtPnBzci5idXN5X2Zyb250YnVmZmVyX2JpdHMgPT0gMCkNCj4gLQkJCQlpbnRlbF9k
cC0+cHNyLnBzcjJfc2VsX2ZldGNoX2NmZl9lbmFibGVkID0gZmFsc2U7DQo+IC0JCX0NCj4gLQ0K
PiAgCQkvKg0KPiAgCQkgKiBTdGlsbCBrZWVwIGNmZiBiaXQgZW5hYmxlZCBhcyB3ZSBkb24ndCBo
YXZlIHByb3BlciBTVQ0KPiAgCQkgKiBjb25maWd1cmF0aW9uIGluIGNhc2UgdXBkYXRlIGlzIHNl
bnQgZm9yIGFueSByZWFzb24gYWZ0ZXINCj4gQEAgLTM4NTksMTMgKzM4NTMsOCBAQCB2b2lkIGlu
dGVsX3Bzcl9mbHVzaChzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSwNCj4gDQo+ICAJCWlu
dGVsX2RwLT5wc3IuYnVzeV9mcm9udGJ1ZmZlcl9iaXRzICY9IH5waXBlX2Zyb250YnVmZmVyX2Jp
dHM7DQo+IA0KPiAtCQkvKg0KPiAtCQkgKiBJZiB0aGUgUFNSIGlzIHBhdXNlZCBieSBhbiBleHBs
aWNpdCBpbnRlbF9wc3JfcGF1c2VkKCkgY2FsbCwNCj4gLQkJICogd2UgaGF2ZSB0byBlbnN1cmUg
dGhhdCB0aGUgUFNSIGlzIG5vdCBhY3RpdmF0ZWQgdW50aWwNCj4gLQkJICogaW50ZWxfcHNyX3Jl
c3VtZSgpIGlzIGNhbGxlZC4NCj4gLQkJICovDQo+ICAJCWlmIChpbnRlbF9kcC0+cHNyLnBhdXNl
X2NvdW50ZXIpDQo+IC0JCQlnb3RvIHVubG9jazsNCj4gKwkJCWdvdG8gcmVhcm07DQo+IA0KPiAg
CQlpZiAob3JpZ2luID09IE9SSUdJTl9GTElQIHx8IG9yaWdpbiA9PSBPUklHSU5fQ1VSU09SX1VQ
REFURSkNCj4gIAkJCXBzcjJfZGMzY29fZmx1c2hfbG9ja2VkKGludGVsX2RwLCBmcm9udGJ1ZmZl
cl9iaXRzKTsNCj4gQEAgLTM4NzcsOCArMzg2NiwyMCBAQCB2b2lkIGludGVsX3Bzcl9mbHVzaChz
dHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSwNCj4gIAkJX3Bzcl9mbHVzaF9oYW5kbGUoaW50
ZWxfZHApOw0KPiANCj4gIHJlYXJtOg0KPiAtCQlpZiAoIWludGVsX2RwLT5wc3IuYWN0aXZlICYm
ICFpbnRlbF9kcC0+cHNyLmJ1c3lfZnJvbnRidWZmZXJfYml0cykNCj4gLQkJCXF1ZXVlX3dvcmso
ZGlzcGxheS0+d3EudW5vcmRlcmVkLCAmaW50ZWxfZHAtPnBzci53b3JrKTsNCj4gKwkJaWYgKCFp
bnRlbF9kcC0+cHNyLmJ1c3lfZnJvbnRidWZmZXJfYml0cykgew0KPiArCQkJaWYgKGludGVsX2Rw
LT5wc3IucHNyMl9zZWxfZmV0Y2hfY2ZmX2VuYWJsZWQpDQo+ICsJCQkJaW50ZWxfZHAtPnBzci5w
c3IyX3NlbF9mZXRjaF9jZmZfZW5hYmxlZCA9IGZhbHNlOw0KPiArDQo+ICsJCQkvKg0KPiArCQkJ
ICogSWYgdGhlIFBTUiBpcyBwYXVzZWQgYnkgYW4gZXhwbGljaXQNCj4gKwkJCSAqIGludGVsX3Bz
cl9wYXVzZWQoKSBjYWxsLCB3ZSBoYXZlIHRvIGVuc3VyZSB0aGF0IHRoZQ0KPiArCQkJICogUFNS
IGlzIG5vdCBhY3RpdmF0ZWQgdW50aWwgaW50ZWxfcHNyX3Jlc3VtZSgpIGlzDQo+ICsJCQkgKiBj
YWxsZWQuDQo+ICsJCQkgKi8NCj4gKwkJCWlmICghaW50ZWxfZHAtPnBzci5hY3RpdmUgJiYgIWlu
dGVsX2RwLT5wc3IucGF1c2VfY291bnRlcikNCj4gKwkJCQlxdWV1ZV93b3JrKGRpc3BsYXktPndx
LnVub3JkZXJlZCwgJmludGVsX2RwLT5wc3Iud29yayk7DQo+ICsJCX0NCj4gKw0KPiAgdW5sb2Nr
Og0KPiAgCQltdXRleF91bmxvY2soJmludGVsX2RwLT5wc3IubG9jayk7DQo+ICAJfQ0KPiAtLQ0K
PiAyLjUzLjANCg0K
