Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616779;
	b=dZY7alBo5+pC7s36icT4a/NmbSB/PP51FGcd4+IoBwnQzom7CYafoHsUnO/acKLGwihl
	 ZO+nU4HGaHD31vpFhySE27wEMXQ18TO2bnpbMirnXc/XjEMuNY6TNK7cYEtaGOwZv9MYU
	 W588CJd6hhZEv5YQgKaPdISi/86oTU1l3ivf0Ffmk/DcVu4kw6bod2H24xYnhw1R29raf
	 lTrri+cUJLNKABhPPjEEpJg33SMtbZjmFoSTjaOWF6Ot3MKu+IX1p/PuTf6IXSqJReVcA
	 AN/vTnkCyWdV7/ENwkapOA8nOfy49p4cZssGbdBL8UbbG9GWc23WVpMqmdVVACJgvEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616779;
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
	bh=oT/VuzalPjlo3ZXz2ujIuCziK9JSCMkeIPK8NdsWnOQ=;
	b=20pOyH3622NELsgtaeSB2n7wYmlrSL21FZDA/KETV4rZ8L7fIm5FPdPvOSzCnZywr386
	 YgyGH59AeU8sysj0T1bGCBnO2Xb8BaXJd5gwlWc0ZeFpvrdeqp4nYwVHqII5cyFp9pPUF
	 Q5rSNF10PA1Se/potum7+3v1/iRPe5NOiJ3Y8bAC7RyaOtNdukOk6rdRheX/pDa0UU8mE
	 t6GD0LlV34YYg92gtHqZ/Wd8qnkMzURJEuICy5jOy6a2nOUcoZgQrEl6tnzLJSLPXMYSf
	 H8g9Tva5C2g51/jo7CWW5qxl9TYLvEVpwVMnNFMh34vIfF9sweERPCwtX0y+RxnJNtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gjeo4oSb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615960A2607
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9615960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gjeo4oSb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616778; x=1825152778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oT/VuzalPjlo3ZXz2ujIuCziK9JSCMkeIPK8NdsWnOQ=;
  b=gjeo4oSbYvRvj2VhAkjp3lIgRR/0uKFjvAgNOPSbv8O5FpyxnACPpYGQ
   mzed5Qe4Oz8UxiJSPhwGiO3J4rJk2UV0XNokC9FUIPpP8gW3SkCN9WdO7
   37S/dr4SZ4HMT3zCvPZH6BiIpYtx3OCSMIl0LwxY1jI3oGGy2zF+VihSM
   8+VWrCBaTYWsIAgDZnW+jCX+m4SYKfhK1tmYmVbXSpoPPdqTpRn0EHa5s
   f5+KX4OZKJ/9kxKja1iL9vzS826BRy7nvuk+wZc53Xjas5LxMqGbFCAwr
   2AmWgimPPub4B5XiC4xU7Z0FipkAhts7TuDLD0PWzW70GZ1T61X43o/kA
   Q==;
X-CSE-ConnectionGUID: o27oOq34QaSFMWw+Mzb6tQ==
X-CSE-MsgGUID: K+dVYvx+QqSFwcS15jDbfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2408040"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2408040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:52:57 -0800
X-CSE-ConnectionGUID: ppUuqUq7TtC3golyrklrwg==
X-CSE-MsgGUID: Xb9DFcr0Qxm0XJjyxsTcPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6218297"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:52:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:52:56 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:52:56 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:52:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC0KA75asPPx3XPZDPdd0XAlmXpLuwI8Y4U8VK83kNK8YkbvHoBpnu7FPurIl9b1ykWZq69z4j6A6Ek0GE6FwQQWdaieqaAxJYcynmutRTXDpc1Nd6lN/kom33hG5P15mhBeMKyVEeEpAL/0OaZft6+4j29hjNj7k6W+RlqHo1atcJ6BnhFqw8eHL5E89GZz6cMl/0K4ycj0YsI97TSYX+R4aoAdrs9G4tcp6LeN/bQ0OhRwidSPyJ8e7jZjWoc4W3D9+069vQaDdYkznMyiXtNBBjk85wcqiXiDqDzqpWzlS9UwaLig0RFKRukuMLS9wNQv84QFF/YTzgpxlaLuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT/VuzalPjlo3ZXz2ujIuCziK9JSCMkeIPK8NdsWnOQ=;
 b=TJOrPaFaRqCC9pf1MEMECOSA7VL42DpzjYYIYnZhssnWqVH2sETsuhqTpC2t8WQtldVhr0DWbbKaisOTwhYAb52fC+Nl738AWho1w6guaU2aqLJJR53SBOK2qcmQPKbm9f0wR9e5Rq8zSULopKAdUImB0oM3dLtpMPMtEfq2rHzZ3WiTmelRqdTNKDXn+UYsmQxfMf3JaGN6ZKe0ati1hGhOKXbU9caB1WzzFq2VTmeZ2CMyXeoC7sy7le7YxYShU73Vc7tvtOw/n8XxX2stHfzDhLqdBh9tWKeptterzeGyKSj4+TOxm6rqGcHz7adVeX2byIJzHT2kyubxBuct5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by DS4PPF6EA6DD735.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:52:54 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:52:53 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] drm/i915/mtl+: Use PHY type to identify TypeC
 ports in PLL ID lookup
Thread-Topic: [PATCH v2 5/6] drm/i915/mtl+: Use PHY type to identify TypeC
 ports in PLL ID lookup
Thread-Index: AQHdaGQwM94BkCAZD0+JWqEjbUgMDbcan8Kw
Date: Mon, 2 Nov 2026 10:52:53 +0000
Message-ID: <DS4PPF69154114F8AF70ECBFAD6F1A51D2DEF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-6-imre.deak@intel.com>
 <20261030114456.651066-1-imre.deak@intel.com>
In-Reply-To: <20261030114456.651066-1-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|DS4PPF6EA6DD735:EE_
x-ms-office365-filtering-correlation-id: d63c4a27-a875-41db-6edf-08df38cf7273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261021123027099003|11063799006|4143699003|56012099006|261009223027099003|261021121427099003|261026121527099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: qx6D/fM2jzVpfZ877r3Pz7Aa087vNJk7ASqXZtK5cEjNR7c0P+vdnOETubXsouk5YB+LFaRpfZDr7AA7/+ggM94oBlu/Waztjhm5Md6dm9AN/RsW0LgJL5tN6yFWuSr9u4IQ06bBCDg4eOCDoj1M5XmGNXb+UrVI9bd6Ihlk4JqKNC6QAH0aTW8Ip3v9NajgB91HT2rkIIcNDjABm+GuyNZlh5HKwQeX9jfxW6QgKtOrZhhr91vvqEyVY/0bDa9CnlPWiCzX6OOrTP0QyY6RV84dQHzudUP5xWOsI73aXaWeHqrT2iufO7+eidxafZfxg7bK5mZxbjJhTOq8kzz6rNYyR6sig5FaipgHA+3AM4OynEFEHfyDIIYTia1YqRHic56/Yad8yIN2yb1i03WspQ+hdpM196+Z/hKEH3JMuoX8bp5KidJ6rSxTWaboC7y4EzunDRd3RWQLHyNc6YyVbufHkOXNoKOg+GxRks0NqXM2GAt6dobxzNg0zJGPj4/16SnYQRAQIAv+lRg7cE7aZeg3pKGKS6Xt1No3aDJICXj39WSwsKQ6t1Xw1RgG4DborD3n/XckXPLJJ4TbfHPKbowYZQDUYaqEfOptbokc0g/AomMKIqxA+tKvqB50IZOprAHoI6UiyDPW+xUkzQrRitKAYiLIL4NCWZlzb5UxQS0jYA/W1UEJyq+y186Aq2ylSemIj0kQphHa9yw/DCPI2vg38D6nArQdOZefr4XToHU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261021123027099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDRpMUd3Wm1HZWtPTE1PYmpMMnpadVdqZXZIWnN1aU5IVXE5RHZFNEVPeENE?=
 =?utf-8?B?aDcwQWpLYzZBWXJKbG02bVIzWllMTDNjM3IyWFhGRXBqdW1UZG5TZUpyU25p?=
 =?utf-8?B?Qkc2RzlHY2JsSGdIaHNMZzc3VWZ1NUFKUFJWV2tXUEc2bEpzWmp5bjFnWTJm?=
 =?utf-8?B?QWxxazY1U0g2OCt2c2pNdVJvcnNPVHQ2K0IySWZqcklVLzJRS2xoR2FsY2tI?=
 =?utf-8?B?YTBoTVd1Qnc3endkMlBHd2ZGVE52b25wOWFTd1R5YkxwL000SVpXQnl5eTJa?=
 =?utf-8?B?NVNNV0lzcjdXakZqTG1Ka3ZwMnNLLzRVOTRITXA3K2tncXBPeDFmR0Z3RC94?=
 =?utf-8?B?My8xTlJ4M3IvQ2tmSFZJSlA1dk1vb1dQckpNSVIxdWRHQk05Q1lOWXdOMTNs?=
 =?utf-8?B?OXZOVXZ4VGdMa3JBQmNKdWxDbnJqUDRzdzNWcjZuMzhXV2c5Z3VDM0s3dU1j?=
 =?utf-8?B?UnUvSEtsU3YxOUFiNGlLcjNuYnZsd2VMb1NXTVlMUHVPREhqZDdwSWpiRWtp?=
 =?utf-8?B?M2U1R1RueWd6ZFB3cjh4VUJ1QnpQR1dUVXpEQ1JjSnFKdUZwRnI1UUYwL3Va?=
 =?utf-8?B?aWJmdzd6d0o4WGtXWnpkUjlZMXlTQzNSNkRZZnhyeTFDdFJyTkZYRkJLTE1v?=
 =?utf-8?B?WHkwWDhlcysvMUdUTnNBV2pJTkxvaWRmaFB6ZVhyaVVmMlBqaXYza29MTVh6?=
 =?utf-8?B?c1NHeGNRV3RKS0Y5Szlybm5jOWEzZXo1Q0orV013UzdacTZBODdraWZabTNs?=
 =?utf-8?B?cjhubk9hVm1jUTZTeE12djJpazFuN3F3SEdSd3FxekJFdVNzN01yRUFST3VP?=
 =?utf-8?B?ZXRscGh2MEQ2Z3V2T1o3RHZMSTRwblNjUjlId00vUnAzNGJ2WkJxVmtZRmY0?=
 =?utf-8?B?ci80cXp4NWRxNWtvSjY5QlZHV1lVZTRrOW15Zlp4ZUw1SWZsOHJVd1JZQXli?=
 =?utf-8?B?VWdTNG5hczZITS9nV1FUVmpheDV2M05vcW5jbGwwWHZoR2VKaWFjVUNnZnR0?=
 =?utf-8?B?V3ptS0Q2bHZjQUZLdG1YWC9ucmRLeFVwQnBtajd6anlEOVVZV1YxSVY5ckF1?=
 =?utf-8?B?aGdqQXNYYzhtbW5LY21jaHdBbXdiUDlvaW53YjM1ZUp2NHBRaWJybDl4Snl0?=
 =?utf-8?B?OGc4VHRxRGFIY1o4bHNtem42c3pZS3NYdVI1MlFJQ0tTNE53ZHUwZGtBT0hr?=
 =?utf-8?B?RTIxZW04cGlacnlQNFpDNU1MKy9CeEF6ekdlZW5iMDNmY0ZlU0QwN0RrYytR?=
 =?utf-8?B?NktMcFB1L3BqeG1PR3A3dnpRNEpFc0xDVlpPZW8zL1ZVTFZUQ3RndXpiSi9w?=
 =?utf-8?B?UGlrd1o0R3cyWUxmMGRjcm9HaHM0S3VWZ0NBRUMvZWhOQklXcDVHLzlINlE3?=
 =?utf-8?B?a2RVUCtkSW5aUFhnaU5pQ1JPakUraXlaZEorN2pkTS9lTElZYVVoc0JBZkEy?=
 =?utf-8?B?N2FESnVYY3NQRGRkaE53MlBDSFp3eXE3ZG1xR2dBanNOS3pQRTR6Znp1d3Ni?=
 =?utf-8?B?TVFwS2VzaVM1SkNIVnpTaUxWb2xmYncxL3dEVWQyblM0R282TytRbXlNTjRO?=
 =?utf-8?B?NU1hUXFWSmZ2YldscTlsb2JnS203TEFwRzBuOEdQRHYvN2lUdUMxcVFkaE51?=
 =?utf-8?B?RHpES3lGcW0vU29WcHZMaUs3bUl2L3Rxc2VOR295aElYUGhtMnVkNmx2a3FQ?=
 =?utf-8?B?U2RyNU16T1FMRWhUbGgrbmFjMVIxOFJZZHhoWWdZNTZteEFkRkFmdXRoOWZx?=
 =?utf-8?B?Q0hxQ3dvbTRmcmpOU21yMjBGcWhoQkFWY1JSMGtOSHNUdml1bGR4a05xbnlZ?=
 =?utf-8?B?akM4NUhhd3ZLSFdrcVZobG1EK0kxNjlzMGdlejFkSmtqMmZWaDFXNUQ0M2Ix?=
 =?utf-8?B?OWtoenJsYVZiUjUvZTFBNFVBckMyTlBFNVZmbWxFaVlwemJxVjNwU1FYd0xV?=
 =?utf-8?B?SzdxZ3cwUis5U3R4bk01emFMeUN0ZG5qVnc4N0VnMFdRdXAva0VaNjVSTDQx?=
 =?utf-8?B?WHBoTkVOdmJLSnBHWFB4eDY5SFRxYXgyenhrMkpucC9KRFdzajJnSzZneU8x?=
 =?utf-8?B?Sm5YZXhoODRWbzdvNG85Q0RGZ3FqdHRBVFZ0YzZ5amY5QkRLdWJ1dS9UbUdJ?=
 =?utf-8?B?NGExbjFFOGRVb0tYOGNHRjNvc1FYeUJaaXo0RkVsRG82OHhSL3RiUzZ0SEJr?=
 =?utf-8?B?S1FrYzNwSjQvVnErcVc3Q25xYlMvWW53NTFWN2xCYUtGdlNTcDdLVUdjTWNT?=
 =?utf-8?B?V0c1UXBoUGkxTUp3MnhaTCtycUtlZFg3aEcyWSt6VEMrclZGZ1psdUdsRS9v?=
 =?utf-8?B?NTZ6N2hNQjAvSTlPR05Wb0FHcTFpVUh1ejdHYWJBaGczMjU0RlVUdz09?=
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
X-Exchange-RoutingPolicyChecked: qt9mfkDuwm0bY2kiGpMw3nH8M9gPxwPqf+hjYeIU3g+dx96Br/Nu+xzhWBh9og4vwuzP0j/zM5Jh9a2WZ5QVF5MHQFZf+m90tWBLDKlAFtM9bQ5fIMWsAdp1hEpAk5sJAHjGm4GvVcQwv/4o7FjeCatMkw2JAL3tluBQbMTONzBBgIP1jk8K6eRtbUnQniIjEJDpodIa72j0Cu5cRe+d8EbrrCGIcU5nr2EMcBGDvYePw5LG1vupwZSLLPz2AjjeQo5jIVdiEGWY86TAJI4ubhHYKRhz9oobbbU2Kz6JF09YQ1AR1gR3gizpTBta+GUmCrvo44gjmq2jIksox0VbIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63c4a27-a875-41db-6edf-08df38cf7273
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:52:53.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77bQOgekoR8XEaEske+s5Pa6uXkZXWA647NEKEHB/zunVEHwpo0kzukr1pWwnSiKprd4gGJrKjoWOFDBGjOWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6EA6DD735
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBJbXJlIERlYWsNCj4g
U2VudDogRnJpZGF5LCAzMCBPY3RvYmVyIDIwMjYgMTMuNDUNCj4gVG86IGludGVsLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgNS82XSBkcm0vaTkx
NS9tdGwrOiBVc2UgUEhZIHR5cGUgdG8gaWRlbnRpZnkgVHlwZUMgcG9ydHMgaW4gUExMIElEIGxv
b2t1cA0KPiANCj4gVXNlIHRoZSBQSFkgdHlwZSB0byBpZGVudGlmeSBUeXBlQyBwb3J0cyBpbiB0
aGUgUExMIElEIGxvb2t1cCBmdW5jdGlvbi4NCj4gVGhpcyBlbnN1cmVzIHRoYXQgcG9ydCBCIHRh
a2VzIHRoZSBUeXBlQyBwYXRoIHdoZW4gYW4gdXBjb21pbmcgY2hhbmdlDQo+IHNldHMgaXRzIFBI
WSB0eXBlIHRvIFR5cGVDIG9uIFBUTCsgcGxhdGZvcm1zIHdpdGggYW4gZURQIHBhbmVsIGNvbm5l
Y3RlZA0KPiB0byBhIFR5cGVDIFBIWS4NCj4gDQo+IEtlZXAgdGhlIGV4aXN0aW5nIHBvcnQgPj0g
UE9SVF9UQzEgY2FzZSBmb3IgQk1HLCB3aGVyZSBQT1JUX1RDMSBoYXMgYQ0KPiBhIFR5cGVDIERE
SSAoYW5kIHNvIHVzZXMgdGhlIFR5cGVDIERESSByZWdpc3RlciBhZGRyZXNzZXMsIGhhcyBhIEMy
MCBQSFkNCj4gYW5kIHRoZSBjb3JyZXNwb25kaW5nIFRDIHBvcnQgLT4gUExMIElEIG1hcHBpbmcp
LCBidXQgdGhpcyBDMjAgUEhZIGlzDQo+IG5vdCBhIFR5cGVDIFBIWSAoaS5lLiBpdCdzIG5vdCBj
b250cm9sbGVkIGJ5IHRoZSBUeXBlQyBTdWJzeXN0ZW0gYW5kIHNvDQo+IHRoZSBkcml2ZXIgZG9l
c24ndCBuZWVkIHRvIHJ1biB0aGUgVHlwZUMgUEhZIGNvbm5lY3QvZGlzY29ubmVjdCwNCj4gcG93
ZXItb24vcG93ZXItb2ZmIHNlcXVlbmNlcyBmb3IgdGhlIFBIWSkuDQo+IA0KPiB2MjogS2VlcCBo
YW5kbGluZyB0aGUgQk1HIFR5cGVDIERESSBidXQgbm9uLVR5cGVDIFBIWSBjYXNlcy4gKFNhc2hp
a28pDQo+IA0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMTQrDQo+IFNpZ25lZC1v
ZmYtYnk6IEltcmUgRGVhayA8aW1yZS5kZWFrQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE1p
a2EgS2Fob2xhIDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwbGxfbWdyLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBsbF9tZ3IuYyBiL2RyaXZlcnMv
Z3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBsbF9tZ3IuYw0KPiBpbmRleCBiZmQ2ZjBhMTk3
MjUzLi5hYzlkM2YxMTAyNzQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2RwbGxfbWdyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kcGxsX21nci5jDQo+IEBAIC0yMDcsNyArMjA3LDggQEAgZW51bSBpbnRlbF9k
cGxsX2lkIGljbF90Y19wb3J0X3RvX3BsbF9pZChlbnVtIHRjX3BvcnQgdGNfcG9ydCkNCj4gDQo+
ICBlbnVtIGludGVsX2RwbGxfaWQgbXRsX3BvcnRfdG9fcGxsX2lkKHN0cnVjdCBpbnRlbF9kaXNw
bGF5ICpkaXNwbGF5LCBlbnVtIHBvcnQgcG9ydCkNCj4gIHsNCj4gLQlpZiAocG9ydCA+PSBQT1JU
X1RDMSkNCj4gKwlpZiAocG9ydCA+PSBQT1JUX1RDMSB8fA0KPiArCSAgICBpbnRlbF9waHlfaXNf
dGMoZGlzcGxheSwgaW50ZWxfcG9ydF90b19waHkoZGlzcGxheSwgcG9ydCkpKQ0KPiAgCQlyZXR1
cm4gaWNsX3RjX3BvcnRfdG9fcGxsX2lkKGludGVsX3BvcnRfdG9fdGMoZGlzcGxheSwgcG9ydCkp
Ow0KPiANCj4gIAlzd2l0Y2ggKHBvcnQpIHsNCj4gLS0NCj4gMi40OS4xDQoNCg==
