Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795417301;
	b=GFF5RXt1Mivky1X9Pf1qUdLgZiu3OmyfB0zTUxrEd0jNFvDNJWfNCIplDl66xJCgRpie
	 cx46Snv4ahbNc4fgYDEWKiwvPlVWiF60Ub2nnR9OgnrKwlEZ2oCn2nsPatinaLHaN0Y81
	 NsPfxLWyr3tupkK33GofbTeQsTqwCsIcFVeeTDMT1BylHnBS3sZ4aKCjSIhI8voINQ9hX
	 sBgGj7L/Q7zhp3vTN+N5Lsx438unvPhbl2cwMblWuc+wm3ut3vJAetkWtxZaHtEhCJRfR
	 /R9SPFXQjWA9ffYdk8K7txoDTKQtA7pNh5i+/ZOf4elhTb1i1MuJlan2pryW4+0tuMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417301;
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
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=r05fGTw5VhxJ7A4E34qZhQdtQilHGpwhLCdmaJJlxXg=;
	b=cjzKbC1UOo9++35BVpuOUz08IJC1bVuq4LqoRiwv/Naz3iTn/OA78pYvHsoO6vdrBZlS
	 G5P1ER+/IkyHsQFJNgO4Gi0VJi2hVDkZW1PmWwNDC1x6m+gOy5KZe+Jrse0JIRrJnR+vd
	 d1x+nXA+9r5KdYT3qIwo+QP5BlG+dCdr/duDfMOLGsvQ0thiJOXJq+r9OFA/+b1N+weEn
	 u/CFRO9PZyTH7rYuZVhaBeDBbkW/TJbsj346yiHLIJlgvqzHs9jQCQxeSdWIGjHZWVglT
	 IJ9hVaHWmB0I6brU8XTfWR+fyllhUrGUyg0Awu1XsDwy08CPQSPlnbF6y6tA3VC9MnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAg+Imjy;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ge4IfDuI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8E606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D8E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAg+Imjy;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ge4IfDuI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795417301; x=1826953301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r05fGTw5VhxJ7A4E34qZhQdtQilHGpwhLCdmaJJlxXg=;
  b=bAg+ImjybgYrszPlombBJCTchJor9hragleq2PmBv3TXrgBtc6xo7wyA
   2GHUYyjkAaougiaikmF2sc7iJEmA9szYz0rm+UjS/2NKUAdAvYH05FsDK
   3+uGZbdJUns1Gp97GA9GzwW3yTTKS6pcbdCqN7geg0Y0JMHA1yOceH/va
   EourTMbF2oEu7m4B5KT5EsGDLqCSoPqUjEQfq/moIsKmLzdBJjOm5CwS5
   hcmuYramOlHEG03Za9EodzhIqFqW+JZQjIUZKMvb8N9vV4GHs5gbhe26z
   YOJJaqMb7m9ZHlHC0LJDvzHdH+vtPF790giYnqkGUNXHmcU5ebbECXwix
   g==;
X-CSE-ConnectionGUID: 97Si2p/XRn2U78071Nj7+g==
X-CSE-MsgGUID: EI5emYUsRWmUHorjg9Dhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4223452"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4223452"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:01:40 -0800
X-CSE-ConnectionGUID: Z59zxKJISn2qy/msFVcFCg==
X-CSE-MsgGUID: vI/JYAYDRcWzaBHX7Oo+kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11527392"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 23:01:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:01:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:01:40 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpaL8kqrcX5+opq3B1dJejZWmJVGsAdz6l9MAGL3CuTNlie51SM6fzcR8dTgCv9T0JHHzpL9nHberiUS9UZUhfh0uEVIyRvZUfCWCXQPh3OBt7tTUTVj++510gkpjaasI2GhE9yYniB4pGp0wW5qzJAx1FgShWDT5n8Xxhp8II+HSlEG8kvAxOrLsZJLuZYz1fgWsNGV5d+rLKxxwYmlQC7wvTUXjpPRha+Ubd2jGDcsWsfqGL9C44cqYoUMyb3LmDO2mvEe3lS+jFCWIVKOlm3Pq7uzsl2RGtUX+XR76fzAuJO51k1mmE5YY+bnei/07zz2qcihqJyGeDMSnbbvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r05fGTw5VhxJ7A4E34qZhQdtQilHGpwhLCdmaJJlxXg=;
 b=RBjd33bUjx+KYJKo3zG4RvtjIXHEnQkES7t7ZcmHQl1jsiy+cAuyMHmQSz1MXtKreItfkO/ChVlddisq4WdGjOodD/vDVgt0PkOsFF1AyoVofMTDsu4JrXSrQcHC2MxGPzVaDf3XYHLtZgZoh/CfhthbHRc9KvmRlM4xT99uAxHG/ig8tjXyqaxC06puUjsr+/Friq9Mov9UmBhtTF5gKQJhd44wYOM0QiYUYxMCP0teSNMvGSue8jqHj0+peohlLCEZw4JZkOoFTVDkmfYu7azeNuDLa5L+eEKE7L0wXaXD92LZZmKNJArhNxl1BtlvEcfpPxmvYVF/EGxf7rwjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r05fGTw5VhxJ7A4E34qZhQdtQilHGpwhLCdmaJJlxXg=;
 b=ge4IfDuIWs4gjTFIyT6LiQUIsSF47dDeP9oghh09Aswmk9XDk7rThja5Sv8uKLvLy9ouaTPvPprm1VbRF42d9IECMcy+7q5Uog7t87NgTkO9ayrF/CHx+LNaEfRLCPUXlWRnysZ7n0fShN+E8abxoNtIEHdgrmSkj9qvi7CD3r4=
Received: from DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) by
 CHAPR11MB9656.namprd11.prod.outlook.com (2603:10b6:610:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:01:33 +0000
Received: from DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762]) by DM4PR11MB6019.namprd11.prod.outlook.com
 ([fe80::9086:5e0b:ad24:762%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:01:33 +0000
From: "Hogander, Jouni" <jouni.hogander@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Manna, Animesh"
	<animesh.manna@intel.com>
Subject: Re: [PATCH] drm/i915/alpm: Track the configured transcoder lifetime
Thread-Topic: [PATCH] drm/i915/alpm: Track the configured transcoder lifetime
Thread-Index: AQHdeOHgNqcqo7AH9UePc+PPTH5gBbc3DcIAgAQxaYA=
Date: Mon, 23 Nov 2026 07:01:32 +0000
Message-ID: <1f4f1837d526f4b41dbd6e72950ababaf763faaa.camel@intel.com>
References: <20261120112446.1562267-1-jouni.hogander@intel.com>
	 <df6089c2500a2f5d3b79bcaa2ac6a440222f7f4e@intel.com>
In-Reply-To: <df6089c2500a2f5d3b79bcaa2ac6a440222f7f4e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_|CHAPR11MB9656:EE_
x-ms-office365-filtering-correlation-id: 5d22e3ac-2690-49c6-e486-08df492f9b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|4143699003|56012099006|10067099003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: 6fFxCVbSl4Czn4woVPa9RJCbY6JMW4vCT9gHhXB7SyeFcxb4QAySvbwBuXt3JfDe4oxFLp9Ijkg/ahqITP5dZD6k25/6QONZniKmH7zKf+BU7QMrTlDvUhpUZSSLWkRCCfJ32l+x1FSPp2UJO+ozupxt2hq/rEtQhva4q+m8TvHWWGxde/qygF7GA5+o/5+BE3vxpu+Q7UY5wl7NGV38RRaL6b77849bwJnZG2L1FJg/G/fPSu38rJkTvHsT6MhBgUv9CvBKjwzhz+aNa2+IyloQzC/pWY5wao8FaYc7QkcnD8RwHMTib3cKH4ijwRb6NvkcLSw+lcJ578xaRxuErUfuD5YtUtR+rJkPIRHUVmQAN1oaJVAcF/Vi/UWqtOQaGTElg3BgHgUEQYzGhduyLa6qRLOxPf34vkWzC2HTMsVM2e7UW/vzK4rBRlYwsYtcXpzuYSdaUWj960Ks3rdOGH/+5PimQq8/CHsl0oEU8lftTQ909Uak5yEg1muIdTWwrO6i12y128ISbCznb7pi0ejCOXF+8ho4m6cK3fCElruoiugAttx9pwH/wfadJUeqzK0vK5nRHd2ueKpmX+grPE69e2ErJYa/vDbfbFDJ2DYJZ1FaMfBmko/Yjv/dAR4QEY0xH+hsnu50NeCOW3gmjNifCDp2gFS/yNhLUkn0G6jTHM4Lf6VaIJo7JipwKQSLw60NpdnY5vAeLM8Wh0rXewi+sMnz+JmPpBdpLzieaJQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6019.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxGUVZpeVozdG8zSmF1VVY0UzdXbjFvRUdWWVRZa0gvUnkvdi9hUWViZGg4?=
 =?utf-8?B?OTN6RnZ1SXc2R2dHZXV5WWtDaGpKYUZLUzRSS09nOFZocVROb21FT3BFSWEx?=
 =?utf-8?B?Ymd1a092dXBrNmx3dkNSZUFmMUFtUEtRSDJNUEF0N0IvZHZ5MWxJd0pOY051?=
 =?utf-8?B?WXMwY0plWnl0Y1BMMHJYWTNIcDZGdlgwK0xSTGRVU2Z2WkZUK3F6S3JFaG5N?=
 =?utf-8?B?anFPeGI0UnduNzM5MzQvNFFJT01qVTJmMmVrQm4za2dwOGh5K29LZVRqdUY4?=
 =?utf-8?B?bHlwMHROS2x3cW1EM09JY213NVZsM3dlRGNNcEY3OGFDMWpkN1hRWUh6K0d6?=
 =?utf-8?B?NGJBR3BCdVRKUktJWXNyb3duY1lBbVV5cTh6cERRNnRKRndwYnRobW9yY3RF?=
 =?utf-8?B?Umk5SmJCMFA3azNKK3N6SGVPL3hiQ21uNVF3VkZ6ZmxBOFZtYlcyYnIzaThy?=
 =?utf-8?B?NFpBQk5mMkNCNFMxcGF4a3IwZExCczRCR1VwMUd1Vy9mSlBlN1c3Vm5aRUE2?=
 =?utf-8?B?ZDhKWUhqZmZpTVhOdnRCdWJkNUtlNEZCbWo3YVlQcUhiTGI3YlpON1M3VWxl?=
 =?utf-8?B?b2Q2UVVmSjhjcmZzMFlNeVhoVm5RZW9KK2hwTEVKMEVWMG1xNldFNVA1cktD?=
 =?utf-8?B?Y0haTE5Cd2dsSUVIRFRRY3BidXdUQjJBdkkyYXZjaXlNbHc3MnN4RTJQYVNO?=
 =?utf-8?B?SGNpUmduaVEyOEVvY3kzQjQwQmJBMHNXMm15TzUvVVVuUVNhbUJ6Y2IwbGMv?=
 =?utf-8?B?T1U4WEpSOERGRUJzeVcxZTQranFSZEFSQ2RZNXVvQXd5TTI0a3FEV3YyWGZo?=
 =?utf-8?B?SVhyRnRmdml0d21jbjhrOU1aSGJ5S2dYT0gwL0hXWVVvQk1wMXd1Y2NNNmMv?=
 =?utf-8?B?MVZJRjViRlJWY1VsZ0FrYkdoeGQyUkhSSWJ2bTNwaVcrbnVmK1FpbEcydkNo?=
 =?utf-8?B?ZmZ3NGFCK2NuTDlRMVdYYlhDV3FIS1BZNUpaZ0lzNjE4M2UyMzl6OWg2Njc1?=
 =?utf-8?B?c1lWSFFXOEdIZEo0SmE1MFY0VnFJZyswMklEaEpMaXVRR2daQlJGd0s1bDdh?=
 =?utf-8?B?UXF6L0x3VlA3SU5LOEcvaEY2dTd3a2RkSi82dGRzbGJOZWpCZHZWYmVVZ085?=
 =?utf-8?B?S05YcG1GVWVjS3h6Tm51VU9DYThkbzAwZHNHczZGcWlHQ2JKYXVlZlg3MWE4?=
 =?utf-8?B?eGt4bWxaYlZLYnZTMWZKT3JHak5HV2hKM1NZZ2ZhQnM0YzMwckJKVXdITG10?=
 =?utf-8?B?NzlrRVZFd2djM2p6L3dpbGtWa0J5cWliWVZEakt0MDlQUG9vVStHaytNbmVN?=
 =?utf-8?B?cW42dGRCOTJDUUlWS3VRYXRjODlqQnc3RGV0YTNBZUtCc0F4MStCdUtPZ1V4?=
 =?utf-8?B?cmxSN3kzd2dTY29DeklHOHZvNEwxRkFxK2tCSUwxYzY4NU9OUmxTbmNqQXdv?=
 =?utf-8?B?KzBBdHBXbDV0OXRWNnE2UmN1eTQxSC8xRGlLN01EME1oaHNmWW1QQlUwWVlZ?=
 =?utf-8?B?akh5ci9SUWh4M2hzS1k1OHhEMkFtZWJGczFOS0lQOFM0RVJFUjRrNWlJK1hk?=
 =?utf-8?B?cWlqQTU3YWswRlNmcU16SlRRRWFTZWt2ODZuMmFyYjFrcGFZSDZnbXNTVVZI?=
 =?utf-8?B?WTZBQ1BuUnpweCtXSUtaZlBXUUVTaURZWkhUQlZ0VEU4eFBXN3ZrR3ZmUlVy?=
 =?utf-8?B?RTNObDRtNVloNDlCVHZWMU9vWXZIcm1sdWhpUno5MjBiLzM1SDBSb0FkaGlz?=
 =?utf-8?B?YitVN2RPZWdJdy96YWMrcERCS1NWV0QxYk0zdkxKUzlKMlR1dW9IRmVKWnQy?=
 =?utf-8?B?cGd3cXZwY2YrTWtPb0xFTVdYeXVMMi9tc0hNRGhSS1J5NmpjdHloWXhnSS85?=
 =?utf-8?B?Qk1WdUpPUy81RXFDWWlZd3AwL0VCRTN3d3RyeDZYMEs4MGRPRXJCMGxXL3JO?=
 =?utf-8?B?UklnNEdxKytLTjFWTTJabWtjclo3UndXYUpadDJYamwvSHFZY3hvWGdtNUFM?=
 =?utf-8?B?bWlPNGtOV0N2MVM4eEVZV0d2NUxzQ3Y4WkFxcko5Sktoems2U050NmRWekVT?=
 =?utf-8?B?K09acXlWKzhiYmx4ekxYeFl1YzljMURlMVZEcGdHNHRzelptUVJhVW1mTm5K?=
 =?utf-8?B?THgxR205a3pWeDJWNmlVZDFrL0ZKTHdTYU5xYXNVRzE4eUhEeXlWSkVUMTIw?=
 =?utf-8?B?dFUrMGxLdURPV1Y0dlZkUG1qR29ZcTBLb2JkUGdGSFo4aDMyVUE1R1VHRkJP?=
 =?utf-8?B?UldNZStkNjUyM210cUhXOE04OXNOTXV4ZW5TU1RadTVMNE9FYVBvb2s2MU9I?=
 =?utf-8?B?dVVWTFZkc3NiUGhHT0lmZDNsZzJJOWsyVzg0emZQYVQ3TDh5YTNXN0NVV0xZ?=
 =?utf-8?Q?hXdviwV+0n+01QCk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E37CF4D4D04844FBEB920C02401F070@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: PjGoqYUZ9e+k1lMs6/Tzh6CkHBdEJfD/0QzbGi4HnGepmvZhWpcVWAOFFWAz4t10HkcoV8InAKYXFiwGMrgxS/bgT0ObpCCePGEpOJI+96ZCATnnjiPoT7XX5J48xmbPnarP9TCTN6MDQFkDRS0xT5Q8t9D/BDCgTWBAV23QP2ORDae6vbBlxLT2phQ6GOmJCFeKPT98unypj1Clsejjc4fQAb3q6h+AvjNqoJ85mbrQStuipiGB4sazOgnYc5GXCTsFgCFOaNpAKnTilC4xbUQOtPjD34Jx2xsZxOq8BFRNsyy2P2BaI0wRJrfVeCS7P0DbUcVxMFRVl/QZlMmzNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d22e3ac-2690-49c6-e486-08df492f9b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 07:01:32.9695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCac7pLwjSCXS/qad3OYcS/JUlc6/mA8hFAjuG/cbL3W6N1X4jhTkRfVqb8WnsrDcIPZyvz33MuqrM5ePjQFKvfI7J7mdyBFWIuguwUqxts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9656
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTExLTIwIGF0IDE2OjU5ICswMjAwLCBKYW5pIE5pa3VsYSB3cm90ZToNCj4g
T24gRnJpLCAyMCBOb3YgMjAyNiwgSm91bmkgSMO2Z2FuZGVyIDxqb3VuaS5ob2dhbmRlckBpbnRl
bC5jb20+IHdyb3RlOg0KPiA+IEFMUE0gZGlzYWJsZSBjYW4gYWNjZXNzIGEgc3RhbGUgdHJhbnNj
b2RlciB3aGVuIEFMUE0gd2FzIG5vdA0KPiA+IGNvbmZpZ3VyZWQNCj4gPiBmb3IgdGhlIGN1cnJl
bnQgbW9kZXNldCwgY2F1c2luZyB1bmNsYWltZWQgcmVnaXN0ZXIgYWNjZXNzZXMgZHVyaW5nDQo+
ID4gcGlwZSB0ZWFyZG93bi4NCj4gPiANCj4gPiBSZWNvcmQgdGhlIHRyYW5zY29kZXIgb25seSB3
aGVuIHByb2dyYW1taW5nIEFMUE0gYW5kIGludmFsaWRhdGUgaXQNCj4gPiBhZnRlciBkaXNhYmxl
LiBDaGVjayBpdCB1bmRlciB0aGUgQUxQTSBsb2NrIHRvIGF2b2lkIHJlZ2lzdGVyDQo+ID4gYWNj
ZXNzZXMNCj4gPiBvbiByZXBlYXRlZCBvciB1bmNvbmZpZ3VyZWQgZGlzYWJsZXMuDQo+ID4gDQo+
ID4gRml4ZXM6IDUwNDc2NjM4MmVkYiAoImRybS9pOTE1L2xvYmY6IERpc2ludGVncmF0ZSBhbHBt
X2Rpc2FibGUgZnJvbQ0KPiA+IHBzcl9kaXNhYmxlIikNCj4gPiBDYzogQW5pbWVzaCBNYW5uYSA8
YW5pbWVzaC5tYW5uYUBpbnRlbC5jb20+DQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
PiAjIHY2LjE2Kw0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9n
YW5kZXJAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEphbmkgTmlrdWxhIDxqYW5pLm5p
a3VsYUBpbnRlbC5jb20+DQoNClRoYW5rIHlvdSBKYW5pIGZvciB0aGUgcmV2aWV3LiBUaGlzIGlz
IG5vdyBwdXNoZWQgdG8gZHJtLWludGVsLW5leHQuDQoNCkJSLA0KSm91bmkgSMO2Z2FuZGVyDQoN
Cj4gDQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Fs
cG0uYyB8IDExICsrKysrKysrKy0tDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9kaXNwbGF5L2ludGVsX2FscG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2k5MTUv
ZGlzcGxheS9pbnRlbF9hbHBtLmMNCj4gPiBpbmRleCBmNTRiMjllMTkzZWU5Li4xMDUwMDZjYTZi
ZTdmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxf
YWxwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9hbHBt
LmMNCj4gPiBAQCAtNDYsNiArNDYsNyBAQCBib29sIGludGVsX2FscG1faXNfYWxwbV9hdXhfbGVz
cyhzdHJ1Y3QgaW50ZWxfZHANCj4gPiAqaW50ZWxfZHAsDQo+ID4gwqB2b2lkIGludGVsX2FscG1f
aW5pdChzdHJ1Y3QgaW50ZWxfZHAgKmludGVsX2RwKQ0KPiA+IMKgew0KPiA+IMKgCW11dGV4X2lu
aXQoJmludGVsX2RwLT5hbHBtLmxvY2spOw0KPiA+ICsJaW50ZWxfZHAtPmFscG0udHJhbnNjb2Rl
ciA9IElOVkFMSURfVFJBTlNDT0RFUjsNCj4gPiDCoH0NCj4gPiDCoA0KPiA+IMKgc3RhdGljIGlu
dCBnZXRfc2lsZW5jZV9wZXJpb2Rfc3ltYm9scyhjb25zdCBzdHJ1Y3QNCj4gPiBpbnRlbF9jcnRj
X3N0YXRlICpjcnRjX3N0YXRlKQ0KPiA+IEBAIC01NDksNiArNTUwLDcgQEAgc3RhdGljIHZvaWQg
bG5sX2FscG1fY29uZmlndXJlKHN0cnVjdCBpbnRlbF9kcA0KPiA+ICppbnRlbF9kcCwNCj4gPiDC
oAlhbHBtX2N0bCB8PSBBTFBNX0NUTF9BTFBNX0VOVFJZX0NIRUNLKGNydGNfc3RhdGUtDQo+ID4g
PmFscG1fc3RhdGUuY2hlY2tfZW50cnlfbGluZXMpOw0KPiA+IMKgDQo+ID4gwqAJaW50ZWxfZGVf
d3JpdGUoZGlzcGxheSwgQUxQTV9DVEwoZGlzcGxheSwgY3B1X3RyYW5zY29kZXIpLA0KPiA+IGFs
cG1fY3RsKTsNCj4gPiArCWludGVsX2RwLT5hbHBtLnRyYW5zY29kZXIgPSBjcHVfdHJhbnNjb2Rl
cjsNCj4gPiDCoAltdXRleF91bmxvY2soJmludGVsX2RwLT5hbHBtLmxvY2spOw0KPiA+IMKgfQ0K
PiA+IMKgDQo+ID4gQEAgLTU1Niw3ICs1NTgsNiBAQCB2b2lkIGludGVsX2FscG1fY29uZmlndXJl
KHN0cnVjdCBpbnRlbF9kcA0KPiA+ICppbnRlbF9kcCwNCj4gPiDCoAkJCcKgIGNvbnN0IHN0cnVj
dCBpbnRlbF9jcnRjX3N0YXRlDQo+ID4gKmNydGNfc3RhdGUpDQo+ID4gwqB7DQo+ID4gwqAJbG5s
X2FscG1fY29uZmlndXJlKGludGVsX2RwLCBjcnRjX3N0YXRlKTsNCj4gPiAtCWludGVsX2RwLT5h
bHBtLnRyYW5zY29kZXIgPSBjcnRjX3N0YXRlLT5jcHVfdHJhbnNjb2RlcjsNCj4gPiDCoH0NCj4g
PiDCoA0KPiA+IMKgdm9pZCBpbnRlbF9hbHBtX3BvcnRfY29uZmlndXJlKHN0cnVjdCBpbnRlbF9k
cCAqaW50ZWxfZHAsDQo+ID4gQEAgLTczMywxNyArNzM0LDIzIEBAIHZvaWQgaW50ZWxfYWxwbV9s
b2JmX2RlYnVnZnNfYWRkKHN0cnVjdA0KPiA+IGludGVsX2Nvbm5lY3RvciAqY29ubmVjdG9yKQ0K
PiA+IMKgdm9pZCBpbnRlbF9hbHBtX2Rpc2FibGUoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkN
Cj4gPiDCoHsNCj4gPiDCoAlzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqZGlzcGxheSA9DQo+ID4gdG9f
aW50ZWxfZGlzcGxheShpbnRlbF9kcCk7DQo+ID4gLQllbnVtIHRyYW5zY29kZXIgY3B1X3RyYW5z
Y29kZXIgPSBpbnRlbF9kcC0NCj4gPiA+YWxwbS50cmFuc2NvZGVyOw0KPiA+ICsJZW51bSB0cmFu
c2NvZGVyIGNwdV90cmFuc2NvZGVyOw0KPiA+IMKgDQo+ID4gwqAJaWYgKERJU1BMQVlfVkVSKGRp
c3BsYXkpIDwgMjAgfHwgIWludGVsX2RwLT5hbHBtX2RwY2QpDQo+ID4gwqAJCXJldHVybjsNCj4g
PiDCoA0KPiA+IMKgCW11dGV4X2xvY2soJmludGVsX2RwLT5hbHBtLmxvY2spOw0KPiA+IMKgDQo+
ID4gKwljcHVfdHJhbnNjb2RlciA9IGludGVsX2RwLT5hbHBtLnRyYW5zY29kZXI7DQo+ID4gKwlp
ZiAoY3B1X3RyYW5zY29kZXIgPT0gSU5WQUxJRF9UUkFOU0NPREVSKQ0KPiA+ICsJCWdvdG8gdW5s
b2NrOw0KPiA+ICsNCj4gPiDCoAlpbnRlbF9kZV9ybXcoZGlzcGxheSwgQUxQTV9DVEwoZGlzcGxh
eSwgY3B1X3RyYW5zY29kZXIpLA0KPiA+IMKgCQnCoMKgwqDCoCBBTFBNX0NUTF9BTFBNX0VOQUJM
RSB8IEFMUE1fQ1RMX0xPQkZfRU5BQkxFLA0KPiA+IDApOw0KPiA+ICsJaW50ZWxfZHAtPmFscG0u
dHJhbnNjb2RlciA9IElOVkFMSURfVFJBTlNDT0RFUjsNCj4gPiDCoA0KPiA+IMKgCWRybV9kYmdf
a21zKGRpc3BsYXktPmRybSwgIkRpc2FibGluZyBBTFBNXG4iKTsNCj4gPiArdW5sb2NrOg0KPiA+
IMKgCW11dGV4X3VubG9jaygmaW50ZWxfZHAtPmFscG0ubG9jayk7DQo+ID4gwqB9DQo=
