Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794367750;
	b=nQOIeonT1X0uC2AlBVoSiiPROKXbJQ0tyo4tBKAScczmYaIMCXKS/KIGRMGGYf2uGywx
	 azPtjg6Uc8AnNBN1tvxHMsWOhHqYos0HdWBCTrDVW6T4LtePfhZ7QyHyRLQDbPSPy1v3p
	 7W6b6jBLC32pfOKVLCA56aKJsBLuFc7dGWFDw/4fOtGrrjnusSLBnmcoHlX5rYdaU1/mt
	 6jLO1cAu6TAZkTmNaV0OOqzGimDA77LZaDFJ1zieKuvZ/yazcfZLQ2OU61jkki4KMOmaT
	 hBUTp/5mVN/FNGFL58bS53e2UQ2zp/t2eERw79+lX+ZjdnBcD2XY1DZFP6xRp/bhzpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367750;
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
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=CLDAmy66l2CZMstnZpsKTsiHzl2KCaQN6uXrviyJ5Lo=;
	b=tEhQt91kyOVAEH2PaAEcPt0t8eJeL6Ol67yWf593Nszpzv4m7m7EDNt07cOV08/AnUyU
	 Qq58pviKDS/wx18pk/AKP69TDBZWzG8Ry7DsE0Y8avkDIT81kA6RMPlCeh5WM9zPljWXx
	 JGOF7ndJRH04mawmg7Sa/TLmIbsiNlRFypO4njZQ2v/tTMBC5nLjd6x+TB3LP23TLQnoL
	 P86YcIIMxX2h+uQLeR9fAjBuLwQxIsPaD0SHn3OVm2e+GcC1h8HMKq3t0EZXpCkfeILN1
	 XKCUoPw8E4qOoE00Q+XtriwF6ahAP3hXIfSPz3Mwgwa7eCOK0IFA7e3TKjWucV6rT2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L0RxLRqn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159E606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8159E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L0RxLRqn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794367749; x=1825903749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CLDAmy66l2CZMstnZpsKTsiHzl2KCaQN6uXrviyJ5Lo=;
  b=L0RxLRqnVGyYqM0ERvNfE5mQd5syzjQfbeH92HBtOSiChWzbGPWwrlSo
   GVoMb7AcAewjAveXax4CdA6bGV6TeyCWqTn0Gaklpp3eYqWqQSWX/yADe
   QqJX2v9IrY+BEGY54qyzSXC/EzdEgsuivalh4xW8l67na62iQuWEJlirm
   15R/VT+cCcYKueZCHdfJJbe00R20ddV4fNQM4x0bOfIt5mQ7KbtW3R6e7
   wcqWRvBld87iU2bCDhCqasj/l8MV2dLnC1m4fZyBOG3G44DoyieoAZ1/V
   1LUpoHUkza91W/EJsrlM1ih97ViJ2gGFgjcm2Q2JD7EaabioGbmzgChrL
   A==;
X-CSE-ConnectionGUID: wJspYn7iTzyj9z5iKXbTdg==
X-CSE-MsgGUID: gKDbonbNRX2pyR6zlGedXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3131201"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3131201"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:29:09 -0800
X-CSE-ConnectionGUID: fTslvFW2S6e4fMzn6679XA==
X-CSE-MsgGUID: XlleedD6ROeH0wyWuGDl7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8739860"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:29:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 19:29:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 19:29:08 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 19:29:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyk+LtKP6uMtFHZ5zVhm4Rp/u9cXEtw3KOn9x7kUGJT/lsjmvv1WqUPSfVoeFG2k7bnP6Q6Sjs5zxwYsiGYPjN6yBLD1grSYnjkoFzmWDO9ntubQyGJRfbGmAgxQmN4qjGEbzc2JpC7FDScc/uGf3gW6T3vaho6nj8yH3NygE/dIxde5E9vfgDsLZbnoBLQGjQ5h9S1TpFL5zZAv9ZPxecMqO1lIp4zVTweI31OL7V5Oi0BrdaslMIobQ8Wue6Djul7Zr3iDUtWqb38PZvIpeI2TpdkrRoXONvunJ1gFzCmbT+TNkLi07bTHUm+gIz34LAU2BcQHtM5Mt8tKlSwx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLDAmy66l2CZMstnZpsKTsiHzl2KCaQN6uXrviyJ5Lo=;
 b=rIZlDIPwC5/onp6KcGFCa10bejw/9c1HKD2R1QjeWKK/j+i/Y+E284p3EVjztuL8EzA5mYYRBbpf1oH9+qnWOCT8xud1uytEBEO1h9P5y+ixPzOl2Fo39ii+Q71IfwPrZi3IsL8T25TOD+drNSoEXsiaZcSNbob23WPUmzbFxRYzH1YnLvex+ZHeeuoIhwtd2+3TtvgNwca0J3PVIFpS6iY4z6QilFeoJQXj1aMNgtY9gm/WBuQozd7lA7uAyfyCXY+94Y7Ivdw8AqEEBodCOGMpyo8meu6lWri5b35HZQTYXKFPUtfI6y0daYyMgpfAh81Mvgp09Zpf4l06tiUYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 11 Nov
 2026 03:29:00 +0000
Received: from PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2]) by PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2%4]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 03:29:00 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Lin, Charlton" <charlton.lin@intel.com>,
	"Shankar, Uma" <uma.shankar@intel.com>, "joonas.lahtinen@linux.intel.com"
	<joonas.lahtinen@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/i915/display: Disable pipe joiner on
 WCL" failed to apply to 6.18-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/i915/display: Disable pipe joiner on
 WCL" failed to apply to 6.18-stable tree
Thread-Index: AQHdcK8+pi98urqHh0CvDo1+jp1aqrcoNxhQ
Date: Wed, 11 Nov 2026 03:29:00 +0000
Message-ID: <PH7PR11MB8252A65F316040CC7A9B657289712@PH7PR11MB8252.namprd11.prod.outlook.com>
References: <20261109200248-failed-6.18-b42b656db138@kernel.org>
In-Reply-To: <20261109200248-failed-6.18-b42b656db138@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8252:EE_|CY5PR11MB6140:EE_
x-ms-office365-filtering-correlation-id: 8016f30f-ad6d-4fbf-28aa-08df3fa3ed24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|3023799007|10067099003|38070700021|261026121527099003|261022105027099003|261021123027099003|56012099006|261022075727099003|261102123227099003|261026140227099003|261021121427099003|261009223027099003|11063799006|261028144727099003;
x-microsoft-antispam-message-info: kwVJJMkyyPVCX8UFggDH7OkjrK5uxjj00K0Oc4tcyiTKcOHVH4kk6a+9T7TcyJx8sL1gImuJExxXjHu1sqvNnxeJOfwRwxGKAf1VjwzVbJSle0nG5vNbJJKOXZW7zSaMxsXxHnEdn/M1ZouvI9t7wGCLpxhbXOxGae2VZ1E/rCy+gm9CgIyOwKEe9mRZRw6tiKrO5M69wpAfS3ismuzY0CcoxgMBsN/N7E92u4F+kegP7Z8483sTVLAFJR4FSrOZcbQ22DN/+PlJJPFrNtmqve2WWTWGS66haUcLa/HiU44lVxsCnmHUdUXIfrXJ/xQjRDiGQcyu85Jdb/A7tn7QUla//s7xnMOS1FXShtaiUTTRwMfIeqUfOB3PjgCMlDZteR69Sg6oOOaunCYNMd5j5ONmhimqY3dKpSDC2rlhFrESBBU5iGtKxEn03tqH0JQ9ENZp3WNJ587hDvQDkkeOUYdNeN8XPypGhNIyfMD/B7NR7zZ19DbaILaglPvh9ODHfVD4LkRMKEsOcnbHwr+TE59nAqlZhXIYH7neOJQM4/bOpZBowHNRU56l7xNjPhG16AzcvDNNJGovdxL9AFx+F96TUwJFFqemz9tp+Sk7fAqiizcVLxK2sOQfVLXfW7rViLoNf+eT+0txIY84tm7QgF+foeCq2IvTKj4pGoAILv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(38070700021)(261026121527099003)(261022105027099003)(261021123027099003)(56012099006)(261022075727099003)(261102123227099003)(261026140227099003)(261021121427099003)(261009223027099003)(11063799006)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUM2emhZd3RRRHA3MmVBRzBDMENQNXBuc3o4S1V1aC9pZlpvV2FSTzB1d1hY?=
 =?utf-8?B?QVovQ2RxcFlKNXVLVGs0clYvSlZJSml2N3gxNkVBWVhVa1d6L0ZMaFlSUE1W?=
 =?utf-8?B?V0p0ajVWWEF1MUNaemNBMHpKZUtnVUZXNWYrak85RWdZNWRSVHVmaWxlY0hl?=
 =?utf-8?B?bXBGNmI5SDBWT0s3WEJPOGt3UU0rQUlBVUNFd0p5V0dNTk1NaVdQY0JNMWdj?=
 =?utf-8?B?emo4Z1BZL2dUd01Qa1pjckUwam5idzFqWWNQSWhjWUlUdmdvd01lQ0ZIODE5?=
 =?utf-8?B?bkE5R0M0L2ZxczVPd2J4R3U4TXhWTlFFTytNcFh2U1dXM0RYZWxSQkZNWjVB?=
 =?utf-8?B?Qm9naFgxazd1eHNDVTRQcEprUjNiLzI3ZmVEYXRtWDY0cDB3UjYzNTgwNjVy?=
 =?utf-8?B?dTJYdVlYN21WMzU4aVBGK0dFK28xUmd4N3h6c3hNempMajJGcGw3S0tQR3Vz?=
 =?utf-8?B?cXVIUzk5RXlleXNwUjNUOEFLN2loM0g2UzZpTklPeElJZFhtNjlkYlpiRDVN?=
 =?utf-8?B?LzFyTXlqUmNPRGhNUXh6Wlg3UWQzcWNBeDFZVWpzMHJSOVVGdVhyTmJjdmRT?=
 =?utf-8?B?QlpmMXZWdmlYZUJhb3FGRFJ3eUZCTUMrRlpsWWFiVXFBL3hyblk4UitCaXc0?=
 =?utf-8?B?VENCUkpRUDNYOEZyU3VQbUwyVFpVRlgyRkJtY0VtU1hVNHNnK1ZCdEJkOFBx?=
 =?utf-8?B?TkdEVHQvbVVtanRkdU01ZTRicHk4R2VhUGdLTHV3ZTBkS0N0TFo5aVdYNnFw?=
 =?utf-8?B?MS9KT1NYeFVCYmRvR0xCVms5ZE5YL2RIa2VpUCtLc2ZDSDFCaHVlWXlhZmVJ?=
 =?utf-8?B?NDAvR2dVQ3ZXaXZXSE1hSUF4VlQ5TTJ6cmdydzluWGJqYXlDL0k4aEdYaVhn?=
 =?utf-8?B?d0ovd3VhclBqeUVXZUtTZ2VlblptckhTc2tUZURSVGtWL2U1MFVpRE1jZ1Zm?=
 =?utf-8?B?aFJsaFN0aS9NbW41SHMwYVZjRDZVenBHR3J4R1BZSzc4VnhXVW9nci9IMkNr?=
 =?utf-8?B?UDVtdDZzMEgvclo4aW9JRVBWZ2hWenVqYkl6SkZvUFBkRk1OaVFzdkVmcUJn?=
 =?utf-8?B?TWRaWUtlVHFxY004aHFpZzBWb0d5QVQ3YmFoN1ZYL210NC9zTTZvUkpiOW9O?=
 =?utf-8?B?dmR4c1FwUXQvYmhzeWd4WnJIK1lhbEV2VkxoNzRJY0EwWXBwcGN6eVZSa1gy?=
 =?utf-8?B?aCtBMURIekRnZFplMGVINnluaDk5Tnp3Mk9nSTZaQnJwYnBsMzRSS3h6aTRN?=
 =?utf-8?B?UDVVYk9JTHBqUmNWNGNKeXBrVWRPUHFBSS9TTTMwWDBrVUYyemFwcS9QYzl2?=
 =?utf-8?B?S3VBaFBIS3Z4TS9VVVBPNUtoQ3B3Yy92ajNFU0J5clFNdDRSRy9rUWxYMzdT?=
 =?utf-8?B?SzlEMXQ1NE84SWFXSEsrTkJPSXBIUTRRSXNWZWJwSVlkQ0U0ZU51cm1pYjFq?=
 =?utf-8?B?eEZyV0YwdUFzRkY4VS9MRFAzQjZ0L0tLdklQM25TaUdpUHRWUEh6cmtzdjNY?=
 =?utf-8?B?QXYrUi84WkJlNXZraC8yakcxN1Z6eEFOWkZCV1VlSXUrTGJqd05WUVovWE12?=
 =?utf-8?B?U1M5b3dPT0MyWVprL1dXV2pTT3FQMG1xdGhYeG0vbVE4MmJ3R1ZoZVBUMlVi?=
 =?utf-8?B?ajZBdjlleXpFN0ZJYUNScFk5MVBHczV1a1M4ai90azhQellTYVVoUVEwcWVE?=
 =?utf-8?B?TVFmUUxQYk5uZ2t4cGtYVVgrRm0xc1d2WFVrSndURjBxUExaY1ZaWi9HQ2VH?=
 =?utf-8?B?VXY3ZDM3aGJKUWJIM1dHbzdwRUlmdG5XSVNsM3NTaW5XRVhVZEkrcmhEMXRm?=
 =?utf-8?B?UjI0b3FnUmh4akFTbXVoaDNHMHdVQXhpLzF0ZXMvdHp0eHZRVnVjMUVVMlAr?=
 =?utf-8?B?RDc4bEUxM3JwTks3UFRxM0lFNE56WnJVUEROZXU5U2VRNmRaTlpVM2FuR0xj?=
 =?utf-8?B?dzdEVmo1dnlwTDNmb0R5d1N5ZElTVUhRQWxZcTZNNm0zNUlHU2g4NDRZbWN3?=
 =?utf-8?B?Yk1FSzdWdVpmWEloY21qVEVRZGRGNGc0RmxIdUlQMFRIOGE0WU9XQTZWMURQ?=
 =?utf-8?B?WmxDSGpJYzNmYXNsRi9hdFVvQWdvdHJVaXdHNlBETmhxbTQrb282QVlBQTVQ?=
 =?utf-8?B?aXc3MGhXVEE0QldEdit3U1l5elFSWE5jRkNGMGtqb0J5U3hNcjhjN0lmRVVy?=
 =?utf-8?B?bVhEZy9XSis3UDlubEFTa0ZhVEg5cGEycWZCSHVkVW1RQ0hUQk55bmM2cUx3?=
 =?utf-8?B?dVI0dFZIa3hjejhJT3VPYW4yZUNkNHNSYWY5eHl6MTdsdEIvdDZrM0l1NlRn?=
 =?utf-8?B?TElNYlZDMFZEakZ1Qi9aZzdRcFVPTkJoV1YxVDlzQVlBeVE4ZjUvQ1g2dTNE?=
 =?utf-8?Q?m1JPCND4VSTQh/LmZcUZ5lEv827BIeXreTcG9+1lGcLlE?=
x-ms-exchange-antispam-messagedata-1: khuxUVgNR717Cw==
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
X-Exchange-RoutingPolicyChecked: B5Re+kO6p1EdaSBorR91dUrYpdvIaCbkqtP/p1My2FmlmITaPPD4guWZB/ro6k75ES/R/7eoeMI9gGTNNLpDxSzDnT7GRLuHYpuXecbv8kzteItcpjE0ypCFCDNqWx1pkvHCOnDk+JReO7cxow7gKv8my8CTY05d/CSo898GkYgUQ6u8Mp8Jl5LTEYSjDHyNawYkF9kGV0KWFPl41dHkteXI+oV9nTLlRupYugJOI+pbgwvp1uHqyfnA/WW9fItFxYwf2EoWa/w1RvJ1oNWEuRUg3zjvmJAqj1QebDaJOXOHdpdClufVPOrfXmgXx3v0l7VAnlkzU6YkqI8QIdt+zw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8016f30f-ad6d-4fbf-28aa-08df3fa3ed24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:29:00.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ORh/g5h6kiHnjKEeKKVhpgVmUR/xX/XpIl8u6JmlhoUhQcN4AwY5NjCgGj/h54OJmiBhFd44f+bcb4ZaIL+fkKMGSrOdT2ziI1fxbfvJX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzaGEgTGV2aW4gPHNh
c2hhbEBrZXJuZWwub3JnPg0KPiBTZW50OiAxMCBOb3ZlbWJlciAyMDI2IDA2OjMzDQo+IFRvOiBT
cmluaXZhcywgVmlkeWEgPHZpZHlhLnNyaW5pdmFzQGludGVsLmNvbT47IExpbiwgQ2hhcmx0b24N
Cj4gPGNoYXJsdG9uLmxpbkBpbnRlbC5jb20+OyBTaGFua2FyLCBVbWEgPHVtYS5zaGFua2FyQGlu
dGVsLmNvbT47DQo+IGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogRkFJTEVEOiBwYXRjaCAiW1BBVENIXSBkcm0v
aTkxNS9kaXNwbGF5OiBEaXNhYmxlIHBpcGUgam9pbmVyIG9uDQo+IFdDTCIgZmFpbGVkIHRvIGFw
cGx5IHRvIDYuMTgtc3RhYmxlIHRyZWUNCj4gDQo+IFRoZSBwYXRjaCBiZWxvdyBkb2VzIG5vdCBh
cHBseSB0byB0aGUgNi4xOC1zdGFibGUgdHJlZS4NCj4gSWYgc29tZW9uZSB3YW50cyBpdCBhcHBs
aWVkIHRoZXJlLCBvciB0byBhbnkgb3RoZXIgc3RhYmxlIG9yIGxvbmd0ZXJtIHRyZWUsDQo+IHRo
ZW4gcGxlYXNlIGVtYWlsIHRoZSBiYWNrcG9ydCwgaW5jbHVkaW5nIHRoZSBvcmlnaW5hbCBnaXQg
Y29tbWl0IGlkIHRvDQo+IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPi4NCj4gDQo+IFRvIHJlcHJv
ZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3VibWl0LCB5b3UgbWF5IHVzZSB0aGUgZm9sbG93aW5n
DQo+IGNvbW1hbmRzOg0KPiANCj4gZ2l0IGZldGNoIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvIGxpbnV4LQ0KPiA2LjE4Lnkg
Z2l0IGNoZWNrb3V0IEZFVENIX0hFQUQgZ2l0IGNoZXJyeS1waWNrIC14DQo+IGI0MmI2NTZkYjEz
ODQyNTUwNDQ3NTRjZDIxNjNkMzcwZDc2NmI3NzYNCj4gIyA8cmVzb2x2ZSBjb25mbGljdHMsIGJ1
aWxkLCB0ZXN0LCBldGMuPiBnaXQgY29tbWl0IC1zIGdpdCBzZW5kLWVtYWlsIC0tdG8NCj4gJzxz
dGFibGVAdmdlci5rZXJuZWwub3JnPicgLS1pbi1yZXBseS10byAnMjAyNjExMDkyMDAyNDgtZmFp
bGVkLTYuMTgtDQo+IGI0MmI2NTZkYjEzOEBrZXJuZWwub3JnJyAtLXN1YmplY3QtcHJlZml4ICdQ
QVRDSCA2LjE4LnknICdIRUFEXi4uJw0KPg0KDQpIZWxsbyBTYXNoYQ0KDQpBcG9sb2dpZXMgZm9y
IHRoZSBpbmNvbnZlbmllbmNlLg0KDQpXaGVuIHdlIGFwcGx5DQpodHRwczovL3BhdGNoLm1zZ2lk
LmxpbmsvMjAyNjAxMDgxMjQxNDEuMTQwNzc2MC0yLWFua2l0LmsubmF1dGl5YWxAaW50ZWwuY29t
DQpodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjAxMDgxMjQxNDEuMTQwNzc2MC0zLWFua2l0
LmsubmF1dGl5YWxAaW50ZWwuY29tDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjEw
MjMxMDAwNTIuNjgzMTkyLTEwLW1pa2Eua2Fob2xhQGludGVsLmNvbS8NCg0KVGhlbiwgdGhpcyBz
ZXJpZXMgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1NKMlBSMTFNQjgzNDZFNTg3NTJGNzND
OUY4NkRFNjU3NkY0NkUyQFNKMlBSMTFNQjgzNDYubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8g
YXBwbGllcyBwcm9wZXJseS4NCg0KU29ycnkgdG8gYm90aGVyIHlvdS4gQ291bGQgeW91IHBsZWFz
ZSBndWlkZSBtZSBob3cgdG8gZ2V0IHRob3NlIHBhdGNoZXMgdG8gNi4xOD8NCkkgd2lsbCB0cnkg
dG8gY2hlY2sgYXJvdW5kIHdpdGggVW1hIFNoYW5rYXIgYW5kIG90aGVycyB0byBnZXQgc29tZSBo
ZWxwLg0KT25jZSBhZ2FpbiBzb3JyeSBmb3IgdGhlIHRyb3VibGUuIFRoYW5rIHlvdSB2ZXJ5IG11
Y2guDQoNClJlZ2FyZHMNClZpZHlhDQoNCiANCj4gVGhhbmtzLA0KPiBTYXNoYQ0KPiANCj4gLS0t
LS0tLS0tLS0tLS0tLS0tIG9yaWdpbmFsIGNvbW1pdCBpbiBMaW51cydzIHRyZWUgLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IA0KPiBGcm9tIGI0MmI2NTZkYjEzODQyNTUwNDQ3NTRjZDIxNjNkMzcwZDc2
NmI3NzYgTW9uIFNlcCAxNyAwMDowMDowMA0KPiAyMDAxDQo+IEZyb206IFZpZHlhIFNyaW5pdmFz
IDx2aWR5YS5zcmluaXZhc0BpbnRlbC5jb20+DQo+IERhdGU6IFdlZCwgMjggT2N0IDIwMjYgMTI6
MzQ6MDQgKzA1MzANCj4gU3ViamVjdDogW1BBVENIXSBkcm0vaTkxNS9kaXNwbGF5OiBEaXNhYmxl
IHBpcGUgam9pbmVyIG9uIFdDTA0KPiANCj4gUGlwZSBqb2luaW5nIGlzIG5vdCBzdXBwb3J0ZWQg
aW4gdGhlIFdDTCBkaXNwbGF5IGNvbmZpZ3VyYXRpb24uDQo+IFJlcG9ydCBubyBqb2luZXIgc3Vw
cG9ydCBvbiBXQ0wgc28gdGhhdCBtb2RlcyB3aGljaCB3b3VsZCByZXF1aXJlIGpvaW5pbmcNCj4g
YXJlIHJlamVjdGVkLCBtYXRjaGluZyB0aGUgNGsgNjBIeiBtYXhpbXVtIHJlc29sdXRpb24gZG9j
dW1lbnRlZCBmb3IgdGhlDQo+IHBsYXRmb3JtLg0KPiANCj4gdjI6IFJlYmFzZSBvbnRvIGxhdGVz
dCB1cHN0cmVhbQ0KPiB2MzogRml4IHVwIHRoZSBjb21taXQgbWVzc2FnZQ0KPiB2NDogU3BsaXQg
dGhlIHNjYWxlciBhbmQgam9pbmVyIGNoYW5nZXMgaW50byBzZXBhcmF0ZSBwYXRjaGVzIChKYW5p
KQ0KPiANCj4gQnNwZWM6IDc0Mjg2DQo+IEZpeGVzOiBmOGUxYzNlMDdkYjEgKCJkcm0vaTkxNS94
ZTNscGQ6IEFkZCBzdXBwb3J0IGZvciBkaXNwbGF5IHZlcnNpb24NCj4gMzAuMDIiKQ0KPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWdnZXN0ZWQtYnk6IENoYXJsdG9uIExpbiA8Y2hh
cmx0b24ubGluQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFVtYSBTaGFua2FyIDx1bWEuc2hh
bmthckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNyaW5pdmFzIDx2aWR5YS5z
cmluaXZhc0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFVtYSBTaGFua2FyIDx1bWEuc2hh
bmthckBpbnRlbC5jb20+DQo+IExpbms6IGh0dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MTAy
ODA3MDQwNC4xOTEzODQzLTMtDQo+IHZpZHlhLnNyaW5pdmFzQGludGVsLmNvbQ0KPiAoY2hlcnJ5
IHBpY2tlZCBmcm9tIGNvbW1pdCA5MTc2NzZhNTVhNjkwMzE5YTAxYjQ1ZDM5NTZlYWY5NGJhNTY0
ZGY4KQ0KPiBTaWduZWQtb2ZmLWJ5OiBKb29uYXMgTGFodGluZW4gPGpvb25hcy5sYWh0aW5lbkBs
aW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9p
bnRlbF9kcC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
ZHAuYw0KPiBpbmRleCBkOGMwZDkzODE0NzFkLi40Nzc0MTk1NzkzNWFlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+IEBAIC00NzcsOSArNDc3LDkgQEAg
Ym9vbCBpbnRlbF9kcF9oYXNfam9pbmVyKHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+ICAJ
ICAgICFjb25uZWN0b3ItPnBhbmVsLnZidC5lZHAucGlwZV9qb2luZXJfZW5hYmxlKQ0KPiAgCQly
ZXR1cm4gZmFsc2U7DQo+IA0KPiAtCXJldHVybiBESVNQTEFZX1ZFUihkaXNwbGF5KSA+PSAxMiB8
fA0KPiArCXJldHVybiAoKERJU1BMQVlfVkVSKGRpc3BsYXkpID49IDEyICYmIERJU1BMQVlfVkVS
eDEwMChkaXNwbGF5KSAhPQ0KPiArMzAwMikgfHwNCj4gIAkJKERJU1BMQVlfVkVSKGRpc3BsYXkp
ID09IDExICYmDQo+IC0JCSBlbmNvZGVyLT5wb3J0ICE9IFBPUlRfQSk7DQo+ICsJCSBlbmNvZGVy
LT5wb3J0ICE9IFBPUlRfQSkpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQgZGcyX21heF9zb3Vy
Y2VfcmF0ZShzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0KPiAtLQ0KPiAyLjUzLjANCj4gDQo+
IA0KPiANCg0K
