Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792497569;
	b=Uqb7IpVT3zyDAFb2dB2jVg5JBQO6rQUIgDiAr3hX3BEZ91CMF9/FwHTG2EuyKa0nGPug
	 k2SXy7bPdQEIqPx+5PlhgK3zhrbD6liVR6/BOwmKyLN8AU8NmjUQNBAKPFJ752sHFGw8l
	 J9f4993moBuGs6uegJ1o7h7JUOf2m9nYl/h2OTYIlkYLBAtlotDeRddXmb6K8BhcC4fXL
	 nhmFMhy4eeah2J7SJzvpm/uPrnC79lF4JIbyCGNv6wrDd//Zy4zH6Jl7uTVAu1a1KeZb2
	 /d+32p/ZzOch4hPypWK2Pe9SLj6eKbVbSFYLzZeEDfMZ5lkHwfnjGAJRkoC+EG89qVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497569;
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
	bh=VEkyA9PUS33YaUMTRTLFp/cxFP3d1T5XNDsA29UVFv8=;
	b=eTziDY2szjrAUOHwetJsgxROF9XkT7sh8PENN6mV9Dnkk8S80p8jN6bBbx23tPkt20yT
	 C/lQYA+iHoOgsFklIiEqbdD6R5b70rJ5Q4TN2kmkxKyuG8uqI+Z/KZs0WLtjXs0EUVXIm
	 T0h/emeSJ9KSJWYamADUYXOA06tbAch6B9ermkBPWIaZCX9oZwaOPjcsvQ7rzWuFPtSYH
	 hbBHGi0PT7AA1PZkybNrJh5CB/LtuNvOdd04d+1w3gIVyRzFNtaHmQ5MibZBSli/wuSfy
	 S2RtGyP3YFqeAWL3HvYZ/ZdHBsCtEUGn6K5InGh1Eo6iL+AXIccWovbpKRGYdC5eHwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BqCe/CDt";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D060A261B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2D060A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BqCe/CDt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792497568; x=1824033568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VEkyA9PUS33YaUMTRTLFp/cxFP3d1T5XNDsA29UVFv8=;
  b=BqCe/CDt07vggbaqFljXsqKUGsY/6YEk5MRp3jWwQgz5Fjsc7I+jDBDa
   b41FDe8ArpZBgOm7+W7dQg1IePxI9RlzicNYFgfULbrVdMxfdcCYUHzrf
   /Gc00bwjane2ry01bjayJKy4R6n68pNPyMd1IaZQQlLkh6zdcIAD58vU7
   RDQAKEw3F6zx9vNmkADOQB70zGoHoMnz9cksfiPsSlZ1WEp9JF6LEIX6e
   S6cq1LXBywwWiBLPKgxB7j09D08ujr2hQRXw1Z9gH8T1VKken68q+S7x8
   p6wuJsIuhmlZ1jAoHUc7EpHqOJHU6Lzp8tQxP7potl6JUaFMrkDFfTfqE
   Q==;
X-CSE-ConnectionGUID: je2FkOEtSsS4HvvBik5Rag==
X-CSE-MsgGUID: C0hecsfvQhKLwB+G8fg8xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1232036"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1232036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:59:27 -0700
X-CSE-ConnectionGUID: ZNVzUvAkQqWxxOfdPCoWsg==
X-CSE-MsgGUID: pHE7O8p7QsiCqRRNlbtFcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3125726"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 04:59:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 04:59:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 04:59:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 04:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjco7DvGGtM7RkkF7ugwTEYkWOj6M8IAb8Hi6/udjKMr3s4upaytLHCH9rCsuXJb9GvDKO1pqRH/uQAxTkB6BpmLDIAt1rfjYvE2iZMeWQ/59ZBa9lTmY6Ij3abfp2d+JGzO+Elh0t8uHHZ/5Qhsl2lSCgTMwqPJ239QCUI22cxfPkVFMPwFlDku3W05GBy72YOdD2iIMeKoJb64izppU7idq+7mfg/krbk5b4ATx3LhLvHkpT+S7tGnrexdh442H4qCfI2MgzIJ8yAPxphHrL9jVcTzs7JNy8S/rk/Riwjke4rGQaUaf7j1Rz+LIrqpo/KYMdStw6r5tkmNvF07sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEkyA9PUS33YaUMTRTLFp/cxFP3d1T5XNDsA29UVFv8=;
 b=JMTIu0Qy68b5H6zhQgx/tRBTHEykBjzMKAwnXcipQsPpEtcbNe/vLhNvHqk/WQIcgW9tz6EeJFqKFb/vz4C2B68qiRt/xPY1O2np7WY1MskEhv469XcAGjwVc6J+JuWemImpF3YHsNUdjmKFb/rF9dVl+6oXSrWSaI5Ko9pls0ApJHP/f1PooNPopSf+p4NwTYY2TpmoTIfHooGaJPTfzIZCEZOJGf2s6q/C3RudK4nVBaXetRHXtxr9mQWNdOSDmpT2WQo2jQ6NMBtXC1p4XjGDreum1nXf4HM6CxpIPxFwIlWrw2t0KfHn8mDe2V9BwQ9bT3EMH58i7P1gQdkT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by PH4PPFCC1DEE4FE.namprd11.prod.outlook.com
 (2603:10b6:518:1::e6d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:59:23 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:59:23 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 2/8] drm/i915/display: Add enabled pipe planes into state
 for selective fetch
Thread-Topic: [PATCH 2/8] drm/i915/display: Add enabled pipe planes into state
 for selective fetch
Thread-Index: AQHdT/dHE8snClWpoUqrn4HCsB3DErcGdODQ
Date: Tue, 20 Oct 2026 11:59:23 +0000
Message-ID: <DS4PPF69154114F2AD36372162D8B4FD36BEF672@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
 <20260929094434.77129-3-jouni.hogander@intel.com>
In-Reply-To: <20260929094434.77129-3-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|PH4PPFCC1DEE4FE:EE_
x-ms-office365-filtering-correlation-id: ed04c63f-807b-48d8-2b02-08df2ea194db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|4143699003|11063799006|56012099006|260925021911599003|261009223027099003|260925022911599003|260925021311599003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1f9KEgL1OonUYmQFACSAbJg6OIY4/DwBjzzjW9kzTg0mxGylMxiDvZbK3Df3taniNrkdzFjwy/LCpoxfNS+dk5xZgc7S9Lu8t5B+US1v93MFO5Axos6vRBsBvOxllFEkexRo8x2PBZMUBjbFTR3aaHecnKkGsD0EIQcJUsDDOnOqpou4BvhZXn0ONX72B5uyYmlkUvOD/7+hXMll80t/PtuTZfyZ7/xLWCh+rCFR3SFrTARvesJwyfDEEbdHwp6tsgxI2FLWZGYZTpSro+k/n4Ivn5eicwrpv+2nuhkZHZMb+yRLn0Vm8aqTtDAFvgCK/sCOJi5/k56ImUnEvCQdslYDamxB7f+GzC+PQ9lriV5nQ/s5KYjR/Y+JwQXDSfpvpo6m1FiwoOtQBY3MieTdgy8rloX4XjgwiJtjST75yEBu3f69CIInRjFFIO7LJm98zabG5hC2/HgnuHu9b8ba2F+ni4G7KjmV4Ixn8KQx1puWsg/SsuBZwzuvfq0KtdvjlRF6oH6f3eefd4SJjPkloITGUwqOqC1se7bBv2AYWDppFKDAEhQRRK4XGe60xoFGTpL8txCx0TbGPX1RdV6KFLjicDC9/13bgtxScFbt9KfzqNbWIJRgAHFQF8lBmhRE+sDwTQfHLg/5YQiLrVq02fW7UB2NuuU9KvUmqCGFDoPUEN7v13x8pIXB5KoruwfpqLkJs6EsPJQrlWSCgoMwxOi2nao26vcjL3hWWa4i39s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(260925021911599003)(261009223027099003)(260925022911599003)(260925021311599003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3lWQmtHdGFHVU04RjRTZ2hXRDYwY3lGOG55QmVoM3BDcDZENTZzT0FobkRk?=
 =?utf-8?B?bkt2cm4wc3NtSVJ2MXdQcVRjaGZzSUxSY0pKUU1xd0NSejIySXdNUHVLNDN2?=
 =?utf-8?B?VXRpZnlUaWMzdnNyS1ZxOXMyYm51c1hYTHlwMm5KYW1ZMXQ2K3Q2aEo2R0dQ?=
 =?utf-8?B?VTNxdm0zM0FJN2JGZzJSV0N4d0lXMWpoc25GVWE0SzdZcW9oUm51aUFCb1Bj?=
 =?utf-8?B?R2dKUUttVnRhNWFOZjlqY3dZQ0YyeXAxMUduKy9zRTc1cHR3cC84bDBhdmN6?=
 =?utf-8?B?VjdZMy9QRWY2Tm5pYkxLc0JyOU03TEd0MnArcTRhYmtWb1VSVXNzZGtwcWVh?=
 =?utf-8?B?bnpMNmc1VFNaVWQ2MnU3aXRPU3NBRzViOHhsNDltYmkyRThOQ2RlamJaUlhI?=
 =?utf-8?B?Z0xsM29vbVJXN0owTnZsdXBKdGtDci9CVjBZeDR1QnhBY1k4NytCYy93ZWZm?=
 =?utf-8?B?YndHQ0QxbVF4VytaTFh5Mkxsd1JoaVFzS1R2SmhJUUlwUExKaU52ckpvYmhK?=
 =?utf-8?B?aVlWN3NkZ3NnVTRmb1ZvVTJ1TnZYeU0xTFVsenEzanV0eFJsbVhmVGVYeitR?=
 =?utf-8?B?WGRxK2p5VXFzMXoyMTM4RmpKZytNQVpIVXpBd0J3QWtRZkZ2ZzZ5N3VuU09s?=
 =?utf-8?B?ekJZY1FpQnQ2UzZwRDZ4eFV3dElrekZ4M1FxZyszenRya0hKNEdaNDl1QnRP?=
 =?utf-8?B?UUE1QVZiMVhaWTVmTXJpNE1PVG1Qc1YxUHFPVGFTL3F3YjZ1WmtOckg1a0NH?=
 =?utf-8?B?R204NTR2SVNZUVpaNktwSHc2eXR0bkF3M3IyTk5XcWxiTktxRUpsaFFHSU9t?=
 =?utf-8?B?cGF2MEdPckRoY2dERjFiR2ZjY0N0cFBHZC84RWt1TkdKSDZ1Q2VyVmYvdTlM?=
 =?utf-8?B?ZHV0bVNWcmU5cGRwc0QvSzlaQ1FnSERQUDdXMEZOUGZWVkt2bnlRc3krRmdS?=
 =?utf-8?B?VGhFb3B1c1FlU20rckEwUkJzeEdZdGlSa2FJME8yVHJrUkdHRWpkb29IV0Rz?=
 =?utf-8?B?aExvWFYyWVFsS2lMeTdMWWVDVXdFQXNUaHRYa2pQM2UrdFhVV0tPTjZ0aEF1?=
 =?utf-8?B?TzU2TG1neHZCemNkS3VTTE5rSlVLTURSY2JTZG5aK1RyR3NvZnMwQ1p3SGJu?=
 =?utf-8?B?cHJEVWs1b1lmcmhPZWFxSWJsWWJiRmxleVRKVnVJanVOOUtLRTNWTkJ3VU1m?=
 =?utf-8?B?YVRzRmQ5V2xZelFXaG1MK2cxRVVuTG5IRldXREEzeUg5Z0NrNkkrUW8xUktm?=
 =?utf-8?B?b2hJTjlOWnVhRmYzQUpxZHpZSHB5bi9kK1NLVG9BYjlsb2czTzRIN2ZkTWVo?=
 =?utf-8?B?cEU4ZUIzc1RxUlZHc3VhVnpZNUwvQ2hCOUxPL1QydVd4REsyN0poUlFJaGtY?=
 =?utf-8?B?OFNUcE95eDJSdlVPc21QdzdOVnpuVkxvNFNYc3g2MjlOV3BIWHhaWjU1TlZw?=
 =?utf-8?B?ZzhCdkRwNlMxanE3Qk5IOVBrOHZpUUtQOU1ncGJNR25hK0RCNTA3M09kTHp5?=
 =?utf-8?B?SmNUeStsRXJ0UER4dkJCNHVzTXpEV0paTjc4c0hnRnZkYVp1ejFDQUZRNlhh?=
 =?utf-8?B?YWl4VlI1U2Q3LzFhQUZXbCtMUTFNRVNPVkMvQlBpYkdkVFJadWQwYkNTRStK?=
 =?utf-8?B?dlh5TDJOY3FVUXhKMzlKandhR0ZjaDJFemtWeWxQU1FlU0o0cHhQb0V2TldX?=
 =?utf-8?B?VUxFdlVieXZBd2pWUFFQUXdlRlFyUEFPTUo1TWJEQ3JQQ3VjUzhJZXlvOENv?=
 =?utf-8?B?b0NoRWVFMm8vSW81Z1NleXZGN1laSGtnMEg1ZWpTWXRuTlREN2NHSXRUOThZ?=
 =?utf-8?B?WjRYR0FWM3RGMnBYNzBhaEhPNEh1L3FLN0ZmU1pyamlTcHI4ZDdmWFc2MWtY?=
 =?utf-8?B?UFEvYmhSOEFhL3RXNSs3V0YwaDBSNnNnNUlqK3QyZmhWSzRZcEQrK0pNRG9q?=
 =?utf-8?B?K1V4STJQQTE5bnlTZTdSUStnQ0xIT0pWTnM2YmlkMlNHZEZyWEZ1TFpJVHY1?=
 =?utf-8?B?akhqMHV0azdQM2hiOEhPNy9LV3cyRWplU2orMmkxd1NOZG5ibGIwN2ZjRXpD?=
 =?utf-8?B?ek1HNm1idHp0bHJXM1JGQnU1K05rM09MalQzU3JOak9JTERGOXZSQnB2SUxG?=
 =?utf-8?B?R0pFYm9scVRhaTltNnRrMC9YYjJ2VHRYOTUzZGZqYisvTEU5YlNrVm9nZzB1?=
 =?utf-8?B?RTdFZDlycUpscXVnM00rS2Q5L0tJZTNZZktSQTI0MWxCZ0xkYWZXcnRrVmdF?=
 =?utf-8?B?d1phWjVTajh6T01zQnN3UHBOc09XbzFYSGdTQ2drc295NTlyZEl1TE50cFQz?=
 =?utf-8?B?dzhTcFVOeXJZcEFGQzFvbUVYdU0wSE45Y2Z5TG5kRHkwR2ZKV3JGZz09?=
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
X-Exchange-RoutingPolicyChecked: Rw/PKGa8PSWpmbsd6alrCYjLYi/Ku1gvVyJBVnbMKsiPiIX/S88i0JEKoDOjU9s8qrmyFNyjMOkcboYuLaWQSfFJg1INpK1MwGyo7/Of8j0wDb9vJ/Sv+TC+nKb9L5kIkEkCSyrm0hSIqPvYytegD+mSgucfbS9Mv2k37+Ir/MU7T6OMIyJs64rlVzneXGmxJ7e9p1zRx7YVI2a7gmzGHuX7r7r3COmKSwnYmbn9L9WEkqpEzI8ETItS9bUKidpI2k5z0JH7tQTNVTET7i7a9RUHed1W8HbafWAZE4mNfTpKzUZDFCtVz17FXiO9LYwlWgbLfphFeprQs85bArXSkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed04c63f-807b-48d8-2b02-08df2ea194db
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 11:59:23.1878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZPZIIorzhBRgxoBGTB4LDV2iGB+76DUa715VtX566etnEzFgs+AqgamAjvfjtqAIhl5Ig+279jld4mJDtkAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPFCC1DEE4FE
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBKb3VuaSBIw7ZnYW5k
ZXINCj4gU2VudDogVHVlc2RheSwgMjkgU2VwdGVtYmVyIDIwMjYgMTIuNDQNCj4gVG86IGludGVs
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBDYzogSG9nYW5kZXIsIEpvdW5pIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+OyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAyLzhdIGRybS9pOTE1L2Rpc3Bs
YXk6IEFkZCBlbmFibGVkIHBpcGUgcGxhbmVzIGludG8gc3RhdGUgZm9yIHNlbGVjdGl2ZSBmZXRj
aA0KPiANCj4gU2VsZWN0aXZlIGZldGNoIHN1cHBvcnQgZm9yIGJpcGxhbmFyIGZvcm1hdHMgcmVs
aWVzIG9uIGxpbmtpbmcgb2YgVVYgYW5kDQo+IHRoZSBZIHBsYW5lcy4gUGxhbmVzIHRoYXQgYXJl
IG5vdCBwYXJ0IG9mIHRoZSBhdG9taWMgc3RhdGUgYXJlIHB1bGxlZCBpbiBieQ0KPiB0aGUgZHJt
X2F0b21pY19hZGRfYWZmZWN0ZWRfcGxhbmVzLiBJZiB0aGUgVVYgcGxhbmUgaXMgYWRkZWQgaW50
byB0aGUgc3RhdGUNCj4gYnkgZHJtX2F0b21pY19hZGRfYWZmZWN0ZWRfcGxhbmVzIGluIHRoZSBz
ZWxlY3RpdmUgZmV0Y2ggY2FsY3VsYXRpb24sIHRoZQ0KPiBsaW5raW5nIGlzbid0IGRvbmUgYW55
bW9yZSBhbmQgdGhlIFkgcGxhbmUgaXMgbGVmdCBkaXNhYmxlZC4NCj4gDQo+IEZpeCB0aGlzIGJ5
IGFkZGluZyBhZmZlY3RlZCBwbGFuZXMgYWxyZWFkeSBpbiBpbnRlbF9hZGRfYWZmZWN0ZWRfcGxh
bmVzIGlmDQo+IHNlbGVjdGl2ZSBmZXRjaCBpcyBlbmFibGVkLg0KPiANCj4gUmVtb3ZlIHJlZHVu
ZGFudCBkcm1fYXRvbWljX2FkZF9hZmZlY3RlZF9wbGFuZXMgZnJvbQ0KPiBpbnRlbF9wc3IyX3Nl
bF9mZXRjaF91cGRhdGUgYW5kIHJlZHVuZGFudCBjaGVjayBmb3IgcGxhbmUgc2VsZWN0aXZlIGZl
dGNoDQo+IHN1cHBvcnQgdGhhdCBpcyBub3QgbmVlZGVkIGFzIGFsbCBwbGFuZXMgYXJlIGFscmVh
ZHkgaW4gYXRvbWljIHN0YXRlIG9uDQo+IGZpcnN0IGxvb3AgaXRlcmF0aW5nIHRoZW0uIEFsc28g
c3dpdGNoIHRvIGludGVsX2F0b21pY19nZXRfbmV3X3BsYW5lX3N0YXRlDQo+IGZvciBsaW5rZWQg
cGxhbmUgbmV3IHBsYW5lIHN0YXRlLg0KPiANCj4gRml4ZXM6IDM4MDk5OTFmZjVmNCAoImRybS9p
OTE1L2Rpc3BsYXk6IEFkZCBpbml0aWFsIHNlbGVjdGl2ZSBmZXRjaCBzdXBwb3J0IGZvciBiaXBs
YW5hciBmb3JtYXRzIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY1LjE3Kw0K
PiBTaWduZWQtb2ZmLWJ5OiBKb3VuaSBIw7ZnYW5kZXIgPGpvdW5pLmhvZ2FuZGVyQGludGVsLmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IE1pa2EgS2Fob2xhIDxtaWthLmthaG9sYUBpbnRlbC5jb20+DQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3BsYW5lLmMgfCAx
MCArKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMg
ICB8IDI1ICsrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9wbGFuZS5jDQo+IGluZGV4IGY5MDhlYWJlNjA0YmIuLmQyM2RlMGYzNGU0
YjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcGxh
bmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3BsYW5lLmMN
Cj4gQEAgLTE5ODAsNiArMTk4MCwxNiBAQCBzdGF0aWMgaW50IGludGVsX2FkZF9hZmZlY3RlZF9w
bGFuZXMoc3RydWN0IGludGVsX2F0b21pY19zdGF0ZSAqc3RhdGUpDQo+ICAJCXJldCA9IGludGVs
X2pvaW5lcl9hZGRfYWZmZWN0ZWRfcGxhbmVzKHN0YXRlLCBpbnRlbF9jcnRjX2pvaW5lZF9waXBl
X21hc2soY3J0Y19zdGF0ZSkpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4g
Kw0KPiArCQkvKg0KPiArCQkgKiBBZGQgYWZmZWN0ZWQgcGxhbmUgaGVyZSB0byBlbnN1cmUgVVYg
YW5kIFkgcGxhbmUgbGlua2luZyBpcw0KPiArCQkgKiBpbiBwbGFjZSBpZiBVViBwbGFuZSBpcyBh
ZGRlZCBhcyBhIHBhcnQgb2Ygc2VsZWN0aXZlIHVwZGF0ZS4NCj4gKwkJICovDQo+ICsJCWlmIChj
cnRjX3N0YXRlLT5lbmFibGVfcHNyMl9zZWxfZmV0Y2gpIHsNCj4gKwkJCXJldCA9IGludGVsX3Bs
YW5lX2FkZF9hZmZlY3RlZChzdGF0ZSwgY3J0Yyk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJl
dHVybiByZXQ7DQo+ICsJCX0NCj4gIAl9DQo+IA0KPiAgCXJldHVybiAwOw0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gaW5kZXggZjYyMGM0NGVlNDAwOC4uYTll
OTIxNTIwMDAxNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9wc3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX3Bz
ci5jDQo+IEBAIC0yOTAyLDcgKzI5MDIsNyBAQCBpbnQgaW50ZWxfcHNyMl9zZWxfZmV0Y2hfdXBk
YXRlKHN0cnVjdCBpbnRlbF9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiAgCQkueTIgPSBjcnRjX3N0
YXRlLT5ody5hZGp1c3RlZF9tb2RlLmNydGNfdmRpc3BsYXksDQo+ICAJfTsNCj4gIAlib29sIGZ1
bGxfdXBkYXRlID0gZmFsc2UsIHN1X2FyZWFfY2hhbmdlZDsNCj4gLQlpbnQgaSwgcmV0Ow0KPiAr
CWludCBpOw0KPiANCj4gIAkvKg0KPiAgCSAqIFNlbGVjdGl2ZSBmZXRjaCBpcyBub3QgYWx3YXlz
IHVzYWJsZSwgZm9yIGluc3RhbmNlIGl0IGlzIGRyb3BwZWQNCj4gQEAgLTMwMTcsMTkgKzMwMTcs
MTUgQEAgaW50IGludGVsX3BzcjJfc2VsX2ZldGNoX3VwZGF0ZShzdHJ1Y3QgaW50ZWxfYXRvbWlj
X3N0YXRlICpzdGF0ZSwNCj4gDQo+ICAJaW50ZWxfcHNyX2FwcGx5X3N1X2FyZWFfd29ya2Fyb3Vu
ZHMoY3J0Y19zdGF0ZSk7DQo+IA0KPiAtCXJldCA9IGRybV9hdG9taWNfYWRkX2FmZmVjdGVkX3Bs
YW5lcygmc3RhdGUtPmJhc2UsICZjcnRjLT5iYXNlKTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlyZXR1
cm4gcmV0Ow0KPiAtDQo+ICAJZG8gew0KPiAgCQlib29sIGN1cnNvcl9pbl9zdV9hcmVhID0gZmFs
c2U7DQo+IA0KPiAgCQkvKg0KPiAgCQkgKiBBZGp1c3Qgc3UgYXJlYSB0byBjb3ZlciBjdXJzb3Ig
ZnVsbHkgYXMgbmVjZXNzYXJ5DQo+IC0JCSAqIChlYXJseSB0cmFuc3BvcnQpLiBUaGlzIG5lZWRz
IHRvIGJlIGRvbmUgYWZ0ZXINCj4gLQkJICogZHJtX2F0b21pY19hZGRfYWZmZWN0ZWRfcGxhbmVz
IHRvIGVuc3VyZSB2aXNpYmxlDQo+IC0JCSAqIGN1cnNvciBpcyBhZGRlZCBpbnRvIGFmZmVjdGVk
IHBsYW5lcyBldmVuIHdoZW4NCj4gLQkJICogY3Vyc29yIGlzIG5vdCB1cGRhdGVkIGJ5IGl0c2Vs
Zi4NCj4gKwkJICogKGVhcmx5IHRyYW5zcG9ydCkuIEEgdmlzaWJsZSBjdXJzb3IgaXMgaW4gdGhl
IHN0YXRlDQo+ICsJCSAqIGV2ZW4gd2hlbiBpdCBpcyBub3QgdXBkYXRlZCBieSBpdHNlbGYgYXMg
YWxsIHBsYW5lcw0KPiArCQkgKiBvZiB0aGUgcGlwZSBhcmUgYWRkZWQgaW50byB0aGUgc3RhdGUg
YmVmb3JlIHRoZSBwbGFuZQ0KPiArCQkgKiBjaGVja3Mgd2hlbiBzZWxlY3RpdmUgZmV0Y2ggaXMg
ZW5hYmxlZC4NCj4gIAkJICovDQo+ICAJCWludGVsX3BzcjJfc2VsX2ZldGNoX2V0X2FsaWdubWVu
dChzdGF0ZSwgY3J0YywgJmRpc3BsYXlfYXJlYSwNCj4gIAkJCQkJCSAgJmN1cnNvcl9pbl9zdV9h
cmVhKTsNCj4gQEAgLTMwODAsMTEgKzMwNzYsNiBAQCBpbnQgaW50ZWxfcHNyMl9zZWxfZmV0Y2hf
dXBkYXRlKHN0cnVjdCBpbnRlbF9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiAgCQkJY29udGludWU7
DQo+ICAJCX0NCj4gDQo+IC0JCWlmICghcHNyMl9zZWxfZmV0Y2hfcGxhbmVfc3RhdGVfc3VwcG9y
dGVkKG5ld19wbGFuZV9zdGF0ZSkpIHsNCj4gLQkJCWZ1bGxfdXBkYXRlID0gdHJ1ZTsNCj4gLQkJ
CWJyZWFrOw0KPiAtCQl9DQo+IC0NCj4gIAkJc2VsX2ZldGNoX2FyZWEgPSAmbmV3X3BsYW5lX3N0
YXRlLT5wc3IyX3NlbF9mZXRjaF9hcmVhOw0KPiAgCQlzZWxfZmV0Y2hfYXJlYS0+eTEgPSBpbnRl
ci55MSAtIG5ld19wbGFuZV9zdGF0ZS0+dWFwaS5kc3QueTE7DQo+ICAJCXNlbF9mZXRjaF9hcmVh
LT55MiA9IGludGVyLnkyIC0gbmV3X3BsYW5lX3N0YXRlLT51YXBpLmRzdC55MTsNCj4gQEAgLTMw
OTgsOSArMzA4OSw5IEBAIGludCBpbnRlbF9wc3IyX3NlbF9mZXRjaF91cGRhdGUoc3RydWN0IGlu
dGVsX2F0b21pY19zdGF0ZSAqc3RhdGUsDQo+ICAJCQlzdHJ1Y3QgaW50ZWxfcGxhbmVfc3RhdGUg
KmxpbmtlZF9uZXdfcGxhbmVfc3RhdGU7DQo+ICAJCQlzdHJ1Y3QgZHJtX3JlY3QgKmxpbmtlZF9z
ZWxfZmV0Y2hfYXJlYTsNCj4gDQo+IC0JCQlsaW5rZWRfbmV3X3BsYW5lX3N0YXRlID0gaW50ZWxf
YXRvbWljX2dldF9wbGFuZV9zdGF0ZShzdGF0ZSwgbGlua2VkKTsNCj4gLQkJCWlmIChJU19FUlIo
bGlua2VkX25ld19wbGFuZV9zdGF0ZSkpDQo+IC0JCQkJcmV0dXJuIFBUUl9FUlIobGlua2VkX25l
d19wbGFuZV9zdGF0ZSk7DQo+ICsJCQlsaW5rZWRfbmV3X3BsYW5lX3N0YXRlID0gaW50ZWxfYXRv
bWljX2dldF9uZXdfcGxhbmVfc3RhdGUoc3RhdGUsIGxpbmtlZCk7DQo+ICsJCQlpZiAoIWxpbmtl
ZF9uZXdfcGxhbmVfc3RhdGUpDQo+ICsJCQkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCQkJbGlu
a2VkX3NlbF9mZXRjaF9hcmVhID0gJmxpbmtlZF9uZXdfcGxhbmVfc3RhdGUtPnBzcjJfc2VsX2Zl
dGNoX2FyZWE7DQo+ICAJCQlsaW5rZWRfc2VsX2ZldGNoX2FyZWEtPnkxID0gc2VsX2ZldGNoX2Fy
ZWEtPnkxOw0KPiAtLQ0KPiAyLjQzLjANCg0K
