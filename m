Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332531;
	b=NoxilHIAHzxyzLJU92b1sKDDeXEtBdVnsf73ymCnWcqMUG6fbJAeNoxTkEFX2c8Gqxtj
	 CZmqZDec17hHDh290p4ElzesKVDAHlCKKjPLuoe+PhFkL36+Obvjh2534Fy6FNvxEo2ok
	 o3x8KiMDTUNNPcl/TJd3QSs7uHs0PXJeFGfNcHYIUbiJhdrV12r+h+u1CM39p2i4OEdPE
	 LRAN1IdH1QiC+vNQWN0wdFBwlyU8Heaj7wqlZ4I9c7IBvXf8lWtjyLnb44ctaKWtBhoHx
	 HmX12NEIqRieTOoWUMEMBKQf9dDOx8wWHQQ22JbHsYb1aZ+z9+zueGXBOkE+1LyaOiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332531;
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
	bh=EgbvskgnZArjUmzokYnUNPnB6dgqigkWAqL2GV03Stc=;
	b=OwR+AK07upH6jfhdXQaNr8ghcdNn10uC0eY7o40aKe8NKxVrZuU+AI8iyBhybrEFdPmW
	 uGTIVt6IoHMBgIm4XennIG8d9/ypEvY7bjq0LdAoAVQGl4Yx8csZarrtP+cidTvQPlEkZ
	 Y3P2VyesTrCSAx7oNgYElxno87nBd8DIecIoJcyMY4oM4TDXM4+/1hyWocdVoLwjg3qvd
	 Fa16UiAgaXWJZRGT/0KOIY0nE4IVFYyTcPOSn05nS+6+O32XA9gnmw7T4CaEaWfGfw51Y
	 e3+o0zYGzmrYVdatM2ePwbHlHLpLRjHIER+1SEMBbY9T8b1WGodyVuFLcm8GgJkV3FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZkKQH51T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96369606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96369606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZkKQH51T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794332531; x=1825868531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EgbvskgnZArjUmzokYnUNPnB6dgqigkWAqL2GV03Stc=;
  b=ZkKQH51Ta1upcdxp1mS4yflyNQBdHzuxumTpgn3D4XDQsFcNOFs5PWiE
   HxmhmCunwAVVJUpD67MLjGaKYDVD+upGij3KTnchV04m1/fhcjBjWbfk2
   tJ+cgJTe5LJN8jKu0u7iWSd2dCusz5oyaF2YhxUbuiZNRBJPkJ5XUwBWg
   l7c3Wnc9EdS8fQB4N54NIv54pL0Hsw5QGVmtri/HcuzePh3EDHeARheVl
   k8F0fyQJvdoOIBX3rEM1qv32f/D5epBKK41I0ElhzDDgnahmB3O9I3EVN
   OetjlljG7GXbTr9zyEJJ6ulfey5e2F69DKK61WfJhLpWBz2inDQedbHNk
   g==;
X-CSE-ConnectionGUID: hgt2iGmwTey7Va5wnf/huw==
X-CSE-MsgGUID: XqqdYa9LSbG6PgrMwqZ0NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2968626"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2968626"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:42:10 -0800
X-CSE-ConnectionGUID: vs9rG9lVQbeCBgCP+O2iWg==
X-CSE-MsgGUID: Be1WPUBJQoKXAV28pRCQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8645076"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:42:10 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:42:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 09:42:09 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:42:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkESVu3+wWpCVb/ssz37MzhFx8k4slyTvxVn1tbTr000tD+fQ/p+LauzSbiRg3qiKSGAXVWgjxPoAG7Rpo2y4HQKhgoIPH6Vm/9bVUBWvacBgFSFV+Y2sXfkbAsQIHZSW1WoyAApdOd1tY+p5nGhz0xfPU1b/fXtHnPiL+ZJVwjp+HYm9qAcfeksZV72fbffofUAZ9mvzIgplThUJl+FAK3ESjjueyN0VfOjt2FJP3CNc4NBj0cF2o2St/+dSubcMUSowDRE8og1QYRxr8Gv1jMWv6SewLJAMLerE9aW4Lw/aGHRLGpwMzt3y7YddooItdW+bdlI1Ftu0YKRmS/yAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgbvskgnZArjUmzokYnUNPnB6dgqigkWAqL2GV03Stc=;
 b=b5kweiwf3SMArIU2FRDJ2svmb9xLNVgjdxB5VIAC2Xp/l9eOaR7jDyKAYBABHd97fsI9LmBHm/8ixJGrV1kP4vqcIcPElCCUh2CQzdpw56rHnMd+TZoFtPEXI4fXEPNiJHColKo8CWjJ3E6s1y+TF17Iiuvdop/jgRRfsYV/FvN/gZfkC7HQocCKeDQTlUZg74K1azhiAQfjSViTNJktbYt15G0R5qbxR19dn+8+oX855fqrANN4X3/wdrstSYq0qRZJqzMdYmTV4HmH2oRt6/UHujbzVIrJfqQHKeEQnLGXR3Z1xvI7esxpFWWgd9xPq6n8nWeLfCyTfSVFXPIeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB619106.namprd11.prod.outlook.com (2603:10b6:8:43e::11)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:42:03 +0000
Received: from DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee]) by DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:42:03 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in VRAM
 on dGFX" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in
 VRAM on dGFX" failed to apply to 6.12-stable tree
Thread-Index: AQHdbqEOFAt1RjMX9kCZcUYIcgk/LLcnmFEg
Date: Tue, 10 Nov 2026 17:42:03 +0000
Message-ID: <DS3PR11MB619106EA87DDC8B73AA1A2E23EF4722@DS3PR11MB619106.namprd11.prod.outlook.com>
References: <20261107051621-failed-6.12-ace076ef0a85@kernel.org>
In-Reply-To: <20261107051621-failed-6.12-ace076ef0a85@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB619106:EE_|CY8PR11MB7136:EE_
x-ms-office365-filtering-correlation-id: dbd036b4-548a-482c-0d95-08df3f51eea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|42112799006|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: 9TtRLTyTck1ylA3e8V/dlKKYXRxwmiD10G0zL4JLyRXYoUTrtze1acSTEyimR2nFB5Tom8MiP3Fl52q3khhoKd2mqJnHDTiEZHXg4ySEQzsvCDd8p0PQ0fweh5kcyypRaV186Sik7excW2JhUiNSmoO+3v6bQoKHi3i9bqflx52jZj351fJ4AF0PCgLApoTB9305Fds/KoOjy0z9gRJfRs7S27sjSf0Bf1SP/3SvmmPecwAuVljsrhQSOvjoHddagyUqUXZ9smJcDM/o76GUE4M7xuAnRR5oIIkmBycAtuo6dOISkeB+5PlsrDbKPR9lJ21UBZiTu503aWSMF2yzs4WzNGwo1eqWjgdbz2cM8wIDExC/ibapyacSwBBxoTdhdIzMITIDQqsOX3Jd69Lu6QH0eQYuTPPurCJ6eYq5i2/B7TD3voGarQaspjimNOyUbw2d84RHfkvT0aQakNfhSTfoZbDyby7YWjVedC73xqfXCT93jnKDoM+ML4L76r+7aTXz2Unfovwl6hLor6dEpIE3TK0vcSQbfo1VH6HMgtlFyONYrXJz3/BUROZkKDsPPaJTl3yyggHooPh1CNXHDWyFu+E9UFKzQg4TMZiEVaB2EgW1Lm8BXFtZ5XdLDXgBq39M0lXXhzpBiS2y64oY82doH3mb2f7GXw6kCWpfzEY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR11MB619106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(42112799006)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1RIaGI3TmJXVmtPQ250V2ZkSDJKd0U2TWtucXR6MzF1dzVRM2JUR2JWMEto?=
 =?utf-8?B?Z2ZBc2p6dWovQi8vamF3S2dqenRoa0lhWFRyK3hHcXcwSDVmMWpZSmpSNXlQ?=
 =?utf-8?B?Y3puTzZ2clVhM1pYMldqOFBsdHRqbUVzSTF6YXNPQlZDRGswMnc1MTFxNDVw?=
 =?utf-8?B?T0hTK0UzZml1Nnl2S25zWHpxSXY0d0pTVjFDZUVmU1lsWFBveFVLMFhqVDBk?=
 =?utf-8?B?c3dYUlRuNVN5WTlhY01CK0FiOGE0SElJSmJLbkEzMFhpS3REcTMrR1pwOWJS?=
 =?utf-8?B?UWUzZ2lzSVM3aEpYNE5QRmZta2RYQ3gvQWhvQzh5eU8rcVcvUlpQVXQyaFpr?=
 =?utf-8?B?U3E3T1hIVXpxY1VZeHljY3VHME9UTDBXYUtCMW9YcEhabjVQV1o2NFVnZERy?=
 =?utf-8?B?R1dLeEFpY0g1TE83RExjN3pDbk9EcGZKZU1nVndNdExKQkFlcGErMGlkdkh6?=
 =?utf-8?B?TytrU1FkNVRnWm84RUJvaXhIaHVNWkMvSGswbGhvMFdubi81V1NXWG9RdkxL?=
 =?utf-8?B?Z0dIQm03OUhoODZsQkxSQVRMOW1yaDZZMlJtYUtNcElkTWFLZHhkTFRtUno5?=
 =?utf-8?B?Sis5akJTZzN5cksxdnJWMUUxYWplL0grUWdvTW9oQm5jVUlXb0RzY3BDVzNQ?=
 =?utf-8?B?Slg4cHBmTzJyTUxXeStxcEJ3MXhyMlFMc0dyTGxJUzZVdVIzSHB0RzVIQStj?=
 =?utf-8?B?Y1lGNlpiV05RUXArRCs1Nm5QWEdQTUlWNWJadjlQZ3ZxdkJKYVBVNjM1cDZT?=
 =?utf-8?B?cUtjb2tObkoxZ1NZcTRqZ0NxeURqR0VxTGFGUHdTSVQ5TjBvVTMvUzhuZFJY?=
 =?utf-8?B?aW9UOStOUEt3SDFFMU9hUEthdGtpQnhmMmhSUkhIU1NlTktFOTlhR09EeUpw?=
 =?utf-8?B?Rm1haTZ5Skt0SGsydlo5Sm8yQmJIMlM4R2lvcWx3NEJ4SkJBaHc0MVdkRHRQ?=
 =?utf-8?B?ZXdVTVNQYVZNZDVQT1RGNFo0QzZmcGZQY2s4akphMnZKaE1wMm1TcU15RFRI?=
 =?utf-8?B?a2kxSWxlRGlZVGcwbDRiL2owZGdIVS9WMmNhOGdQSHpjTGtaN2ZIZjJQSnE2?=
 =?utf-8?B?d1F1NVl2MVplcmNIYWlRbURlQzRUQWhSbEhWM25NUUljditOdXhIbDgwZWVy?=
 =?utf-8?B?RGFCcGNlZldUYkh3MDRkakhlNk1WSCszWlpkNEJad0pjR3pRTGhWNlN2OEFi?=
 =?utf-8?B?ak1CeUkrdnR5VDEwVG5WTG1hU2Q5MnVac1pyRWpRLzBHQzZTbUh6RmRMN1Ew?=
 =?utf-8?B?bGNPWnIvY3JDcGI1TTFNdlFlN2Z2cXhLN2ZLaGhZdDhnOXpmZWdtSE9EaEpW?=
 =?utf-8?B?Um95a3FGcTQramM2TWduQnI2dnluUjR1OUpNL0Qyd3k0cjlPWjFpK1dMUVRU?=
 =?utf-8?B?WEYrc2xsUHhnVmZvK1pISTZveHZiTzNHdGZER09uS09CZFBVNmE5M3M2bUli?=
 =?utf-8?B?Nk0rWk1vTFgza1BvMnE5Z2tGMWJYMTFYbW1DM3RVSUhsRnpIRDFkaExQVm1p?=
 =?utf-8?B?alJqS1R1czlPTWI4bk82VDNCVDVyRTZETzQ4Zkw3Qk9wUEJLSlNIU2pCcXJL?=
 =?utf-8?B?N0J1d3l4bis2MnlkejJha1NTQmtGVzY2emhTVzFoUXVYWUlIbW5QZHpLM1lJ?=
 =?utf-8?B?MHRGcFEwVEd6Y09WNHFUWWdPbFRCc0xJMjgzeE9ZSVNKWnZrMGhNV0dLODRF?=
 =?utf-8?B?b3RrVE5seVlwMDRxb3FpcFlFTVZGYWN0dUdydmJ1b3BHRHdLaEZpaS85STUv?=
 =?utf-8?B?UkdHMVJVbGdRSW1qdGQxOGZSWEVPS3Mwa2hDNHk1aEZBUi9oVm5saTNIRWtJ?=
 =?utf-8?B?cFgrSWxuV2VKdzZnOE11NGIyM3l5ZEJVQm93dkY1UWJydVhqWGNMM3BzUWRK?=
 =?utf-8?B?SHBTemNnMldzOXJqcHREbHpJZC9TdEJZZUMydWN3RTE5U3Z5MmQ0YjBIU1hF?=
 =?utf-8?B?QTU0RCtiUnVnYXNDbzkvWllCUUF6akw0cndmZkJHY1RJOFJ4YTJkazRuT0p2?=
 =?utf-8?B?REJDTmVLR2JJeHc0ZWpTY1VrMTVubFZYVUcweldVNlN3WjZGQm80OFZiL0Vm?=
 =?utf-8?B?by9WVnVOK1QvZUFoU241YTlhRzN4andXcUluRnVpa0lMYy9keUNsNnowcVkz?=
 =?utf-8?B?V2JDVzFWL3Z3TEpZUkhTdXVmOFl4d1ErZmVtckQ3b0ZucHhyT25UVHFMZ3JO?=
 =?utf-8?B?elBWSm1jcGUySUdBb3ZtbzllcTNYSmJjVGlHcGdUcEdGQjMyL1M2RTBLaXhi?=
 =?utf-8?B?UG1kVmNzRm1zOWl2WVFWZENxSGYyL3pkMzF3SUgyQWowWWlmTm1ld2w2WEJx?=
 =?utf-8?Q?cD/N9+78K+XtjC11M5?=
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
X-Exchange-RoutingPolicyChecked: jw2P42IhJuG1J0qYipvvWjkst4by3qBJwr4uNK/m8f5Za0QcIDdVMIMcWgKOduP9ic5sSXf7lgyBRlF/X9hgQYuquHxgHBOtmlGFbqn75TjXKRECV/ILjcwzGr22Z95nZ7bD5boxN0IAMrZP8dH042BgQkRQ0DDLaYwFHTQLdG9cTjxc9YcTrjDRN5h+OYDmUo9Pmh6JgL1Zl+HS5XClmgguM4fKSG/4ZtjEnkQUeF7sXFlHtUBZARaNHj8xDxsnaO38z/KtkOS5dUbMym9TwFy1SZilpQfPy5Nc8NadH/mZZ7KsBHHrwDMed3xZF8q7M/yCuQeutiWZcYnld5qAeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB619106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd036b4-548a-482c-0d95-08df3f51eea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:42:03.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +laenzPARQaP9gdmTRnfA6wtYUPHV+eQS7J6+3ZH+HyxLu0HPY4Fe7hfK9SAX3ggN8x278u5tgAI7VBYHD6BcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com

SSBjaGVja2VkIGluY2x1ZGUvZHJtL2ludGVsL3hlX3BjaWlkcy5oIGluIExpbnV4IDYuMTIuIFRo
ZSBoaWdoZXN0IFhlIGdlbmVyYXRpb24gZGVmaW5lZCB0aGVyZSBpcyBYZTIsIHRoZSBwYXRjaCBp
cyBmb3IgWGUzLCBzbyB0aGUgcGF0Y2ggaXMgbm90IG5lZWRlZC4NCg0KVGhhbmtzLA0KSmlhDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzaGEgTGV2aW4gPHNhc2hh
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgNywgMjAyNiAyOjE2IEFN
DQo+IFRvOiBZYW8sIEppYSA8amlhLnlhb0BpbnRlbC5jb20+OyBNdW4sIEd3YW4tZ3llb25nIDxn
d2FuLQ0KPiBneWVvbmcubXVuQGludGVsLmNvbT47IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVs
ZEBpbnRlbC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IEZB
SUxFRDogcGF0Y2ggIltQQVRDSF0gZHJtL3hlL2d1Y19hZHM6IGFsbG9jYXRlIFVNIHF1ZXVlcyBp
bg0KPiBWUkFNIG9uIGRHRlgiIGZhaWxlZCB0byBhcHBseSB0byA2LjEyLXN0YWJsZSB0cmVlDQo+
IA0KPiBUaGUgcGF0Y2ggYmVsb3cgZG9lcyBub3QgYXBwbHkgdG8gdGhlIDYuMTItc3RhYmxlIHRy
ZWUuDQo+IElmIHNvbWVvbmUgd2FudHMgaXQgYXBwbGllZCB0aGVyZSwgb3IgdG8gYW55IG90aGVy
IHN0YWJsZSBvciBsb25ndGVybSB0cmVlLA0KPiB0aGVuIHBsZWFzZSBlbWFpbCB0aGUgYmFja3Bv
cnQsIGluY2x1ZGluZyB0aGUgb3JpZ2luYWwgZ2l0IGNvbW1pdCBpZCB0bw0KPiA8c3RhYmxlQHZn
ZXIua2VybmVsLm9yZz4uDQo+IA0KPiBUbyByZXByb2R1Y2UgdGhlIGNvbmZsaWN0IGFuZCByZXN1
Ym1pdCwgeW91IG1heSB1c2UgdGhlIGZvbGxvd2luZyBjb21tYW5kczoNCj4gDQo+IGdpdCBmZXRj
aCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
bGludXguZ2l0Lw0KPiBsaW51eC02LjEyLnkgZ2l0IGNoZWNrb3V0IEZFVENIX0hFQUQgZ2l0IGNo
ZXJyeS1waWNrIC14DQo+IGFjZTA3NmVmMGE4NTRhYjU5NDBiYWNjNTM5YmY2NmFmZDYxZDExOGMN
Cj4gIyA8cmVzb2x2ZSBjb25mbGljdHMsIGJ1aWxkLCB0ZXN0LCBldGMuPiBnaXQgY29tbWl0IC1z
IGdpdCBzZW5kLWVtYWlsIC0tdG8NCj4gJzxzdGFibGVAdmdlci5rZXJuZWwub3JnPicgLS1pbi1y
ZXBseS10byAnMjAyNjExMDcwNTE2MjEtZmFpbGVkLTYuMTItDQo+IGFjZTA3NmVmMGE4NUBrZXJu
ZWwub3JnJyAtLXN1YmplY3QtcHJlZml4ICdQQVRDSCA2LjEyLnknICdIRUFEXi4uJw0KPiANCj4g
VGhhbmtzLA0KPiBTYXNoYQ0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tIG9yaWdpbmFsIGNvbW1p
dCBpbiBMaW51cydzIHRyZWUgLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBGcm9tIGFjZTA3NmVm
MGE4NTRhYjU5NDBiYWNjNTM5YmY2NmFmZDYxZDExOGMgTW9uIFNlcCAxNyAwMDowMDowMA0KPiAy
MDAxDQo+IEZyb206IEppYSBZYW8gPGppYS55YW9AaW50ZWwuY29tPg0KPiBEYXRlOiBUdWUsIDQg
QXVnIDIwMjYgMTY6NTA6NTYgKzAwMDANCj4gU3ViamVjdDogW1BBVENIXSBkcm0veGUvZ3VjX2Fk
czogYWxsb2NhdGUgVU0gcXVldWVzIGluIFZSQU0gb24gZEdGWA0KPiANCj4gT24gaUdQVSwgdGhl
IFVNIHF1ZXVlIEJPIGlzIGFsbG9jYXRlZCBpbiBzeXN0ZW0gbWVtb3J5LiBPbiBkR0ZYLCB0aGUg
Qk8NCj4gd2FzIHByZXZpb3VzbHkgY3JlYXRlZCBpbiBzeXN0ZW0gbWVtb3J5IGFuZCBsYXRlciBy
ZWFsbG9jYXRlZCBpbg0KPiB4ZV9ndWNfcmVhbGxvY19wb3N0X2h3Y29uZmlnKCkuICBBbGxvY2F0
ZSB0aGUgVU0gcXVldWUgQk8gZGlyZWN0bHkgaW4gVlJBTQ0KPiBvbiBkR0ZYLCB3aGVyZSBpdCBp
cyB1bHRpbWF0ZWx5IHJlcXVpcmVkLg0KPiANCj4gRml4ZXM6IDljNTdiYzA4NjUyYSAoImRybS94
ZS9sbmw6IERyb3AgZm9yY2VfcHJvYmUgcmVxdWlyZW1lbnQiKQ0KPiBDYzogR3dhbi1neWVvbmcg
TXVuIDxnd2FuLWd5ZW9uZy5tdW5AaW50ZWwuY29tPg0KPiBDYzogTWF0dGhldyBBdWxkIDxtYXR0
aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjYu
MTIrDQo+IFNpZ25lZC1vZmYtYnk6IEppYSBZYW8gPGppYS55YW9AaW50ZWwuY29tPg0KPiBSZXZp
ZXdlZC1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcuYXVsZEBpbnRlbC5jb20+DQo+IExpbms6IGh0
dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDgwNDE2NTA1Ny4xMjk1MjktMy0NCj4gamlhLnlh
b0BpbnRlbC5jb20NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjLmMgICAgIHwg
NiAtLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfYWRzLmMgfCA4ICsrKysrLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjLmMgYi9kcml2ZXJzL2dw
dS9kcm0veGUveGVfZ3VjLmMgaW5kZXgNCj4gNGYxMzJiZjg1MzlkYS4uNDI4NmJkMDVjNjg2MSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Yy5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS94ZS94ZV9ndWMuYw0KPiBAQCAtNzMyLDEyICs3MzIsNiBAQCBzdGF0aWMgaW50
IHhlX2d1Y19yZWFsbG9jX3Bvc3RfaHdjb25maWcoc3RydWN0DQo+IHhlX2d1YyAqZ3VjKQ0KPiAg
CWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiAtCWlmIChndWMtPmFkcy51bV9xdWV1
ZV9ibykgew0KPiAtCQlyZXQgPSB4ZV9tYW5hZ2VkX2JvX3JlaW5pdF9pbl92cmFtKHhlLCB0aWxl
LCAmZ3VjLQ0KPiA+YWRzLnVtX3F1ZXVlX2JvKTsNCj4gLQkJaWYgKHJldCkNCj4gLQkJCXJldHVy
biByZXQ7DQo+IC0JfQ0KPiAtDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS94
ZS94ZV9ndWNfYWRzLmMgaW5kZXggZjhjNjc5Y2VmMDAzOS4uNzc0MjlmZjRkMmE5YQ0KPiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2Fkcy5jDQo+IEBAIC00NDUsMTUgKzQ0NSwxNyBAQCBpbnQg
eGVfZ3VjX2Fkc19pbml0KHN0cnVjdCB4ZV9ndWNfYWRzICphZHMpDQo+ICAJCS8qDQo+ICAJCSAq
IEFsbG9jYXRlIGEgc2VwYXJhdGUgQk8gZm9yIHRoZSBIVyBmYXVsdCByaW5nIChVTSBxdWV1ZXMp
Lg0KPiAgCQkgKg0KPiAtCQkgKiBSb3VuZCB0aGUgc2l6ZSB1cCB0byB0aGUgbmV4dCBwb3dlciBv
ZiB0d28gc28gdGhhdA0KPiArCQkgKiBSb3VuZCB0aGUgc2l6ZSB1cCB0byB0aGUgbmV4dCBwb3dl
ciBvZiB0d28gc28gdGhhdCBvbiBpR1BVDQo+ICAJCSAqIChzeXN0ZW0gbWVtb3J5LCBubyBJT01N
VSkgdGhlIFRUTSBwb29sIGlzc3VlcyBhIHNpbmdsZQ0KPiAgCQkgKiBhbGxvY19wYWdlcyhvcmRl
cj1OKSBjYWxsLCBtYXhpbWlzaW5nIHRoZSBjaGFuY2Ugb2YgZ2V0dGluZw0KPiAgCQkgKiBhIHBo
eXNpY2FsbHkgY29udGlndW91cyBibG9jay4gIEd1QyByZXF1aXJlcyBjb250aWd1b3VzDQo+IERQ
QS4NCj4gIAkJICovDQo+IC0JCXNpemVfdCB1bV9zaXplID0NCj4gcm91bmR1cF9wb3dfb2ZfdHdv
KEdVQ19VTV9RVUVVRV9TSVpFICoNCj4gKwkJc2l6ZV90IHVtX3NpemUgPSBJU19ER0ZYKHhlKSA/
DQo+ICsJCQkJIEdVQ19VTV9RVUVVRV9TSVpFICoNCj4gR1VDX1VNX0hXX1FVRVVFX01BWCA6DQo+
ICsNCj4gcm91bmR1cF9wb3dfb2ZfdHdvKEdVQ19VTV9RVUVVRV9TSVpFICoNCj4gDQo+IEdVQ19V
TV9IV19RVUVVRV9NQVgpOw0KPiANCj4gLQkJdTMyIHVtX2ZsYWdzID0gWEVfQk9fRkxBR19TWVNU
RU0gfA0KPiArCQl1MzIgdW1fZmxhZ3MgPSBYRV9CT19GTEFHX1ZSQU1fSUZfREdGWCh0aWxlKSB8
DQo+ICAJCQkgICAgICAgWEVfQk9fRkxBR19HR1RUIHwNCj4gIAkJCSAgICAgICBYRV9CT19GTEFH
X0dHVFRfSU5WQUxJREFURSB8DQo+ICAJCQkgICAgICAgWEVfQk9fRkxBR19QSU5ORURfTk9SRVNU
T1JFOw0KPiAtLQ0KPiAyLjUzLjANCj4gDQo+IA0KPiANCg0K
