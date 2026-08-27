Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76209272E56;
	Thu, 27 Aug 2026 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792430; cv=fail; b=RQXT9KyMdxlCX29AUFq4cedkMnhwBJyhLcOmn2c/FoqPNfwOapS3s1GVIQoiGNPmumD8pcQMsvkec3JqCoi7/dg0+Cov/1iELEBEcK85JpIEv56RORDu5rWeF7KSIA+lmVXT2ipx2KQA0rNPo4LDam8K6vtV8555wVLoSwTTJzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792430; c=relaxed/simple;
	bh=qppiRKZQuxxluZja+KWzxRo+OCuShCi7DC3zkc04psk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fj/ooR0kd+vqb44K6vgWw2XH20BD7V/YiFrE5GbqGus7Jv7xaHrPU1AsdGRfllb9yqqhAu/zWwhyAlIjBPtu4yQ391jxEa5+BTQ/mkxJ1RIYL1Sp8Ev+sLT56LfTSxOFiEEEtpRgOe92jrYuVgaA+NDBbDLigLw5SRkVqY4VJn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgh8caIq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgh8caIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787792429; x=1819328429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qppiRKZQuxxluZja+KWzxRo+OCuShCi7DC3zkc04psk=;
  b=Qgh8caIqsIv6iLa7rh3Gf3WC9Ti2fRk/BOaYDm8tkFjL98vU2sX5Y7sF
   AcwaxCDKzvOFZVF1eKbSR3FEE7dYDCgfFS4+gRQwGdGpNonXQyORA26vS
   xOVDs3FHz8hBYAHHHsHjxWj4F7T1fXLiShfW10QMqAzS9KKYauFWXaEkQ
   6GS/Y/lmzGycjM/dtskUWiYApmk1APwKpuTlMlImfDe3NG9nZL3uS1/Nx
   8cPZEpol+eRkGTA5CpgxMkiJDM/3SfQ2eoqCuHacAapmjzSfDpdKGmNhQ
   lKI9TfKjYH5DrxLbcd9zY06vNB3fhxXZU+SDCSsp6VOgO8kjKdp4iIFBw
   w==;
X-CSE-ConnectionGUID: VYyeOJfuQRCTmYCDvl7eCg==
X-CSE-MsgGUID: tgJHn5I9S5+8z34OpIkhHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98885391"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98885391"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 18:00:28 -0700
X-CSE-ConnectionGUID: CKMriuW4QsCxY2Qh9N+TEA==
X-CSE-MsgGUID: yS7V31HBTvm8uObzQEoSVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="297605655"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 18:00:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 18:00:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 18:00:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 18:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9RLKujmiG8i7tfFIc9vapyUKvaEFEYfNML8v571CfdVUl2FMt+7SwoN30GUC1nLlweWbmwTN3HZqQX9hH9SjSjMQ+prEIGcJOpVdt1aJU5i6UtdHSSiTfXO0uKMsA9d/QvFcUqGgaPOItZx1rdct8gD/D5wIIzNSMpxumxaVTogJdok2mu3ODb0Tpz7oMpzZPImmFVXVcTtLIuUX1YyADk/LNHbCtUmiKIJ9SAijl4ARTlo4PiH3VR2rIV+7+gPdaw+AwaJZcpFMxk8SblGQFkoC0C/xjsF4echiqxfbUXa7TktdIr7LDQrx+9m54aiz9UnnKfSz2SXS0QcS0xkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qppiRKZQuxxluZja+KWzxRo+OCuShCi7DC3zkc04psk=;
 b=bZ1k44Ze6Z77WjTpRkzLSRWFYkJzkXwDF5gTScF2ym+19xSOA2rRG6PlNSwy3r5LiNBdp6dvK7CWOAG1x8z6qBswyRvj0ETWepDNpdVJ+7ayExUUwcNk5hCqkm3x/6LqAA7W6v/Sg79oQ0TtZs19f2LmP8V1f69x5F+TQV3KjllJn13O5PIE4roEFMxg/KHybm0HyI6EIomTRu+AKohF5piVNONY746kz8cBPSeH6m5aB9fRT67eZiSYileRT6skvbK4CqAvspeaAdGFSAc32XY6yissSgMuplanVnrpQCimfhuiBqK+jHoBuFLOwqM7Eq0koA+pG1Wf9Y2EWTXoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by DSWPR11MB9869.namprd11.prod.outlook.com (2603:10b6:8:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 01:00:24 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 01:00:24 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>
CC: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input buffer
 for the DMA
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quicki2c: size the input
 buffer for the DMA
Thread-Index: AQHdMjQpjOXT9LnzF0uw7scCh+5XYbavhq2QgAC6xoCAANahQA==
Date: Thu, 27 Aug 2026 01:00:24 +0000
Message-ID: <IA1PR11MB609867952C6FAA206ECDAE32F4AD2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260822124531.644834-1-sammiee5311@gmail.com>
 <IA1PR11MB6098D3A31961238BCC060D83F4AE2@IA1PR11MB6098.namprd11.prod.outlook.com>
 <CAJciObF_qN2G0RNpqO0N+DURop0Ja053QY1krfneCT0bmmv51A@mail.gmail.com>
In-Reply-To: <CAJciObF_qN2G0RNpqO0N+DURop0Ja053QY1krfneCT0bmmv51A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|DSWPR11MB9869:EE_
x-ms-office365-filtering-correlation-id: bc46cd06-42a5-4362-feb7-08df03d69364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: vToZHzBbckFCgIm/dzZHEM3AExeVISSbe7LmSWpmD9FYSzCjp8+xL6rtE+UYYsjqvbz0HS00LXCIBW2xx5OeNRy8L66xV36F+QAOEcGnf5JkoS6IRVv8nlVF2N7xd2jmzLcGPbBT4myyOgzaInQpIrPmLAMvbmNfb1LkTjVC1vQ+RYX5Ad3AhLQAwWVbXFiDjmklmQicOfxHKZA4xbNi5hsGlyAZJZS5aP2HenecRv6uKA7g4xemJvxpMpv2DJCH5/B8+ULFTMgnITxU5rjRZjohK+0LP9i/zYUAtfxwDbehz6VPhYQUgiUwe2lW1nLrDR1GK6OFMxw5gvGkjXhPpf0ow7LKDRUhDITjBghX/aFsXDApoDL/KNXdfo6ZNPpdHJLA8LTkqgWS+BgmHpSQdY9IYz8h/9PQS99tJfm71bCIq7QOpS/dxWe/XHO5U7QE9DfUpizwA1ujuJZklAN3EL5sO9xrrVQCX4QkPbQwRGGwIr6/Tga0figf2MY6mx2xecSnUlN6yB3eTmMgfWYsVYcJsOoFQbe7slBNMGw9Q4VZSbSO/FB9e0YD+b6G2ivU1q1IZ3WrGwH1RIcjtFo4ihesMRt0lK4Dx03VF7NDChfz7RzQ0bguWb9HLit1Kew3QBwOAwopR3DPItv+FfI9RT/VRHZtuIJPlp20Xybxf2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDF5c1Zhb3hjYllVemxTZ05SQVkvWXhyUFpJREZaV3F5SW1rUlFDZHlLcHdn?=
 =?utf-8?B?dXBsOHp1UWhzTUxsK0lvT0l2eEcwZEE2ajk0bFV2UkZnN2dtMFNjaW5FZzYy?=
 =?utf-8?B?TytKWnBKeU5qMUVHZHlNQjhEZFh2SDVSemxKaHdYM1V4QUNwYVpka2piT0Nl?=
 =?utf-8?B?TFdZSlRGdnRrU0REa040NFZ3anBLTVJiVHFROEIzODdmZ2YyRVlnQnFrOW5O?=
 =?utf-8?B?RGRFYTJHN2hQL1p6bTQ5QUg1cDdMMU1xTnFWTEJWVnRuZmIydklaOXNQRk1t?=
 =?utf-8?B?VUJnZnJTalE4YkRCcnNYSWY5SVY2eVRKb25mbUJoUFhUR2RFem9zbTdKYzEz?=
 =?utf-8?B?c2JpTG5BL1ZrN1JFeEEzWHJoTzFHaDFJK3VtbXdPcWcvMHc1VENVWlEvQko1?=
 =?utf-8?B?WXlwM3I2YXlWc0NaR3E4WGpIRVpReFlpQjBmN0JNVmZxSlYzcGJidkhpT2Mv?=
 =?utf-8?B?MFNGQ2U5cGdVdVo1b3dYSzg4bE1tVHIydmZhU2h3cGJKVFZrU1R5dUlscjFl?=
 =?utf-8?B?eEw4RVlYWXM1QXZOWFVlUU5aYld6b0IvZTUzb2tmR2lEbXN0TVQ0TW4yMStP?=
 =?utf-8?B?Wk02QitzOVVuVlA2ZDJoNFhleFBGb1dqQjMyT2ZsNUx4ck5RRk9icGMzQTBj?=
 =?utf-8?B?cjF2ZUpldzI2blBsMmE5Q29EOGx6d1VGQkxrcDE2eEdXUDlpcUgyLzRDL0w4?=
 =?utf-8?B?cW5rWThRL1Jsei9MNVV3bmNDelNLUEpMZkROQmt6cHJpN3hkSVlYV05FbU4v?=
 =?utf-8?B?SjJpWm00MFc5MXVhbVpBWXo3aHRQTDBBOUw5VmFSWVZsdXJmeWJVWGtUUDlY?=
 =?utf-8?B?dkJ0Y3J6Z3c3WG9IcWNKUkJ2UHoxQXpaaUQxMEZCTkMxeFFCaTZKNDQvN1N3?=
 =?utf-8?B?VXFleDEvOEJOMFE2cmxlRFNqSGZIREVtK1VyRFc1ampuSDUyWUY0ZjBqYktz?=
 =?utf-8?B?SmthbjY2b3h1VkZLbUZNUWR2UkxmY1A0YVo0dFpCdVVOOWRWYndyRUlITlpS?=
 =?utf-8?B?UksvVStLN2FCYTB2dTdYajBFbGVsQmdhN0NBQStESU40L2I5Tnk5a08xVjJo?=
 =?utf-8?B?dXQ3RmM3YlNyT3ZPOUR3MlB1eEt1d3FsUnZmbXlUWTZVYjU5cFZUaG5ja2dL?=
 =?utf-8?B?YWIxWTZBbmVRbC9ndUFlUlE2WHJwOGYvWUU4eThlK2dXUFNsRElJOXU4SUd0?=
 =?utf-8?B?TEdxUkRjamFyb01WWVcrWjlNMVBHQ2ZkZy9lUVhnN0ZrWktzSkV1dnVFb1hy?=
 =?utf-8?B?THVwMnpUWFFGelpWTHY5cHR2ZDBYbm55VVM1Y0ttVmdXUnYydWIzNTRJeGVa?=
 =?utf-8?B?MzA2cGZBS0RNRHFMSFFsN1dRcW5oaDJoYjErZEw5VEZFQ1lNTWVZcFJ1Z0dB?=
 =?utf-8?B?amZkd1dWdjRoOHVpQW1YcW1adDZsZi9CT2VyY09BWGxoU2FUQmZKQUFvRm5j?=
 =?utf-8?B?Z0lpWnFWY2NZbXVPRlBzNk03RHRHSXpEUC9BN2hoUzZBOEJnOVBLbUpXQmxh?=
 =?utf-8?B?RDA1akV5Wnk2UlI5UkYwZmo3MUs3WFZ6Z0tqYmIyTmdBUklmM1R3MEtsQkxD?=
 =?utf-8?B?WHhhcSthRlRjbStpMEFNUTBxekt1Q00ycndkSmVLbE9WS2FEb0c5OC91RlVq?=
 =?utf-8?B?Z3FoWWxvV1E3a2ZqQmVUOXhSNGtxUmZmUzduWk1RR3Rvb2xNZ2ZjYUw5Ymo0?=
 =?utf-8?B?akRlamQ3dW5wUkMzQWYzbFRZVFJFU0V4dzNHUU5obmN2TndKdzJOKzJmZlpu?=
 =?utf-8?B?UGV5QzliRys1Q2loRXNqWVFtbnp4ZG9LaUplQnlUYU5PUFhCWFMySXpUWGx2?=
 =?utf-8?B?ZXJjVlA5V3kxMUVWM2JhdjJqaWlJTnQ0MnRHV043NlorMUN3aHJKcENFR25Y?=
 =?utf-8?B?aFlEbFpnZXl4M0dLK1Y2VWd1dDI4WDU3U3JGcFo4Z2RkSHFEclNDWi9jb0RL?=
 =?utf-8?B?ZVpkUmthNksyYnRjWG5odjZFQUJOTDAvYUZvMkYvYzZDcTlmdTJHUTQ5MXVv?=
 =?utf-8?B?TkFiY3h2UDZQT0JEUWpHLy9vQlJYR3lJS01EVTAwQzlDbnZvOW80V0JsWDR0?=
 =?utf-8?B?ZG9TWmtqQTNIbGZiNTl4L3NHaDdrMGZOQ2hZOUI2akJLSTAyMkNOcjNTTFh2?=
 =?utf-8?B?dmIyNzNwRVJYcEtNaTlvd3lwSENHYnVhMkJhdUM4eURiUHk2SUU3b2ErVFFq?=
 =?utf-8?B?bUIxQkwvSmZqWmZPWXFoeHFXMkREejJ0SS9XS2pxUVdyY1hoMzk0d0RqdEVv?=
 =?utf-8?B?a2RjTWNvejJVU1BPSGxBV0hCWmJOc0dJNWF0bGkwQmRhdXJyUDdEQUZnZHlq?=
 =?utf-8?Q?OvHY5MXMMrcmn68ApI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N13ZiLliIrrtAQY+rRLlPnJ8SZDQAt2VS7kFU2CJo1QQn33uGsZNaiJYptriH8uGvcN7NbyyeztyIW+RmqkIkp9YHexIczjB4BjzqaQ5J7SpmHCuYr24o0PuT95zDDXAkZuSHB2KQzmDRrW9QK550TWBTFMDFLAA+8yTTHpgkrMeZppAaPRq80fJfEM2FAHRw8phdxzJPv8B1oAIVgwQxj2JgakC9mICvmeetrjRtnLHhHpBNlbaI2srmhqpu0v+AP+A87TLpaN3bgA023bcVIF8X1lk8LZKAz+9/i+S/KalEFGYpgutnRTS+lO4hlEoet4i1rB3xbIhw7k2xiQ3ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc46cd06-42a5-4362-feb7-08df03d69364
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 01:00:24.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tslWUpUkeSLdnjthocIFoJ2VrxTLpzVsyLW+UpH5cW6inKXUzlHNcQR6KDiSrCnmiIVHb+ptpqV8LpS/DarYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9869
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIeWVvbmdKdW4gQW4gPHNhbW1p
ZWU1MzExQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjYsIDIwMjYgODow
NCBQTQ0KPiBUbzogWHUsIEV2ZW4gPGV2ZW4ueHVAaW50ZWwuY29tPg0KPiBDYzogU3VuLCBYaW5w
ZW5nIDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+OyBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9y
Zz47DQo+IEJlbmphbWluIFRpc3NvaXJlcyA8YmVudGlzc0BrZXJuZWwub3JnPjsgbGludXgtaW5w
dXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBISUQ6IGludGVsLXRo
Yy1oaWQ6IGludGVsLXF1aWNraTJjOiBzaXplIHRoZSBpbnB1dCBidWZmZXIgZm9yIHRoZQ0KPiBE
TUENCj4gDQo+IE9uIFdlZCwgQXVnIDI2LCAyMDI2IGF0IDEwOjEwIEFNIFh1LCBFdmVuIDxldmVu
Lnh1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gc28gaXQncyBub3QgYSBwcm9ibGVtLCB0aGF0J3Mg
d2h5IHlvdSBuZXZlciByZXByb2R1Y2UgdGhlIGlzc3VlLg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
ZXhwbGFuYXRpb24sIHRoYXQgY2xlYXJzIHVwIHRoZSBTV0RNQSBzaWRlLg0KPiANCj4gSSBoYWQg
cmVhZCB0aGUgUnhETUEyIHNpZGUgYXMgYSBzZXBhcmF0ZSBjYXNlLCBhbmQgaXQgbG9va3MgbGlr
ZSBJIGhhdmUgdGhhdCB3cm9uZw0KPiB0b28uICBpbnB1dF9idWYgaXMgbWF4KG1heF9pbnB1dF9s
ZW4sIFNaXzRLKSBhdA0KPiBwY2ktcXVpY2tpMmMuYzo2MDcgd2hpbGUgVEhDX1JYRE1BMiBpcyBz
aXplZCBBTElHTihtYXhfaW5wdXRfbGVuLCBTWl80SyksDQoNClBsZWFzZSBwYXkgYXR0ZW50aW9u
LCBpbnB1dF9idWYgaXMgSElEIGxldmVsIHNvZnR3YXJlIGJ1ZmZlciwgUnhETUEyIHVzZXMgdGhl
IGhhcmR3YXJlIERNQSBidWZmZXIgd2hpY2ggYWxzbyB0aGUgc2FtZSBzaXplIHdpdGggU1dETUEu
DQoNCj4gYW5kIExOTCBsZWF2ZXMgcWNkZXYtPmRkYXRhIE5VTEwgc28gdGhlIG1heCBmcmFtZSBz
aXplIGZlYXR1cmUgaXMgbmV2ZXINCj4gZW5hYmxlZC4gIEkgaGFkIGFzc3VtZWQgdGhhdCBnYXAg
d2FzIHJlYWNoYWJsZSwgYnV0IHlvdSB3b3VsZCBrbm93IHdoZXRoZXIgaXQNCj4gY2FuIGJlLg0K
DQpJZiB5b3UgbWVudGlvbiBxY2Rldi0+ZGRhdGEsIHRoZW4gaXQncyBhbm90aGVyIHN0b3J5LCBp
dCdzIGEgc2VwYXJhdGUgSFcgZmVhdHVyZSwgeW91IGNhbiBmaW5kIHRoZSBkZXRhaWwgaGVyZTog
aHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvaGlkL2ludGVsLXRoYy1oaWQuaHRtbCNtYXgtaW5wdXQt
c2l6ZS1jb250cm9sDQpUaGlzIGlzIGEgbmV3IGZlYXR1cmUgb25seSBlbmFibGVkIG9uIFBUTC9X
Q0wvTlZMLCBzbyBMTkwgZG9lc24ndCBoYXZlIGl0Lg0KDQo+IA0KPiBFaXRoZXIgd2F5LCBwbGVh
c2UgZHJvcCB0aGUgcGF0Y2guICBUaGFua3MgZm9yIHRha2luZyBhIGxvb2sgYXQgaXQuDQoNCkFs
c28sIHRoYW5rcyBmb3IgeW91ciBwYXRjaCENCg0KQmVzdCBSZWdhcmRzLA0KRXZlbiBYdQ0K
