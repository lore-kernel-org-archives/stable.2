Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792581014;
	b=WwKOaBQn/NzZt40yuBZoLQa+ZE2h4jO8maMh9c7NUCESSU+7+Gwf8b4iSSnhTfprzpf9
	 hd2eUh1O5/3zJ8W1IcnY0PaHphta1toYMGvj9R3H/z9wF5js6qJGG9PL9ki8XPdPTrt+B
	 RpSpNsdimiljy6tquFGs0z+QjETD1f7Ww7AOUB9uHf9x3BxFH+LdKvxJL/o/nkhITBexn
	 qbfFdyX2ZN38PCK3+d5EQGTo5uY0CX4mcK/EydHulTMdVOa2mV4/hFSf0aTTvmhzZneMi
	 S7jrM+MB0g73s8dwaL6wRBh24xe0uoJcxKwWny1XonvxBoeZk0FEOd8lU3lry1EI8Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581014;
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
	bh=uz+GBhF1shoGNpRHd8B8ZwpZPggMUNifpqFT72E9Ap4=;
	b=J8Hv0saGfZzNrb8EWYCCzuiCuGyUOLZVVP5gxGZPo2e4OvKhzscRK72ILF6N0DmadVQP
	 VBZDsOaoYuG2Qnfe0sxMlLxYdfK85fHh9QBlNlDLFyqI/xMNa5dqnXVnlcG/Hb02DjKAu
	 1+exE3u1m5rAJ/Tb2wWzDOouV8wC6nnYaFAPCh37lp9aq3oVDsfHKOhA+tRit3TMIMtRD
	 sq5KIPzGe3blx/DeqiEk9zjH+44/Dyw1HBv8mrAgWml53hP+gVkOYy+KPN1/VM8vaAmZA
	 G/GE1O7tL5oM7jfsl53h1Ix5TGvmH/60pWa3N1FNdrHxDm5Ji5xMiLY6KRSOPUtOZTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IgIeOzuv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F23606A31B;
	Wed, 21 Oct 2026 11:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F23606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IgIeOzuv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792581013; x=1824117013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uz+GBhF1shoGNpRHd8B8ZwpZPggMUNifpqFT72E9Ap4=;
  b=IgIeOzuvB1gnateyCILuPzLj7rj8/OftJz/PBLBiEMOmP2Wi8cIrhnS/
   yL484wiYH2z36L0YF9ezy3d40ZXOanszw2+bEYbJFK4VcyGuB8uor/ul1
   Y/bv5G7eehbd5rdlDEAsL2Cx9IQPmb/QwDez5e+OqShPdNtxe3LNnL51j
   SKYX3DhPI0BPgWxBix7LCXp/mQSbvFuVoT4lWAQBeYPGOGayaLE8TfKnm
   58luTcAbt3eKP+ejDO745xaX4G831APL6JDrTGgIIjXx70Ix4HX+p53e5
   xhVH3dHGrCkr0olpYAbPdHZHviff3BDXdnVx83sib2TOGvX63F8aQ6XYG
   w==;
X-CSE-ConnectionGUID: mMxpCr8qTu2bzAyTbDHk5A==
X-CSE-MsgGUID: o2BxfiRBRV6QSdIWPDxx5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1338597"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1338597"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:10:12 -0700
X-CSE-ConnectionGUID: upknfI/8R0mIwTnn4u9Fhg==
X-CSE-MsgGUID: JbU06e1TQ26rLQdFCSuYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3409336"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:10:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:10:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:10:10 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dARdP+acazmLSIChcWlHV95LNNgHWdnQ/9adTcj70vM+aZ2snQMC7ykZLBV8MRqCdLuBLoy3CNWZoy9xV4ZSrM5dnnOZBn4LAzXeWRC9JW/Ql5BTQ3jpIvsffa9jFPz6syh7L6BYQ2Sa6gZ9GfzuYfXpikGDuhu5j9nvCnyHzAKCe2d79vyIqZSpMkbnvJbfnVjgogMjkDdLhiibb1lwzFaQ3erlA1sEJuuiLJzs4UhMz6udEVz78DBhf5AP1CcAWyRb5WsckX8nD6Xx8KHHqqLkTdjQiXai2e9YMXJ85pm5/LD0KHdu36XS6akG6zMFCi1uRtCc4EhvXH98PEuhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz+GBhF1shoGNpRHd8B8ZwpZPggMUNifpqFT72E9Ap4=;
 b=BYx5nkJMhqw6HtJaNCdw34lv0w6VtAru5f19mbVkhXSxeF7NjMAEFY01uw47QLQ1pEn/UDsut6hW0yOu+rN6bJad3c2WSGfXnyJY9szX94J/3W7+/f7o86Ws0+dNK4gVsZcUkyxClUxPHXG8eHUrpie0Uy3HJQFqidjThTVQOLpgYXgWqoINzJfKsI67E0ULfGsNgLkeOy6PS11NOIO+W6CkLSG/AxApHCyi0M2HbT71A1/U96eUQ7bgkFBWgQQbpDEPKtAkqC28WBP2YRVwBPdDiUFy3tSnscWgBgdpVg5wa5TcpqDjQ4SVs99BPfMZyNInIDcWJ6ZCjXC3HeBrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by DS0PR11MB8737.namprd11.prod.outlook.com
 (2603:10b6:8:1a1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:10:06 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:10:06 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michael Grzeschik <mgr@kernel.org>, Jijie Shao
	<shaojijie@huawei.com>, Denis Benato <benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Thread-Topic: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Thread-Index: AQHdX8/bZLEmrrsASEWls+Ht5tLxarcH2adA
Date: Wed, 21 Oct 2026 11:10:06 +0000
Message-ID: <CH3PR11MB566895CD7DE8923616D891C85BE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
 <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|DS0PR11MB8737:EE_
x-ms-office365-filtering-correlation-id: 89b5be30-46a3-4827-80d1-08df2f63dcb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|38070700021|56012099006|5023799004|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: vj5bXlzRwJhVzxJosPspNT2xcKFmtfWAIYgGXe2VABErEs9lCWx2cNQl+mwZYZ18nNnPxUGsAjLHBuYeqKBhRA0TO98Q34rwQZEIyVbXKoZrIT/fI6KxYO8sUAgcDfl8qNpkAnqzPI6fZuFu1qIF0ApnVFOF/R5NB0EOU5cWdJE+Qrg27Fi66ZqcWMG/VLX6J8I5PKkhDthGRiyK9v1/lmgjcqKfTeed3ljHa6Y1uBxq3gawVUcPqyJcuxxlpjdSTvUxhLrFEJ+dPm85mj2Eta8zEDdWHO90z4isOB0TdJ7dHl6tfg+hNfmPjVNAsZe35vpuLPuGUt54eqELipo/JE9cCi6GrUOJCDl8eeblUxmgI0pNg1CWU+65A27Y6z0s5fKxSxoFIUNJ3J3L3v4ztx/tD3IdbqfDvUghIlAo7p6B9Ah7FSkWBrWMANGZIbFNcHnq3lYnuON1E4gTGWahcpRbc+0qR+dMMC2J3MvKcOmWkZVNfxG10JEu7qlsqCrs3qgQknf6kRsSxlymZBJJgOp6prMQBhV1besWiwxJMH4gmMcg5pE8u5t+Nu2WGO/ccG3C3D9M94Q2lhCUstsgVybheQkUpPWyf0gMgxUADjrpCzQrQNrmpffZYol1m0QBFMmiW09If7CBC0ymf+hmVxTRoIS0gq7ZuQ62mAqPNGKSBUIQYRlBzF7BtQV0lFwXwuCQZrVQ8KGgqNOotJFYOZlZ0nYvI3AP3SFB/7xXrEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(38070700021)(56012099006)(5023799004)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0pJVytzOS9raTdpUEVtcjdGeitzRFJHbUJNSi94MEZZRDcrREZkQXFRR2dU?=
 =?utf-8?B?N3p4VDMwMTJMT1N5b2svaHhNcGNBNHNnNG10OFU4RHlWNkp1UkJYb2VQWjhQ?=
 =?utf-8?B?OGtuUnBxS1RLK2tZQUxuSVVoY0RIbFB2SmV5WElUYy9EWUZXUklsZWg4R2l6?=
 =?utf-8?B?dmdnVGFlOXpGaUdrdnd5NnZacVZxTVpSdjNDR29pMXJ2K2M2SGZKNEVPY1gz?=
 =?utf-8?B?NUNEZlFwUDFaNXR6TWU0VldxN203RnJodGE1T0pIT0dnV0w1bDdvZnNZcXM0?=
 =?utf-8?B?dEoxVmZtSGJLRFJFWVZzcktPQlR6QkhVaVYxNzFpdHMyemd2UmlZZUJWTFA3?=
 =?utf-8?B?SDFVamh5UkJ3SXhqK0pyY0FUbDU0Mm1oTXE0ZFBuaEVEMHRJUXp6MGpKZ2li?=
 =?utf-8?B?bjJyQnBrRjdRNTNEQWtBNzJWNXZQM3M0Q0t5NGJIUGU3NFVOOWtXcEVibEFl?=
 =?utf-8?B?bnhyQ1RxRWZMaWh6akFBdWFzUkQ2RmFFWnlsOFNRWlNhcG5Semx0OHEwWHdY?=
 =?utf-8?B?UWM2QlpSZTlEV2h6UEU1a0ZFNjczbTZYcU5VWDlGaHRxWU9BVWxSeHI1S2V3?=
 =?utf-8?B?UWlUWVQvcVhPaVpvUlhaL1ZwcXQwaDlUZ29ZdVBwWTU5bWhyaTBoVyt1eXo5?=
 =?utf-8?B?WkR5akpZRGYyUzdPZGJoUXQ5UXlJMDVRSUM5cTIwRnFlR1AvMVhETGdXMUhL?=
 =?utf-8?B?WEliazFuTjhrNzNac09QYlNZTVlYbGk2Nm9zbGMyWnAyREhzL3ZPVExkNUNv?=
 =?utf-8?B?Yk8rUThKcHF1TzdoVE8zekh4VlI2bjdKRlRUbmN2ZW1JejhMWHNCY1o1MEpB?=
 =?utf-8?B?Z1NPOUdNR2dWUzA1WmlOSTNZRmNkcmlJVDhMeDRYVTR2ajUvckJqdnJ4bU1q?=
 =?utf-8?B?Skh6NDB3ckFNM2RLQ2d1WmFqOE9DMWY5Rzg0cGR3VEE3VUZnNFMvbTM0QVk5?=
 =?utf-8?B?dnJsNDdYUEhpMEx6Sjc2d21rdW56aFY1LzJ3MGdVL3ZnR2N4Yys0dlpzWHlV?=
 =?utf-8?B?ckVoKzdXdVpyNzRtQ09GSHh5SG05c2hZKzZkVHdlOWxDcEplWmZjK2JHN2NC?=
 =?utf-8?B?ZkUyZlVaMGZSbkZJOHhQMytmWWw4WlUxMElmUC9jc2tUYnBBak9BMUp5cExT?=
 =?utf-8?B?bmErUk94ZU43aGEvcDdjOW5XSXVHWDRZaGNBVmtOb1N2RzJoR3lmKzRJQjhz?=
 =?utf-8?B?cDlCTWpGR3lyV1BOOXgwOU53NUp0S2FJeUJ6NGlkaytUSzFtc0h2QXZSSmVI?=
 =?utf-8?B?U2NUVE95SFNQU3pTMTgvUGlRU3M2aGtnbmRlWkE2azQ5SWUzYjlsWmoyMmtH?=
 =?utf-8?B?UDdjNW1ROVVwZTYzZVhjcy94S2MzbWgvbGdVRGtSZ0swcDM0Y1Q0N3ZOM1dQ?=
 =?utf-8?B?OEdZUU9nbWxpRTdoZjIra3JnQTBZY1J3dnppYm5BeTFCVWNYbmxXRTJsaXM0?=
 =?utf-8?B?Z3N1MFFlOE1CQjlhRndnRFdxMUxqUG45Qmo5TXRqYkhlQW5mUmxiTmpLbG4z?=
 =?utf-8?B?a3E1TVVqb1RBY2JYQWQ5MGNabnJiL08xaU9GTkw0WDdCU3ZMb1hNL1QxMjJw?=
 =?utf-8?B?NDhlcXpWKzlzd3pWc2FxM3ROQ2F2TGhNZWltRmtYWWNIdHM2TE52UmUwNXRC?=
 =?utf-8?B?bW9TU1dMbE11T0dGUzA0Q3pGTVhZVGpUSHdoRWNwM0hGTW9CclZPVTBQclB5?=
 =?utf-8?B?Q09JYjdEQTZmcmEyNGtLd3VOOHErRjdSZWhYVmZxaWFLNkhCeG8zNmx2MThy?=
 =?utf-8?B?ZXhhbXFpY2pYSEFiSkRURHJESG9HMzhsQ3BVM0RNc2VvTVZPeW1sVW9Rakg2?=
 =?utf-8?B?MkVLd05HWXhpL3RIYkdSWi9mSkRFbXdLc0RoRnlOdUFXemxpd0RVMTJ3RTBp?=
 =?utf-8?B?akdsSmthL2hPTzExZTcwdm1BSndhK01vYks4NzhneUZzdWo4TVNMMVhZNFN3?=
 =?utf-8?B?QlFTaFdwSWhYSlN4K20vSG0vTTh6aTgrR0NFYVk3Qm56dkVZMS8yd3U1ekM2?=
 =?utf-8?B?TnhSYi9hTUNHbTRCOG81RXFzUlRWcThadmwyQjJTSkJ1MkZrOU4vQStJUFpi?=
 =?utf-8?B?c3lRVFpaemw0ZXFwM0xsMjZVOXBhZWZvdUZsL3N6Q01MbHBva0ZZOUkyRit0?=
 =?utf-8?B?RDR0RmVOU3Bjbm1NS2xwSmxoakRKVTlzdnBFSk9CMllrOENZQ3FxcDJzNnNq?=
 =?utf-8?B?dmNNOXQrc0FaM1Z0K1NDVzh1K003MDJXNTZmVjA3VGVaamFtVVI4TGl0eW5m?=
 =?utf-8?B?UkNCWjcrVXNkZmlLcFY4bGlZWGMwdVdJQkdZUm5PYTJVdnBWRDJ4YnZSMWda?=
 =?utf-8?B?N2gwMzFYdVdLMkVDUVlFaGRBKzhFa1dqUVVSbHdUTlJxK1FtSmVZTno0eXZQ?=
 =?utf-8?Q?2XsVZ/PqAzvM0My0=3D?=
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
X-Exchange-RoutingPolicyChecked: agRl0FRbY0VogAGN/KW0e0/GSFC46IqKTrtAFkgnEicoxBAi0tMMs+6AhyUGvIx53pqz2Mj0wSYkxWz3YsS3SuteGWEcagATHEtgjjx+YCFdHOyOTCjYmA/dgZcL7//8q1jmXzQNVs9BSln3DgE5s5rvC31buFdML0dv2hbvuIzpvp6sEOgOmbT5/+bblUUk6tRoOIOFhg0UVOpqdpwWu3BTbL52iTM04aQDp4nKCNWpPrltHW99wUEXq5LMAuh4gweuU2PP9sXK6mvmezxOxldfpSMy54XmTzPtU6zFLLJByF9VOlfQKVliK/zL1cziN4si4nhbEVSsDceZegbsDg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b5be30-46a3-4827-80d1-08df2f63dcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:10:06.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLkMw9mJW9E0umM/rFsK5OD6dGbHSxsenynBaZo4hEl4JskU325FeKUucNrwIbDY2ngKg15x1kNf4ZFHknncfUxcFmkdZOlMVAWjo+zi6Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8737
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog0JbQsNC80LHQsNC60LjQ
tdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1iYWtpZXZAcHJv
c29mdHN5c3RlbXMucnU+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxOSwgMjAyNiAzOjQzIFBN
DQo+IFRvOiBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPg0KPiBDYzog0JbQsNC8
0LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00LjQvdC+0LLQuNGHIDxyLnpoYW1i
YWtpZXZAcHJvc29mdHN5c3RlbXMucnU+OyBEYXZpZA0KPiBTLiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiBKYWt1YiBL
aWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29t
PjsNCj4gTWljaGFlbCBHcnplc2NoaWsgPG1nckBrZXJuZWwub3JnPjsgSmlqaWUgU2hhbyA8c2hh
b2ppamllQGh1YXdlaS5jb20+Ow0KPiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxv
a3Rpb25vdkBpbnRlbC5jb20+OyBEZW5pcyBCZW5hdG8NCj4gPGJlbmF0by5kZW5pczk2QGdtYWls
LmNvbT47IFV3ZSBLbGVpbmUtS8O2bmlnIChUaGUgQ2FwYWJsZSBIdWIpDQo+IDx1LmtsZWluZS1r
b2VuaWdAYmF5bGlicmUuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGx2Yy1wcm9qZWN0QGxpbnV4dGVzdGluZy5vcmc7DQo+IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIG5ldCB2MyAzLzNdIG5ldDog
ZmVhbG54OiBib3VuZCBjYXJkX2lkeCB0byBwcmV2ZW50IG91dC0NCj4gb2YtYm91bmRzIGFjY2Vz
cw0KPiANCj4gRnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0
ZW1zLnJ1Pg0KPiANCj4gY2FyZF9pZHggaXMgYSBzdGF0aWMgY291bnRlciB0aGF0IGlzIGluY3Jl
bWVudGVkIG9uIGV2ZXJ5IHByb2JlLiBJdCBjYW4NCj4gb3ZlcmZsb3cgYW5kIHdyYXAgdG8gYSBu
ZWdhdGl2ZSB2YWx1ZSwgd2hpY2ggdGhlbiBpbmRleGVzIG9wdGlvbnNbXSBhbmQNCj4gZnVsbF9k
dXBsZXhbXSBvdXQgb2YgYm91bmRzLg0KPiBMYXJnZSB2YWx1ZXMgYWxzbyBubyBsb25nZXIgZml0
IGluIHRoZSAxMi1ieXRlIGJvYXJkbmFtZVtdIGJ1ZmZlci4NCj4gDQo+IEJvdW5kIGNhcmRfaWR4
IHRvIDk5OTk5LCB0aGUgbGFyZ2VzdCB2YWx1ZSB0aGF0IHN0aWxsIGZpdHMgaW50bw0KPiBib2Fy
ZG5hbWUsIGFuZCBmYWlsIHRoZSBwcm9iZSBmb3IgYW55IGNhcmQgYmV5b25kIHRoYXQuDQo+IA0K
PiBmZWFsbnggaXMgYW4gb2xkIGRyaXZlciB0aGF0IGNhbm5vdCBiZSB0ZXN0ZWQgcHJvcGVybHkg
b24gcmVhbCBoYXJkd2FyZSwNCj4gc28gYSBtaW5pbWFsIGJlc3QtZWZmb3J0IGd1YXJkIHdhcyBj
aG9zZW4gb3ZlciBhIGxhcmdlciByZXdvcmsuDQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmlj
YXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0KPiANCj4gRml4ZXM6IDFkYTE3N2U0YzNm
NCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpoYW1iYWtpZXZAcHJvc29mdHN5c3Rl
bXMucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgfCA1ICsrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
ZWFsbnguYyBpbmRleCBiNWU5NmM3MDM3ZjMuLmQ1OTMxYzAzMTRmYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZmVhbG54LmMNCj4gQEAgLTQxLDYgKzQxLDcgQEAgc3RhdGljIGludCByeF9jb3B5YnJlYWs7
DQo+ICAvKiBpbnRlcm9wZXJhYmlsaXR5LiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4gIC8qIFRoZSBtZWRpYSB0eXBlIGlzIHVzdWFsbHkgcGFzc2VkIGlu
ICdvcHRpb25zW10nLiAgICAgICAgICAgICAqLw0KPiAgI2RlZmluZSBNQVhfVU5JVFMgOAkJLyog
TW9yZSBhcmUgc3VwcG9ydGVkLCBsaW1pdCBvbmx5IG9uIG9wdGlvbnMNCj4gKi8NCj4gKyNkZWZp
bmUgTUFYX0NBUkRfSURYCQk5OTk5OQ0KPiAgc3RhdGljIGludCBvcHRpb25zW01BWF9VTklUU10g
PSB7IC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMSB9Ow0KPiBzdGF0aWMgaW50IGZ1bGxf
ZHVwbGV4W01BWF9VTklUU10gPSB7IC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMSB9Ow0K
PiANCj4gQEAgLTQ4OSw2ICs0OTAsMTAgQEAgc3RhdGljIGludCBmZWFsbnhfaW5pdF9vbmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsDQo+ICAJaW50IGJhciA9IDE7DQo+ICAjZW5kaWYNCj4gDQo+ICsJ
aWYgKGNhcmRfaWR4ID49IE1BWF9DQVJEX0lEWCkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYs
ICJjYXJkX2lkeCBpcyB0b28gYmlnICVkLCBhYm9ydGluZyIsDQo+IGNhcmRfaWR4KTsNCj4gKwkJ
cmV0dXJuIC1FTk9ERVY7DQo+ICsJfQ0KPiAgCWNhcmRfaWR4Kys7DQpjYXJkX2lkeCBjYW4gcmVh
Y2ggMTAwMDAwIGlzIGl0IG9rPyANCg0KPiAgCXNwcmludGYoYm9hcmRuYW1lLCAiZmVhbG54JWQi
LCBjYXJkX2lkeCk7DQo+IA0KPiAtLQ0KPiAyLjUzLjANCg==
