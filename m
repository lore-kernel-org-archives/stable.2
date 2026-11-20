Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795168719;
	b=lxkGZXEjzneBnnowWhaEwx6/W8fBnntLm8qriGSDzbykwtWrFS7RiZH/lZibsINzBIN1
	 Z0r1gKIqww25BM+cc3rxjyR8Gm5VFdskJIdII2ltboEdY94qIzYwJYqYBk/LzUdCFaC4f
	 btIXTfhEot2QxMlU9/FqcHkt8lA10YS3UrpWoumTG3s5RXMJbPsAzl9vtUDgyewWl0w1r
	 DIW5VgDOZK2P6BULWUYjkNVtdzmvW3/YLaWJ193lTDEFtO+1h5AKsQlLTnQrbLQ2tAxyS
	 W4rROjImeBj+OmBSl5yAPKPLmW6HmAyH8/Sw6muRK1DY0XdOar59YH5rGw6F1y1jIHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168719;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=qdFWTnyZ9UUdjlwx9ZzktZC8UOTAHvzZBs5BCll0jno=;
	b=ee8pLNc+xqzMInl9jQHELwoJhDY7P/Cqxm3uYn7GC4Gls9b+uVhGeBwb3PZfeUYx866Y
	 KK28Obih4UmoCoCCK38eW02MxCkhgajNH9cHd75+9qZdfNi8wo/Cb0elyOCUvwjoiBs6I
	 bpwdad/ZsdXfW8XV2eOP4cbojd6OykAwJqWAtNbYHeX9KbqjnwevJY/2omTfkWYVDOp26
	 RGbH+X4GB3q4x12f6AXlt3RG6LZlpS0py6OgslXPfISXbuMcCpQXxxqkxXgqV81FP5Acn
	 ufdZi+nn8tyb34LoBulWXZUsHGwumqGAdgm6GGSpDk4kEE4AXNP+m6ItVg7Ji6IR00Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VNx8Iigg;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BaadZk6C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFF606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 09:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71AFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VNx8Iigg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BaadZk6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168719; x=1826704719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qdFWTnyZ9UUdjlwx9ZzktZC8UOTAHvzZBs5BCll0jno=;
  b=VNx8IiggiGP6rkKBytoiDROMTsKVCaG8SqQYu7FaN/HXaCFlX8kdtdCH
   VW0W5V9/6spCDltlNSrt/As95vx/5lnS4/gFTYDmx0un6w/flSTdY64Bf
   TRY/YPo3jjxYkBLTNZdwESMYZJnsIOh80gaauWx6CkevTDK/WNd9mk3IK
   sDsV3jS+doMt6ZWv2nQ7oJ4GXm2nbOLMbjj+G8xbzDqS9+Xiw3tWwKvj/
   NDnlq4wJpZOByheBx/D8/2/oFtN65Uh0krTHojA1qxEpU1asNnRuPGX7B
   KEpvp06j8xUxbuc2Bmd6gOQZ5F7wFSwilonyh6efUQiHlqAQOfgXnaSvP
   Q==;
X-CSE-ConnectionGUID: CPRm8WOgTNmmQgugxTibmw==
X-CSE-MsgGUID: vhWnd5ftRqejHn+Lk3G2Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3892014"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3892014"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:58:37 -0800
X-CSE-ConnectionGUID: qT+zE61hSUGRYkhW2t200w==
X-CSE-MsgGUID: qcAC42SaTxWQ5qL7l8J+dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="12658325"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:58:38 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 01:58:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 01:58:36 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 01:58:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQqaqC5lni7l6dvXj5wY4TfBIgKfpZyc2dUfR+U/hh2i4TfB/cbtCBX6pfXC8eWhZbsdzR44BQJt1N53j5tU1wZSX1z1I9oz5JhiJL93/oL9C9gyoknvhvwz1sG5JkXwgH/A5KRTsNyKUijnuJrma3scTuZpb6aZuFbYQGOJ1z935+wD9Y7jSU3/oEo1PJlwFSiYO2aDfSAyZ//TosLx7/cDTZvodbAdiVY5/puHg5lB8VKg6cZUqXqQSF2zlU4qYsqu5Du3g3RXUYlCyKsxAgLhNsvaV5duer72FRdtZieiUsvE5VGMk93iEJkPcn8i5+6S3GzKN7cTZp5Pn1Mj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdFWTnyZ9UUdjlwx9ZzktZC8UOTAHvzZBs5BCll0jno=;
 b=d2lVGtWjfFm6d97XoHlHSB7sKhXwxd68FWcXbQ9eeR94GP2rL2OIoR+FP6+RM20daIkyQjVnhC+nkY6ste7g5xM6hat3Q1tWywoMsbXb8fZmxRmPCNPvSdr4+mqbrOEC3hJUi8WHXXF0s+upKi8MzjrJXBhjsOqwfPatNQbBJL128uVEwQO+ccCC0Dbj1T3rBjJ76NDOpO22XhWBmy8Nu8sGeSf1MkvMgR3ktBZy9U3yWlizPKWcKW+sXcmfrol9q8qGTpzSUMyBnB52YmqD0W995fQi7El5/QumIAhAl35bZcR2+Z+kRAnixAK/E3iLN3enppOBOoNIK/oapkwFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdFWTnyZ9UUdjlwx9ZzktZC8UOTAHvzZBs5BCll0jno=;
 b=BaadZk6CJndgJJTLrAYI6CojgNZRr+CowvbSaZG0GuDqV2bD4CGEQTzgAf2Irk2Ff+zLGKJ25yGeoBAiBWGWxH5k+XAO9UZUxaxgMkUuY10x2dRRiQydjdmWnOZOsrTuloVqxAME0nMTMCxhXoxW8glubtMv3uHK9A3qHZFFF9k=
Received: from MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 09:58:32 +0000
Received: from MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1]) by MW4PR11MB6570.namprd11.prod.outlook.com
 ([fe80::63e8:6dc8:402b:36d1%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 09:58:32 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Nikula, Jani" <jani.nikula@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2 disable
 quirk
Thread-Topic: [PATCH] drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2
 disable quirk
Thread-Index: AQHdd0xUm2I56nFmikWZgsmC7xQxN7c2vKJA
Date: Fri, 20 Nov 2026 09:58:31 +0000
Message-ID: <MW4PR11MB65701C4E512D24A5B51B9AC2EF782@MW4PR11MB6570.namprd11.prod.outlook.com>
References: <20261118110220.77370-1-jouni.hogander@intel.com>
In-Reply-To: <20261118110220.77370-1-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6570:EE_|SN7PR11MB7044:EE_
x-ms-office365-filtering-correlation-id: 3912e312-bcd3-4e83-6e46-08df46ecd5a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|261102123227099003|261021121427099003|261009223027099003|10067099003|38070700021;
x-microsoft-antispam-message-info: rH3VN9PPxbu3K99ubC/hASR1wP/s1iJaVsfXwAwvQqJ/pk9fUn0FpTm/ApS2JInNB+sALBuwzj8toxhF/NR7tUTiryAM2ENv6/FetOI8lKeDEnt/1BH4MshqV3hfdHAUa6TGG5rsR6618iD0KmQG7ZtQhbdhENM0jJL+C7/oa/XN7aP7+I8om9X996INXHYayqDcaHhuMeXYxykZaCifyosPIvdkcP7Cu0hhcbhyGj1nllFVhY4TsUJthDxsnYMbJEAuWP+FSRENyIyPPrW1gQWKYZUiFIHqi0VUXOgFkgWu2wjmHMLAfTqjVEM17fcTgoOqBW/mnHatPROlHjntIBjuoc9ee2RG+T3CQ5li0tE+ShVteoCt3FhUeG44yAoQaN8NTa3ZRePKDLdwPj0gfR4ft0Trf4SzuCojPfsMJzE6Jf2uLUrROkXJ/OLSjuUNg9/txLJ9XII5efbttc/5giXt3F6L+9B29PIbqBhSc+fJNMrlwXK4L1lcfwPngkw3CrPmpbjCU8SxorQ5FdeCGhuX8HbuGCrJsfJZCiE5vCoJKRIQ07nolgJrxP8O0S/J1WO99SBSXJLWTerNZKANmAt/CdYRZBYhKFARfbmxvwnRsM7EvSOcsb/DWpgG0L+JeXH6WyrQiotpnpV7LKFN9Qa2RRWw4Oea+FjmKZNeN1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6570.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STI0dHYvbStQWTQ3TS8zU1RQVWdyUThySlZsUWJKNVVxaG94K0gyUmd2QnJH?=
 =?utf-8?B?UnhkM2VMeWpmNzhIc25iUXlHdXBnZ0lSaDJLeHQ4T3RLeFk3VEhWTis4Z2l3?=
 =?utf-8?B?ZmZnL1ZISHJuekFyMXJUWEhVNmhJdkZDMnEzRFN5aytrc1kxUXJUWUQvSkJs?=
 =?utf-8?B?SjBEcmFFMjVycEkvcG1tL1Y3MUJGdW02MU9ZU3BBaVdzNmZpVlFvbTdhUE54?=
 =?utf-8?B?L0V0QXlLajEwbk16RkFIR2lqYVpocDduRUhaTEEyZ2Q2UmxDdnY1WnN1N0U1?=
 =?utf-8?B?L0tlT1JDUXRmVE5yWXROeDdUSW5abHJLM3pJblpIYnk1cDdLNmFFVkkrVEI0?=
 =?utf-8?B?Z1M4U0x3Q01kQTFjTmlPWno4YUd1Yy9XczZpSVJKYzFJUU56aktYME1KN0pa?=
 =?utf-8?B?dk1PZXprK3BpVS9aUGt3TGVUbmo1Z0ZHZngrKzVkcFozUk1Nb082OXZKTFJL?=
 =?utf-8?B?cXpLUHlSSTR0cEpUU0UweU9WYXZOU0s1OTg2R2I1ZE5JS3JpOEFUQ1didVps?=
 =?utf-8?B?amJQSW1tbFo1MnhlRGU1b2xiMEkvdGZKNHhjSDRKQUJxMTdBaDBtUVQyZHFO?=
 =?utf-8?B?NWpTNTlNN3B2OTVyb0NOQzdXd0NpMzNwN09CWjZ6czErZ2FoeTE4d1ZPaGxQ?=
 =?utf-8?B?Mzc4azlmWkhQMjI0VXBOUGpOQk5qcWRXWWVJbCtsUG9pdDZJVXMzdG4xSnY0?=
 =?utf-8?B?cWZZcTRqVi9MV28rSVNxWXVDTDdRdVBPTGU5QlZTM1NCMUNwL24wSE9tT2NI?=
 =?utf-8?B?S0JpK1BMb2N4YytXMmQ4MnpjMUM4czVOS0J3OWtJRFBFcW92cWdXdnJzbW5v?=
 =?utf-8?B?M3JzWlZnTjg3UjhaZWRHQklJTkNFKzZhVUZtR00rc243b0NjVTlpd0RzZDZs?=
 =?utf-8?B?M1RtTFNGV3hESmR6dFBqUDNOaXQ1YkYzdHRValp3ZVRIcE9sUTRxMGFZamtX?=
 =?utf-8?B?U2U2amF1TUhjVTRtbmJscUNJSjVzU1pnb3h1OVpRYkNmZERvWEVROENPak1v?=
 =?utf-8?B?eDREK05rNFArTWs4YUFpUkNBRlFseEM0NktUd1F4OU9tVDF1d3V4WEx3UXpJ?=
 =?utf-8?B?T1ovL2FSdzB1UzU1ZjBQUGVvTmVKL3lQTUkwalhkMmpNa1VpRU1LNnlvYTZX?=
 =?utf-8?B?dmJUNURmNGFtem15b0VrclBlZW1wUU9obnZrSXJoMnJCWFlGZTJmRDdXN1Vr?=
 =?utf-8?B?bnc4b3ZOS3hOTVo3bUdod09JeUdNc0F2K2s3R2VUdzRsOVRrQjljS3F1MFc2?=
 =?utf-8?B?b3IxRzR6bG5ldmZFeHBpMGljNmpXWEp4K0xackM0Vk1DZ3NubTFDY25qdzM5?=
 =?utf-8?B?YVVOVnNxbGE3dHR5TWtHUE1ENmVaUWxOSHJMaHZ5UHlkYUo0ZFQ0SjZPcWMx?=
 =?utf-8?B?ZVY4QUNsZnBhVnd2TXBYcnFnNll6SlE1TnErcjBKOGpGVFF1a2VyM01XeG5N?=
 =?utf-8?B?TmUxSFFxL1ZZMEVpbDE1alQyYzR6TVl4UFJRcnZSd3RWTUNCRFFETmNHcW1M?=
 =?utf-8?B?aHUvMCt5NVphak1rQVBmMlBqR3JDWUUzQ2gxYjFhM1Rra0o2WUVTY1hOcCtk?=
 =?utf-8?B?VTVPaUY1em9aMDQwK2xpV1NFUWV2QWlyUCs2Ynh3ejhmTUF6OHFmWjJZTjFM?=
 =?utf-8?B?cUs5ZmtNVGFIVlZ0aVdJNGZBa1YxWHJTQnY0bzM3WHZyZmxOU1FVNXI1M0dq?=
 =?utf-8?B?RFdTNDJKWjhoUWFGZlQrTFArdWZYdUlsaXpQVGJ5OE9ISnhYSHRMWTBpdWxO?=
 =?utf-8?B?cE9yU3VHWlh2QzQrRWZVN0RaU2RERzBhMTBLenZZMElFMTdhL0VYOE1IdGpy?=
 =?utf-8?B?dTdUamYySnlpNlF0Tm9wVVM5M3BaVWV0WDRpZVFYV2FXeldrVDlXVTl3NEN6?=
 =?utf-8?B?ZVJGTkVMZEIvZVBzLzBCY29rWkh1MUFmVG1veEpPSjhVamoxcnk4ZDNpK3gw?=
 =?utf-8?B?NHNUQXZEZ3Y2blpLRGJwblVVTzVRekFhRVNZdEtsWHQ5U1VRWmNGVE5MblN3?=
 =?utf-8?B?U1FxeWhHdndCSTU5V2NRdVpYa2pYL09NNjZIUnI0Z3NTUFlYTVpaR2Q4ZTNj?=
 =?utf-8?B?TkxGNnpXS29tQjFLTUZkQmwzZjJZYnZMdGNYK2ZFdGhqenRzL3FTOVBCdlNG?=
 =?utf-8?B?UUVmUHVOQmJab3huSlVZYS9SbFgwN1lTTjlGMG5EN3lrTkVYNDA2UmJYcmlT?=
 =?utf-8?B?SEtnalVpam1OMjJTcmlrYlpxdDZEcytaMDVrSXFNMEQzOUNjenBDSVh0M25G?=
 =?utf-8?B?cWFtNXpmaDFTYVdlbWIxNEMydU9EdkM3V2phb3FMalFLUTV2YVdlREI2SzN4?=
 =?utf-8?B?dVdUU2lKRnBQS004Y2Q4NnZCZ29aT2pqWmZvbVJiRHpJRXB0ZzhLdz09?=
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
X-Exchange-RoutingPolicyChecked: g/+2wcXen4H+MC3uZrOzJLqyyQNc8s1l57Kp0qQSkBtxFBZuf2s000/8oCWQnaCsGPo8EhZWC27nezSRRXy9lzioFByPQzkIqeNyNDdRvUfUhcmKFAr5oslooZWs1ZKztjkZFS36Jh9FNJSW691ExeeTMqCiXpIADQK9aWw+2gS5i8iBVTytPjxOjzvTbG/6PVn+bxoT8+HCabVxitZfGPLIPIDWfBOOCIUEwprK1nmeaocRfMesyCZS/RUwYCiayOFnvH9L/MBSzvpBOHp/2/9ExzRyNqOiE6c2D+qTPdui+ZQWn0d7niqGRkkfU0Hm4SxUHkdnZjycSIYVZLz6Ew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6570.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3912e312-bcd3-4e83-6e46-08df46ecd5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 09:58:32.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAzpW0E9bSapyaS6QdhU6Pdpu7HF51Wi8iKFHO8o8xEmMnNvuMqKl28JAKHUoPC4quuMYSYWxQe7Qt0+lO5QEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb2dhbmRlciwgSm91bmkgPGpv
dW5pLmhvZ2FuZGVyQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxOCBOb3ZlbWJlciAy
MDI2IDEzLjAyDQo+IFRvOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBpbnRlbC14
ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IEhvZ2FuZGVyLCBKb3VuaSA8am91bmkuaG9n
YW5kZXJAaW50ZWwuY29tPjsgTmlrdWxhLCBKYW5pIDxqYW5pLm5pa3VsYUBpbnRlbC5jb20+OyBL
YWhvbGEsIE1pa2EgPG1pa2Eua2Fob2xhQGludGVsLmNvbT47DQo+IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBkcm0vaTkxNS9wc3I6IEFkanVzdCBYaWFvbWkgQm9v
ayBQcm8gMTQgMjAyNiBwc3IyIGRpc2FibGUgcXVpcmsNCj4gDQo+IFdlIHdhbnQgdG8gYXBwbHkg
cHNyMiBkaXNhYmxlIHF1aXJrIG9uICBYaWFvbWkgQm9vayBQcm8gMTQgMjAyNiB3aXRoDQo+IGRp
ZmZlcmluZyBkZXZpY2UgSUQuDQo+IA0KPiBGaXhlczogNWU3OWFmNWRiMDBiICgiZHJtL2k5MTUv
cHNyOiBEaXNhYmxlIFBTUjIgb24gWGlhb21pIEJvb2sgUHJvIDE0IDIwMjYgYXMgYSBxdWlyayIp
DQo+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwv
LS93b3JrX2l0ZW1zLzk1NzUNCj4gQ2M6IEphbmkgTmlrdWxhIDxqYW5pLm5pa3VsYUBpbnRlbC5j
b20+DQo+IENjOiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29tPg0KPiBDYzogPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjcuMisNCg0KUmV2aWV3ZWQtYnk6IE1pa2EgS2Fob2xh
IDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogSm91bmkgSMO2Z2Fu
ZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2k5MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9xdWlya3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
cXVpcmtzLmMNCj4gaW5kZXggOTZlYjlhNDBkZjliOS4uZTMzMDNkNTE0NmU4OSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9xdWlya3MuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3F1aXJrcy5jDQo+IEBAIC0yNzAs
NiArMjcwLDcgQEAgc3RhdGljIHN0cnVjdCBpbnRlbF9xdWlyayBpbnRlbF9xdWlya3NbXSA9IHsN
Cj4gDQo+ICAJLyogWGlhb21pIEJvb2sgUHJvIDE0IDIwMjYgKi8NCj4gIAl7IDB4YjA4MSwgMHgx
ZDcyLCAweDI0MjQsIHF1aXJrX2Rpc2FibGVfcHNyMiB9LA0KPiArCXsgMHhiMDgwLCAweDFkNzIs
IDB4MjQyNCwgcXVpcmtfZGlzYWJsZV9wc3IyIH0sDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaW50ZWxfZHBjZF9xdWlyayBpbnRlbF9kcGNkX3F1aXJrc1tdID0gew0KPiAtLQ0K
PiAyLjUzLjANCg0K
