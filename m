Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793871988;
	b=tviYV5HN52aOT/FImLEoML1reL2bN9RKQRibCdenN5RkpLwQLiwqPZc2eqsB0l/NLF52
	 TDuSPnGvZUcm4bNfXWPvV0QBui3n7k3jeceCtgygmry2SxKvDu9U+6pIlV8/2wXvHxtWw
	 vkZWtHfJ+JQS7FxefXhsQ4bgLiWIgwZEQFn7mDws+9orQ+JPMw6sijMLEnwMJ3DMEzAH4
	 mxn7SRQcxNlMz/H05FvlfUhgedV9hBJHHVsE4dH04oahdIjS+0mea3Ht8Uw80jR14Mq7I
	 ALMI+JOlzfdlZAuHqjDt/eduxMoEIugaNTBmMudhIw/eU4yGHZob0+nAJFlDjhjTczQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871988;
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
	bh=EHhCVT5/esnKdxxI62mMwd9M+CRmigq/Krw+7OkFN20=;
	b=wH8T1j1ko+6mCx3A7WCVJZ5U77GksxzNQtspoYTtaWx/9xOPqFIadtQe8FZfypjEdALX
	 RxasLUNpU9SeOCUqrpRuo7ICMLvUueStZn0HzB+y85SZuFce0hYrz82MKQsh59t8a5GmM
	 VYt1kBXsQPCdxhuWYlg1ZQENAqOfSM6ZcKGtk1nZizXWYwWTqmTMwJEbpWWP8MYq+l+f2
	 DYOk3fKhmCbBxgX4W6xU8zGVSzYvBWXWsRC0dyxoZ+3mo6+/GdUbhQ9U3JoNpLggU7HtB
	 6P1gzeheV4xEpDOA6CmRgcg5ZDuWEuSORDrfiPUTXwBqVcvMHZuOAV/BEVDbh8VtE2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="c/mO2Jer";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7977606A31B;
	Thu,  5 Nov 2026 09:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7977606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c/mO2Jer
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793871986; x=1825407986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EHhCVT5/esnKdxxI62mMwd9M+CRmigq/Krw+7OkFN20=;
  b=c/mO2JerR+SUeWZv8V7/jFUPTQ3SCybwWG0W7pobrT294pPteMntnYqM
   szEPqwm3eSO4FcmJlj4i7cd+nj7KFSWqJ5udqDtpUVu4WySrfgTY8jr7O
   fZx2VZUiW7iiJ4334jmh0ckput1fhTe8ah9l7q6qO47EEvrvqjvMyWIx3
   bDGRaS+mGmr43pIvVR1m6TH5NemTaqhBfIYwituu0vhQ8TJlqr7YMugWA
   gTAT4abRUGAAC3WR01sO0VbBzlEs4vFxKI7OkTPotr0sLRAQh2ShUQBdM
   qDytgWClm0ir2s25AEFgfWPWU2tWuUefJ/63DwtWIKNgNyvUiwcRBh+Cu
   w==;
X-CSE-ConnectionGUID: DRGNzHUuTlKVfRhG1zVxvA==
X-CSE-MsgGUID: M15mtqIdSNudyZk7dW6A2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2668652"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2668652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:46:26 -0800
X-CSE-ConnectionGUID: 0VdnDvE4S8WTWVw1P76GxQ==
X-CSE-MsgGUID: 415XZYTdTLuN0dLD89H9Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6860956"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:46:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 01:46:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 01:46:25 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 01:46:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJQixB5S+6hVpbK/ifcms18Fsxe4kVhn+0EeM3hF2pC6tp4FMq4AKwZEhaQQ0DC2LxHqgBFgRZyN6oh8zSA6gIoW9JnZIXVch70GTFAfPndvwiM1vJiDJDIBZAdjDb4gFjehOaCh1Clo0cWA+08+FxHxokMI8247QNGECUyHBn9v/iblVPtZ6qE8+a/TKNeAswl7wJrkdNipgX5MNrEBngzisDZ7MAF5TmDhugd+qzlak1b/jj7bGunftRAP600l+UqY/2n67itv2+c7xiN/ao+YQQ1NQ40KfiV1I1SvexcyCiDSG6C7UyY4xWmwvCYWUcTTQmYJuIXa3+YJDGEoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHhCVT5/esnKdxxI62mMwd9M+CRmigq/Krw+7OkFN20=;
 b=IT4tuO0ZXhy3BpFU+D/tfIz7SZrY9qniIkVfk+CjsdbYT19sfXRontSvYc283tOYPdTNBRC9tcEMaLqtr5Pugd1fdVNa/hiXYX/FM6vOAF+nMlivpLmFLUyKlEyRBChtdzphhGbAnU5zAwpI/mlOBebX995f/7LxwqMGXqLW40Qn+c78fqQLg27ygjwJ6VVnBVhtQ4KHqicSmmLpg48lyHelrAXIWweb+OcbSWLSYS4NWnsPmioUUyIiRBpKVzYdhBgTnty8sf7CfTvwR4I3KlNSE5KVOBTgc91QVVOeh9trDrlRlp9gUJCxMZ6VQhNe3PoPjNP0YxBf0I6gUWvzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by CY8PR11MB6866.namprd11.prod.outlook.com
 (2603:10b6:930:5e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 09:46:20 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:46:20 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "tkusters@aweta.nl" <tkusters@aweta.nl>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander Duyck
	<alexander.h.duyck@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
Thread-Topic: [PATCH net] igb: do not let a VF set other VMOLR bits through
 its frame size
Thread-Index: AQHdbCagFqUY3rWnhkCEAI2TlSxHMbcfPJgg
Date: Thu, 5 Nov 2026 09:46:20 +0000
Message-ID: <CH3PR11MB5668951D97E4B7A4F177F8536EE5772@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
In-Reply-To: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|CY8PR11MB6866:EE_
x-ms-office365-filtering-correlation-id: 40701ba7-fdd6-4d58-be19-08df3b21a54b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|921020|38070700021|5023799004|11063799006|56012099006|261021121427099003|261021135927099003|261022075727099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|13003099007;
x-microsoft-antispam-message-info: bdhBt5hNI/rruPiyDnlXWFkKjyyoLDTXIRrGEYkCME8BC4BXVacbjsvSpcat5XEGh64A6IdXLOD4fgZ2MoCvlaEwqX1uUgYoQCRYkdWUpT0iHIhCyh53Slr4qb0X5pXVbkRDe+fNv5BAzN+ts6Cu6mTmpI/8Z4RciPvWk0FK+PIwX7uBGXZLhYA5FZFgozDv+uQOL8hdvEaldJ9fu4QhvoqCd0A/qsGOvaM3nVSxcHsli/nl9eoVzE8qtMnQzTZ1a0qipvEayjtuOMKudBRcXnc8CSU+pr/aoTIjVoi1dWZEAxdxS7I9pr/yspFmVM0mWbdB6SHau0x72MzNro5B6vQFV2bUBQMAoezJiWwNytjOBSqIaEBRmAf+Rf11o7uYW+AHcVTYtT4+zsK9nwcEidsbtRhu9cFmO88SpYVbcgAiF6CKrDy4LIQiq9xd95drd/LHV7/XozG7d3t86vgtMzJ3jVRZVTkMgsKch7nUSqLYBnTJZBzn0ZUI7IwjojompffTtNx3uJUUt3PEzZ147gNpQcPm/l5+hXSnVSCuaX7Qlnd+6Va/qjK8/XG/0ynFIOpfYskq/suzEHM0hfkOrU3GTBxKfFioXw2aOzrzopsZBOU3nyoEIhtZo9YA/aHiXtl1vta99K6g/ei6QwmFUD1zTcGhOV2BcvxcKm7cellhoHgXT9xGZGtnQ06b4MXa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(38070700021)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261022075727099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vmcxa3NmWndEVkt2WEJrNzIzQTY1K0I4VVRGcHNXZDFNV2g1WDBGL3k2RThE?=
 =?utf-8?B?T0VNK0pjQmdrRzk2Yjg5WUxjRS92MkRWb29SOXFGZmZCRjY4V2prbDRHRGN5?=
 =?utf-8?B?S3p3cHhHcHhGZUYwaVJNTDBHdUxFYmdCZERHTFNaNEVXbEhQY2x4NjJ4U3N4?=
 =?utf-8?B?RGg5RVlOZXIwa3g3L29jYVlwWFl5ZVdnT09MTFlrd05pM1pQcmNBRU1rRXdk?=
 =?utf-8?B?TUVyT3FCcTRZa2xEVjc1REx5NFhpSm9vTmpHNlEzelMvWUNBNmp2OTU4UXRK?=
 =?utf-8?B?aTJycmkySVJzYmtqWStaT2k1aUxkbnFwZXNjVXYyWHcrTVJKUkYwWXBTclpq?=
 =?utf-8?B?eVBuMWkrYWtOTCtuMkROWHY4TlFiSkduT1VyZndvMGRDTmIvRFh6bTFvYmk1?=
 =?utf-8?B?eVV5M1M0d0JoM1lQL3gwQmFQbDg3ck0veUlyZER6ajJxeEFhK0c0Q1d0UDZ6?=
 =?utf-8?B?cWZUZzFoUkpCazRuZ29MdkxXQXE5NzJ3blN2UEpaaGtkOEk3TjJOMldBd3do?=
 =?utf-8?B?N2JzUk0xcUVPVHllenBUcmRoS1hoVjd1OFBsU1B6cTUwK21EdEpXemFDOVB6?=
 =?utf-8?B?TENTNmc3RFdUay96R3FyL0NlcEQvcnM1WWNPMXVJMTVxWTVKU04wRzBvZlpM?=
 =?utf-8?B?UHZ5UXZSTzAxR1MwUS9qc1BDUTVndlA5N3gvTGh1ZGN4Y2Q2ZjVKZ3pBTzQ1?=
 =?utf-8?B?d1lKeFJQTEZ1SERIQmtHdjk3MHRDWENTQWRjU3RKNG5yczZ1Z0VzMkpxcUYx?=
 =?utf-8?B?dldBM3FROTBPYU5vQzVOMzFJaEh4WjUwSktETUZmS2FaNkUzTm1KZGhNK3Mw?=
 =?utf-8?B?a2Vzc25Wd3YwckZhZGJiOEdWKytNQXhXKzRkSVp6VnBVYVNhZ1ZCZkJsOWY4?=
 =?utf-8?B?ZmNKeE05K3ZvVVp0NmUwTTRYN0FwYTdrMlptTnpjMUhZYlJpRG5jUTZWa0FH?=
 =?utf-8?B?R2hJQ3laT1BoYW1DTHc1czBhZ3o5NzN6M1lrcUM4MkdwV3FsMVlueVN2aEtF?=
 =?utf-8?B?ZXo2ZG12NldjWmx3SFVYenM3aUNBbE5DZlpJSVdwQXpJSkpUZjZxbUFpV2Ft?=
 =?utf-8?B?NnFTejY4cFIwRTZNT2Z2VkdaR1ZlYW5lU3ROWGI1dWpPSWhCWmpPNEtKRGFk?=
 =?utf-8?B?UGRRUmZmYXVGYmZwOTFpWkRzcmhpQnpGZC9UOG03S3B0bHZkdHVVc05QaWdB?=
 =?utf-8?B?NGxiRlJ2ZFNkVlU5b1ZERUNSdDVRNVFYaWM5T1NLeUtYelVoRFFQeDdOR2V4?=
 =?utf-8?B?eHBySEZ3QVM3TGYrdytMcnY5WDdVcGNhUTdiRDJzYUxjeVpacFhyNGpENzdG?=
 =?utf-8?B?alZMTFNwN3RZLzlvTFJhM21KUWFWMDlFZkhCeWtqWXV3WSt5cmoweWZTMXlL?=
 =?utf-8?B?L2hMWGRzRHdzLzlLK2ZIbHNnRERjQ3JoZWFXYWNSZkxHZEx2K2xpRnZCdnhk?=
 =?utf-8?B?N2JLeFpsVHRPYWk4YkJzNnZjL0FJU1htYUpCTUg1TWpoZWNPRjhweEEzMzlj?=
 =?utf-8?B?bmhnWW1Ybko5dXh1Y05LSU5KL0l1cjhCbDVQaWVCRnBnMmJiUEY0Zlp3OFdj?=
 =?utf-8?B?NEo0ZStXaUNpMUpCczZmM0pIZ0QyVkxSUXl2SnEvTUNwOEd5bkVtYlY1OVRU?=
 =?utf-8?B?YnJCR01EbjlCdzNxTE5zNGVieGpNbERLK0NBWEczeTN4alA3UVVaaUZrV2li?=
 =?utf-8?B?M29PM1daeDFESXdQeFdaa3JWWVVHajVTL2Y1cGZDMmtNK2tKWnN2dVdkeS8w?=
 =?utf-8?B?R01kQ3Q3eGszRUVYTDRIQWlZTWREYkEwNytYQ1owbWp0ajBBekFPVUVtUnp1?=
 =?utf-8?B?cmphMG9sYjBQamY3QUNVTjdPVTlxaUQ0RytqT1ZGRXRUTnNlbzBMYkRLV2NX?=
 =?utf-8?B?cE1tOTdRZjNXMUFZK1U2TEgzRWpRWEMvcWhaSHZ5ZmZqQXpaS0xVZTdCd1Na?=
 =?utf-8?B?aGwvVFhoazNkZUdGeFpCQ1oxUlFzQ0J3UWh3SDFYTVZjdjl5bUpIK1RXMldL?=
 =?utf-8?B?VzhsdFhWT0lwekkzV29UUHFpUU5leVBwNTJBdmRxRnkxVnoxVWpYNjYrSlVy?=
 =?utf-8?B?T3crSWlDL0lhL2pwakN6Mmk4VzJpY040ckUxRUYwdGdVS3QrckU5cDFQVzdD?=
 =?utf-8?B?ZHZBVnlqbWhnVGJFMVVkMTZkcDhJdXhQcUVvV1F3TUpyeU5FbmdsWFhLMlRo?=
 =?utf-8?B?QTRmR3lMN05WQXhQU1hpQ1NGb1QvMmFlZEF4NnJEUkY5bzJQU1ZJS0ZxanBa?=
 =?utf-8?B?MlN4ZFRCMEI2WWRTNjNkY0l0NkZvMjB5Rm1GT3QrcXVpYmdKOE1NQTF2dVNI?=
 =?utf-8?B?aEpqSG1ENHRHMnRaRzhqTk5MNHVobFhkQjVPQ2l1SVdHVUNOSFdWY1RVTkFR?=
 =?utf-8?Q?qvS9Nvgari1DOPFw=3D?=
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
X-Exchange-RoutingPolicyChecked: vgowuuMDe8+bR16fVpwdvzjxy5I7bp0v8BiJOUerQaplmOa6Ab1oFVRpr9QPCxXZA6FvjpHjuN5dYCHjsaH3dBqDXHP4gUqz4O9HJ+9v4Rdyqh9zrrFCKA6mIzI5dAbpiEIJhncSOgjrGJOo32zMW+fpjxotbXppe/kGnozS9jC8nw4Rn4J7KFFHCbzdItkuPJXC7DpTENjw+knQAI5b8jvl1yPA5QnJb6dAla8jpY6STqu8SUVYLMMlHlIilgZBtdl9Ns2AYVpTaALKMidA5i43tlkSgOXoAQSZIu3Iz60JLbRDgabWZobQ//yyc0UA0Oixtd8O5Q7HsYFU3Uyswg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40701ba7-fdd6-4d58-be19-08df3b21a54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 09:46:20.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EY7vyEa89gskXZ2fRzXUM/xCE+/LwbuWmwxGDMh0VzmL8/ix/9Y9KIi4wd4e1CHa+1doWJJTa7+vPX3svP8Ltjickr/LSaKwsp9oiHzzy6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGplcmsgS3VzdGVycyB2
aWEgQjQgUmVsYXkgPGRldm51bGwrdGt1c3RlcnMuYXdldGEubmxAa2VybmVsLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciA0LCAyMDI2IDc6MzUgQU0NCj4gVG86IE5ndXllbiwgQW50
aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcN
Cj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25l
dGRldkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pjsg
RXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBrZXJuZWwub3JnPjsgSmFrdWIgS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVkaGF0LmNvbT47IEFsZXhh
bmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KPiBDYzogaW50ZWwtd2ly
ZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBUamVyayBL
dXN0ZXJzDQo+IDx0a3VzdGVyc0Bhd2V0YS5ubD4NCj4gU3ViamVjdDogW1BBVENIIG5ldF0gaWdi
OiBkbyBub3QgbGV0IGEgVkYgc2V0IG90aGVyIFZNT0xSIGJpdHMgdGhyb3VnaA0KPiBpdHMgZnJh
bWUgc2l6ZQ0KPiANCj4gRnJvbTogVGplcmsgS3VzdGVycyA8dGt1c3RlcnNAYXdldGEubmw+DQo+
IA0KPiBpZ2Jfc2V0X3ZmX3JscG1sKCkgZ2V0cyB0aGUgbWF4aW11bSBmcmFtZSBzaXplIGZyb20g
dGhlIFZGJ3MNCj4gRTEwMDBfVkZfU0VUX0xQRSBtYWlsYm94IG1lc3NhZ2UgYW5kIHRha2VzIGl0
IGFzIGEgc2lnbmVkIGludC4gQSB2YWx1ZQ0KPiB3aXRoIGJpdCAzMSBzZXQgaXMgbmVnYXRpdmUs
IHNvIGl0IHBhc3NlcyB0aGUgInNpemUgPg0KPiBNQVhfSlVNQk9fRlJBTUVfU0laRSIgY2xhbXAs
IGFuZCBpdCBpcyB0aGVuIE9SZWQgaW50byB0aGUgVkYgcG9vbCdzDQo+IFZNT0xSIHdpdGhvdXQg
bWFza2luZy4gSXRzIHVwcGVyIGJpdHMgc2V0IG90aGVyIGJpdHMgb2YgdGhhdCByZWdpc3RlciwN
Cj4gc3VjaCBhcyBBVVBFIGFuZCBST1BFLg0KPiANCj4gQSBWRiB3aG9zZSBwb3J0IFZMQU4gd2Fz
IHNldCBieSB0aGUgUEYgaGFzIEFVUEUgY2xlYXJlZCwgc28gdGhhdCBpdCBvbmx5DQo+IHJlY2Vp
dmVzIGZyYW1lcyB0YWdnZWQgd2l0aCB0aGF0IFZMQU4uIFRocm91Z2ggdGhpcyBtZXNzYWdlIGl0
IGNhbiBzZXQNCj4gQVVQRSBhZ2FpbiBhbmQgcmVjZWl2ZSB1bnRhZ2dlZCBmcmFtZXMuIEl0IGNh
biBhbHNvIHNldCBST1BFLCBzbyB0aGF0DQo+IGl0cyBwb29sIGFjY2VwdHMgdW5pY2FzdCBmcmFt
ZXMgdGhhdCBtYXRjaCB0aGUgVW5pY2FzdCBUYWJsZSBBcnJheTsNCj4gd2hpbGUgdGhlIFBGIGZp
bGxzIHRoYXQgdGFibGUsIGluIHByb21pc2N1b3VzIG1vZGUgb3Igd2hlbiBpdCBoYXMgbW9yZQ0K
PiB1bmljYXN0IGFkZHJlc3NlcyB0aGFuIHJlY2VpdmUgYWRkcmVzcyByZWdpc3RlcnMsIHRoYXQg
aXMgYWxsIHVuaWNhc3QNCj4gdHJhZmZpYy4NCj4gaWdiX3NldF92Zl9wcm9taXNjKCkgZG9lcyBu
b3Qgb2ZmZXIgdGhpcyB0byBWRnMuDQo+IA0KPiBUYWtlIHRoZSBzaXplIGFzIHUzMiwgc28gdGhh
dCBzdWNoIHZhbHVlcyBhcmUgY2xhbXBlZCB0bw0KPiBNQVhfSlVNQk9fRlJBTUVfU0laRSwgd2hp
Y2ggZml0cyBpbiB0aGUgUkxQTUwgZmllbGQuDQo+IA0KPiBUZXN0ZWQgb24gYW4gSTM1MCB3aXRo
IHR3byBWRnMgYW5kIGtlcm5lbCA3LjMuMS4gVkYgMCBnb3QgcG9ydCBWTEFOIDEwMCwNCj4gYW5k
IGEgdGVzdCBidWlsZCBvZiBpZ2J2ZiBzZW50IGl0cyBmcmFtZSBzaXplIHdpdGggYml0cyAzMSwg
MjYgYW5kIDI0DQo+IHNldC4gQmVmb3JlIHRoaXMgcGF0Y2gsIEFVUEUsIFJPUEUgYW5kIFNUUkNS
QyB3ZXJlIHRoZW4gc2V0IGluIHRoYXQgVkYNCj4gcG9vbCdzIFZNT0xSICgweDhmMDEwYmNlKTsg
d2l0aCBpdCB0aGV5IHN0YXkgY2xlYXIsIGFuZCB0aGUgc2l6ZSBpcw0KPiBjbGFtcGVkIHRvIDk3
MjguIFRoZSBub3JtYWwgaWdidmYgc3RpbGwgc2V0cyBpdHMgc2l6ZSAoMzAyMiBhdCBWRiBNVFUN
Cj4gMzAwMCkgYXMgYmVmb3JlLg0KPiANCj4gVGhpcyB3YXMgZm91bmQgYnkgdGhlIFNhc2hpa28g
QUkgcmV2aWV3IG9mIGFub3RoZXIgaWdiIHBhdGNoLg0KPiANCj4gTGluazoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzE3OTM3MDQ1ODE5MC40ODg4NTYuMTc2OTc1Mzk3ODk0Mzg2MzE4
OTZAa2VyDQo+IG5lbC5vcmcvDQo+IEZpeGVzOiA0YWUxOTZkZmQ2MWQgKCJpZ2I6IEFkZCBzdXBw
b3J0IGZvciBlbmFibGluZyBWRnMgdG8gUEYgZHJpdmVyLiIpDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFRqZXJrIEt1c3RlcnMgPHRrdXN0ZXJzQGF3ZXRh
Lm5sPg0KPiAtLS0NCj4gVGhlIFNhc2hpa28gQUkgcmV2aWV3IHJlcG9ydGVkIHRoaXMgYXMgYSBw
cmUtZXhpc3RpbmcgaXNzdWUgb24gdjQgb2YgbXkNCj4gaWdiIFJ4IHRpbWVzdGFtcCBzZXJpZXM6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xNzkzNzA0NTgxOTAuNDg4ODU2LjE3Njk3
NTM5Nzg5NDM4NjMxODk2QGtlcg0KPiBuZWwub3JnLw0KPiANCj4gVGhlIHBhdGNoIGFuZCBpdHMg
ZGVzY3JpcHRpb24gd2VyZSBwcmVwYXJlZCB3aXRoIHRoZSBoZWxwIG9mIGFuIEFJDQo+IGNvZGlu
ZyBhc3Npc3RhbnQgKENsYXVkZSkuIEkgcmV2aWV3ZWQgdGhlbSBhbmQgcmFuIHRoZSB0ZXN0IGRl
c2NyaWJlZCBpbg0KPiB0aGUgY29tbWl0IG1lc3NhZ2Ugb24gbXkgdGVzdCBiZW5jaC4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyB8IDMgKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiBpbmRleCBkNGE4
OTdhOGM4MmMuLmQ4MDhhZDM3MDQxYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2lnYl9tYWluLmMNCj4gQEAgLTQ2NjMsMTIgKzQ2NjMsMTMgQEAgdm9pZCBpZ2Jfc2V0
dXBfcmN0bChzdHJ1Y3QgaWdiX2FkYXB0ZXIgKmFkYXB0ZXIpDQo+ICAJd3IzMihFMTAwMF9SQ1RM
LCByY3RsKTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgaW5saW5lIGludCBpZ2Jfc2V0X3ZmX3JscG1s
KHN0cnVjdCBpZ2JfYWRhcHRlciAqYWRhcHRlciwgaW50DQo+IHNpemUsDQo+ICtzdGF0aWMgaW5s
aW5lIGludCBpZ2Jfc2V0X3ZmX3JscG1sKHN0cnVjdCBpZ2JfYWRhcHRlciAqYWRhcHRlciwgdTMy
DQo+ICtzaXplLA0KPiAgCQkJCSAgIGludCB2Zm4pDQo+ICB7DQo+ICAJc3RydWN0IGUxMDAwX2h3
ICpodyA9ICZhZGFwdGVyLT5odzsNCj4gIAl1MzIgdm1vbHI7DQo+IA0KPiArCS8qIHNpemUgY29t
ZXMgZnJvbSB0aGUgVkYsIGtlZXAgaXQgd2l0aGluIHRoZSBSTFBNTCBmaWVsZCAqLw0KPiAgCWlm
IChzaXplID4gTUFYX0pVTUJPX0ZSQU1FX1NJWkUpDQo+ICAJCXNpemUgPSBNQVhfSlVNQk9fRlJB
TUVfU0laRTsNCj4gDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGMzZTY3YmQ4MmI5YjliMWE1
MTE4ZjA5YTQyOWNjZWZlMmFhYjA3NDENCj4gY2hhbmdlLWlkOiAyMDI2MTEwMy1pZ2ItdmYtcmxw
bWwtOGYwNjVlZjU3ZGIxDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFRqZXJrIEt1c3Rl
cnMgPHRrdXN0ZXJzQGF3ZXRhLm5sPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0
aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KDQo=
