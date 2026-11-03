Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793675974;
	b=wPZnA6Lm4Y/QLJePu4NuMfiDfQk3SWOU4IHwiNb0mSMeguJO/T32JYNy2eUDxso2eYIC
	 d6vVyiJKOw0wJUQtdNEylC9TZTCHJOuf41Gs1hXk0XkefXHRmus4xFIMg5kGePrQDkI/X
	 tik36NSdrbSbrzduRTX8Xd3okzvpyFq2B4X4oPhskOUNoh3oDfhRm/C3bRBBqp0elTase
	 NwECpw5wl8VSAMREi1higSzaZIfDU4sAcPVywDWtxHOZUSXmsnk30yZvyAVcEDhjcOlsf
	 ZMAyYV89F/ljDlK2pEzqnk7LZJ1GC3dtBb4fVXx6xoRwUsm6/qhl5++nZq1FL4xZ6Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675974;
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
	bh=EzlFOft1IugyFc3O7AAc1tr1+uwzZGuW33+lJCS41Jg=;
	b=mhqbi6269C5wFS9PaZ4uul+VIBaERgb8sJgfuIK8fP8Anpng7a3AvsiBDmZNFH4J8Xx4
	 XRgQZzI94LRqL7ZtuP0kTmU4HkpG94QGz34ZFjlsciBW/Cj3SL/W1agfXDg9RKiNKN+eO
	 Ii9q5InAyBAhPKYG2yiV5XDbGbhCcG4dJAiSx445LlT8QFffDZY7kkHlbpJi7PT77FgA6
	 TbCJxz4FrJUsgD6MBmmAyrcI+gesbaO5ksf3dCyehTKkKdAJg/NTwoP9eZDw3pNxobLQS
	 ruIQpCJFD2lxded+2zxFmy8wVYGbgdgVkEe6Qsvru3UYtBjMv91PZZ2xrpMoURTZ0rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FhQDephA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A4606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 03:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08A4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FhQDephA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793675972; x=1825211972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EzlFOft1IugyFc3O7AAc1tr1+uwzZGuW33+lJCS41Jg=;
  b=FhQDephA8HuNTU8Wf0SgiAIsZn0L8Y64/nlLwfGlchOquIRcDGSiBIAU
   W6tXjSlKcqckdCcJkU7pun5ZZu7+XgnXsY31K4Spz4HrN4OAKroIQf12m
   DQekLHZK4CmiZ5YkeW+UBR1A4ms9sLQS6kePjPiU35CKusQuD73Is6JsW
   rqhWGesC8MiqeJvEcbyTEeb2xO8r0G7uPB/x/QnUrCC7mNMMr7cXY3Khh
   kZGQze4wEcCkbYx78uu8Awzm9Gtc24oMQl+zdi89co6kOSw/6hqrdYKbO
   gPCXqpIe2SIw1jjpKKsE58zVLQxTE2Gx5XEoDkNS0wR14GenO0oFt1UuT
   Q==;
X-CSE-ConnectionGUID: 9JNpLjwxRo+YNgn5+AuZ/A==
X-CSE-MsgGUID: fraJDa4GSTGz39aqeL3XfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2416129"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2416129"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 19:19:32 -0800
X-CSE-ConnectionGUID: biJc929lSyOzbWblUIgYDg==
X-CSE-MsgGUID: YOroTsUnTtuzGqaccAdHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6624792"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 19:19:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 19:19:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 19:19:30 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 19:19:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCIKJyJ/WGYLDT5kGWRO/ap1hcEfYPhwBFftZARLQcR1Cq/0oASKUjg4vIeARPZq94bphoY1+63O8LlhnR0SClTXKMnoQsVJOuyRO860dQjW1+fO0lOLuu384ynR9GX5+01tXGn7eW6js6fbRvRCQYVUJWFqHphGvN2w7bfwWflZ40+5mPUk+2xp7b7DvEIqmYBSR0X7q3rLwqufWdp9PoHRwHXJxFSVPF95ATkhRR6mFZfCcW5n++V/cw6z1sDuQqkSMR9BS7rYEiBeIm6tBIzYWa6k/bGzwr+E+gVSAYWxjyg2bmSfIeBStzLJTRgYzrq4yFqbsAXxtDtFCkWLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzlFOft1IugyFc3O7AAc1tr1+uwzZGuW33+lJCS41Jg=;
 b=yUOTCOJkJrpzk3CyVXhIZ+8e0b5wXYEEfcIXbEpkqeYGF4fSoj0RMS+ly+twWOQYiYHEkWoCQSAN2uychKHKmxDMBgcOkoo+GFU1z+dwoqVQl2+CaWeyL5h87ubYacor8D5cqr9EmJC1eW9EXc1QEj9cWTzE5DgrdK6iuOSKAqksgHXVj4rUHrG4s9nOzqHAeiMi+jXkHDZkibn9nQ++btF0Hs5HDV9tuRq4NzPPg5GQHS6qA1vCaJRpQUen2uFqr2S9HuDQNyXcR1sLM8Hq5TsLrCCTDgybpuglqJRXqqZMNucVTX/T9p5kSt/uOm7E8UD91gwkPCH0qVt42Dvu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by IA0PR11MB7695.namprd11.prod.outlook.com
 (2603:10b6:208:400::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:19:23 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:19:21 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 01/10] drm/i915: Disable port sync if VRR is enabled
Thread-Topic: [PATCH 01/10] drm/i915: Disable port sync if VRR is enabled
Thread-Index: AQHdaJIUIAMjnvGYHUOO7JzADYEOdLcaghZA
Date: Tue, 3 Nov 2026 03:19:21 +0000
Message-ID: <DS4PPFE901A304FD05565ABE33F79803F55E3692@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261030171327.29829-1-ville.syrjala@linux.intel.com>
 <20261030171327.29829-2-ville.syrjala@linux.intel.com>
In-Reply-To: <20261030171327.29829-2-ville.syrjala@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|IA0PR11MB7695:EE_
x-ms-office365-filtering-correlation-id: 796e9487-93e9-4ea4-c65c-08df3959411d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|261102123227099003|56012099006|22082099003|3023799007|261009223027099003|38070700021|261021121427099003|4143699003|11063799006|5023799004|10067099003|261026121527099003;
x-microsoft-antispam-message-info: uG05SkMGQvC5D5zAwb2Yt7zEPDxaSQL9fsazlOd/gLYbvPfrIkPBnWH9ZJtC9PR0HYKBOSgmdJEBx3gcVa9LmI84oL1rxMtlFImH7cv3PKs8FGOEsYfLF6UJsSFCKUSbdFda8bdmdpH/JWa56OFa+7kQ9NnNZwrYsb++JKPEPsEfQ7/riE0py6jXQLdhv+h4HTW82b9QRgPW0fkr+6g5ALrSzuTqxFkDtcBk9/UwO40Et/eIYDNOd7r8cHjuGfGP/I6Bzos7BioNmtfNWeaQe08JfZ0JuHp/vqtZAdiqztrh4doXVMj2GI0wYHlKlX+kjfZO2egOpUlz0GYjL6+QD48CfkyouMuTkQmgKRUmVHhikMyZ4YLkoKJmht1ujCQBexkfTkAmyRwDOGaJ2kXCKdsdhIt30jmpCNukLzUYWWUwfFd0m3838ooAonOStYVNEFElb2nACoXMDqNhiRwI/vMatQ45Ycx/+ihdpc81u2hUcKDCM1QI49+muvo3iEH7TJmP7kiCNMXjmrMlsnCDSB70Iqcmort/lWbINeM968J6TWNFIQ1wRcHnxtRH79MIlVD9ckkFDWwE5mtHjMNkRKjkin+0CCGWwqYomqXQDeX4EMSOsV0xIWwqiPRlUspObutFGSoY9OgNwuUX7a9NPiOgNRvez6+xTAwCHaqGB5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(261102123227099003)(56012099006)(22082099003)(3023799007)(261009223027099003)(38070700021)(261021121427099003)(4143699003)(11063799006)(5023799004)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklnY05WRTRDTDVvSWJpTmF5RytUQ090VkVQUDQ1ZDMvak1SZndRSnoxcWJL?=
 =?utf-8?B?Z2hBYjk1ZDNnMEM5UkhibUFNbWdxYXVQbzl2Q2NqQy9IVWVxOVpVdU9VSnE2?=
 =?utf-8?B?SitUanlNRUNhaU9JZmNpL2NSNng2MFBQUkV0b2NuVWFzT2pzSVdUbjFETTBl?=
 =?utf-8?B?Qm5sVWwxVnJpVGlpSndBOGRqVlI1Rk9QdmQ4QktIQTd2V0RUallsQkJRMElj?=
 =?utf-8?B?WCtxWnJQY1lzTHFzOW1lOCtNNzNxR1Z4a0ZKMkJJeUVOZEVhY0tnUng2aWRH?=
 =?utf-8?B?MXNYYXBnays1WDVVdTB6bjA3UEJLOEdtTU9XajhrYmVhQndteWtNRk42V3FM?=
 =?utf-8?B?czk3V0k3UTNnOUUwaVNNR3ZGVDhDOElNS3FZMXRnZzc4K2dwUVgxa2FWa3lJ?=
 =?utf-8?B?VUF1ZWJ6Y2ZOeE5UQ2lmdnlmRXNDYjNETksyeDVHVEhTczNEU3JJUFRUV2VX?=
 =?utf-8?B?WFhBemsySUtCMnBCY3hJdk0zTjF4M25DNHdqejg1aWVFSTFVRXMvK3RvS29r?=
 =?utf-8?B?ZjBaSVVmdkRiNUlOTXV0SEwrZFAxMUNJOVBaT2c0ZFRlR1QyM2phSHJqMHlL?=
 =?utf-8?B?MWwvckswSEVuNmxJYmxEUXFlTUZ0Zk5rTDhjKzNJQnMrMHg2Q0w3Q3FGdCtT?=
 =?utf-8?B?YVlNdVVGRnh2aStLblFVSllHQmxNRndOOHcvZGtwMnBlZDJkS1FVWnVEN0Yy?=
 =?utf-8?B?ekZkdnlpanR4WlZIL0dhRjBHR1ZWQkd6V1lqZmppUzFOOVhCWUlRRVBONHNT?=
 =?utf-8?B?akhIWFEwTkMzUUVON0xrWlcyaVNnbVNPOTRwTysvbys2MGp0c2xMSmRLWkFX?=
 =?utf-8?B?UXZ1bFVTSVlhenZwRVNmZmUrbE4zTUkvNGxTdklNMFpRa24zTy83V245ZDUx?=
 =?utf-8?B?THpIQVJlNm9rdTJnRkkrZ0Z0MTUvc0k5ZzYrZGtvZjdTSVVCR1hkdjdUcHg4?=
 =?utf-8?B?bTdtU1IxT2ZESEpYV0F6NkhnMUQxcnAzTytFeEhqSkhKNkdiQko2WFJtQzBJ?=
 =?utf-8?B?MjRndU5hbHFjWXlPRDBjdzJjdXFhZy9vMzBOaXpHd2JNOWorUTZFc2ZqeWZY?=
 =?utf-8?B?S0xyS1VIMjJBQnlEOEFTZTIyVXROdGlIVEZsbUxkR1gyenBhWktBaFphaGMx?=
 =?utf-8?B?b2xkcXI5VkNUWEZuaUdYSk1PSXJ3c0dvR2FOR1dJamNvZ040SzVMb2RNODJD?=
 =?utf-8?B?N01JbzFmZWxsWGRqcGtNaFBZaXRteWF6SjJQdWlvK2NvVC9RM1VmdWpHK1RW?=
 =?utf-8?B?bi9WNEw3eVBHNEIzZXNoWXRqV2V4MlVrSzQ1WTRxdWo1WERkVTkzeFBLaXha?=
 =?utf-8?B?WWNTZndTamQ2MHlWdDl3YVQ2RExHUEhzNEpXZjRNbmFIMXVLOUZUcWxGOUJM?=
 =?utf-8?B?WHg5Skg0dWlSYkg5ZU54N2pkaTA3c2dQcVlZS3hRbjd2aFh5WjhWTnlNZitx?=
 =?utf-8?B?eEtUVFhubVFhU3BmYzFMeUJrZjNDcVZIMWRYQXlqK0txWTA2N2s2dVpreWRs?=
 =?utf-8?B?K25MV2VTYnZUYVlla1d6V1VjaGNEZVRNaXN2S2ljcWlab1RHZFhYRjRnVXJK?=
 =?utf-8?B?dG1HckNUbzd3QzJkdTNVNDh2dU1ObXdjcnpUbjRyWDlpYkJHaE1ST0gzYTlG?=
 =?utf-8?B?djZxNzF5M2ZLMy9Ibk9ldHU4Mmc0YXo4Q3VZbURCVGRMVGZ5VHptdnl1SzRE?=
 =?utf-8?B?cVRxNmpyLzhzWm9Md0tRN0JBYzJVTisyS3BwVzcvYzNVOFdvekwweDZWaWND?=
 =?utf-8?B?aFFhWlYzNGRZclJVbkR1TDBPRHVqZUpGQWcxQ3N5T2FYMDBkL3crSkdwN3dt?=
 =?utf-8?B?WHRvUjY2K2pRZUNkbHBWWFFqenJrOGlCeVM0WHJEaTFXdXdDVGFkdzBoY04z?=
 =?utf-8?B?SlpKcVJWQnF6YzM3ZFFDS1ZEcE5vWU9hMWp1NUo2SDRSQmFJdVpzQmFPTDF3?=
 =?utf-8?B?NWVpY0gyK0o2RW9BQ2o3RlFjbDI3WW1uN3M1SjZHcGg5UEc3YXBNSVo5VExU?=
 =?utf-8?B?K2kwRDdKRE9xa1JDMWtRZVlMQytBMVYwN05Ub1I2ZHU5VWVtNjR3cUZZN3V3?=
 =?utf-8?B?UzlBSTkyL3BVVGQrZUQreFFzTTl3cW1IdDRXbkNGRHhGK3JjMGxFZzlSZmll?=
 =?utf-8?B?YXRYKzZTVGZVOS9OSithQ2xZaWszbGlsTEVIOXVGU1EreWdoVW93QUhjSDdz?=
 =?utf-8?B?cFlwVjYxc3hjK2d2WmFkV094cFRIb3R4RGdDak4yMUNBMWNPR0FEKzFETXBn?=
 =?utf-8?B?d1BEaXhBend4TUE2TlZxVy9aeUVRdkVydE1vcGh6ZmFVekV3L2lGWlduZWxQ?=
 =?utf-8?B?dE5yWmxRelRYK0RLaHFpbmVVVnZkWTcyVm9QWUs1bTkwZWh5M2hRQT09?=
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
X-Exchange-RoutingPolicyChecked: F+1G9EJNiU1bRVykdoz78kUgOnMnbTBn51rmakQ4auWr8zq8tmH2LYZZs7pF0wn3FFUz4szs8m8gbuQUEOSwuEQk1zeHDCY0dWX9n1JqIhvYZuDuXlHbVQIejAvgZBVvwz+zGCDH480/eOlNyRW2jM0ykkOyLrirexGikQaMR2Z0Sd3K7BfyjcFYcoyIxjpGh5uczP31i0VBiyIuIwHYFcMoOthSImr128NJ0VvBAp8GrJlerBkVmI6DYoa9J5WZZRuox/ARFeUYLQfwVaTBu88THgAYuPjcM80MR+ptfP9fa2djiBRk4Hn7Xz46tdKyAjXmcZNDiuH5BVXXqamYvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e9487-93e9-4ea4-c65c-08df3959411d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 03:19:21.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yj98C4op1723eukeuc4M6vMV8/EOpDPzZIe5T3u4wxWVygaWmYDniHGrUKev8YZ6YHXiUSi7OjEXMooOUBDRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggMDEvMTBdIGRybS9pOTE1OiBEaXNhYmxlIHBvcnQgc3luYyBpZiBW
UlIgaXMgZW5hYmxlZA0KPiANCj4gRnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxh
QGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFVzaW5nIGJvdGggVlJSIGFuZCBwb3J0IHN5bmMgdG9n
ZXRoZXIgd291bGQgcmVxdWlyZSBleHRyYSB3b3JrLCB3aGljaCB3ZQ0KPiBkb24ndCBkby4gVHJ5
aW5nIHRoaXMgd2l0aCB0aGUgY3VycmVudCBjb2RlIHdpbGwgYW5nZXIgdGhlIGhhcmR3YXJlLiBE
aXNhYmxlIHBvcnQNCj4gc3luYyBpZiBWUlIgaXMgZW5hYmxlZC4NCj4gDQo+IFRoaXMgd2lsbCBv
ZiBjb3Vyc2UgYWxsb3cgdGhlIHByZXZpb3VzbHkgc3luY2VkIG91dHB1dHMgdG8gZ28gb3V0IG9m
IHN5bmMuIEl0IHdvdWxkDQo+IHByb2JhYmx5IG1ha2UgbW9yZSBzZW5zZSB0byByZWplY3QgVlJS
IGluc3RlYWQgd2hlbiBwb3J0IHN5bmMgaXMgdXNlZCwgYnV0DQo+IHRoYXQncyBub3QgcG9zc2li
bGUgcmlnaHQgbm93IGJlY2F1c2UgVlJSIHN0YXRlIGlzIGNvbXB1dGVkIGZyb20NCj4gLmNvbXB1
dGVfY29uZmlnKCkgYW5kIHBvcnQgc3luYyBmcm9tIC5jb21wdXRlX2NvbmZpZ19sYXRlKCkuDQo+
IFNvIGxldCdzIHRha2UgdGhlIGVhc3kgd2F5IG91dCBmb3Igbm93LCB3aGljaCBhdCBsZWFzdCBr
ZWVwcyB0aGUgaGFyZHdhcmUgaGFwcHkuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KDQpTaW5jZSB0aGlzIGlzIGdvaW5nIHRvIHN0YWJsZSBkb2VzIHRoaXMgYWxzbyByZXF1aXJl
IGEgZml4ZXMNCg0KPiBTaWduZWQtb2ZmLWJ5OiBWaWxsZSBTeXJqw6Rsw6QgPHZpbGxlLnN5cmph
bGFAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZGRpLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
ZGRpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+IGlu
ZGV4IGEwYWZmMDg3ZmFmYS4uZWQ3ZDRjYmJmYjVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RkaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfZGRpLmMNCj4gQEAgLTQ1OTksOSArNDU5OSwxMiBAQCBzdGF0aWMg
Ym9vbCBjcnRjc19wb3J0X3N5bmNfY29tcGF0aWJsZShjb25zdA0KPiBzdHJ1Y3QgaW50ZWxfY3J0
Y19zdGF0ZSAqY3J0Y19zdGF0ZQ0KPiAgCS8qDQo+ICAJICogRklYTUUgdGhlIG1vZGVzZXQgc2Vx
dWVuY2UgaXMgY3VycmVudGx5IHdyb25nIGFuZA0KPiAgCSAqIGNhbid0IGRlYWwgd2l0aCBqb2lu
ZXIgKyBwb3J0IHN5bmMgYXQgdGhlIHNhbWUgdGltZS4NCj4gKwkgKg0KPiArCSAqIFRPRE8gVlJS
ICsgcG9ydCBzeW5jIG5lZWRzIHNwZWNpYWwgaGFuZGxpbmcNCj4gIAkgKi8NCj4gIAlyZXR1cm4g
Y3J0Y19zdGF0ZTEtPmh3LmFjdGl2ZSAmJiBjcnRjX3N0YXRlMi0+aHcuYWN0aXZlICYmDQo+ICAJ
CSFjcnRjX3N0YXRlMS0+am9pbmVyX3BpcGVzICYmICFjcnRjX3N0YXRlMi0+am9pbmVyX3BpcGVz
ICYmDQo+ICsJCSFjcnRjX3N0YXRlMS0+dnJyLmVuYWJsZSAmJiAhY3J0Y19zdGF0ZTItPnZyci5l
bmFibGUgJiYNCj4gIAkJY3J0Y19zdGF0ZTEtPm91dHB1dF90eXBlcyA9PSBjcnRjX3N0YXRlMi0+
b3V0cHV0X3R5cGVzICYmDQo+ICAJCWNydGNfc3RhdGUxLT5vdXRwdXRfZm9ybWF0ID09IGNydGNf
c3RhdGUyLT5vdXRwdXRfZm9ybWF0ICYmDQo+ICAJCWNydGNfc3RhdGUxLT5sYW5lX2NvdW50ID09
IGNydGNfc3RhdGUyLT5sYW5lX2NvdW50ICYmDQoNCkkgcmVtZW1iZXIgdGhlcmUgd2FzIGEgaXNz
dWUgb24gUFRMIHdpdGggNWsgZGlzcGxheXMgdGhhdCB1c2VkIHRpbGVkIGRpc3BsYXkgdG8gc2hv
dyB0aGUgc2FtZSBzY3JlZW4gd2hpY2ggY2F1c2VkIHBvcnQgc3luYyBkaXNhYmxlIA0KVG8gZGlz
cGxheSBjb250ZW50IGEgbGl0dGxlIHNoaWZ0ZWQuDQpodHRwczovL2dpdGxhYi5mcmVlZGVza3Rv
cC5vcmcvZHJtL3hlL2tlcm5lbC8tL3dvcmtfaXRlbXMvODk5MQ0KDQpSZWdhcmRzLA0KU3VyYWog
S2FuZHBhbA0KDQo+IC0tDQo+IDIuNTUuMA0KDQo=
