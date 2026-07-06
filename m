Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023107.outbound.protection.outlook.com [40.107.44.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3D41F7C8;
	Mon,  6 Jul 2026 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338185; cv=fail; b=M6WHrnxPSouSx04NzIjbUPcmUd0/sCRM1duacwLwFXVfcuxzx6XJCb6pdAUxH0UELxDDtSzbWsZuZfFDcZGSnZ0MTF9WLvxs+vOJjghGjJt1PK2XW+FdlHhinrPoKzzLBYXwLpL9dmqk0l24mfm5vS6BSFt5CVKAB0EmLPG7+HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338185; c=relaxed/simple;
	bh=DV1vNh33cEAtDXHyf/WjiIiDa7ZKokYW4/7KJPv/j2g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JKexBNeP83C8DdJMybqxMBf7qLE5Y0CTzPlnG/3nV+7bnWIAUdZG+JhwDQWw35q0zu0KI+yNVP3E0+WNclMCZEsyiMqHy3sAbH6HDETztgCTsMtSP/Mwi6bvymwwXOFhGi9nCVuXYpJfHV1bWJiPWTEK1vPVa4US5HJNzfIVRJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=GwsjTRVR; arc=fail smtp.client-ip=40.107.44.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="GwsjTRVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsqrmU907bCUskbN3WqDOSPM94IeA+1G657UO63Z6k7T8DoQUyn/WJe/OPWiQM/wRLGQ8z5uJQy1++W+3DtkYFGmZ9sqst6JipXmWHOWOsjpXfbDLdyaDSc6AmaaaHMM/i2OC0vv/Hgsnl/rxL8+OB1R1L1kXKpbB+Yq/P/sJLx32mezfQwZ0HhfZo4K33wPB+G7aHJIRPv4U33aX5ewGvL9zXx9Nb+b9fB8HCG8sTcKMoJLt06DZbx2yAhXQSsjY+sIXVIK/sckiqFqFrZHhBOdoFBj5zOFF2q61Nrczr51AZCYjWjkbsadvLcNUicHitIjVdWiKQDrzr8u2plZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DV1vNh33cEAtDXHyf/WjiIiDa7ZKokYW4/7KJPv/j2g=;
 b=swshvZRmz4EnEplD3bcBc5jpPoxzH6QtSFPElTH4dbIK/vx+ZDiVTaN6XIEo2UCV2+Lu4j6BIr12irf0n0LR8l0WpvHwsdtNFkkJui2iPP4H1jRlJiBm5oN8uWf6V3MK1O6TGzRJFp63Lg3TuRoeavVsnTuAggso6O1PFYOyrCbQLQBwbwBwrbN7Nv+dVHKSh/wkXGcLS+3tk452k4e/DB+R8t/g21GyxEv5hXgo358/ZIIQ0XlxpqV1b97IMWca/bsqTDNPu79p3Kt7iJR9XTvBR+nOi23IwtYpU5/OQOVIt6MGtFGdsadbtUY7ucf1SGUZlsoTz4T0el6wrPNbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV1vNh33cEAtDXHyf/WjiIiDa7ZKokYW4/7KJPv/j2g=;
 b=GwsjTRVRib/q7PfS3hPe3Wb72nSkGoU8412VCDuxvczzY2DjSPrZjcVcwnbr9T8P4ZzFirn3csx9QVB3UcL+c6WTEtiR5R286j/yxJyI0k6wiR+tnAlba+kCXXxpQh+Kzjp1lpMvnDhiJtbd7vhI6K6X8sW5IfssKw8iOguKDqs=
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com (2603:1096:101:2e8::6)
 by TY0PR04MB6543.apcprd04.prod.outlook.com (2603:1096:400:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 11:43:00 +0000
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2]) by SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 11:43:00 +0000
From: Ao Sun <ao.sun@transsion.com>
To: "ulfh@kernel.org" <ulfh@kernel.org>, "avri.altman@sandisk.com"
	<avri.altman@sandisk.com>, "shawn.lin@rock-chips.com"
	<shawn.lin@rock-chips.com>, "beanhuo@micron.com" <beanhuo@micron.com>,
	"jenswi@kernel.org" <jenswi@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongyan Xia
	<hongyan.xia@transsion.com>, Ao Sun <ao.sun@transsion.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jiazi Li
	<jiazi.li@transsion.com>
Subject: [PATCH v2] mmc: block: fix RPMB device unregister ordering
Thread-Topic: [PATCH v2] mmc: block: fix RPMB device unregister ordering
Thread-Index: AQHdDTyYu/dO7T4xakaScwmMHOorCA==
Date: Mon, 6 Jul 2026 11:43:00 +0000
Message-ID: <20260706114218.907-1-ao.sun@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR04MB8921:EE_|TY0PR04MB6543:EE_
x-ms-office365-filtering-correlation-id: 8e61e600-ac62-4e91-b7a9-08dedb53bb3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|42112799006|1800799024|366016|23010399003|376014|18002099003|38070700021|6133799003|11063799006|56012099006|5023799004;
x-microsoft-antispam-message-info:
 56xJJzQZAebXcCFX224col6FhqLGgMdEodm8+dj3ig3laOWrVmgO+vfbWhi6NET26pkV8cWHoCJnbBUJVxoWBqX5Q/La2V94jv2ZvVvThEEa9eqXTqOaddzvjzhaEFUDmzRMIzjoN98UDv3MrF6OQ4ZpLHAC0O3rhzWnUbpQIrYaBdbM9wh1GbIXr7g4V/DIex6LAhNGSZFaJOkIyGFbiuSVnb4+CvisZsXOnSgqLbWY9C5yldFe/vj7Uwus8ZS6K4l0akIaQLrBH4Wd3KetRSi+aruyD6BLcaSYwUeOHtaNfqlqedY/rWZipp3iUsrpshtNz0EYdcByt2I3qlFWcALgQT9XVQWzLcr5z6qZ63ga9vvJrB1HQkZuGYyv6m+vEKNOSHK4PyH/QqrhBRr4oqXiqxSj4h35zpis/0fcqFdfkqJXGj4IJSksTaRpkAw3J5e8w7vmLdWooldCoWKkYhezLK6aS820VOIk/ExhHcJ6qspJ43QWPZNfRVPRWUrNVxw+aIreT54JlZ6uRjXyXcUkKzfZHYE6jbXPTmu6oZtzOasROOMfW1Q8sxPsjf8mwz5jvkTxtMRECDbK9d5w2phkh7AqRLKw/6BXLvjKiFtDJ7ESvF0/hVq0AGx5h1EE+CXsVwFWIfkeI4pxbVN6ZMLXMrG7rlgP1/hVMlg7DE9HJcRkneOLkhKSw2rHHYn0WPzElhj+qJkgzdEW4miHlnhym8R9+2Vb1f0TATUAQHM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR04MB8921.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1l2cy9TKzlTYWhHS1lMY01yRWw1TTB2UjhlZW1kL2lQaUg5OUxwVjRBUHYr?=
 =?utf-8?B?NUVJdVNQcE1nWC8vWUN5aFRsWjVOOERoc0pEL09GOTlxM05zb2VXa0hRTVhO?=
 =?utf-8?B?V3JXQ0s2Q1N4L2hGRXFKRm5GZzBCOU83US9XRE0zN1E3eG5VWk9JM203YXFY?=
 =?utf-8?B?MktvUlBGOERaTk9Vd0ZmNEtlUldYVHNYTTA5Yk82OS8rYksxRnU2akxPSng3?=
 =?utf-8?B?Q0ZvU1c1Vzh5L3BOMG90YVFCeXlsV0JEZVg2VmlmTHJ1Y2t3N1g2eHhSdlE4?=
 =?utf-8?B?YmZuS1UrRTdkd2xiTVc0QTh5aVBsdkFhbkxBa3VFeXN2emRpNjY2ZzNvcjZK?=
 =?utf-8?B?MTVBSm5VQXhFVUlMRnRDbU9CWDdLRmp4dmtmRVdxYWVzZUpaU3piS1V4VkRI?=
 =?utf-8?B?ZDBGYndiNW1yVEUxVnpqVXpNaUxiUUxCdFRQbnNzbHRkZVZpa2ZmbnlwQjN6?=
 =?utf-8?B?Vk5lcE9Pd3dRSFV2ei9QY1prd1JHN3ErNXBCR2pFVEpTVVJ5d0gyS1d4czcr?=
 =?utf-8?B?dDlxcUVVRmM2WkRkNEkvdk4wb09VZFo3MEJINFZoVG1xZ0xLamR5eE5RMWYx?=
 =?utf-8?B?TWkrSWk0QitRL1Q5MStxVGMzbS9EdHlrKzE1dC9TTldpbTBhaVRSMVBrb1Q5?=
 =?utf-8?B?SEkvWkNOY2c1a3ZVL3ZvVWhoamRuVjdESGJ2NUVwQmMwUnZ1Y1BiaEFDa1kz?=
 =?utf-8?B?RFB0eW0ya0Vja3ArNDlYdzB2RmhPZE1qRGt2Zi9JSDlCakdNNXNIWGYrQ1hG?=
 =?utf-8?B?NXE0K3VXSHcxYm52SmV5eElMVDAxOXRwbjV4WStSSlpWTm9UaGw1TXZyeERj?=
 =?utf-8?B?a0swSGpwdkErUHh0Rjh0N0swU3huVHJXVzBtOVpvNmFmTE0yVGhUejRrWHIr?=
 =?utf-8?B?RjZXcXBoOElLL2s1RDRPa1NWMmtnVTZOTWVOOEt2aDcyUUVrTnQ0azY1V1lJ?=
 =?utf-8?B?ZStqcW8zMkRPby92OVU0R1RaYVJJY2RkQnJyYWR0QmhjS2VPeGpYU3BZaE42?=
 =?utf-8?B?azMwR0NDMUl3QU5zdy8vOHpNbjdQR2hNRGRMRE9BQUY2VytCWW1rVEVzaVlI?=
 =?utf-8?B?RVdTVi9qTVVnMVBDODhVZ2RSYkVHUzIwVlVYOVE4QnlxaWxhYmRPeUNHdEtq?=
 =?utf-8?B?OWo3c2JFZGtIZDVUbmt4UTZlRkFocVVvV0JBUVlpTVY0SU1mWTRTcFZmRW9H?=
 =?utf-8?B?MUhGWUpyRGZiWlhKQkNlTnZaRnJHcDg1OThiVXZVUTFGV3Y4M1AwdzViV2Zx?=
 =?utf-8?B?SVY2K0h3dXArVXdkaXlpdmx2VWFlSXkzU2o2cmNvVTUyNGFVUzZlRTZjbzFE?=
 =?utf-8?B?cGc3MXdhUFhTck5oZjFFdi9kamFvbkhvZ29sRWZwVkRxQ2NYaUlZQi9UMFhp?=
 =?utf-8?B?QVlZUm1tSXR2cE5OUXdLZXBhYjNncDYySDhIMXhEOVBHeUdYaXhHdlpKMHVS?=
 =?utf-8?B?ZU1pV1BUN3BHM1h0QlZSTmdNL0ZFYlh0OS9YSTBsdXZUZXBVcHJNS0lXNFVt?=
 =?utf-8?B?M1FyWEdrUG03azFueVh5Rldza1RkenMvSTN5MWdMRlZvejE1emZlNUQ1UVBm?=
 =?utf-8?B?L0wrZ2RvZXRaU1Y1dlFlUy9rWHFjVmF2Zm4ybEhQYXZpVFRWaVlTcTZiR01v?=
 =?utf-8?B?QnF3Q1dnTWlLVWZFNzU1RlpMVFpQN0dtRlZNdUI5dUdTWGMrVnc0eXVMMzc5?=
 =?utf-8?B?NWIyaUtNQ3ZMMGQ4WFcxNHo1b2tTeGVsa1FNTjlNZzY0TkkrSGhPejFpR2xz?=
 =?utf-8?B?MUxUWnNiRW5ubVRTb2FXSnVRWXdhVklma01DVCs4RThPRHU5TTcrUHNhZUpy?=
 =?utf-8?B?OFo2YWpBTURQNU8wUjlSQ2dqZEtHejc3aGhNNkZySXdvVkdXd2cyK2VPUHh4?=
 =?utf-8?B?N1hHRzJxN1ZHMnJkeE5sWDY3dm1mUnRsUFRqaGxuK1NJMlBiNlhZSWcrcTkw?=
 =?utf-8?B?WlVkNGdUV2FaTGdWcjBrZm1zRzZCUDlPa1FoYS9QQ2IyeVZOM3ArSWxURXdY?=
 =?utf-8?B?STF0bTBkdVpxenVPSDRET1pMTm1vUzF4QlRYa3d0Nmc0L2g1UlJFdVhnWVND?=
 =?utf-8?B?Z1R2UnFHQUtBYk9uOUVWNENKK0M3NDkzTWw4SUtwMWhzZStJVnZlRml5YXpN?=
 =?utf-8?B?dzZpMVE4QUNXVjBESkFhZWlrY0w4TFY5aHZGQzVpNmhFdDgwWitoaFF0VFI1?=
 =?utf-8?B?QmllZFdqbUkyN3d1dDhLeFE4YzRtNE9FMnl2M3J3Znd4TE9keExzWXJ3MWJQ?=
 =?utf-8?B?SGhONldSK1RsVU1yanREN0IxMW14RFMrSW5SWWRuaHdxUHcwVlV2WUtseTVS?=
 =?utf-8?B?aTVLYStOUm9kQVpaeUhhcmYrZHVSYVFxL2JNNWlBZWhYdHNzMDRaQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8921.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e61e600-ac62-4e91-b7a9-08dedb53bb3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 11:43:00.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBXGIaacnUgIgPGrkKo+vH6WNGaYyN3pIk+O2OPLWrKZmupvbTwRSfvnu5CXTUo/h4Y5qQfZBe6ga0NxmZ/ldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6543

RnJvbTogQW8gU3VuIDxhby5zdW5AdHJhbnNzaW9uLmNvbT4KClNpbmNlIGNvbW1pdCA3ODUyMDI4
YTM1ZjAgKCJtbWM6IGJsb2NrOiByZWdpc3RlciBSUE1CIHBhcnRpdGlvbiB3aXRoCnRoZSBSUE1C
IHN1YnN5c3RlbSIpLCBlYWNoIG1tYyBSUE1CIHBhcnRpdGlvbiBpcyByZXByZXNlbnRlZCBieSB0
d28KZGV2aWNlIG9iamVjdHM6CiAtIHRoZSBtbWMtb3duZWQgZGV2aWNlIChgcnBtYi0+ZGV2YCwg
YmFja2luZyB0aGUgbGVnYWN5IC9kZXYvbW1jYmxrWHJwbWIKICAgY2hhciBkZXZpY2UpIGFuZAog
LSB0aGUgcnBtYi1jb3JlIGRldmljZSAoYHJkZXZgLCBiYWNraW5nIC9kZXYvcnBtYk4pLgoKVGhl
IGNoaWxkIFJQTUIgZGV2aWNlIGhvbGRzIGEgcmVmZXJlbmNlIHRvIGl0cyBwYXJlbnQsIHNvIHRo
ZSAKcGFyZW50J3MgcmVsZWFzZSBjYWxsYmFjayBjYW5ub3QgYmUgaW52b2tlZCBpZiB0aGUgY2hp
bGQgZGV2aWNlIAppcyBzdGlsbCByZWdpc3RlcmVkLgoKUmVtb3ZlIHJwbWJfZGV2X3VucmVnaXN0
ZXIoKSBmcm9tIHRoZSBwYXJlbnQgcmVsZWFzZSBoYW5kbGVyIGFuZCAKdW5yZWdpc3RlciB0aGUg
Y2hpbGQgUlBNQiBkZXZpY2UgaW4gdGhlIHJlbW92ZSBwYXRoIGJlZm9yZSB0ZWFyaW5nIApkb3du
IHRoZSBwYXJlbnQgZGV2aWNlLgoKQWxzbyBkZWxldGUgdGhlIGV4dHJhIGJsYW5rIGxpbmUgYmV0
d2VlbiBtbWNfYmxrX3JlbW92ZV9ycG1iX3BhcnQoKSAKYW5kIHsuCgpGaXhlczogNzg1MjAyOGEz
NWYwICgibW1jOiBibG9jazogcmVnaXN0ZXIgUlBNQiBwYXJ0aXRpb24gd2l0aCB0aGUgUlBNQiBz
dWJzeXN0ZW0iKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBKaWF6
aSBMaSA8amlhemkubGlAdHJhbnNzaW9uLmNvbT4KU2lnbmVkLW9mZi1ieTogQW8gU3VuIDxhby5z
dW5AdHJhbnNzaW9uLmNvbT4KUmV2aWV3ZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkBz
YW5kaXNrLmNvbT4KLS0tCkNoYW5nZXMgaW4gdjI6CiAgLSBhZGQgYmFja2dyb3VuZCBkZXNjcmli
aW5nIHRoZSB0d28gUlBNQiBkZXZpY2Ugb2JqZWN0cwogIC0gYWRkIEZpeGVzIGFuZCBDYwogIC0g
Y29sbGVjdCBSZXZpZXdlZC1ieQotLS0KIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8IDMgKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
CmluZGV4IDAyNzRlOGQwNzY2MC4uNTRhOTIzYmE0ZjFlIDEwMDY0NAotLS0gYS9kcml2ZXJzL21t
Yy9jb3JlL2Jsb2NrLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jCkBAIC0yNzE1LDcg
KzI3MTUsNiBAQCBzdGF0aWMgdm9pZCBtbWNfYmxrX3JwbWJfZGV2aWNlX3JlbGVhc2Uoc3RydWN0
IGRldmljZSAqZGV2KQogewogCXN0cnVjdCBtbWNfcnBtYl9kYXRhICpycG1iID0gZGV2X2dldF9k
cnZkYXRhKGRldik7CiAKLQlycG1iX2Rldl91bnJlZ2lzdGVyKHJwbWItPnJkZXYpOwogCW1tY19i
bGtfcHV0KHJwbWItPm1kKTsKIAlpZGFfZnJlZSgmbW1jX3JwbWJfaWRhLCBycG1iLT5pZCk7CiAJ
a2ZyZWUocnBtYik7CkBAIC0yOTMwLDggKzI5MjksOCBAQCBzdGF0aWMgaW50IG1tY19ibGtfYWxs
b2NfcnBtYl9wYXJ0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwKIH0KIAogc3RhdGljIHZvaWQgbW1j
X2Jsa19yZW1vdmVfcnBtYl9wYXJ0KHN0cnVjdCBtbWNfcnBtYl9kYXRhICpycG1iKQotCiB7CisJ
cnBtYl9kZXZfdW5yZWdpc3RlcihycG1iLT5yZGV2KTsKIAljZGV2X2RldmljZV9kZWwoJnJwbWIt
PmNocmRldiwgJnJwbWItPmRldik7CiAJcHV0X2RldmljZSgmcnBtYi0+ZGV2KTsKIH0KLS0gCjIu
MzQuMQoK
