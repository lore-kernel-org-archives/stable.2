Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181586;
	b=crLpFx5lPv4xEylz6jMFFa5B1jPZQIZCfVZUXM1gMUMfAw0+ze1pZrIiqMaDAiGyvYVZ
	 aTkqH8JUZLTN5oggRsjGggXF/ujTjtbP+zIJRYx7yPil3RzNuBKYkq4TE+nc72mjg45gb
	 ffjrAqv9F44bhEHQF/4UgaQGntGxvoGyISL+60jPbfP8kmXkkMSbCfrdI5B4HAk39jqUJ
	 g2BMj/Ic5zY6zU/JZvPwgisuQt3potQzNLbv9ZfzUzQzE6eAPoc8eGyWJOFPxWMqLwfGG
	 /G6m2gcMa0HCSBOB0iAJv7JRx9glbf3Efm7aAWTEtqhbiZC8CBEvBmljiShmDfthkWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181586;
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
	bh=d47/sj6cblaTfh0hblHnT2lb27pde9dcPQV+oPfXxcw=;
	b=ymFH++IBSR+rMT+2YqSFTbayB0HkcE7U0Ry29zbwEG/ZZf9wPCPYRQRfDF4+hwcrxY18
	 VkaHVxUbnNwnEvY/sWU9Eu+mcA5mPHL34xm8I7pZL/hBC/+R3FYN7PxjQCco3ZnD6D9js
	 zKi/s57KPECRGMjKoZMm5VzfLxW70x6tIUWk/pqD5ImbSiXXI9Su+PT4yb3B1eFF2/iUf
	 lF1tk1YryM4Z8o32x2WbAmAqf6yS4Pnstap4qIdg9RU1iuAlJXyxdnEPOYqMtk7FeGZuA
	 JV+F7kfGD8tPWx1cvo9rpYLiyBLSbQ/IyAT7gwHQHfQMpP7RbGDeuFYLXV4OaWSIgKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gnq1fF9b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE8606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71AE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gnq1fF9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793181586; x=1824717586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d47/sj6cblaTfh0hblHnT2lb27pde9dcPQV+oPfXxcw=;
  b=Gnq1fF9bS/CFYXp0uuah6x9qux8qTGhYFoqd2iSd4MIsh3r9MU281jjr
   rnwiCry8o2xq3cZHKxozn2nK9zr5zlDW/AtfWfa35KV8zmjvwfQhlY8wE
   wj1zAISkTrF8wjausUJ+7vORGNsAAnC43MnC2VjZZmqPwGsERqixsBk3A
   ZlJIyUsjyMBzMNRA7D6ZWmHmvBobvY/yOrDKoVYgOmRWSATpccLRXPtSL
   CxUw6kxTGZJsd8Ik/fTjayxJG1BX8Api1P9eHzCZdkPlSyvCfKxWRnQF0
   UaFrhqW8xcM8KngVJfgpB5X4/Jg8vOyPmrHSDfYX/2BjkVNlx9mdJ4Wzu
   Q==;
X-CSE-ConnectionGUID: 8HYrfCYHSJ2ymKtiBOn0ig==
X-CSE-MsgGUID: k9LnpcJ2REuDQBHXFxeg9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1790177"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1790177"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:59:45 -0700
X-CSE-ConnectionGUID: 7vzwe0NgQmyChCrHoCMyag==
X-CSE-MsgGUID: O/WA6fiOR6WQJqO0+uDEMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4765858"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 02:59:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 02:59:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 02:59:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 02:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvp4yNSdWuUV9htLxoJdTHecrxuFPvPWhs4OQXWf8y8TG9ezI2m/w7EqC6V2lqH7/cNww0f9pbrhlTzYEuRBBXbr2KsdNRupMv8ijtuMUWbw49vXCJXuIGFptG8e/fWZ/1ZXSQ+4oXxJ00yvObfpATZKdG7SSnt3lY6n+pSQIF3lNXXGXO7K7nw5hSrTWO7R1nPVDK+pM9gQJsYkR6SjGbpDsKO6lzCAaR2gti37YOKUctP7NKePgmgNIxW39DumeGFGpHESdDy2VLe2FMBXKDCDc3wZ94DjHRT7bMHWPIPUq2BLGzqTh+JjgQPnzlbwdxQ9fRDfOjqdOdTKRjDlrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d47/sj6cblaTfh0hblHnT2lb27pde9dcPQV+oPfXxcw=;
 b=FbTZXDgJKzbv9BbXDvfx1pMVutSOcuMKt7O8i4m/+verFCKUYhCSJTVWck244FI8b5kKeFdR4j9YRPnLDt6W8p5cwdEJFu92FGJXNSk6aaZQkCtdsCN+4JH+t1yGQdWx2K6ChsLVlRWs8hcKPM+PmCUBVmUkoa6PMDVpMHJj6rvO+Paac/+qduPnSaAjX+nTXiuFkZYxddqOxi4nGsRjIpmMqytle+zd36tirbCR/lqhlANTF3uWR5vOBwwln3iZdAe4K01VJV0/XZPY9sbyQVPsfPhZM9hwtnZ4MB64OPcEWNSSZ+KSxC7FTn7YeUiTc6l1CTZHuYYbWJDRgJaVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14)
 by CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:59:37 +0000
Received: from PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2]) by PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:59:37 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Topic: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Index: AQHdZqv2N/K1IP074U+vOvCtUeUWMbcSogiAgAAEZgCAAAl9gIAAAo4AgAAGFRA=
Date: Wed, 28 Oct 2026 09:59:36 +0000
Message-ID: <PH7PR11MB8252C032AB2E00046CC69C14896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
 <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
 <48da0157-6fb3-4e93-a43c-0443c5bcbbb2@intel.com>
 <fe7b9725-be64-4a34-a8b1-b2551fb0ae91@intel.com>
In-Reply-To: <fe7b9725-be64-4a34-a8b1-b2551fb0ae91@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8252:EE_|CO1PR11MB4804:EE_
x-ms-office365-filtering-correlation-id: 57b3230a-7066-425d-6575-08df34da2cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|22082099003|18002099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|38070700021|261026121527099003|261026140227099003;
x-microsoft-antispam-message-info: Oeln2YyhYXdCtVzRedVor6gWNUmWhjbAVY0VDebtm/3koOQKnmNdjcqpuyfcLjY4ySDBGV3lhyf8bBHA0LD0+BP8d3Z9jcWqRWyyj0BbjVLOkLlp0+X05WISrw9qzFx7S+iMvfiy29ADNriiBrQ2AMF/qzoVZXBpF1LgrkC6Mguf+GUz5rS5hQNhheJoHkR9Ldg2JLF73NI0W7gjHKEMWVQ1hcvOT+UQOqAYkrlKB2fRyC5b+c8qXGpiObPztLWTvF4O4U+KMAcmgcEGvWEqVKDMs4g2fz2rydWl5/cHz4AmDb5OB72wrmqc98L/J+kTvGQH5GTAdmQiuQZAa35rKe0rLhgVcH9VPI1LyTeI0umljjiNETXNFh7Ti6N+av8U0ily45+gPHnSpbLfgnVTCrK38Zo4cat5qrnKhHDXKfgXsAuVeybGGRedT4PSYFOoCm4fPgloguKNik+bIzDPh0WGfsfhh4IUWJ2l4tNL3cL6gi3m1G+qHVR9Wd5Pl752mPj1pXgQ+AgqEHq9vRffdT2JHuYBGk8n25r7vBs1JclC/1EjGV3ZU/r7TM24fZVsuB1+E+TxjmgR8FUSqEjCBJE3cXzm9fex0ANn7eRlIsPBSVDzKwuUlxEXfjj52mfrSJ9GebAZs+IyqUJFtYbCrWQpSjmnyzCpLoQO67FZ+ro/N9huLq5mSIUPCdHtFrScQjIQ4NX1EjdBnetLCEIVYzpwtPtmimNIXYsUCwuh76c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(38070700021)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmNIVTl1b0dFOHQvMDNTYUNoTjhTZWNKM05KYmU3Y3dCRVd0SzJqT1BuaXNU?=
 =?utf-8?B?SkNiQSt4bVRjVk1EbTJ6MFh4bENON3N2Wmo5UWZWNWRwV0cxSGtMbjBZT1NL?=
 =?utf-8?B?Rlk5UTJtTnE4bFkzNXhFVERCdmk3WmxYeUQyVU1HS1I3b0ZvNzQwUjdPQ0Ew?=
 =?utf-8?B?MTE4ZlZVb3dHb2drVnlaNzcwUHZzZkJHdkFDenkxSVRTdjNkbWdIT2djUVNy?=
 =?utf-8?B?c3JaZytGWUpPNW15YmswdUtKMU1TeGNIaUUzMS85Q2JudzBuWTBTOG05bm9S?=
 =?utf-8?B?UjQ0R1hsczVMb2FWMFZ0anhpMjV5YUJkNkpTRGZsbitrL2xRQ3liVFNIQ3Ry?=
 =?utf-8?B?blNJVlpoUXFxYnFObHhBRlBKWHBaWXdScHJ5ZEFMVDgwblZ2ZWFlUmU3cEJk?=
 =?utf-8?B?TkVHaDRCNHRGR0VoTDMzUWlxY0VNLzBmYlYzVWs2QVcvS2VjU1BXRytoTmdO?=
 =?utf-8?B?ZHVibERlU3ZjTThDWGdTMHBTc01CT0RMMVlHOE1ZS3ltejVkZEtZNXp6bWpL?=
 =?utf-8?B?aXgzUUkwVFVhNGp3bFFkMGtOOVdKRndpd2t6cjYvcUFKRXpHYWtUa1BZYUV0?=
 =?utf-8?B?ZWE1K2VUMnh6ZHhtUHB0VmdwbWpBMEl0dFJPc2MzZUtUNlRTU3Z0V2gyWUo2?=
 =?utf-8?B?RU5yaGNDYmQ1eWl3a0ZDTGppb1BQTFEvbXZ3Ymk1WFQ3RDdTUlVka3lqYWFK?=
 =?utf-8?B?a2kvWElaWDYrcVRSekZ5WTB0L1I4YzBLUTF0MjM3ZC9PSGdORE9qSVVCaVUz?=
 =?utf-8?B?LzZiaHZMbkR0eVJ0cUxTTDFyb0hsQ0Y1TGIwdUxXejdVMUdUYjJ2Nkx6WDEr?=
 =?utf-8?B?bVRMWXIxRVJZMWdzVDlnRlk3WWZnQkFFcTAvZFBacE5YaWVnSGhJZklhTzVZ?=
 =?utf-8?B?UHRTVWVTQldPc05iRTZGWFR6NTFMN0NIUFprSmlnbEZJaFpUV1lmenQxU3lr?=
 =?utf-8?B?STlJdTBSa1RxWWEyd3lrcmFOYW1IMmh3bitCTzVwTUhYVm5ud2NPemR4Q1Rs?=
 =?utf-8?B?S1ZNYUpGRnQzTi9Nam05U3NYelBoUjA5RDdnTUFmRnN2bUVXYS8wZVJPYkR5?=
 =?utf-8?B?b2VWUHhXZHF1ci9rbFVGTFFLY25Fa2ljNDI5bFBpOC84Z0ZITjRvMmRta250?=
 =?utf-8?B?WWYrZXgrU3lwczlaSTFsOEQvRXRIOE55cVhSWFREbmk4SW1uaEgrRk50dnRK?=
 =?utf-8?B?bnN5NkFkNnFKWjhrTVlwMVNQYXp6a2FSZ051RlVvZDgyaTN3Q3ZBbmU3cm1O?=
 =?utf-8?B?WGkyc3BJNU5MOGgxQ2NvS0IyOWdKQklsYU00QW8raWszbGlBWlNVUzdQdzZS?=
 =?utf-8?B?cWVkL2FuRTdmYWkxM3ZaK3hKM1hrVEsrR01vdzc1NDZDNDgrWC9NSkZManFR?=
 =?utf-8?B?UjNjTzZDRytQV3lwQUhRd0d3eXJiNk9MeGFrLy9JdDdKemRxUWp0eC9pNHVk?=
 =?utf-8?B?SGlUa3RMdFE5T21QbDlmRVF3UGxTU0tnYjZaRjdjNDZia1MyVnVtQktNblBR?=
 =?utf-8?B?b0FvNjN2T1QxTFBCcmtsUGoySmVDbkxPLy9zR25Hb0FndjdmVEI3VHUxaVlr?=
 =?utf-8?B?T0tuZ3dHU3lJWTVQS0wvdGZlbGl6U1RvWG44Z1A3bE1pVGNRaHRNUnJTRXRu?=
 =?utf-8?B?Q1JOSGtldU9rcGVtQm4zblFHTEYydHZKMDRDNllGSThWd0VXdEtYMHBpTjcv?=
 =?utf-8?B?MlpXZnpDc2NjV3E1TlorMFdPV3lEV3drcDl5YXcvVlVKalR0dmhpdGpZc3Zw?=
 =?utf-8?B?ZXRzNG5XTjNDOGFhK2xsRnNLcGVDcjNvUEppZU1PR2dvTzE4TkcxdFFZRTBF?=
 =?utf-8?B?SjNDem00NVdsSjFoR1Frb3V6YUVqNXpnQkhpNzcvWXZIRUJqVnRTcVIzLy9J?=
 =?utf-8?B?b0VNN3lVYng5c0NMekN0YjVDTEhUS0ZwRWh1Z3l0czN5SkorMWtKa29GdWM0?=
 =?utf-8?B?T2xkdmwrbTF4QjBxNlhVRStzKzRpS3NFd2hUcitXVnRXNjlnVndwMWtQSmJR?=
 =?utf-8?B?Y1JYOE5OZlBPaHF1UnFIaXFJdmp3WFJqYVVpd0E4d0MrWjhoSTMwWUJpT1J1?=
 =?utf-8?B?OE5rRERmQzRyWXF4a2JkdXJ6UzZiVzR3UitKTkRVRkZJRnpFRXV3eHFpaW1o?=
 =?utf-8?B?bXBHVFp1QStZOXY4eUxUVS95NkFzRWJTUWxtZ2x2c2M0dUNkZXRjRUVQS3Zh?=
 =?utf-8?B?Vm9JZm9BQlIzMXg0blpiMGtsTDVGbnAvLzNiVmZzVWh4SGtXenA4Mk5SeUxy?=
 =?utf-8?B?Y2FGQVlkRzY0RXBZVXQ5blV4aXFiWE5uN1ZRQWp1elo2a2VYdk9aZUo5YlA2?=
 =?utf-8?B?akgyT2pKd3cxNHRreHVic3RCSmM5WUR2Q3NSd1lJSGJzNkxnSFMxdz09?=
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
X-Exchange-RoutingPolicyChecked: Y2aQT8cAUs0v1kABespNAhYwU3JEeh/Dosp/C3hvXbqMgYRkZwUEvVI1mKgOacUYXeI8SxZU7kaINSJlrCOsqZi+M8BOd4ptI7d9eq22doeZrrU7fxcAWocUT8gICC6gYfmJdcryz2yyPCh3S0EKJZSpzLOfG57Lw3tFS9jE/19iGe+9sDCez/cio+WHnQeSLIGH51csEHraadF2ioPNuVG0D8Pg2uueLt4IlfIMbcoX6QS7Q+GeTQlE667V6hroZDAAMSUY27z/sBskh01fIWU5qhU7Hod3KTPP09HTsQtWq1mInpqQaozF/4Y9v1xKP1amp851QpHqD5DDackSiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b3230a-7066-425d-6575-08df34da2cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 09:59:36.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mE8DH43PLI8gPJ56yailVQqwYIh3A546QDu3A3JnluEyO1XJvi6Ynpqfmza2Jkb5ZdCUSBzTHZHyrfRkg8tyQO76zEyhIXySKocH7dBTfHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yYWgsIENoYWl0YW55
YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFyLmJvcmFoQGludGVsLmNvbT4NCj4gU2VudDogMjggT2N0
b2JlciAyMDI2IDE1OjA3DQo+IFRvOiBTcmluaXZhcywgVmlkeWEgPHZpZHlhLnNyaW5pdmFzQGlu
dGVsLmNvbT47IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGludGVsLXhl
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU2hhbmthciwg
VW1hDQo+IDx1bWEuc2hhbmthckBpbnRlbC5jb20+OyBqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5j
b207IExpbiwgQ2hhcmx0b24NCj4gPGNoYXJsdG9uLmxpbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMi8yXSBkcm0vaTkxNS9kaXNwbGF5OiBEaXNhYmxlIHBpcGUgam9pbmVy
IG9uIFdDTA0KPiANCj4gDQo+IA0KPiBPbiAxMC8yOC8yMDI2IDI6NTggUE0sIEJvcmFoLCBDaGFp
dGFueWEgS3VtYXIgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDEwLzI4LzIwMjYgMjoyNyBQTSwg
U3Jpbml2YXMsIFZpZHlhIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IEJvcmFoLCBDaGFpdGFueWEgS3VtYXIgPGNoYWl0YW55
YS5rdW1hci5ib3JhaEBpbnRlbC5jb20+DQo+ID4+PiBTZW50OiAyOCBPY3RvYmVyIDIwMjYgMTQ6
MDgNCj4gPj4+IFRvOiBTcmluaXZhcywgVmlkeWEgPHZpZHlhLnNyaW5pdmFzQGludGVsLmNvbT47
IGludGVsLQ0KPiA+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+Pj4gQ2M6IGludGVs
LXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU2hhbmth
ciwNCj4gPj4+IFVtYSA8dW1hLnNoYW5rYXJAaW50ZWwuY29tPjsgamFuaS5uaWt1bGFAbGludXgu
aW50ZWwuY29tOyBMaW4sDQo+ID4+PiBDaGFybHRvbiA8Y2hhcmx0b24ubGluQGludGVsLmNvbT4N
Cj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBkcm0vaTkxNS9kaXNwbGF5OiBEaXNh
YmxlIHBpcGUgam9pbmVyIG9uDQo+ID4+PiBXQ0wNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+
IE9uIDEwLzI4LzIwMjYgMTI6MzQgUE0sIFZpZHlhIFNyaW5pdmFzIHdyb3RlOg0KPiA+Pj4+IFBp
cGUgam9pbmluZyBpcyBub3Qgc3VwcG9ydGVkIGluIHRoZSBXQ0wgZGlzcGxheSBjb25maWd1cmF0
aW9uLg0KPiA+Pj4+IFJlcG9ydCBubyBqb2luZXIgc3VwcG9ydCBvbiBXQ0wgc28gdGhhdCBtb2Rl
cyB3aGljaCB3b3VsZCByZXF1aXJlDQo+ID4+Pj4gam9pbmluZyBhcmUgcmVqZWN0ZWQsIG1hdGNo
aW5nIHRoZSA0ayA2MEh6IG1heGltdW0gcmVzb2x1dGlvbg0KPiA+Pj4+IGRvY3VtZW50ZWQgZm9y
IHRoZSBwbGF0Zm9ybS4NCj4gPj4+Pg0KPiA+Pj4+IHYyOiBSZWJhc2Ugb250byBsYXRlc3QgdXBz
dHJlYW0NCj4gPj4+PiB2MzogRml4IHVwIHRoZSBjb21taXQgbWVzc2FnZQ0KPiA+Pj4+IHY0OiBT
cGxpdCB0aGUgc2NhbGVyIGFuZCBqb2luZXIgY2hhbmdlcyBpbnRvIHNlcGFyYXRlIHBhdGNoZXMN
Cj4gPj4+PiAoSmFuaSkNCj4gPj4+Pg0KPiA+Pj4+IEJzcGVjOiA3NDI4Ng0KPiA+Pj4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+Pg0KPiA+Pj4gV29uJ3Qgd2UgbmVlZCBhIEZpeGVz
IHRhZyB0byB0ZWxsIHdoZXJlIHRoaXMgY2hhbmdlIG5lZWQgdG8gZ28gdG8/DQo+ID4+DQo+ID4+
IEhlbGxvIENoYWl0YW55YSwNCj4gPj4NCj4gPj4gVGhhbmsgeW91LiBZZXMsIEkgZGlkIGNoZWNr
IGNoZWNrcGF0Y2ggZ2F2ZSB0aGUgc2FtZSB3YXJuaW5nIGJ1dCBJDQo+ID4+IGNvdWxkbuKAmXQg
ZmluZCB0aGUgZXhhY3QgcGF0Y2ggdG8gY2FsbCBvdXQgdGhlIGZpeGVzIFRoZXJlIGFyZSBwYXRj
aGVzDQo+ID4+IGxpa2UgRXh0ZW5kIHRoZSBtYXggZG90Y2xvY2sgbGltaXQgdG8gV0NMLCBSZXN0
cmljdCBtYXggc291cmNlIHJhdGUNCj4gPj4gZm9yIFdDTCB0byBIQlIzLA0KPiA+PiBkcm0vaTkx
NS93Y2w6IEFkZCBkaXNwbGF5IGRldmljZSBpbmZvLCBBZGQgcG93ZXIgd2VsbCBtYXBwaW5nIGZv
ciBXQ0wNCj4gPj4gZXRjLg0KPiA+PiBnaXQgbG9nIHNob3dzIHVuZGVyIG1lcmdlIHRhZyB0aGUg
IkFkZCBzdXBwb3J0IGZvciBXaWxkY2F0IExha2UgKFdDTCkNCj4gPj4gZGlzcGxheSwgdmVyc2lv
biAzMC4wMiINCj4gPj4gU28sIGNvdWxkIG5vdCBmaW5kIHRoZSBwYXRjaCBmb3Igd2hpY2ggSSBj
b3VsZCBtZW50aW9uIGZpeGVzLg0KPiA+DQo+ID4gRml4ZXM6IDYzMjYzM2QwOTViNiAoImRybS9p
OTE1L3djbDogQWRkIGRpc3BsYXkgZGV2aWNlIGluZm8iKQ0KPiA+DQo+ID4gU2hvdWxkIGJlIHN1
ZmZpY2llbnQuDQo+ID4NCj4gDQo+IFNvcnJ5LCBzdXBwb3J0IGZvciB0aGUgZGV2aWNlIGlkIHdh
cyBhZGRlZCBldmVuIGJlZm9yZSB0aGF0Lg0KPiANCj4gQmV0dGVyIGZpdC4NCj4gDQo+IEZpeGVz
OiBmOGUxYzNlMDdkYjEgKCJkcm0vaTkxNS94ZTNscGQ6IEFkZCBzdXBwb3J0IGZvciBkaXNwbGF5
IHZlcnNpb24NCj4gMzAuMDIiKQ0KPiANCj4gSXQgd291bGQgYmUgd29ydGggY2hlY2tpbmcgdGhv
dWdoIGlmIHRoZXNlIHBhdGNoZXMgYXBwbGllcyBhcyBpcyBvciBtaWdodA0KPiBuZWVkIHNvbWUg
cmViYXNlLg0KDQpUaGFuayB5b3UgQ2hhaXRhbnlhLiBXaWxsIHVzZSB0aGlzIGFuZCBmbG9hdCBh
Z2Fpbi4NCg0KUmVnYXJkcw0KVmlkeWENCg0KPiANCj4gPT0NCj4gQ2hhaXRhbnlhDQo+IA0KPiA+
Pg0KPiA+PiBSZWdhcmRzDQo+ID4+IFZpZHlhDQo+ID4+DQo+ID4+Pg0KPiA+Pj4+IFN1Z2dlc3Rl
ZC1ieTogQ2hhcmx0b24gTGluIDxjaGFybHRvbi5saW5AaW50ZWwuY29tPg0KPiA+Pj4+IFJldmll
d2VkLWJ5OiBVbWEgU2hhbmthciA8dW1hLnNoYW5rYXJAaW50ZWwuY29tPg0KPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFZpZHlhIFNyaW5pdmFzIDx2aWR5YS5zcmluaXZhc0BpbnRlbC5jb20+DQo+ID4+
Pj4gLS0tDQo+ID4+Pj4gwqDCoCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2Rw
LmMgfCA0ICsrLS0NCj4gPj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcC5jDQo+ID4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vaTkx
NS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gPj4+PiBpbmRleCAwMGUwMmUwMTlkMjUuLmVmMTY0YTc5
NzYxOCAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2RwLmMNCj4gPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVs
X2RwLmMNCj4gPj4+PiBAQCAtNDg1LDkgKzQ4NSw5IEBAIGJvb2wgaW50ZWxfZHBfaGFzX2pvaW5l
cihzdHJ1Y3QgaW50ZWxfZHANCj4gPj4+PiAqaW50ZWxfZHApDQo+ID4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4+Pj4gwqDCoMKgwqDCoMKgIH0NCj4g
Pj4+Pg0KPiA+Pj4+IC3CoMKgwqAgcmV0dXJuIERJU1BMQVlfVkVSKGRpc3BsYXkpID49IDEyIHx8
DQo+ID4+Pj4gK8KgwqDCoCByZXR1cm4gKChESVNQTEFZX1ZFUihkaXNwbGF5KSA+PSAxMiAmJg0K
PiA+Pj4+ICtESVNQTEFZX1ZFUngxMDAoZGlzcGxheSkgIT0NCj4gPj4+PiArMzAwMikgfHwNCj4g
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoRElTUExBWV9WRVIoZGlzcGxheSkgPT0gMTEgJiYN
Cj4gPj4+PiAtwqDCoMKgwqDCoMKgwqDCoCBlbmNvZGVyLT5wb3J0ICE9IFBPUlRfQSk7DQo+ID4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgZW5jb2Rlci0+cG9ydCAhPSBQT1JUX0EpKTsNCj4gPj4+PiDC
oMKgIH0NCj4gPj4+Pg0KPiA+Pj4+IMKgwqAgc3RhdGljIGludCBkZzJfbWF4X3NvdXJjZV9yYXRl
KHN0cnVjdCBpbnRlbF9kcCAqaW50ZWxfZHApDQo+ID4+DQo+ID4NCg0K
