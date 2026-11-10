Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332363;
	b=qFjkD2GD9yy+TVI9HreDaAnBwyb8RwymFKKtmjIQ+FEQjVb6bDniCr+zT5XDP57FcGT2
	 b2woGfwQR+GGUvp9E22zb4BnScQT2dm7tf9uTHBiU67PcwD2YktDTkT2UbfgcuVyjdixJ
	 7Rtn2XTj6cgHA9m9CXw0raonkr09Cnzyqf3ZMr0oFN7aKtx1D7PUZ5Ml+nZeR5Onb/Jtr
	 3bxD73b1mKwolGgQwQmggsiNLWUPCMpStM5csgnWT0fujAONulJ94mMzVUqciW5S/zJfR
	 +KaNOU/KaTPlb/5aEt8pEomKEVoDf/ZUiRppKoyu2IOWE9qLdGgEvMYiQ7X/1fZKlVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332363;
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
	bh=ObqUA9PwCTAHW3pXV7bKYoZlVF//0IXedtWRQN04yKI=;
	b=hadaptwhsOinFXsmr95gBQdpXW14bmqFtDHoYEebZox+a+b4V93xy5FgtiFwc/u/AI2j
	 teH7R55THcyZbFdW0GrOcK6vyeR5StT096E51kwWriLxBM5VYw7LPOITnNDPSNcBTOOKR
	 1OrN0Y4tRSXfXJftZJVytZS9PPf84IpeQKeBXQKh6xbT2p10TEXuqpqVd7Uy2HqqguDDG
	 pGqJRM8SCsfUa6EZ8G/H1NJ79io73VSVd+Q3cu7xgE3IDK/BLYXqgRPZ7xesH+Uw+hASc
	 fCh4fF2XOd8ra7FmkxcxPKfVtbXyFpQqVe030vl+IG1z+u/0UxZ1GL8MJStktZOR1lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHM1bAFs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9A606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B9A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHM1bAFs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794332363; x=1825868363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ObqUA9PwCTAHW3pXV7bKYoZlVF//0IXedtWRQN04yKI=;
  b=LHM1bAFs48EeJFojij93NT1k1b3eAIPnuxGJE5qzOQfarR3tOihlRoZz
   OpYWQClSor1wib7V/p051kifgBN5E42nDBGev0P2ldZisZ5FaSY3eM85K
   i2MFrmkSb4mW5GjbL7YquiAWXgYvY7oHu/PP4Rea1nif/1lUSZthYSfHy
   7TnbcC8mCT1KXd3GfdjRfNDDFdOTQctK/ejZklGAIiYnwgVwY056BldMU
   iQEJJ4WszJJCJtAUCYHZphZUkiKm/vB3w0k8hDUd9PjluLM9jsiIXAMJc
   1FmfdE95ZxOHGT68aH+ty0mm5GyWrcG0fNi398dY3U8FnYkvOX3g2wnvH
   w==;
X-CSE-ConnectionGUID: cjtG8YAnRnyzbaJMtA5ltQ==
X-CSE-MsgGUID: dfctpKsIR8WWE7/mXzEtzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2991449"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2991449"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:39:22 -0800
X-CSE-ConnectionGUID: nNZosegsSJiqRBiaYZjEzw==
X-CSE-MsgGUID: YmiTssleSDyKQgNYVYUlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="9940116"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:39:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:39:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 09:39:21 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5ajr765/IuMZv1HPn9P+hlQMgge085v5jUMgP773rp82ScSkJ1+txpyKf6n2FyToDHRrj07+dyOBB5vTir5e328Dpt0ABf2gVdj6AoMuINz9td8vIeQ3zwLoOhZTQxOPWAlAFK0nB7+wmmllNuIaVx0VTBCAMoIV0K/IedBODZiTF5WKNt/SJYSs9COXV3Q7geXgJ6ZGqbFIvPmp0gZouOfZQJWNdwRlC82xkhLtYSrgopCjXCVHy8O/bmH0Y8X8n9YHMUvnqBPeDmtce0/0cF9oPFntKD/bQkJIB3nzTDUM0v7+rNkzqVfYMnhBQruLwBF5ZNPed6o8oiMZyEaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObqUA9PwCTAHW3pXV7bKYoZlVF//0IXedtWRQN04yKI=;
 b=ITJ78+cKrN8OpcDR9KzUT66UyL7rQjvsJ1L+nOSNAlGWyTWvLXzDuhZnMzUIooalE5nHMYIhQQDYD84qWfWdG1Q7wqsaE8e8WNfH8TIcP5EVKCZ00koTD6eeqOJqQdYBX6scwtNM+wyzwiTfUg0O5Ohv4+LDHn9L/IWkpucNeXr7UUxCbfkaiHC+k+FAWWC5x+Swf8dwX1o1VAM5sywLRtK+Iv2YzoAYIbGcDsHbXXZduge7sCD0bc6bSrfCbpWgDOmVSqUr1ESizPxUK2i8DGJG99IP8pzADuMEU+edNZDEjZ3H1UtvtpC/fFL1GmR510iGcB9h2VZ57agFqnTzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB619106.namprd11.prod.outlook.com (2603:10b6:8:43e::11)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:39:12 +0000
Received: from DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee]) by DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:39:12 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for
 UM queue BO" failed to apply to 7.3-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for
 UM queue BO" failed to apply to 7.3-stable tree
Thread-Index: AQHdbp8ajLJwuDXZ8EqdlzcOJF604Lcnl4gw
Date: Tue, 10 Nov 2026 17:39:12 +0000
Message-ID: <DS3PR11MB619106CB5CBBB44401E5CF32EDF4722@DS3PR11MB619106.namprd11.prod.outlook.com>
References: <20261107050222-failed-7.3-9daa302a8259@kernel.org>
In-Reply-To: <20261107050222-failed-7.3-9daa302a8259@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB619106:EE_|CY8PR11MB7136:EE_
x-ms-office365-filtering-correlation-id: 3d681883-2b96-4a22-4e78-08df3f5188b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|42112799006|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: cLuGWFZQkAvrJ5aDydxH0kODv9IZw5ablg5k4cjLz3SbqjaNqSd2hOHFDUDc65Xd4r8TQkqBuavlYT4xQt6BRj/AI7UpR1S9wVPyJ3m5vW3zEFYLROPAiCboq0OAuKA0q9+qqXd0a1D8OU6dW+e5ctm2bEQ3KVVQrNjgjVX9mBTNKL8iTC1VqaWDXJkj7dmyrv9Q9M9r+piYDfw5haMZpe4Ob7hLBVnGgCdm7+W/7PEbmOWEkqROQmgUREbxQpDml8+V7ylvIBHziEXKYu00B7HMBeWS92h0zLk6li5PITiKHpGDoYsbDKhCJBmivm6Ska8utqAimlDSwbmQIous+6061OV5XSc87WVoAnyNR1bD99Vk4l1zUQR5N+waG7yK1QKHmdxWGjBDlPxVeyaa69UT6gAMHRzXEZLKLXMvPq90/Gjp/uJfAY6AKJ+ME/NhUXKMwP67WtXXjINqGzA0oCUtFMTIv0sYF04CeAfcsoRV9DoIrrX855SJHTwerDFJzJc2zNu7JmcgbT0xCtVwcahSmdSbV08MJIeX3XhHQp5CrIqoIsIlKiU702P4Tk1xQS2HdiPDOHqKase9p5k13w6BI0rZC9GZ3L4HJkZxa2MapD+Ko2bR1orgQBm1I6eXnA9Y3X2AQp+aOWOzI+FZaSZOJfSZ47byrKrO6EYvoDY1laHx+1yZlo40pIahh1Rf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR11MB619106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(42112799006)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDY2Z1lONm1Qd1AvYmk4WWpQT1NjcnZLY2NoMkxZVjZoUXdzSzIrbGM5V1Fl?=
 =?utf-8?B?ZTZjdDFLYUtaK1BCS25MajRORitrcjkvQXFIQWJQRnJuMEh1TEV1SDBDRFpT?=
 =?utf-8?B?WEIvckpwc0U3dkgzK0JBSWRCdzZlV1h4RnlvSGhBcjQrUVhmRld6d0VHOFRj?=
 =?utf-8?B?VWpmd2JIVDhmVXdKUHU4ZzVNbUtmeWUzM3VqVE5CRjMya1VjT2VCSVdvcDF1?=
 =?utf-8?B?L2hzYm4rUWg1QTFRUDJKdnZ4QUI2Y2twUzJ0VHJ1TVdEcDZya1FCUTVUR1dq?=
 =?utf-8?B?azFqNDVGc2xYc3ZET2hhQjFvaWF3QVNVV2ZrNlJQUmhFSDIyb2VCcjR4bkov?=
 =?utf-8?B?UGlBam8zMVVNQklXMDZDa2hoVXhNNVhuYmVCTHMydEJDNWNmRXFIRHVITG11?=
 =?utf-8?B?cVVtNjVXeXdJRUtPNVBZYlJ1V1F1TzFjRUt4TThadExqMmN2T1pTcUdIMStY?=
 =?utf-8?B?VTZiaGpHSTlBUU1IT2hTR2JCYnptOHdQRHF5WDZrRldPQkhYSDkxMjVjT1Zv?=
 =?utf-8?B?NzJoaG42MlBOcUhsQ2pmalY4ZjdGSCtFbEJuVGsvbGkwekk2Yi9EMWFrLzZm?=
 =?utf-8?B?b3pLZFJzdzg4Q1lMcEkrdkpWSm9EbytuVDljWUh2M292Q1RQRFBwemdkU0xW?=
 =?utf-8?B?Q092RG5uOXdzYzZOejBlLzc1aXl4TkVNMW9xd1UzTE93UzFRQ3JLQlpVY25P?=
 =?utf-8?B?U3FlZFpyWDlVWi9aY0VreThBQ2YvWjA5NFRxMU9jYXFKMDhiK1lsTnFKamdK?=
 =?utf-8?B?b1RkVWJ2dmEzamdvQnI5bnZUSWZLL3RkRDZUY0RSN2pHcXQ1RHBuSXFIdHVx?=
 =?utf-8?B?RUoxUi9kZU5WWTNXZkkyZDh1NE1ObU4wRk5ZdzlWdzdNT2tNa25iZSsxTUY5?=
 =?utf-8?B?NEtsek9xdjdzUUhDWUJVdVBUZUtQQ091RXo5UTlqWGVwNW5LOU81RUxkbDJL?=
 =?utf-8?B?VmNkeGRkc0o2cjNheFVhVHFDalNvRHh6QU96OFM3VDdLTEhvcnBqRGVobEsy?=
 =?utf-8?B?dUhaQTdoMnJtcndZczF0SjZoOUltMUNFSnF3Qkd4WnJnSFdtaGVnbkZPZmky?=
 =?utf-8?B?azNQNGw1SWpnQ2dSTDFxaTBreWVXbnVKM05jWkNXbEFVQ2FBUkpKTEd5YVlQ?=
 =?utf-8?B?ZGpzK2FmV1Mya241WlpGd1c1TGhmcmNHRWpIYnVKcnFLblRhZElZL252TGVn?=
 =?utf-8?B?cDdxQkhXUXVjaWdNY21qc0NhclRVWGg1ejE0bkdmRFlTSkN2N1l5NkFjcDNR?=
 =?utf-8?B?blZBdVowemdKelFwRVhMODBVd3M0bGlocGFUUGttWXVvd1h2eEhTUmVxU3VM?=
 =?utf-8?B?aXB3THJpaVVyV2RIaldDRy80cGlZU05EYVh5MXk4aktCYy96QXNPSFVkek5K?=
 =?utf-8?B?dmxPSldCbEZ1UzVyUTVCOEFKUWd1VlRqZ3ZQbVR4NjQ4eFZsZ0pCeFNNb3Fy?=
 =?utf-8?B?M2p6YTZ3STNjRHBBY21ZdVhTdWNUSkk4UnVPM3IveStoVzU1djliVG5oK2cx?=
 =?utf-8?B?dmJJOTkyaUNwLzBEL0ZubnZwZVFKdmRiQ2xQMm1VY3lWbEQvdytGTVVpOC96?=
 =?utf-8?B?NDJOL1ZIc2NGd2YrMFJhVE43QkJBTEhTVWFzcDkwbUhCVHI5b0o4eE1ZUnNs?=
 =?utf-8?B?cTdVSi9tTExrNmxNOXNZLzgvbjE4RWc2VjlidzFiZWJhOThqTU9VTkY5Qk9M?=
 =?utf-8?B?dzVKZklxeFdzWlRQS2tpMkJPYVZzV2hERFFrRk4wbWE3SkRhS0haZGh1ZW9K?=
 =?utf-8?B?ZTJYTC8rYnZKWDlEOUp0OHVaSk9VSG03UGtvVWd2MVpLRUVCemZnMWlLTkYr?=
 =?utf-8?B?ZkZBV1Y2QmJrbEwxbUhXRWxIclBRTDZoVWFCVHZ4Q2FNeTZJVVV5WDNMUDdw?=
 =?utf-8?B?ZFBpN2pmbzFNVHluMVFZZHgwRkY2clYyRUY0bDJhNDN2cUF0cHFNMmhVeUVF?=
 =?utf-8?B?bkFiVlExcy9uUGREMXQ1NXRxR2hCOThKeWwxbVFKVnhNbFlNMXByM1hFdjFy?=
 =?utf-8?B?NG5IZzhmdXNldS9zdUVwWnNBcVNvNXppZ29JMVVJeE5zMFFJbC9IUHVmTUxx?=
 =?utf-8?B?cVdvWDcxS1RzTnE3Wm5oVC9USnBGaGsvZi96WU9GejdwTVZaVGFZbGl3Q041?=
 =?utf-8?B?dnN3QzNodXVmYXZrZmIwQjE3UU43aDdxWHZFTVIxaHd3K0lDVG1oSVNOOEFR?=
 =?utf-8?B?bmk3VXdIN05BaWpnbmFUR1N6NUJ1MkFoSmdLNXBoaURQNWpzNW5TK1BhdDE5?=
 =?utf-8?B?UHFOeXJIME9nVi9SVUtUNEdyM3ZQalYzQVNETFJsMEx3cWxaNXNLZTgrdHR4?=
 =?utf-8?Q?b9P7gG2X67JMTfCQJ/?=
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
X-Exchange-RoutingPolicyChecked: ZkQXAMCKetkn45lANBH1T3iyeZcFAt9bLSyNK8pWeP9Hvi9RKTgFNqe+YsxKcmL4WED3rXdaf/IkdZlTVO9rRENsX90W8aIM1pqQU8P84h2tzyZrYLlbEE1cWpUaQARXnTPy/qBuRibyd0DBEXH0n1HYXf3InKG74Nf3oSHllRtC0KBKz5xPVipVw7EUEDaUbXNVBs0+fGaqJRFzPGXG8E4iyfhKDW9ZZzC7IJeLSUlXLdCnPTMZxt3ALYN0G2oNbDrFEifJouB/cXMxeMT4H68g56t2ebVWWq0/9m/KsNrOkjZRh42VvPrMPJ4uwjOuV5pMemkqzUAbt1SAQI0mqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB619106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d681883-2b96-4a22-4e78-08df3f5188b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:39:12.8078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AorFpmdYdjNjAM1PzZ5+UTYM5mIaFVMOLKfgHR91y34Mp6RIqG7B7onYdkgL/4XpXGTAptm7f9UZPb/ykV2/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com

SSBjaGVja2VkIGxpbnV4LTcuMy55LCBhbmQgdGhpcyBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuIG1l
cmdlZCBpbnRvIGl0Lg0KDQpUaGFua3MsDQpKaWENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNh
dHVyZGF5LCBOb3ZlbWJlciA3LCAyMDI2IDI6MDIgQU0NCj4gVG86IFlhbywgSmlhIDxqaWEueWFv
QGludGVsLmNvbT47IE11biwgR3dhbi1neWVvbmcgPGd3YW4tDQo+IGd5ZW9uZy5tdW5AaW50ZWwu
Y29tPjsgQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogRkFJTEVEOiBwYXRjaCAiW1BBVENIXSBkcm0v
eGUvZ3VjX2FkczogdXNlIHVuY2FjaGVkIG1hcHBpbmcgZm9yDQo+IFVNIHF1ZXVlIEJPIiBmYWls
ZWQgdG8gYXBwbHkgdG8gNy4zLXN0YWJsZSB0cmVlDQo+IA0KPiBUaGUgcGF0Y2ggYmVsb3cgZG9l
cyBub3QgYXBwbHkgdG8gdGhlIDcuMy1zdGFibGUgdHJlZS4NCj4gSWYgc29tZW9uZSB3YW50cyBp
dCBhcHBsaWVkIHRoZXJlLCBvciB0byBhbnkgb3RoZXIgc3RhYmxlIG9yIGxvbmd0ZXJtIHRyZWUs
DQo+IHRoZW4gcGxlYXNlIGVtYWlsIHRoZSBiYWNrcG9ydCwgaW5jbHVkaW5nIHRoZSBvcmlnaW5h
bCBnaXQgY29tbWl0IGlkIHRvDQo+IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPi4NCj4gDQo+IFRv
IHJlcHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJlc3VibWl0LCB5b3UgbWF5IHVzZSB0aGUgZm9s
bG93aW5nIGNvbW1hbmRzOg0KPiANCj4gZ2l0IGZldGNoIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvDQo+IGxpbnV4LTcuMy55
IGdpdCBjaGVja291dCBGRVRDSF9IRUFEIGdpdCBjaGVycnktcGljayAteA0KPiA5ZGFhMzAyYTgy
NTkwZWVlZTdiZGM2ODAyM2RkYWQzMDJkZjRiODhjDQo+ICMgPHJlc29sdmUgY29uZmxpY3RzLCBi
dWlsZCwgdGVzdCwgZXRjLj4gZ2l0IGNvbW1pdCAtcyBnaXQgc2VuZC1lbWFpbCAtLXRvDQo+ICc8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4nIC0taW4tcmVwbHktdG8gJzIwMjYxMTA3MDUwMjIyLWZh
aWxlZC03LjMtDQo+IDlkYWEzMDJhODI1OUBrZXJuZWwub3JnJyAtLXN1YmplY3QtcHJlZml4ICdQ
QVRDSCA3LjMueScgJ0hFQUReLi4nDQo+IA0KPiBUaGFua3MsDQo+IFNhc2hhDQo+IA0KPiAtLS0t
LS0tLS0tLS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAtLS0tLS0tLS0t
LS0tLS0tLS0NCj4gDQo+IEZyb20gOWRhYTMwMmE4MjU5MGVlZWU3YmRjNjgwMjNkZGFkMzAyZGY0
Yjg4YyBNb24gU2VwIDE3DQo+IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogSmlhIFlhbyA8amlhLnlh
b0BpbnRlbC5jb20+DQo+IERhdGU6IFR1ZSwgNCBBdWcgMjAyNiAxNjo1MDo1NyArMDAwMA0KPiBT
dWJqZWN0OiBbUEFUQ0hdIGRybS94ZS9ndWNfYWRzOiB1c2UgdW5jYWNoZWQgbWFwcGluZyBmb3Ig
VU0gcXVldWUgQk8NCj4gDQo+IE9uIFByZS1YZTNwIHBsYXRmb3JtLCB0aGUgR0FNIHdyaXRlIHRo
ZSBVTSBxdWV1ZSB0aHJvdWdoIERQQSB1c2luZyBVQy4NCj4gaWYgR3VDIHJlYWRzIHRoZSBxdWV1
ZSB2aWEgR0dUVCAoV0IpLCBzdGFsZSBkYXRhIG1heSBiZSBvYnNlcnZlZCB3aGVuIHRoZQ0KPiBj
YWNoZWxpbmUgaGFzIGJlZW4gcG9sbHV0ZWQgYnkgYW5vdGhlciBhZ2VudC4NCj4gDQo+IFRvIG1h
dGNoIHRoZSBHQU0ncyBVQyB3cml0ZXMsIGNvbmZpZ3VyZSB0aGUgR3VDIG1hcHBpbmcgYXMgVUMg
YXMgd2VsbC4NCj4gDQo+IEZpeGVzOiA5YzU3YmMwODY1MmEgKCJkcm0veGUvbG5sOiBEcm9wIGZv
cmNlX3Byb2JlIHJlcXVpcmVtZW50IikNCj4gQ2M6IEd3YW4tZ3llb25nIE11biA8Z3dhbi1neWVv
bmcubXVuQGludGVsLmNvbT4NCj4gQ2M6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVs
LmNvbT4NCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHY2LjEyKw0KPiBTaWduZWQt
b2ZmLWJ5OiBKaWEgWWFvIDxqaWEueWFvQGludGVsLmNvbT4gUmV2aWV3ZWQgYnk6IE1hdHRoZXcg
QXVsZA0KPiA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhl
dyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBMaW5rOiBodHRwczovL3BhdGNoLm1z
Z2lkLmxpbmsvMjAyNjA4MDQxNjUwNTcuMTI5NTI5LTQtDQo+IGppYS55YW9AaW50ZWwuY29tDQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYyB8IDMgKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS94ZS94ZV9ndWNfYWRzLmMgaW5kZXggNzc0MjlmZjRkMmE5YS4uZmY4ZWVlMzgzMWFhMg0KPiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2Fkcy5jDQo+IEBAIC00NTgsNyArNDU4LDggQEAgaW50
IHhlX2d1Y19hZHNfaW5pdChzdHJ1Y3QgeGVfZ3VjX2FkcyAqYWRzKQ0KPiAgCQl1MzIgdW1fZmxh
Z3MgPSBYRV9CT19GTEFHX1ZSQU1fSUZfREdGWCh0aWxlKSB8DQo+ICAJCQkgICAgICAgWEVfQk9f
RkxBR19HR1RUIHwNCj4gIAkJCSAgICAgICBYRV9CT19GTEFHX0dHVFRfSU5WQUxJREFURSB8DQo+
IC0JCQkgICAgICAgWEVfQk9fRkxBR19QSU5ORURfTk9SRVNUT1JFOw0KPiArCQkJICAgICAgIFhF
X0JPX0ZMQUdfUElOTkVEX05PUkVTVE9SRSB8DQo+ICsJCQkgICAgICAgWEVfQk9fRkxBR19ORUVE
U19VQzsNCj4gDQo+ICAJCWJvID0geGVfbWFuYWdlZF9ib19jcmVhdGVfcGluX21hcCh4ZSwgdGls
ZSwgdW1fc2l6ZSwNCj4gdW1fZmxhZ3MpOw0KPiAgCQlpZiAoSVNfRVJSKGJvKSkNCj4gLS0NCj4g
Mi41My4wDQo+IA0KPiANCj4gDQoNCg==
