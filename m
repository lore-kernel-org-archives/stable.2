Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793711465;
	b=tUgUFgIKBFXVa1OwZQvi/ak/B8MMGWCOXh1Xzk2bYSicw8/B0ZgWraPHDhY+a+L+jn7L
	 dEaTjNT7myu6OnKoQSYv7HBuBg3QYaJAG27LgK4hOQr2U+8DM5loq7f4Hfp8mR5otzXc9
	 BBS//fECNnkyUu1BSy1vVjGTxtq0Pj9ogEoRhp/S6vRMHAhUIN5XpNYHPxHsf14npca9V
	 zRtmgVeDPp4MwSZx6lpxiueOZlTH+zfL+r5jQYhQ7LNVNKZzeeCPcCcN2Om4Cf60C2wUc
	 t/AL870+DdKU0o4RQBoN39KowuTcfmF09Vlu9yPczLvq5CXCjo8SmX/SZ+v24ghZsow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711465;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vj873CO+AIEMKXqhCpa0Cv2p+ju52ehEXtlFOw/6VcI=;
	b=24X9gzltw0s+lbcacTfsJ7AP24PGJlTelmeUz1s0mqjYbxN9YWIJVdY5cl32ka5uoXlq
	 xKWYISnKQAJelluD6OyExzoix6iVtjp7mNpw07f1DJeWE2/26UuZM5eOstoL2ho1h3t8Z
	 ySTZ5Pf68F8bbTzOn1loztWRQ2E0BjZ/6j81ja83kH37iO4sZGLHvax71dg2W5g7K/3gm
	 pd6WtdP4RS4h2iLGaG4o5GeChonjMJakWcKmt2p1ozUrnq0Ppxnokd7jUgfhDjPDnLUk5
	 kHOnPNH+bXsYgR4aa97bdvECKBcyXAkWS5q95HpLtVyQLad4M3Ve2pAg1Pxe826LRig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b="e/R3lr2Q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.18
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19B606A32D;
	Tue,  3 Nov 2026 13:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F19B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=e/R3lr2Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcD57cKe7mMT0Bg2DzzzavCZ/fYXERRwp3E/gZhfz5WDM9XAIfjAjkGM3cfytp29x7Bur4WEQDCKVjM52rcruNYRHXJL+xnlQDm9sRxJbllEJk41AGK463CVdRiw8J00jL+a7COlrtEEtRV0wICXV65WWEbPYwcAu8vF9F1LzoYuzNlMQCabrTv9DIExbUiKSihmIenavBsIYuUrSPoaDP7YLE4cDmj8ViqJfxPrJVROEU1kGv/yof8uwJLEBUqi3MoQ3pshk8d9PT+JCP7GjSpnLWZ9f8isWc4EP/lOPeIdlReraaNhEAYM7M3vPTRAdxKv88f4CuG4LjacvlY1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj873CO+AIEMKXqhCpa0Cv2p+ju52ehEXtlFOw/6VcI=;
 b=BfpqI6wOJta2BD5K0Z2csRQx5yGiczLWxHebACY8xU3GnhhqSWxvZ3BdzlfVvf+lVt/gh4dooGGY9+XToF3+Mt67L1TOxedEJi7cLUzm3N2aKBWMqc9/QRwk2q6d3iRvRANcLfOACu9Kc/6WHKO6NRc8CkBu5jI1+XZ2jfUw5QRSvU0R1hXMkaSJY6tv1xvB92tL4IayhPpDcJkyC0H3wI4ZTFSlrdUJl70BewT6th/xviluC5OIOxgJuFcxqaq7aVRfDI4MxV1W1mYrOR3On6qIXjRIumN9xNxH8HA5PpM0WlLTCduuAcIac6dOT7B6Sushqz6OuDtKjiSJ5/eabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj873CO+AIEMKXqhCpa0Cv2p+ju52ehEXtlFOw/6VcI=;
 b=e/R3lr2QC4uzcR6EhiJRYdCJ2WyoOKVFnLk40MAqs4yjRsZdbtttSQK9W1qRZsTRzhIKijSIFK015YohbtpgGRyu9WUT5MgmyXZjcEu8MhRAAHWJY6oYbZ8YcWDDR1pzc4q4r4cxQbqyJ+E2GaWNlgHcPBhcrQdIcYNt7ySWAoIHVmt02xRtQQwQcSCfCmbxzriacZSC82gcSsSytlEF7Omt3eM6Wb6ngJVWhAy4/3QTMlZsHmYo5IYe8hJEKPjhnkSMA+KnW59QvfpL0D2FqoLRKirbrXiRFPsGZOBMwfUFYZ0Fv+fxY3OGLE52uBHnrVAk8PsVEy1G/1O3xY8Tcg==
Received: from DS6PR11MB371697.namprd11.prod.outlook.com (2603:10b6:8:4a5::18)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:10:59 +0000
Received: from DS6PR11MB371697.namprd11.prod.outlook.com
 ([fe80::64f5:fb5f:2f92:2f0e]) by DS6PR11MB371697.namprd11.prod.outlook.com
 ([fe80::64f5:fb5f:2f92:2f0e%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 13:10:58 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>, <devnexen@gmail.com>
CC: <joshua.crofts1@gmail.com>, <stable@vger.kernel.org>,
	<nuno.sa@analog.com>, <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
	<andy@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Thread-Topic: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Thread-Index: AQHdZMa5rZTiJ2OA5E6RIaE/HN263bcOzgCAgA2R+YA=
Date: Tue, 3 Nov 2026 13:10:58 +0000
Message-ID: <3ccc9b0ecc2f1bc3eba6b0f4ca4d8f81e5f30a31.camel@microchip.com>
References: <20261025211856.256491-1-devnexen@gmail.com>
	 <20261025215707.4fe42618@jic23-hlaptop>
In-Reply-To: <20261025215707.4fe42618@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB371697:EE_|SA0PR11MB4720:EE_
x-ms-office365-filtering-correlation-id: ebd08297-1772-4cd5-2d07-08df39abe6f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|261102123227099003|56012099006|10067099003|261009223027099003|261022113327099003|261022115727099003|261022105027099003|261021123027099003|261021121427099003|261021130227099003|261021133027099003|261021135927099003|261022075727099003|4143699003|11063799006|38070700021|261026130827099003|261028144727099003|261026135527099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info:
 FZf/hQtsf9T3EIiPKrxN3GJYsK7+tQy9bq8CXGhAM96W6hWveixyMeor/uzIES5hnAAIl4gSMzTYogmG6uBGL6eBIiWxrg69/UhI5p5KlLQQ3gOFQaBQn88+OE23a4fuUCqOCwtOX7enw4ZPliPjK2UnypbG4HpjpdNDAFWgGUKyNJd/+pxz4eeyLciu8euTne8WyhwmKw7amD1dm0E5UTH6QFb/WvU+ugGVQzFSJOqieKxkk4conWMjjv7f5GNTGdLKroZo+QzkfU8SQz+HgCU4hgmMzusGpA3qHHrUcH277orFCoKTKwL2Ev82nmutkyTR5KkooC9FOAz/hF3/n1/eTn6Xi8I/v8fE7pKzqcJD9Enz+6racb/exYMAg7ZO8h8i8uL3TvBp/R+xd/zI/bC3C8mDBrcHRjFwzZd9z1pzirSatpAfPBAUbIWQ7Dt+Tn8qR8sN6H/GwUroQkQRHegecLXqLQS1Ul2C66cDiWd43NjS+rKD2RkYv/mJ/gwAO/lA2oatSQVLUmMfLSLg8vvYz0nWOtroyg8ZUygspu8+XI5kLC+AeQII7dQeQsTXD6dajbT4Ap9iJk+vZ/u9fseWsTOSZHEQh+ZE+RxhRQRP1qqE7O4FAxPhkpH67k2tmmOhTYeZMvKAQobMSqLDqcvlgAww1wxFQlrPnA0w6lM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB371697.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022113327099003)(261022115727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021130227099003)(261021133027099003)(261021135927099003)(261022075727099003)(4143699003)(11063799006)(38070700021)(261026130827099003)(261028144727099003)(261026135527099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhHL1l1NTA3blZVT1dQQnJ6TzNGWXpld2J0Z0tKay8rZkMwUzVJYStvdFJ5?=
 =?utf-8?B?Rk5UYTBONEdMNHY4c1VZYnJvTElQeEJIL1pPUWxabkRNZXVsY08xaUNrUzZl?=
 =?utf-8?B?N3JGTTc3ZnZWaVpJMktuay9MeXhqM3h1c1IvK2lsRHhLdGw5M0t3ek5YVmZD?=
 =?utf-8?B?Y3lxWWhaU2VhR001NFpmcGxJR1V5NHhFeW5WWGRDajJXODdSM3pxOW1PZUhI?=
 =?utf-8?B?MjRZdmVPb1NmY2tjY0Mwcis5TkZQcG10M2hqTjROMFlWVVlPbWJpQzhzbVVj?=
 =?utf-8?B?RDcrMFZ6TFFiRnQrMWhXUDBsUmFPZFk5Snk3MXh2NEticVppUDFJWGdZdTM5?=
 =?utf-8?B?U0ppSTdRNVgxOXJuTkx6dHFQQ2tsSnd4U0h4NHhWRExQY1R2K3M0UmFzblFH?=
 =?utf-8?B?Y2RmTUZ0UlJNbForVm1ZK29YZm0yL2RpSktQcGpRanVnVTFrdmw4Vkc4OHor?=
 =?utf-8?B?aUNuQ25HOElCVFRjd0FZdUViSlZzUFRTSHJuUDcyT09XRUZ4NGNHSitsMklm?=
 =?utf-8?B?SWNqMWhpRVFpKzZ3Q1ovSEQ3VXhna3FBZHgxSXNFb3JSc3V6dGs2bk5peXhl?=
 =?utf-8?B?Um4vUjFIUlQ0a2R4ZEFvTmFkVDRuTTNaczZVdGZHK1U4V3praUNaODE0N2ZJ?=
 =?utf-8?B?azBUdFk3ZFY0VVUvODM0U1BjVit2TEkyaGtBeEJaQSt5NTUvLzZQOXlBUEJF?=
 =?utf-8?B?d0dRaytkRDQ5S0JVaEVZb3VmWjVzRk1HWW9yTm9PWUsxQkpkd1E0VW9KYWJ5?=
 =?utf-8?B?SDFmMGhqRmlNcCtMTWwwdHIwTDZGRGhDZUpueDBGSWRkMCsxcXpGNkM0MUsr?=
 =?utf-8?B?QytxYkN6ODdjSmM0Ny9QaU04Y3BBTTl1WjZoTHdtVW1HZEUycFJYb0R0V1hE?=
 =?utf-8?B?WWtnRjBhYTFHMTlHU2JtQlE0aktkTm1LRkVlT0V2SktVcEFRYWtFemw0V3ZH?=
 =?utf-8?B?M2JQSHdiNXR4VFZMdFhGU0d5MzVBazFuSEpweTB6eHBXVXNuS1o2elVHRTJ3?=
 =?utf-8?B?c29Gd1RDOE5hRU9wb2tkNlJBSTNKQUVqb3FYekY0UmptQk8rV0JXV1hPdVR3?=
 =?utf-8?B?UWFMWUtsZE50OU44K3A4aDBBTXhWMzdRQjkvUmtCbDhMRFBobHR1R2hXTG01?=
 =?utf-8?B?VWRuV1Bud21nS1RWS01EaWRoM0dibHhFM1FwTk0zdjVjUldCT1NaVlhMWXZ4?=
 =?utf-8?B?bEUwbGdUanIzL3ZnajlzOVRvSVdwMFR0TmRHMXZSd0VtMlZJQ2R1Q29LRnM2?=
 =?utf-8?B?VXlSMEp2MnVmenhiUjZHU3hudGx3Q0xhS2N4U1lDVVhZYjk4dldYNVpuUXVD?=
 =?utf-8?B?NzcwQmZLY015K1VxT1R4QS91MjdaYytlSDhsSmJQb2JsM1RBVEt5a3U0UmFy?=
 =?utf-8?B?aU1DTVowRU1zUGhJWjhMcytUak5KcjF0R3FkMldjRUpxZ08xalJWTHQzUkc4?=
 =?utf-8?B?ckVWQTZ6QVNsOE1FNTN1TDRDN2FOenVtMm5qVUtDN2NWR3RlT3ZqRHJmdFRR?=
 =?utf-8?B?aDYyT0tTdUFSL1VYWFZUcGEvYWRrd3AzWXYzb0Y4SkxEVlVHcjFWa01DOFFv?=
 =?utf-8?B?a24vRkJsSEFmamNMbXVvWEV0Y3doQVpSaFUxN3VGNVJGelYxL1pSY1ErVGxr?=
 =?utf-8?B?UVJtaXZ3WFRqT2g3YU5LOGpERzhiOEgrWlNqUG52WWVia2dvNXg4a3ZPenNZ?=
 =?utf-8?B?YnZDb25welJOUkNack82YXVxcnN3eE1vaCtWbWU2c3prUDVBZ1F5YitBVzNW?=
 =?utf-8?B?a1dzdFc3aDNiMzNaR0VNY01RRFN3TytqRU5XTVoxeGRpN2IvRkxocFJZZFJK?=
 =?utf-8?B?UEdSeGVOY3BiSkFwTStUZTFMOXkzRy9oYVlzK21zT0hxcGdoYis4MGhHdkRW?=
 =?utf-8?B?bW12OTNCNVQvb3NzSERWRU5GS1dOTEJFY0YzV0hvWkFVWDlqeS9zekJzVEVM?=
 =?utf-8?B?VUh5bHNkMTJNRDJMbGh5Snp2MzErbW8vZjNFL2poM01QdlluYXpsQmQ1aG8r?=
 =?utf-8?B?aWxNTjR2VVNJRk5rRGVSRlUyYTFXR3ovN2U0eXRxQnpnWTVpclg5bFhHMUJW?=
 =?utf-8?B?ejh5SG9NdnFtU1FPWmVGSTNpMVNJQ1Ewb0dYdEkyR3p0dkZ3Z29VYXdnT0VI?=
 =?utf-8?B?d1U0TmlYc2xYRW5uMDNRWXdGdjhRNTJNSTFUL2JiVnZPaURWK1ZhN2VXNk11?=
 =?utf-8?B?TTV4ZFlNRlpUOUFRbHJCMjdDbkJYZ0tQVWQvRTdBWVFLam1wV010QnZUQ2cx?=
 =?utf-8?B?Ym5VM3R3RHhRcmdmeW1vSjNYTnc4QjZYWnI3RTJOemgzUkJEMncvTzk3ZmVh?=
 =?utf-8?B?SHlPd05wMUxlTkhucGxONHR2ZVlETGRlVGpyTk1qTTlqY0lkNWFvanZhZ29u?=
 =?utf-8?Q?NkaVJQbyc8B6KXZc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C3E43D1CC66B346A1C8C3BB95F31B83@namprd11.prod.outlook.com>
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
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB371697.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd08297-1772-4cd5-2d07-08df39abe6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 13:10:58.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/D+WwZ2Fy3QEZDHo6cP2jSG/KgfHpVPpzr3bwYqHPCIetObOPzoqAXp9L2WGZSSm8NQKjLus35gUmWfwg1Q1TEZxMRpJBejsL1QC2ZEkwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720

SGkgSm9uYXRoYW4sDQoNCkkgdGVzdGVkIHRoaXMgcGF0Y2ggb24gYm90aCBJMkMgYW5kIFNQSSBw
YXJ0cyBhbmQgZm91bmQgbm8gaXNzdWVzLg0KVGhhbmsgeW91IERhdmlkIGZvciB5b3VyIGNvbnRy
aWJ1dGlvbi4NCg0KVGVzdGVkLWJ5OiBBcmlhbmEgTGF6YXIgPGFyaWFuYS5sYXphckBtaWNyb2No
aXAuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmENCg0KPiANCj4gR29vZCBjYXRjaCBidXQg
Z2l2ZW4gdGhlIGZpeCB3aWxsIGdvIGluIHRoZSBzYW1lIGN5Y2xlIGFzIHRoZSBkcml2ZXINCj4g
SSd2ZSBkcm9wcGVkIHRoZSB0YWJsZSB0YWcuDQo+IA0KPiBUaGlzIGlzIG1vcmUgYWJvdXQgaG93
IEkgY2hvb3NlIHRvIHF1ZXVlIHRoaXMgdXAgdGhhbiBhbnl0aGluZyBjb3VsZA0KPiBrbm93LsKg
IEkgbWlnaHQgaGF2ZSBoZWxkIGl0IGZvciBuZXh0IG1lcmdlIHdpbmRvdyBpbiB3aGljaCBjYXNl
DQo+IGl0IHdvdWxkIGhhdmUgd2FudGVkIHRoZSBzdGFibGUgdGFnLg0KPiANCj4gQXBwbGllZCB0
byB0aGUgZml4ZXMtdG9ncmVnIGJyYW5jaCBvZiBpaW8uZ2l0LsKgIEkndmUganVzdCByZWJhc2Vk
DQo+IHRoYXQNCj4gdG8gcmVmbGVjdCB0aGUgY2hhci1taXNjIHB1bGwgZ29pbmcgaW50byBMaW51
cycgdHJlZSAod2hpY2ggd2FzDQo+IG5lZWRlZA0KPiB0byBnZXQgdGhlIGRyaXZlciBmb3IgdGhp
cyBwYXRjaCkuIEknbGwgcmViYXNlIGFnYWluIG9uIHJjMSBvbmNlDQo+IGF2YWlsYWJsZS4NCj4g
DQo+IEdpdmVuIEknbGwgYmUgcmViYXNpbmcgYW55d2F5LCBleHRyYSB0YWdzIHdlbGNvbWUgKGFu
ZCBJIGRpZG4ndCBob2xkDQo+IG9mZiBvbiBhcHBseWluZyBhcyBJIG1pZ2h0IGhhdmUgZG9uZSBp
ZiBhaW1pbmcgZm9yIG5vIHJlYmFzaW5nKS4NCj4gQXJpYW5hLA0KPiBwbGVhc2UgdGFrZSBhIGxv
b2sgYXQgdGhpcyBvbmUuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gDQo+
IA0KPiA+IFJldmlld2VkLWJ5OiBKb3NodWEgQ3JvZnRzIDxqb3NodWEuY3JvZnRzMUBnbWFpbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgQ2FybGllciA8ZGV2bmV4ZW5AZ21haWwuY29t
Pg0KPiA+IC0tLQ0KPiA+IEZvdW5kIGJ5IExMTS1hc3Npc3RlZCBjb2RlIGluc3BlY3Rpb24sIHJl
dmlld2VkIGFuZCB2ZXJpZmllZCBieQ0KPiA+IGhhbmQuDQo+ID4gQnVpbGQgdGVzdGVkIHdpdGgg
Vz0xICg9bSBhbmQgPXkpIG9ubHk7IG5vIGhhcmR3YXJlIHdhcyBhdmFpbGFibGUNCj4gPiBmb3IN
Cj4gPiBydW50aW1lIHRlc3RpbmcuDQo+ID4gDQo+ID4gdjI6DQo+ID4gLSBVc2UgR0VOTUFTSygp
IGZvciB0aGUgdXBwZXIgYm91bmQgc28gaXQgaXMgc2FmZSB1cCB0byAzMiBiaXRzDQo+ID4gKEFu
ZHkpDQo+ID4gLSBEcm9wIHRoZSBBc3Npc3RlZC1ieSB0YWcsIHJlbW92ZWQgZnJvbSB0aGUgZG9j
cyBpbiAxZTAzNTI5N2ZmZGENCj4gPiAoSm9zaHVhKQ0KPiA+IC0gTW92ZSB0aGUgdGVzdGluZyBu
b3RlIGJlbG93IHRoZSAtLS0gKEpvc2h1YSkNCj4gPiANCj4gPiB2MToNCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNjEwMjQyMTQ0MjMuODY1NjM1LTEtZGV2bmV4ZW5AZ21haWwu
Y29tLw0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9paW8vZGFjL21jcDQ3ZmViMDItY29yZS5jIHwg
MyArKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vZGFjL21jcDQ3ZmViMDItY29yZS5jDQo+ID4gYi9kcml2
ZXJzL2lpby9kYWMvbWNwNDdmZWIwMi1jb3JlLmMNCj4gPiBpbmRleCA4OGJmZmJhYjA4NTQuLmI1
YTJhYzRhMmU2NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9kYWMvbWNwNDdmZWIwMi1j
b3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9kYWMvbWNwNDdmZWIwMi1jb3JlLmMNCj4gPiBA
QCAtNjk2LDYgKzY5Niw5IEBAIHN0YXRpYyBpbnQgbWNwNDdmZWIwMl93cml0ZV9yYXcoc3RydWN0
IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2LCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYw0KPiA+IA0KPiA+
IMKgwqDCoMKgwqAgc3dpdGNoIChtYXNrKSB7DQo+ID4gwqDCoMKgwqDCoCBjYXNlIElJT19DSEFO
X0lORk9fUkFXOg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHZhbCA8IDAgfHwg
dmFsID4gR0VOTUFTSyhkYXRhLT5jaGlwX2ZlYXR1cmVzLQ0KPiA+ID5yZXNvbHV0aW9uIC0gMSwg
MCkpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHJl
Z21hcF93cml0ZShkYXRhLT5yZWdtYXAsIFJFR19BRERSKGNoLQ0KPiA+ID5hZGRyZXNzKSwgdmFs
KTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiANCg0K
