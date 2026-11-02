Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616824;
	b=hR+jWB/LyG+EThNBVdB4Wiqltra/vkcbu8KQ/WtpGfPZ1sh0VshbjrNoXFcxM6/4nBIT
	 DNeob3NOcA4xz8O7soZcG7frCSMuips6/Xex5A+h/XIRuNSW7a6htzhkmQ0xJuSBVVDvl
	 na6SonJ500E9AaIfb812jNLZ6yCBCvqkm7g/v2QB2KGcZZKI6AhNx9JsTxSMTJ5YfW2wG
	 JsAnYSsCQeDQ/eLxuXmAoU89tPYJgLYgGvTite4JqhHIxpN7EEPCFKnlay3/w/EanDQAT
	 pxDJbDzCO5rh0WRR2dLxddKGuXjM3rbAeqUxL3AYJE/pvKcXZu7E+gXF4fOldcCLdDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616824;
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
	bh=V7c1lDNAgEFHrDKVFLu+jpt4cN/1ESV4ZecJ4zuib98=;
	b=irjbgBCyecWLyNYh3D5XPtQxBQYDLsFP9FhgxQaUJyaYP5r6DYwcc8ApCJJ3XBp450aK
	 C7fR0Gvly7AD1SAoe931rREmopqyQnpip1EKbjO3aPD1ON298l7pUOLnRRwwhaZoduhrS
	 M7yApn8iDJVotAvo3g+fIDec+CycDDArI+KgsP64vCa9+RvNl3A43L6AdCXZdnW02rKiu
	 V1hegQY0YnMgX8VKIdV6Ial91ENDeWWlegI2YV0mSIUNXx9KPYBIsrAsMnNX26gBP9iQ4
	 jJJZ+aRoyPEY3Z9u5RlVoKDgbT6n3hUxdw1y0d/ixr++6eZQnkvKjVeUspAJs2gaL/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YzlaeBqk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6E606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA6E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YzlaeBqk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616824; x=1825152824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7c1lDNAgEFHrDKVFLu+jpt4cN/1ESV4ZecJ4zuib98=;
  b=YzlaeBqktWcJAlZqQLImkPFVurOt51pse8iPynAfkUKujEZkkwdudcXy
   0fu2cxqmGBmyYqjK2Bq6MeUYoYOztPRnR5U7act+lQ9POyqclWKkirK2S
   WBp9XkDZHYCNmXYeMAXVlfMKYLLEphflvTJMvaWyS8HE7FduUH1z/w3v+
   YS/hk56+aAbeTTqS0la7hy4eSCIdN8jvg71yJMrrw4mHhINUAiQ/LiPN3
   eogvNNQx43fd8odv5TvyUiciPf5ZsQGBnFdgPqPqaABLDFU4tqRNKLXOz
   TX0TWQWKuDJmzb6HTYorTJRG52UrB+3ENBAZ0ebTOlr158bOfHRfIMnul
   A==;
X-CSE-ConnectionGUID: +LUY/GtVQFe7p1Tfn0COeQ==
X-CSE-MsgGUID: Vn02cIAdSlCmBGvO6lxAKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2210382"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2210382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:53:43 -0800
X-CSE-ConnectionGUID: YryqLzTzTdqd124G+nP1Tg==
X-CSE-MsgGUID: wLNrsjLTR++J40S1qNuz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6081705"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:53:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:53:41 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:53:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvvTQP7sXN/zh/womUY2rTxlUdQfCdLyVD0D1/OoX4CirRl4e1eSAd5Rwe6Cv8/Wok5ukVSWlA6/mrm/m+7C+zmSyI4DkIuOPUL843cFRmmQashebrdTOYr/vIxrYF9Si3NoFosn+Zh2p1Y5pqeiuS2DOwhx0lIhDOx+G/DJ5BXVgKIRh8AUx6h4oiRZ9nH9FdXFbqlyJeMAgO7KwbKPcuFLN4fybrrSKCZkZ3ggEGbBCFOQmUddYv2Yu8+r0d+KF5pLzz5WDsa5k6zcx+alkgRJ2HDjeli9sA+iWGejXDUmB6jbqb9IyrHe6Eg0zvCtnu0uxSKzfRNG9KEo/MNpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7c1lDNAgEFHrDKVFLu+jpt4cN/1ESV4ZecJ4zuib98=;
 b=uPY+zxyn+WzY0xANs1iORu2N1bfDlSrRQM6hcl0tFZ7Cth1KAvChn8i/ss4Xt6qzJgxPk4KZc79rh7v6fcI0uqC5kzvFeMR6TuaXsUt2ONZ/JczDyOjTiewgdUWBMmq+OxJeDoBHjPCyt5TB0HhdLOxkkZDJwYsYyadbmixHjbVVc1PIBuefXdsOOXqG9HxsIotux7q//gTr9Hxs52DFGo8qMdn+8Mv8328NZ6ZSfhj46kFGfZyyekQ6AR6FgAj4FGuIUWR2+DZDZoAlzfNNLpohLeAbBZ7JdCPGxohosg313o62Y/p9+mBlGaH4VLR+mvFmCQzHJJ4UiA8oXT7ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by DM3PPFA69606334.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:53:37 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:53:37 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 6/6] drm/i915/ptl+: Fix TypeC detection for eDP on port B
Thread-Topic: [PATCH 6/6] drm/i915/ptl+: Fix TypeC detection for eDP on port B
Thread-Index: AQHdZ5nPZmifZl/kyEuNm6V7ndBmQrcaoYpw
Date: Mon, 2 Nov 2026 10:53:37 +0000
Message-ID: <DS4PPF69154114F4ABEE5367DDD3D4EC13CEF6A2@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
 <20261029113017.618286-7-imre.deak@intel.com>
In-Reply-To: <20261029113017.618286-7-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|DM3PPFA69606334:EE_
x-ms-office365-filtering-correlation-id: c0a4fa7b-f04b-4520-18f8-08df38cf8c7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|261022075727099003|261009223027099003|38070700021|4143699003|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 26b6QhhU3go83+bTBXVLux63kfY/e4suXz8AWQ+MD95GH6Zky89vTsy4pMvFpHrvOnEeT2mAeQL8evZByu2HYWcdCnLFcxy5Xu/f1PA8muNjIRLEvj9s4QbMp5KN6Vj3qcjjHdeB1LeddQOFl42ghr85Mt1ErEZFEC4Xh1tjo2xDt4/BdgJSuydvMkAv+zwo5ICkHwI637eMPh61Cx7ejrt6x5UrY1572mLfHuQRahtHqbjxyQc50b4Cr1C3a6I18V/ZhkYa8ZudTPftyyU/uXO7SyzHe6tF7AVRDdwO+VgJAVr3AGltGoEwCkkrGMENZtodIFOzgsMvXGq75v+NxSFsuLgD8ZRkNGUHGUlPxL6rVf/bVBUfZDwEwmZcP87HQ7oOVU0OwaeRxk6Dxh94nltuMyh6XIbHrfESWaIJfyPLnNlzUo7bJIWzvLZEFQ9XzlexlCG80/LzqO5bJo6bt5watbjOFkW1V6J1zd9CWXMCKumSpkTfGH4j0I4zC4roXnPnFu8EMKJ4UUDUhyQgGQqDMCcYtk5Ll5CdWUMsopzb2Zv7sak3cZJvS3OSphRn433pBGNSUQrVcDHxA51RBT6aU0GX2CVIFBrImlJQU16tWXQi+niHzR94Cy3z2bkg7dWNhyz7onFYqknxUR87T5MlXDecUcM/c2kC9oPy9q8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(261022075727099003)(261009223027099003)(38070700021)(4143699003)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnBLQ0lFcmpMMjM2SUJhK2psODc1SnBGdjQ0N1ZFR0c5RlNjU2RoYWNzSkVH?=
 =?utf-8?B?cnZuRUMyYXBzaTYwQk85aXAwMFpIdXdrYXM4ZzdCMXdpNjhqQURJSGk5dmpw?=
 =?utf-8?B?T25FR2V4QklwOFc3N2JkNmI3cVNtbHRRN2NDVHA2aE5qRHpVU09oM1ZUM2cz?=
 =?utf-8?B?dWZVTEtpUTN5ejdkVjlVeGs5SkJ0dysvaXZvek1ReDArNzE1ZUUyTmxtSFdG?=
 =?utf-8?B?UTM0RklTRnJPaWpRYW5rU0VYUFVFMGxoRnRId2Y1MC9pTnB3dnJzcHhBQS9x?=
 =?utf-8?B?b1RwSWRkTHJVK1BNM1g2SElPazBBdythOVFjajVxYjBYSVVEb2xwZHplOVVB?=
 =?utf-8?B?aHRGZVRQRU5vdHdRTzJxd3pGWmY2OHVJMHFmaW9pMSs1dWx3bUcxRDhYUHM1?=
 =?utf-8?B?ekN0MUZ6RWdoOTUyS0paN093THJRNy9aU1AvYUkrYlZOT0N0VmRDZXhuVkRo?=
 =?utf-8?B?eU5oYy9GMGFqdkFqMjBiSmpSZWlHeGhTVExlRXNLL0pBZm9ZQ3NkbkxWRHVH?=
 =?utf-8?B?WG9OWHQ4N2RqRXpMRVd4K3dQUmNjRytrZVFsM3RSSmxGSlhwQnBHUFdhNFJ5?=
 =?utf-8?B?NjFNVmcyRW1CN2hBdlZHQUxibi9INmRCTkJYN0p5dG04T0F6L1F1MlFZV2Q4?=
 =?utf-8?B?bHIyQXE4ZUtDVHVYSVNzck1mTURPOHlWQUxMZ0NySHhFcE5sU0xyMUdYUzRm?=
 =?utf-8?B?TDlGam1FeHIrRE1MMEhKTXQ2Ym1vOFpEclhacENNMlg0N1V3bkpXRFpTZTF3?=
 =?utf-8?B?Q2ljUytBaS9Ba21TMnphUzlleXIvS2pidER4dVlhNVp6b1hIa0lVZUdrMDAv?=
 =?utf-8?B?NTlmMlVHdjExUUc3d2E4NnJ0QXBnVEsxUVBlbkV2Q3VFNkFxZnduY2FwUVFm?=
 =?utf-8?B?c3p5UHNHRC9oTUtpUXpZRWtING95dkE5TXZ6VlFDZXF0NXA2anF0ZVJQYzFv?=
 =?utf-8?B?V2dUTzgyQ3dxamV2Snc4QVhQa2grWGoxdFJob3haNGVNOGhtVi9zQkc4Y1hG?=
 =?utf-8?B?T2l2S3Znc00raGMrMnRrYnIrU1lpajFUc25UdVlqN2Z0dUE2alNKSHVDSDB4?=
 =?utf-8?B?Y1VZT0U5RlFqUVRFVC9WR24veURrcXNxRGRGWHVvMUllREF5UDM4Z2RKU3Vx?=
 =?utf-8?B?dUxHdERlVDJGSlZIZklBMjFXeWEyMG5MYUhRMFZIQVFjSWxrTHhuRVRDZXlF?=
 =?utf-8?B?V2dvTE80bnN3YmVFOGdPMUtrOGZiWVI5Nmw4aVJrZmNzZUtGQXhjdjJldFB6?=
 =?utf-8?B?dXA1Um9VWHJVQ2pRU0ZpTE1HVURWd1F1T1gzM1RnNEZncEMrY2dMWVNZRGFv?=
 =?utf-8?B?VE9rV2xDcUYyOU9USEpZZDRKQ3Q4UUdlaU5XUDZoWmlyandqa1VubTd5VXJ2?=
 =?utf-8?B?RWtCVnowTWNKVElVL21WRm9mTnByM3Y0bWhUNit1WUQ5UXBSTzZGYWt5dFl3?=
 =?utf-8?B?bS9HbHZTRzJhSEY0OGJ5cnYrdlRlazdpSXlMdlBmZDRGdGhvaHQrdFVHbUtV?=
 =?utf-8?B?VDhQS3Q3aXZiWFZCVkFrekNUSjJzRjJURjJ4M1k5RUFVd1BiZXkxQUpIWE9x?=
 =?utf-8?B?SDFvcGpoZll1ZXJZaEllb010YzJyNGlUakR4VnpOdVBoWFI2Y3hRNTdqeVV4?=
 =?utf-8?B?Njc1L2MzTjgrMDZqc3dnVTlUN2R5aUlqNnJRaVJOekRCWk0zdCtGWURqY0lp?=
 =?utf-8?B?Z3VGQXl0LzhZdm1CMGhYQ0kvcncwUWlaZXpoancxTkFIZzVHaXQzSkVMdmEy?=
 =?utf-8?B?d00waU1ZZ09URnF1SnBUcncxTFcwbDNTM2RLWEp2clVISkdMZTgvTE5GRVJs?=
 =?utf-8?B?UGxFNCtTYllxQklEY2tUeFUzNE81ejMwYno5RVptazBuRkJlMHVyY1FWck1z?=
 =?utf-8?B?L0J2ci8zVTVSdkl0SjVETGkybFp5aERJclkvK1I3R0p4M1RjVTVMV0RWODFj?=
 =?utf-8?B?TSswUUFLMU81TEVqS1hIMHV0NkhLNDlUTndaV3R0M1EwLzRhRFNiK2xFd0Nu?=
 =?utf-8?B?QXU1bWFoY296YmZkUHdWa0ttblVCYnU2VlRUVjVacFByOEc0RDhiQ1MvZVRy?=
 =?utf-8?B?QWhFUk5TL0o0Q3lTd3ViNWZOcFllV1F2ZExJOStvWjhPTmVNWHJoZlFXSFQ0?=
 =?utf-8?B?cDlUMzJMZW9odmFPSGVOcXMxVS9jNkM5WG1VKzJjZ2xxWThId2VlYnJSeFQ0?=
 =?utf-8?B?WDF3RW1Db0hhQ0hVOXdjSzBxZldPOGRFYVBGS3pHT3UvcFE0TDU0RFJMMGk2?=
 =?utf-8?B?VGhPVzd2bWs2cUVEREFTUHlxK3g0RDl4eWMyOUxFcGMrNmRVN0o4TjNJUDdK?=
 =?utf-8?B?S1BmcTAwTE96bDVUbkZNSGwzSW1Sc0p1czhoRzRvTTRoTSs4Y0wwdz09?=
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
X-Exchange-RoutingPolicyChecked: GnGHIBp4w3UWikNOG25mUuZYZZP4zNW0w6lsleoPT/XS02ghOfRL0BBWtdHhUIvSZsNyGIjuScU7zhOclS40Z9zv31HWdZsu2hA4HI1UUUlr/sbWALb/qrLUwwYIuvxt98y+lwatgg3GC4kMooH+B/gckObHpz9OFDogpdTZM1AswisQOKWsmcAXxjGOvzhnU9JXp5mxUxYvfoJmlH83fFnt4QaTOXGGGY58k943YSXq7A27REHTFzER9b0ENfWEahxU0iNQdDMgNOaFyC6bfQEqSBWz5J7N6/BKYn5PiaFYgzodGaG/HpjDreMx3scvYlo8fS5qutTzruyEIBxBKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a4fa7b-f04b-4520-18f8-08df38cf8c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:53:37.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOPavybNLglkY+DgB0Y7wgT8gknc1ApU7xh7iIuDdroTpUDhM1Kqmr2dXh40jRZY9s6UgDKJJrm1P/E+6RPdxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA69606334
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBJbXJlIERlYWsNCj4g
U2VudDogVGh1cnNkYXksIDI5IE9jdG9iZXIgMjAyNiAxMy4zMA0KPiBUbzogaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwteGVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCA2LzZdIGRybS9pOTE1
L3B0bCs6IEZpeCBUeXBlQyBkZXRlY3Rpb24gZm9yIGVEUCBvbiBwb3J0IEINCj4gDQo+IE9uIFBU
TCsgcGxhdGZvcm1zIHdpdGggZURQIG9uIFR5cGVDLCBwb3J0IEIncyBEREkgaXMgY29ubmVjdGVk
IHRvIGEgQzIwDQo+IFR5cGVDIFBIWS4gSWRlbnRpZnkgUEhZIEIgYXMgVHlwZUMgYW5kIG1hcCBw
b3J0IEIgdG8gVENfUE9SVF8xIHdoZW4gZURQDQo+IFR5cGVDIHN1cHBvcnQgaXMgZW5hYmxlZC4N
Cj4gDQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJu
ZWwvLS9pc3N1ZXMvOTE5Ng0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMTQrDQo+
IFNpZ25lZC1vZmYtYnk6IEltcmUgRGVhayA8aW1yZS5kZWFrQGludGVsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IE1pa2EgS2Fob2xhIDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXkuYyB8IDExICsrKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZGlzcGxheS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMNCj4gaW5kZXggNWU0MDQ4N2U5
YWIwNi4uMTBhZjEyODQ2ZTczMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9kaXNwbGF5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9kaXNwbGF5LmMNCj4gQEAgLTE5MDQsNiArMTkwNCwxMSBAQCBib29sIGludGVs
X3BoeV9pc19jb21ibyhzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSwgZW51bSBwaHkgcGh5
KQ0KPiAgCQlyZXR1cm4gZmFsc2U7DQo+ICB9DQo+IA0KPiArc3RhdGljIGJvb2wgaW50ZWxfcGh5
X2lzX2VkcF9vbl90YyhzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSwgZW51bSBwaHkgcGh5
KQ0KPiArew0KPiArCXJldHVybiBESVNQTEFZX1JVTlRJTUVfSU5GTyhkaXNwbGF5KS0+ZWRwX3R5
cGVjX3N1cHBvcnQgJiYgcGh5ID09IFBIWV9COw0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogVGhp
cyBmdW5jdGlvbiByZXR1cm5zIHRydWUgaWYgdGhlIERESSBwb3J0IHJlc3BlY3RpdmUgdG8gdGhl
IFBIWSBlbnVtZXJhdGlvbg0KPiAgICogaXMgYSBUeXBlLUMgY2FwYWJsZSBwb3J0Lg0KPiBAQCAt
MTkyNCw2ICsxOTI5LDkgQEAgYm9vbCBpbnRlbF9waHlfaXNfdGMoc3RydWN0IGludGVsX2Rpc3Bs
YXkgKmRpc3BsYXksIGVudW0gcGh5IHBoeSkNCj4gIAlpZiAoZGlzcGxheS0+cGxhdGZvcm0uZGdm
eCkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gKwlpZiAoaW50ZWxfcGh5X2lzX2VkcF9vbl90
YyhkaXNwbGF5LCBwaHkpKQ0KPiArCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiAgCWlmIChESVNQTEFZ
X1ZFUihkaXNwbGF5KSA+PSAxMykNCj4gIAkJcmV0dXJuIHBoeSA+PSBQSFlfRiAmJiBwaHkgPD0g
UEhZX0k7DQo+ICAJZWxzZSBpZiAoZGlzcGxheS0+cGxhdGZvcm0udGlnZXJsYWtlKQ0KPiBAQCAt
MTk3NCw2ICsxOTgyLDkgQEAgZW51bSBwaHkgaW50ZWxfcG9ydF90b19waHkoc3RydWN0IGludGVs
X2Rpc3BsYXkgKmRpc3BsYXksIGVudW0gcG9ydCBwb3J0KQ0KPiAgICovDQo+ICBlbnVtIHRjX3Bv
cnQgaW50ZWxfcG9ydF90b190YyhzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSwgZW51bSBw
b3J0IHBvcnQpDQo+ICB7DQo+ICsJaWYgKGludGVsX3BoeV9pc19lZHBfb25fdGMoZGlzcGxheSwg
aW50ZWxfcG9ydF90b19waHkoZGlzcGxheSwgcG9ydCkpKQ0KPiArCQlyZXR1cm4gVENfUE9SVF8x
Ow0KPiArDQo+ICAJaWYgKERJU1BMQVlfVkVSKGRpc3BsYXkpID49IDEyKQ0KPiAgCQlyZXR1cm4g
VENfUE9SVF8xICsgcG9ydCAtIFBPUlRfVEMxOw0KPiAgCWVsc2UNCj4gLS0NCj4gMi40OS4xDQoN
Cg==
