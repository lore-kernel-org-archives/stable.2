Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793971334;
	b=IhwncXULDSSeoHuYrg0L0lUVqRjN+t/9Q+KAttr5bxIax2B1JSu3E0Z5qw2SmU2YaLnY
	 o9PXSvAhPVKTXD7NlloWfGVU2ugS8zoG/QFlJu5vWDu85/ovuVURbcW/STzCLFot5LXtY
	 YlJH4BQCduTNqRftxYVnWCqCDPyCkZgc17OqhA9mRsRQ0NsZaRzf031lBJ/GcASZwW4vy
	 6UnEIuMp2ZU/2a6TiBhy3KDgn8xse1fDss7Ab9eVf9VtEbQ6JMq1Mk8UhOQ0hDLouzrWx
	 f5vVh2kiZbbd7Q0Ldpwtx4xkpG3k2VY8Huo3RbZL5zyDA43SJvRQ+BXS0ZC/IQqOLYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971334;
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
	bh=smTo5O17QEg+ENuhPRJlb0yioWp/p57DgkXskNEw2IA=;
	b=HQR9eE6fr9HE69K6ak3DCH9dPGe8gBpWulIsZd6aNOwtaX3pPun0pZ5PX/bkedjjh9vE
	 r2LLq61fCon+652+KyxAIK0mizB1kX+80KYLCWjCjpkWfdtGUqLWkpnKqi6gYGkvhag4Q
	 f6G/p5pC64UwNzZ72KNTlZmwPimBXhjRSBiwOZspUJW2Rn7/o4ATDilFT5IPPJ3yFY/G7
	 RV9tjy+WwhZEsthO1IQjrYZW51BRbe1tAqFlw3ivkmlztiicHC1d8UPrDivjwW9lGeiax
	 XL6yfNXZsqolr8lNe9hZRxyExV3nftpGQlUI8fNT6NZ76b7P+Oo+eXavh+v5RL5k7aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ow1mAF1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FB5606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FB5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ow1mAF1O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793971333; x=1825507333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=smTo5O17QEg+ENuhPRJlb0yioWp/p57DgkXskNEw2IA=;
  b=Ow1mAF1Ofw0mbc4wc1nZkXZJQe0QKfwqWhovapyfPuv5r9K9gmgefuKY
   JyxII7baa2hiecARr9767Erg4XBcdgOkdt9TShn7SxB/anAupoh8AVbrt
   nQZGn5goEZW7l5ANB8OQnBthK+TZvERadUG/03VvukzFtbB1eaQj/FcSO
   YtuAmYCjC2FPMZM/luqtRfTe7X/dxProyhPogLSmYsc8jHolbGKAoio0N
   Q4ShYVvk4EWM4+O6GzdKW+0WXo3KWoC770bIuz2ANOfBIDh9ZAyHERhKE
   DFTe0t7ngVzpJ/Geh2tREojdPHahJhyniYRI23sR8QOjYgKVmIH5FLsjZ
   g==;
X-CSE-ConnectionGUID: I2R8tgkdR8OxrpjpFaTzcw==
X-CSE-MsgGUID: 71jv9UJUSlu28jDVqXOPog==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2786813"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2786813"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:22:13 -0800
X-CSE-ConnectionGUID: UdD8st04Q2i/LfKM+shaow==
X-CSE-MsgGUID: zSKw6oT+TrCNn0qmR7NPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9024816"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:22:13 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:22:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 05:22:12 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 05:22:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLpikO3lPLZag4pZh9H7+CEQXjDcvEndIGvBz3Wcgg5qazh9HvgeBf0ZmwHz8paSrABnnMDwkWOZTPDdHAX4QGe5N2wjA8YLIOqjiJUlMWAgaUtYhwGlToGOJnoMkZ+Ah6f491xDMCB+Z0Z4gXFgei+3580GQcwPyn8cOipN58zlVqaybi0xyvVfe9SEte0Kb2q7vsGaNf9FoEAowlNcu85BCKcq5uBR08rTWdLz04QBAZoKxozuynzgPj2+X0VkdROEGqCuBzPAxcM5gbX2fI+smLlHIcw/D6WbRjKaBcBvISHjzQyUmFMhK9G/74O/a9BozpGxjvxogtP2OeCIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smTo5O17QEg+ENuhPRJlb0yioWp/p57DgkXskNEw2IA=;
 b=qgqqj0lEtGCABvHt1vfeiTdPZbUuObwuy/mxt5Z5cl6kfnH9EOvXWQhg0/e7cdtuy1dZA8zvrwqnn/iol8Hxr5zDxNJrlTmz4RGKAZipyvJrpuN6nuc8EJEh81I96pW0Zj2zrf0ZJOgLhBwF6X7ltioYfYhxv43nFbJUxYsXt3cXLjLc8B6JyuTos8HrpptcqEx7i9oVcRM9e4usQtEEmghWhiewwuXIQRdpsl1tqsTM2pHqI6lGRP9XvwTUiFRMm9AGMCZJkwuVi0BjOmH2MDPdwmWoQH+1tBDuzhy3BdtD/OlPdgLwc2iVeb3HWvnm9oH/emLJ/JS9FGzE+U7XqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::28) by DSVPR11MB938433.namprd11.prod.outlook.com
 (2603:10b6:8:37a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 13:21:34 +0000
Received: from DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9]) by DS4PPF69154114F.namprd11.prod.outlook.com
 ([fe80::79ab:f4ae:b1c2:61d9%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 13:21:34 +0000
From: "Kahola, Mika" <mika.kahola@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Pramod, Ambica" <ambica.pramod@intel.com>
Subject: RE: [PATCH v2 2/4] drm/i915/psr: Re-arm PSR after flush
Thread-Topic: [PATCH v2 2/4] drm/i915/psr: Re-arm PSR after flush
Thread-Index: AQHdarEpNahGg3DHUUuSbqDZa8J2KLchDgYg
Date: Fri, 6 Nov 2026 13:21:34 +0000
Message-ID: <DS4PPF69154114FAA8D08B1C161192F4413EF762@DS4PPF69154114F.namprd11.prod.outlook.com>
References: <20261102100051.272137-1-jouni.hogander@intel.com>
 <20261102100051.272137-3-jouni.hogander@intel.com>
In-Reply-To: <20261102100051.272137-3-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF69154114F:EE_|DSVPR11MB938433:EE_
x-ms-office365-filtering-correlation-id: e4b15f21-c7b6-4dc0-dcb8-08df3c08e0f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|10070799003|366016|38070700021|4143699003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ixVycX4HgCCSPMHyH1eFj2HXluF7icXlMSjEwA3lquHXWofBppe0jzaFTRriq+1np/xYcVvBg/6GOLwYm4NeXWSzuaCV9B+fz391vIaA5CB0mLZnYKaBCekW0dOE/d0cLEZ5ynhzlw9VCK0TTyyWZsfXbAY5nISPozNhJfMr/MnkaEvTsshYyns3plAgsYNkS6m+iWJtLky7Cb+qk8lqqcfbJM7xU0MNP7wx6//Cq3+Wzsje6XcdWtL+Wv4TDRDuXq9mTQSeer5nyM5jeWPeYmXXQmLa2eTYTju1897oW6MX6NTTr6tCdM8lz8qBh4XHaT44ZqgqT11olE2RxIN613j0UW0hBvHW/GK27YjDzgMyepWXll+RyFYnu8HtgxR5U2WDaJqxDH+gKq4EPIkl4dsYlpWCfVV020ENZhoS1AHDMMxkpWN6PpeExX9j6FP4BNXf0MV4kq86s+BuMUBgjvjODhWQQLDhlwnQ3Y7NgbMjTDCTVDloOS6CESNryAW2wN6gzonqVzJsQ8VPDP5HVF7k1zVC7RYJ+mzRsiAaT2F2QgQ4kuJ7oNQVaTPrvpe45B8lsNadVQ3uGHqnkZReW0yaZDFx1gcovk7itp3P2SxcvN6apr2CBupH8C3ovS40jWcr6CA4eqHwjI2M6xo1Lteu+0qCBXOHfZ9oP77IPVhhSYrwkRTXbbGCLB2K7vf8awQnr2TUbHcnCT/g+PDOrt6VismXWlzUGSw5KejCQME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF69154114F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlpCQ3Z3MERKRlkxbER1bFdlejE1VHdxM0o1NVVrUzUyN1RGSUZOY2dMNFhT?=
 =?utf-8?B?S3cxczFWZUhxM0d2ZytZcXk1ZUtFTFZnbXhybVBTVTBIVmdjOWVHcmd1Q0Ew?=
 =?utf-8?B?T2NjSXd2TW9xeWlTd2RuRkVneCt3ME9Sd2J1blFCL1JTNjhnL2JEY1o5blBr?=
 =?utf-8?B?ZmNVQjJjZ25HR0JmMGJIWHJqK1FqNlgvQmRyQlV5akEvRDVzM2tKb0VmMjha?=
 =?utf-8?B?c3NWaW5KU2QrVG0xSGU1YzhwUTk1VGVRaTI2a1g5N1N1Uk1GbHp4UWhkTnFi?=
 =?utf-8?B?U2JXS0pGeit5aVEvcVQ4cW4wQmlHaWowODRPSmlpVzF5MTkwN2hpOCsxR3Zn?=
 =?utf-8?B?WS85dmt5SEJRUktVZ2dvRFVVSTd2R2dRbExqdFY1Y1MxaW02bDQrcm9SUVdw?=
 =?utf-8?B?MXd3N28rRk1sMDlFbGxVN0drZTh4a2xZRXhUVzFuMnY2Q1dLK2FNb1hvcXh0?=
 =?utf-8?B?WjVyeTBsNW9rK1NmUk5YcEg4OWk3b2d6UTZ1T3NEK0RyK3EwTW51a3I0ZWlV?=
 =?utf-8?B?VE0vbzNiMUhtdFUyaXN4bnovS2VZMGI5aFlBMXEvd1dGbktoS2haaGNtc3ho?=
 =?utf-8?B?WWpBcmdNUy9FZ3BKR29VT2FKUitWbWR3dUhqaFpVZnBkYjRsSmJqWW5tcDk2?=
 =?utf-8?B?YU1ZVC9keUFQZmxidjdpc1BEQU9mMG1UcyszKytrZVpDc25oTEczc3FVN2FN?=
 =?utf-8?B?bFhWd0ExWml1aFdERHNycElYbGd0RWFndURRRmdjTE1LNmZCdlBrV3VmWGxH?=
 =?utf-8?B?L2JxRU9NZmJlczJLdlRyS1pSa253RHYyT0RKbkRsbVNKOVRKZmd4dk1DRTdi?=
 =?utf-8?B?cm9HTGxYVE4zYXorODB1Q0xiczdBN1JVdG9YbmNhL1JTVWlBc0JpUlJudW1P?=
 =?utf-8?B?U1hHOENZdWFlUXZ3RUY3UXZnU1dDWmk1bld2WU5DcG9TR2o0TnJGcmlrU3hR?=
 =?utf-8?B?Tmx1WGhPeGo3bmhjVmdsd2RLRHVHTmlMOW9hQk1INFZQRGJUTUJhRzZTYXht?=
 =?utf-8?B?TTlzRG80VEE0anhsdUd0dkZSRDJZSEQrL1k0Y0ltbXoxRVBzOFYwWFlYU0cx?=
 =?utf-8?B?empoZjFqNm1pNHM1MFpESExxYzdHazl0NmVrcjBxVjZYM010YkNhcGhMUEx3?=
 =?utf-8?B?VnpqZ1BENjV3RTdKWVZxSEFhQ2xtSjZFOUx2MkI5bDZyejd3ZzhnVWJkaGNs?=
 =?utf-8?B?QmVHNTkxMU5NMEMwQzluRTArR0c4Y1JlbDVBQnV5ZjB4dmVjdGN4bXdCZzBQ?=
 =?utf-8?B?M0l6aDNiQzlDM2NXLzlpQkRUekpQaWZWQXFoWE1NOHE1Qmx5cG8vbXc4cE5X?=
 =?utf-8?B?c1AycHJPOXlNbkRuMEdmVkFvUjVkYzlqR0JCV3RYUjlaczdJa01jcVpIMWN2?=
 =?utf-8?B?VjQwZ29aWmU4NXJkU1ZJa2N3MEpWT2FiUFFSNFRwaVV5SzY3Ris5aVpkeDF4?=
 =?utf-8?B?cTFNUEJpbFRBMys2cWdBbnp2S2xJeEVORklFSnBNS3RLbE5RUkt6ZGc5TXVR?=
 =?utf-8?B?WHJPSUpnMTljK1ljVHBrbHpLR1F2ZHJsOXdBTUh3SHRNbzBuMWRQbnJEMHFv?=
 =?utf-8?B?bnpmeWFGbXZnS2ZFNE1nbGF0Q0pXeFphODhTUnhNTCt5K2Q4TUQ0SDRIS21T?=
 =?utf-8?B?RGwxNFJZem1mcFlpRVhiYTRYZG02a3E3bzhURkVrcmJnUm1TQVpwSGtadHl4?=
 =?utf-8?B?Y3pXSWV1N1ZXeEdmMW9wcWx4SlhMRnFwYWxFRnNEU1VoY1RvUmNIc25xZUlO?=
 =?utf-8?B?S1ZXNk56N2w1K0pSYzZFVXhlR2ZSY1FwbWVaTEtMbjlPMWJINi81TnVldU5a?=
 =?utf-8?B?am9wemt4NmlBQlJLN3JkanB6Wjc1YmpPK1MyMm9YWG1zM3R5WDNqZTlheGR2?=
 =?utf-8?B?aVJMQ2ptRmZYNHN3RGFhZSsrOGxBOVQ5bXdYVjZuaVRaL0pGTC9ocTNHVkZ1?=
 =?utf-8?B?akt0U3l1djhFaC9ubHcrR2JzbU1BQXZtbHErSWtMSHhiN3VmNDMyZVZqQ3NL?=
 =?utf-8?B?N2JwUE1TcTMwa1dQTVJJeUhPOWM2MlZnQ3ZoN3dVNlJJMGozN2Q5d2ZzSHo1?=
 =?utf-8?B?MVhnYVhFaGdDYUdoY0d2QkxjRFJMdVc4MWVwTko1YzI4dEdadXdjejgwZkN4?=
 =?utf-8?B?Vlh6UFB0Tjd5QURVb0dTdVFSQU5PWS90UksvbmxTdFhLcTNnNGZDNDd2Mm5t?=
 =?utf-8?B?d2pnMktMQmt3M21kL28zWURZM055enJ1dmJOWUZuVXdHdzZTTmtRNW1mK053?=
 =?utf-8?B?UXpOeFZrWDBhM3dGTTJhUU5UaXE1c1Y2SHR0RXJBZm5WU0s1YU1kaGo0eHBF?=
 =?utf-8?B?blF1cGtPMFovQmdzYU5nTXVsUzF2V0duT1lLNnZkeEdBSXhTdXlLTGM3L0Yz?=
 =?utf-8?Q?Wfh0+uQk+tcU/4qZh8Uo4DBiAkRZvk8IO8xcW?=
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
X-Exchange-RoutingPolicyChecked: rRiHc2XaRZWNu/5HS+FtClO1/SyDji+GNQ/RapjuObVN/L7vYmhjB2zEkeZXQ+hRAB/RYIrkQR2IaR0Fq5JHZMNuyVkygWCm7YShZcwCtD6uoEBJ1lduzLV2BT2J0fuXhxXaKO8/li9JxEpEr9Mo2cH790zGceQPnt6W0nPRxei8I/wRg+YFJaGXTKg+gqWP5wEDINcvNjcXqvjwO/zpyWVwh8xCNqqZY4JZKdicenaPqgyC+CjgkiFRzAtBURc9y8r+pydapXy7r83ouM0Vnr/L5QNmABjjP/T65NY6C56ZSdHrC0z2+TGefHzEAwK83OqYUbi8AeZaRD8KABlcdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69154114F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b15f21-c7b6-4dc0-dcb8-08df3c08e0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 13:21:34.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KooEX82JKm9kQSszVzH3re2m6+6u57Crp/LD0QwAWB7k6IP0ayFDnF7W8870i+E4wG2c+fz3WtuMVAmoFkdWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB938433
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC14ZSA8aW50ZWwteGUt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBKb3VuaSBIw7ZnYW5k
ZXINCj4gU2VudDogTW9uZGF5LCAyIE5vdmVtYmVyIDIwMjYgMTIuMDENCj4gVG86IGludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogSG9nYW5kZXIsIEpvdW5pIDxqb3VuaS5ob2dhbmRlckBpbnRlbC5jb20+OyBzdGFibGVA
dmdlci5rZXJuZWwub3JnOyBQcmFtb2QsIEFtYmljYSA8YW1iaWNhLnByYW1vZEBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzRdIGRybS9pOTE1L3BzcjogUmUtYXJtIFBTUiBhZnRl
ciBmbHVzaA0KPiANCj4gQW4gT1JJR0lOX0ZMSVAgZmx1c2ggY2FuIGNsZWFyIHRoZSBsYXN0IGJ1
c3kgZnJvbnRidWZmZXIgYml0cyB3aXRob3V0DQo+IHF1ZXVpbmcgdGhlIHdvcmsgdGhhdCByZS1h
cm1zIFBTUi4NCj4gDQo+IFF1ZXVlIHRoZSByZS1hcm0gd29yayBhZnRlciBlYWNoIGZsdXNoIHdo
ZW4gUFNSIGlzIGluYWN0aXZlIGFuZCBubw0KPiBmcm9udGJ1ZmZlcnMgYXJlIGJ1c3kuDQo+IA0K
PiBNb3ZlIGFsc28gcGlwZV9mcm9udGJ1ZmZlcl9iaXRzID09MCBjaGVjayB0byBkb25lIHJpZ2h0
IGFmdGVyIHBpcGUNCj4gZnJvbnRidWZmZXIgYml0cyBhcmUgZmlndXJlZCBvdXQuIEFueXdheXMg
bm90aGluZyBpcyBjdXJyZW50bHkgZG9uZSBhZnRlcg0KPiBpbiBpbnRlbF9wc3JfZmx1c2ggaWYg
dGhlIGJpdHMgYXJlIDAuDQo+IA0KPiB2MjogRG8gbm90IHJlLWFjdGl2YXRlIFBTUiBvbiBvdGhl
ciBwaXBlIGZyb250YnVmZmVyIGJpdHMuDQo+IA0KPiBGaXhlczogZWYzOTgyNmMxMmI0ICgiZHJt
L2k5MTUvZGlzcGxheTogRml4IGdsaXRjaGVzIHdoZW4gbW92aW5nIGN1cnNvciB3aXRoIFBTUjIg
c2VsZWN0aXZlIGZldGNoIGVuYWJsZWQiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
ICMgdjUuMTYrDQo+IFRlc3RlZC1ieTogQW1iaWNhIFByYW1vZCA8YW1iaWNhLnByYW1vZEBpbnRl
bC5jb20+DQoNClJldmlld2VkLWJ5OiBNaWthIEthaG9sYSA8bWlrYS5rYWhvbGFAaW50ZWwuY29t
Pg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5kZXJAaW50
ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNy
LmMgfCAxNiArKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX3Bzci5jDQo+IGluZGV4IGIzNzcyM2FkNTZjNDIuLmJlMWVkZDkwOTlmYjMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0KPiBAQCAtMzgyMiw5ICsz
ODIyLDYgQEAgc3RhdGljIHZvaWQgX3Bzcl9mbHVzaF9oYW5kbGUoc3RydWN0IGludGVsX2RwICpp
bnRlbF9kcCkNCj4gIAkJICovDQo+ICAJCWludGVsX3Bzcl9mb3JjZV91cGRhdGUoaW50ZWxfZHAp
Ow0KPiAgCX0NCj4gLQ0KPiAtCWlmICghaW50ZWxfZHAtPnBzci5hY3RpdmUgJiYgIWludGVsX2Rw
LT5wc3IuYnVzeV9mcm9udGJ1ZmZlcl9iaXRzKQ0KPiAtCQlxdWV1ZV93b3JrKGRpc3BsYXktPndx
LnVub3JkZXJlZCwgJmludGVsX2RwLT5wc3Iud29yayk7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IEBA
IC0zODU2LDYgKzM4NTMsMTAgQEAgdm9pZCBpbnRlbF9wc3JfZmx1c2goc3RydWN0IGludGVsX2Rp
c3BsYXkgKmRpc3BsYXksDQo+ICAJCX0NCj4gDQo+ICAJCXBpcGVfZnJvbnRidWZmZXJfYml0cyAm
PSBwc3JfZnJvbnRidWZmZXJfbWFzayhpbnRlbF9kcCk7DQo+ICsNCj4gKwkJaWYgKHBpcGVfZnJv
bnRidWZmZXJfYml0cyA9PSAwKQ0KPiArCQkJZ290byB1bmxvY2s7DQo+ICsNCj4gIAkJaW50ZWxf
ZHAtPnBzci5idXN5X2Zyb250YnVmZmVyX2JpdHMgJj0gfnBpcGVfZnJvbnRidWZmZXJfYml0czsN
Cj4gDQo+ICAJCS8qDQo+IEBAIC0zODcwLDEzICszODcxLDE0IEBAIHZvaWQgaW50ZWxfcHNyX2Zs
dXNoKHN0cnVjdCBpbnRlbF9kaXNwbGF5ICpkaXNwbGF5LA0KPiAgCQkJcHNyMl9kYzNjb19mbHVz
aF9sb2NrZWQoaW50ZWxfZHAsIGZyb250YnVmZmVyX2JpdHMpOw0KPiANCj4gIAkJaWYgKG9yaWdp
biA9PSBPUklHSU5fRkxJUCkNCj4gLQkJCWdvdG8gdW5sb2NrOw0KPiAtDQo+IC0JCWlmIChwaXBl
X2Zyb250YnVmZmVyX2JpdHMgPT0gMCkNCj4gLQkJCWdvdG8gdW5sb2NrOw0KPiArCQkJZ290byBy
ZWFybTsNCj4gDQo+ICAJCS8qIEJ5IGRlZmluaXRpb24gZmx1c2ggPSBpbnZhbGlkYXRlICsgZmx1
c2ggKi8NCj4gIAkJX3Bzcl9mbHVzaF9oYW5kbGUoaW50ZWxfZHApOw0KPiArDQo+ICtyZWFybToN
Cj4gKwkJaWYgKCFpbnRlbF9kcC0+cHNyLmFjdGl2ZSAmJiAhaW50ZWxfZHAtPnBzci5idXN5X2Zy
b250YnVmZmVyX2JpdHMpDQo+ICsJCQlxdWV1ZV93b3JrKGRpc3BsYXktPndxLnVub3JkZXJlZCwg
JmludGVsX2RwLT5wc3Iud29yayk7DQo+ICB1bmxvY2s6DQo+ICAJCW11dGV4X3VubG9jaygmaW50
ZWxfZHAtPnBzci5sb2NrKTsNCj4gIAl9DQo+IC0tDQo+IDIuNTMuMA0KDQo=
