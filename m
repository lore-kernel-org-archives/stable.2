Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8602248B3;
	Thu, 23 Jul 2026 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799371; cv=fail; b=hzDsTpNjMv6d0VY0/8sjTCOcZKU2MtehUi7cvySZu2xK03Z19SXygXxxIqws+CsW6MMVZC40BGSoWwuL+YOT/u45StgjrYRGz+dI6BQUDg0LOJ2kYwzHpI5nP5KwyeqkcGe+NfDec7xi/qJTrQt3VwtNCAf7SneH+GntRlECnZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799371; c=relaxed/simple;
	bh=K8it02dqCzFXWZcejm1XmqsTcPv0CWh5J2ig2vni6JM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fUxO16QJRMr+h2U5koCglGeS3IQIdCS/GIOTpwXdLBrh521PePi+5CRygLO5BZE/mG4PSpgf9Vl3fw0PsD2/7JiRWNCp1XTXr5yPZO+HXPCO99thlN4roxHAWGdwhCuGg24sO/gMPaCx3St5vaELTPrYlOQazPz22scehYb8q0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y8sAsFJO; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y8sAsFJO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtbByHTykTS05bXDxMJNE/znD1uXIKbXM65KCAeLIqQVhdqNJLbwtC/gdW1n2kce16Az5/k1flYzVYflnblekzyzi2SGD7t0ZuceO8Q/rw/3udLUeMkHUqPWPtG1qczqPgHCBpnR5t5RWyELMsjh9JWrQMARdmj4PaKzxuHuTsUTZkTLtyo2iUvtSLE9Va5PoC02zPJwrh1aD8y63RSXt4XEmEPYYPDA6RotSw02PnHaA1V8mDNx5CvlPYxImuFnhKt2jTNyXy3aRC8LYseyJNOZ95h2GltT/3TyndROmpwAxf1QE+3OGL50EKTdztnvRdTInO3KJdFX5SesQ9Dm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8it02dqCzFXWZcejm1XmqsTcPv0CWh5J2ig2vni6JM=;
 b=MTyNc42pUpghjOd2FukQDuXAo7GBRbzqCj7ng04tSsC+nNRL9BsqELrmkk/KGUgQmx7EVOXKL/+O+mjdMg/UzoHRY0JiMeX18Ufn8Q9hPHMGAc8j6+8gBEu1uBs4TjUVfpVrsNbEK3ga7/A7px0NgSp6gtVYGyMobl7yrL1sNCL4E4TJVUhFkvB1+90ctgL8vAle+sEv5d0bLlk3Fj7MkcmYsA/F4he7rI49PqGlYRrncYX5eGT50PFFrt7fR6AvALgGTccd981nFwkz1R88efZKKjqYzfAn1TxAyQY+2KNCZMBLHZzpBZAwvNgXmxoHy9u9zf/8108Yoi1T4z3c4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8it02dqCzFXWZcejm1XmqsTcPv0CWh5J2ig2vni6JM=;
 b=y8sAsFJOvK4sCXCnTiwPlNfu4+TFeZTm4WjzokdICXT+4PzOWCW/LaKkbDtpGeIEGOIXVpth0KT2zEV3+gEuJHWOn7evbM/P6K2Xtk3ck1rp+dAt+z2EZwISp5CUeDXAJ54pag+sQKIttAPKLdvSN3gsIFCHIvSGxmwcbpc3XolAiw8yV7XyDe3Q/I8QdrHr3WAk2s4z3zK0wJqcMXqbrJqH525ZtMdPnPLDmprtqnJAhNyMCZqLlYTQblDcJXVWXQCclJN9zFkSesi1ap+la4ilgRxBMvSjZtnZKRil+KF0qqL6PXz2/B87LoERqHMl0XoJuNftt2SH/hPLYkemwQ==
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 by PH8PR11MB9605.namprd11.prod.outlook.com (2603:10b6:510:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:36:02 +0000
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5]) by SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:36:01 +0000
From: <Balakrishnan.S@microchip.com>
To: <ehristev@kernel.org>, <mchehab@kernel.org>
CC: <hverkuil@kernel.org>, <sakari.ailus@linux.intel.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
Thread-Topic: [PATCH v3 01/10] media: microchip-isc: fix awb_mutex and lock
 lifecycle
Thread-Index: AQHdGPvEqRytHEFJsEuH+29tEy7Z2bZ390AAgALkIYA=
Date: Thu, 23 Jul 2026 09:36:01 +0000
Message-ID: <4d82eed5-e1a4-45d7-ab41-1a2bb0c2fade@microchip.com>
References:
 <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
 <20260721-balki-isc-prefix-fixes-v1-v3-1-ffe10640a2d9@microchip.com>
 <d98128fe-079c-4145-9e4f-68cbdc9702dd@kernel.org>
In-Reply-To: <d98128fe-079c-4145-9e4f-68cbdc9702dd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4910:EE_|PH8PR11MB9605:EE_
x-ms-office365-filtering-correlation-id: dff98a7b-25f2-4204-2f73-08dee89dcf39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 XpBgOjbh/28v0m8A9mNYZwIdUVOHPijmrR4wdRCsr1Bq51Lc+1bHYssjsTxaWWGdOv1lwR2FMlEyUJOvppn6Biukz1f8it6ol2MlXR8QDVbohKMg28W3+EkS487N4s8mwbVSzq9lbvR65zcDeEYtobmoEZ6u31i8toGJ9vItOfrUwcQeXkbXCqCB1Q9D9msS6fMqJXTdsv4nxAnmGtb//GgnrDyoJMd22YMC8e7HrEKoqAQScTx4yCMaiLbbYcynKfB5TmZq/oZUu8x7IusKJEApEmhQx6Ijsv4AxLFvS0lqHIGJweCMCer8HjaIkz6/DtdUOyYoX1IA9z+4ncGqMajL9WeifkQ0Wx5TiuHASHcw3Y17yfm+J1ffhEGcb0u4gqETftgURRvjKzZfKlg3P9cTaqrZhliGvm5Mz8mHhy+tDTN/UduukYKA1H2ReSiwjV0UANEwMaXwyIiI/4oOXVCeL5Ri2RBkinncg7WTS7Qft/umw+kNkHZEafSRmOovl9A/To0DyBA22SX3WiPKxQXbZLrLZDzSn12jZDJEalh+niYs/QOm+XZ4dk8lTBZQRmxen1TRDs7+ROMXVqlZ9qUsA8fSv9lFN/tRfFGWi2i/ZsBm8G0PDvh8/a3Vt0KntH7BP+eUloqyDcriF6MjQwxtGAdzzR4zD86YHrklouejvOdHP4hLGHFFSy3liT2b/hK6t9EB3ecEfS7FHaPB/JZ2/YuJq0wHkZ8pDjkoZmA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4910.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azJXVjVTVXdadWFjd0w4bW1kWFk0TzVXUVhuZjhVd2JydUxRZ0kzdFhFdTFn?=
 =?utf-8?B?V2xkM1BHNmZFbDVqV0c0NHlzL3I4Zjl2a09xMFVCd1hhTW9UVTRuREMzZGtk?=
 =?utf-8?B?WW5hWWZ2WUNjbmY2aGpET1BpbUVhbDJkcGQvK2RXbUtIWVY5dnVGN28zanRj?=
 =?utf-8?B?NS9yT1Zrc3ZPK2RhTXA1WGlDdWIwS1dhS2FHb1IzQUFJNTZnbWtFRW9rTmJI?=
 =?utf-8?B?Q3dwU215WW1BWTJvNVI2N0ZhVER1YUltZCtkV29qNzhHK2xhajNKVlRmYlFa?=
 =?utf-8?B?anJkVUhTZXVLMmtkc2RVVm0vVXpZRzJkR05JYXhKcWpqSzRDOVcxTzBCYktC?=
 =?utf-8?B?ZUozYUc5RDJNdTNTUDcyRVBxZHRBZzNXcTRvempPTExZT3VXTDA0dnp2d2Zx?=
 =?utf-8?B?Y2hCekZjMWQrS3kyMGw2TEw1dm9WaFJ3WlR2M0ZEL29Ba1hxdjJmc1VOUFc5?=
 =?utf-8?B?bTQwVjRueENpdGZCWFIyNFUrL1ROSiswc01BOXBlUEFjdTM3bFc5b2xpdjB4?=
 =?utf-8?B?N2tWVkloWGFJZVZIUUpJMlRpUE9jN2JPRDV0YUQ3aHBmOEVmTlhjRE5nbm1Q?=
 =?utf-8?B?aTdTU0REYThXRHh3NlVaUkNVa3B2RXpDbHpoL2ZTRTNQeWZuakJMZHp4ejl6?=
 =?utf-8?B?UmlqQUdGd3NCYzFaOVB0WTV0c3Fta3FwNjliZXdDTjFsd1Q3UC93bWN1THFM?=
 =?utf-8?B?QkhwV25adWZValJuc281T0h2OTNac0ZTbVdINWJpMjIwMUl1RGVacStGOC9y?=
 =?utf-8?B?c0hxdThmODVBeWR1d2Q1ejFhZFA1SHBmNG1DeFd5UnZSbDB5TERkWEcwd3ZG?=
 =?utf-8?B?M0ovQ01iS01CUDBKcHV2akt3ZldGYWZNWHBROWNOWkZwT2M3QW9WZVlYZGtH?=
 =?utf-8?B?NDhwR3Y1KzUyQmplRmEwa29ENjRPdjJJN1d0OHpnT01oaTdrdi9NanZIY2xW?=
 =?utf-8?B?RWUxL1dYZCtHb25SNzJDaXZJNW5jSm5SaXovNXltUFpkYm85MnBrbGR2QzVC?=
 =?utf-8?B?NnZnMFR4cHBkbENsWGxaYWR6TTczZUtGaWVBOCtzcGpid0ZFMHNUYnVFcjFL?=
 =?utf-8?B?M3dWWnR2KzE4YUg0YVJ5Qzlpdm1MQTM1ME5IaGdkL25xa2pndlNQb2pWMXpJ?=
 =?utf-8?B?TzVYYXRubnVqR1dpOGJZZmJJR0ZMK0o2UGp2RjhiNXdJd281NExQUldNVmkz?=
 =?utf-8?B?UlhqNFVKbUY0L2o5UENuc2RLWnRSV0NJZDB3bmMrazRhbjhFT2pJMUNvOS9j?=
 =?utf-8?B?Zk9JZzJIZHcxK2grVUxEU0V0NHcvaktLUVlyaTJnR1NrOEdVTmk2M1pYU2du?=
 =?utf-8?B?TWtlckx6ZXBJczVPWkhMbkVZVWt4YkhWVTBiQUp5ajRFczhxMm0zbkJIc3l2?=
 =?utf-8?B?cTBUZ2s0cGwwUUJaejVTMVM5TkZ3dkk0RXVOYWlmbm5xTXhXcmxrblc3eW5N?=
 =?utf-8?B?eUdYY2dqQWdwQ21tUExpdlQvbmNRUG85bzRYTmw5Q0k2WWdZbDl5Q2Rxalpt?=
 =?utf-8?B?MkU1R0VwWERSYk1GVDJCTUhzZjFrMzdLVGdoK3Bxb3JWQ1BUcFpQdUlzMlJO?=
 =?utf-8?B?OGs3K25xcThSWjhBdlpNTTRWc2hSZmxlWnhuL05uUUxTbUxsTHRFUFd5UG8w?=
 =?utf-8?B?aHJxTVhQMEdoSWdTU2pFOHdBRUcxYlozR2tVOEFEMVJJV2QxMmtYMGVtby9D?=
 =?utf-8?B?L29IcURLdzlzVHpQc3VjbzRyc1hyM25EMy9VN1ZEK1Nic2FuYjBNSVB3cjRk?=
 =?utf-8?B?cUpZUUxHakpWdUc0M2hRSjVaMG1pM0dESVU1TmRqZWlPMUcyb2JkTFNQdkpz?=
 =?utf-8?B?NmlXdFN2R0hCMGF6akJtdWczbEtwRDJQZUNqWjZxOEpsanUxM2xrS1gzMHM5?=
 =?utf-8?B?T0hVNm1CbzlILzBaSjFLMmdxVW5iTVl3N3IyRjdKb2RVMlUyUEZoc2xMMmxW?=
 =?utf-8?B?SHdhSUcyK3ZBWGVTb3FON04vQWcvaDVBNmRXWDVhNzlkZUJsZ1p6QlhSRVBW?=
 =?utf-8?B?K2VYQ2VzVW84N0lYZ1krM2pKUWhPQVV0bUFHbDNMQUg1UU55WWhPWFJUU3pK?=
 =?utf-8?B?cW5aQ1p4TnN6c1dPaHR4U3kwTWdGMjJsd2hwd1ZySURqL01oLzlYVEVHR2t1?=
 =?utf-8?B?N0hKVmZJc1duVkpjUERGRmJvc3p6NGVpNVB5bUhTSGdRNzlLVkdyZy9yZVFr?=
 =?utf-8?B?RnBjTnY5NG82bnBna2o5OWFyVmVxSGN2TjVTbEExblVObmlySjMxWElVemVP?=
 =?utf-8?B?cjZYdFpHVXQveE1JdmZQVWZacS9HUUh2VHBMQjdjL2RVZ3NoY1NTNDloRE9w?=
 =?utf-8?B?T095bHJ6MjFvUHVZMmR5SDNIaW9yV0ZQenZUL3N3eXM3MGhYR0hHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF1A2CEEECD7C4693EA41CF22FA529C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4910.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff98a7b-25f2-4204-2f73-08dee89dcf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:36:01.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axgRuJ9xR6dC2foI+Sv/NUXmLOaxm5/vd9Nl4g73ObU0W8+Kp1dXwM/dgHr9bUL3iuhRHHQ45kMd+KiKYpGSkgc2ZHy/bbG6X0lFqI9EQNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9605

SGkgRXVnZW4sDQoNCk9uIDIxLzA3LzI2IDY6NTcgcG0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gNy8yMS8yNiAxMzoy
OCwgQmFsYWtyaXNobmFuIFNhbWJhdGggd3JvdGU6DQo+PiBpc2NfYXN5bmNfY29tcGxldGUoKSBp
bml0aWFsaXNlZCBhd2JfbXV0ZXggYW5kIGlzYy0+bG9jayBvbmx5IGFmdGVyIGFuDQo+PiBlYXJs
eSBlcnJvciByZXR1cm4sIGFuZCB0aGUgdGVhcmRvd24gd2FzIGluY29uc2lzdGVudDoNCj4+DQo+
PiAgIC0gaXNjX2FzeW5jX3VuYmluZCgpIGRlc3Ryb3llZCBhd2JfbXV0ZXggYmVmb3JlIGNhbmNl
bGxpbmcgYXdiX3dvcmssDQo+PiAgICAgd2hpY2ggdGFrZXMgaXQ7DQo+PiAgIC0gYSBmYWlsZWQg
LmNvbXBsZXRlKCkgZGVzdHJveWVkIGJvdGggbG9ja3MsIHRoZW4gdGhlIHY0bDItYXN5bmMgY29y
ZQ0KPj4gICAgIHVuYmluZHMgdGhlIHN1YmRldiBhbmQgaXNjX2FzeW5jX3VuYmluZCgpIGRlc3Ry
b3llZCBhd2JfbXV0ZXggYWdhaW47DQo+PiAgIC0gaXNjLT5sb2NrIHdhcyBkZXN0cm95ZWQgb25s
eSBvbiB0aGUgLmNvbXBsZXRlKCkgZXJyb3IgcGF0aCwgc28gdGhlDQo+PiAgICAgbm9ybWFsIHVu
YmluZCBwYXRoIGxlYWtlZCBpdC4NCj4+DQo+PiBJbml0aWFsaXNlIGJvdGggbG9ja3MgYmVmb3Jl
IHRoZSBmaXJzdCBlcnJvciByZXR1cm4sIG1ha2UgdW5iaW5kIHRoZQ0KPj4gc2luZ2xlIHRlYXJk
b3duIHNpdGUgKGNhbmNlbCB0aGUgd29yaywgdGhlbiBkZXN0cm95IGJvdGggbG9ja3MpIGFuZA0K
Pj4gZHJvcCB0aGUgZGVzdHJveXMgZnJvbSB0aGUgLmNvbXBsZXRlKCkgZXJyb3IgcGF0aC4NCj4+
DQo+PiBGaXhlczogMzE0Yzk2ZTUyMDNkICgibWVkaWE6IGF0bWVsOiBhdG1lbC1pc2MtYmFzZTog
dXNlIG11dGV4IHRvIGxvY2sgYXdiIHdvcmtxIGZyb20gc3RyZWFtaW5nIikNCj4+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWxha3Jpc2huYW4gU2FtYmF0
aCA8YmFsYWtyaXNobmFuLnNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNyb2NoaXAtaXNjLWJhc2UuYyB8IDkgKysrKy0tLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwL21pY3Jv
Y2hpcC1pc2MtYmFzZS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9j
aGlwLWlzYy1iYXNlLmMNCj4+IGluZGV4IGE3Y2RjNzQzZmRhNy4uNDVhN2FmNzc5MzIzIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlz
Yy1iYXNlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwL21pY3Jv
Y2hpcC1pc2MtYmFzZS5jDQo+PiBAQCAtMTcwMywxMCArMTcwMywxMSBAQCBzdGF0aWMgdm9pZCBp
c2NfYXN5bmNfdW5iaW5kKHN0cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVyICpub3RpZmllciwNCj4+
ICAgew0KPj4gICAgICAgIHN0cnVjdCBpc2NfZGV2aWNlICppc2MgPSBjb250YWluZXJfb2Yobm90
aWZpZXItPnY0bDJfZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGlzY19kZXZpY2UsIHY0bDJfZGV2KTsNCj4+IC0gICAgIG11dGV4X2Rl
c3Ryb3koJmlzYy0+YXdiX211dGV4KTsNCj4+ICAgICAgICBjYW5jZWxfd29ya19zeW5jKCZpc2Mt
PmF3Yl93b3JrKTsNCj4+ICsgICAgIG11dGV4X2Rlc3Ryb3koJmlzYy0+YXdiX211dGV4KTsNCj4+
ICAgICAgICB2aWRlb191bnJlZ2lzdGVyX2RldmljZSgmaXNjLT52aWRlb19kZXYpOw0KPj4gICAg
ICAgIHY0bDJfY3RybF9oYW5kbGVyX2ZyZWUoJmlzYy0+Y3RybHMuaGFuZGxlcik7DQo+PiArICAg
ICBtdXRleF9kZXN0cm95KCZpc2MtPmxvY2spOw0KPj4gICB9DQo+Pg0KPj4gICBzdHJ1Y3QgaXNj
X2Zvcm1hdCAqaXNjX2ZpbmRfZm9ybWF0X2J5X2NvZGUoc3RydWN0IGlzY19kZXZpY2UgKmlzYywN
Cj4+IEBAIC0xNzU4LDYgKzE3NTksOCBAQCBzdGF0aWMgaW50IGlzY19hc3luY19jb21wbGV0ZShz
dHJ1Y3QgdjRsMl9hc3luY19ub3RpZmllciAqbm90aWZpZXIpDQo+PiAgICAgICAgaW50IHJldCA9
IDA7DQo+Pg0KPj4gICAgICAgIElOSVRfV09SSygmaXNjLT5hd2Jfd29yaywgaXNjX2F3Yl93b3Jr
KTsNCj4+ICsgICAgIG11dGV4X2luaXQoJmlzYy0+bG9jayk7DQo+PiArICAgICBtdXRleF9pbml0
KCZpc2MtPmF3Yl9tdXRleCk7DQo+IA0KPiBEb2VzIGl0IG1ha2Ugc2Vuc2UgdG8gcmVpbml0IHRo
ZXNlIG11dGV4ZXMgYWdhaW4gZXZlcnkgdGltZSBjb21wbGV0ZSgpDQo+IGlzIGNhbGxlZCAsIGFu
ZCBub3QgZ2V0IGRlc3Ryb3llZCBoZXJlIGluIGNhc2Ugb2YgYW4gZXJyID8NCj4gDQo+IFRoZSB3
YXkgSSB1bmRlcnN0YW5kIGl0LCBpcyBpc2NfYXN5bmNfY29tcGxldGUoKSB3aWxsIGluaXQgdGhl
bSwgdGhlbg0KPiBzb21lIG90aGVyIGZ1bmN0aW9uIHdvdWxkIGRlc3Ryb3kgdGhlbSwgYnV0IHRo
YXQgZGVzdHJveSBpcyBjYWxsZWQgaW4NCj4gZXZlcnkgc2luZ2xlIGNhc2UgPw0KPiBJdCBpcyBv
ZGQgdGhhdCBhIGZhaWxpbmcgZnVuY3Rpb24gaW4gdGhpcyBjYXNlIHdvdWxkIGxlYXZlIG11dGV4
ZXMNCj4gaW5pdGlhbGl6ZWQgYW5kIG5vdCBkZXN0cm95ZWQsIHdoZW4gdGhlIGZ1bmN0aW9uIGl0
c2VsZiB3b3VsZCBpbml0aWFsaXplDQo+IHRoZW0uIEl0IHdvdWxkIG5vdCBsZWF2ZSB0aGUgZGV2
aWNlIGluIHRoZSBzYW1lIHN0YXRlICwgYWZ0ZXIgZmFpbGluZyAuDQo+IFdoaWNoIGlzIHF1aXRl
IG9kZC4NCj4gSSBhbSB0aGlua2luZyB3aGV0aGVyIGl0J3MgYmV0dGVyIHRvIGFsbG9jYXRlIHRo
ZXNlIG11dGV4ZXMgYXQgcHJvYmUgYW5kDQo+IGhhdmUgdGhlbSBhbGwgdGhlIHRpbWUsIGFuZCB0
ZWFyZG93biBvbiByZW1vdmUoKS4gSXMgdGhhdCBtYWtpbmcgbW9yZQ0KPiBzZW5zZSA/DQoNCkZh
aXIgcG9pbnQuIEkgaGFkIHB1dCB0aGUgaW5pdCBpbiBpc2NfYXN5bmNfY29tcGxldGUoKSBqdXN0
IGJlY2F1c2UgdGhlDQpyZXN0IG9mIHRoZSBzZXR1cCBpcyB0aGVyZSwgd2Fzbid0IHJlYWxseSB0
aGlua2luZyBvZiB0aGUgZmFpbCBwYXRoLiANClRoYW5rcyBmb3IgdGhlIHZhbHVhYmxlIHBvaW50
ZXIsIEV1Z2VuLiBXaWxsIGFkZHJlc3MgdGhpcyBpbiBuZXh0IHZlcnNpb24uDQoNCj4+DQo+PiAg
ICAgICAgcmV0ID0gdjRsMl9kZXZpY2VfcmVnaXN0ZXJfc3ViZGV2X25vZGVzKCZpc2MtPnY0bDJf
ZGV2KTsNCj4+ICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gQEAgLTE3NjcsOCArMTc3MCw2IEBA
IHN0YXRpYyBpbnQgaXNjX2FzeW5jX2NvbXBsZXRlKHN0cnVjdCB2NGwyX2FzeW5jX25vdGlmaWVy
ICpub3RpZmllcikNCj4+DQo+PiAgICAgICAgaXNjLT5jdXJyZW50X3N1YmRldiA9IGNvbnRhaW5l
cl9vZihub3RpZmllciwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBpc2Nfc3ViZGV2X2VudGl0eSwgbm90aWZpZXIpOw0KPj4gLSAgICAgbXV0ZXhf
aW5pdCgmaXNjLT5sb2NrKTsNCj4+IC0gICAgIG11dGV4X2luaXQoJmlzYy0+YXdiX211dGV4KTsN
Cj4+DQo+PiAgICAgICAgaW5pdF9jb21wbGV0aW9uKCZpc2MtPmNvbXApOw0KPj4NCj4+IEBAIC0x
ODQxLDggKzE4NDIsNiBAQCBzdGF0aWMgaW50IGlzY19hc3luY19jb21wbGV0ZShzdHJ1Y3QgdjRs
Ml9hc3luY19ub3RpZmllciAqbm90aWZpZXIpDQo+PiAgICAgICAgdmlkZW9fdW5yZWdpc3Rlcl9k
ZXZpY2UodmRldik7DQo+Pg0KPj4gICBpc2NfYXN5bmNfY29tcGxldGVfZXJyOg0KPj4gLSAgICAg
bXV0ZXhfZGVzdHJveSgmaXNjLT5hd2JfbXV0ZXgpOw0KPj4gLSAgICAgbXV0ZXhfZGVzdHJveSgm
aXNjLT5sb2NrKTsNCj4+ICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gSWYgbm93IGlzY19hc3lu
Y19jb21wbGV0ZV9lcnIganVzdCByZXR1cm5zIHJldCwgZG9lcyBpdCBzdGlsbCBtYWtlIHNlbnNl
DQo+IHRvIGhhdmUgdGhpcyBsYWJlbCA/IE9yIGp1c3QgcmV0dXJuIHJldCBpbnN0ZWFkIG9mIGdv
dG8gWy4uLl0gPw0KDQpBaCwgaW5kZWVkIHRoYXQncyBhIG5vLW9wIHNvbWVob3cgSSBtaXNzZWQg
aXQuIEknbGwgZHJvcCBpdCB0b28uDQoNClRoYW5rcywNCkJhbGFrcmlzaG5hbiBTDQo+IA0KPj4g
ICB9DQo+Pg0KPj4NCj4gDQoNCg==
