Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795352443;
	b=VQzIBw4na09ZCZtenXnR/V6p/ovgikFompaXXK+w/uxvTvEoOG8sFbaUsYW2TFtl2nto
	 kpzCa0I6d7cHdnVMOhpRb3AXoBKFOz2O5FilGl7NNl0cbbYuCQaIuL/jEVR2PBLW9kyHQ
	 coV3UenbkgioZyLjpx1lkTuOQ/ehu+XVN15b8mYDqBX3V4GUTcAQDOIk6I0YFRu2LekOL
	 waw4aunGTE4qkR4JE53RZIK5xQTHUTBRwFCqb2uf47YNIh1uqFjxiu9viuH6bsrAeGR7C
	 uOl8lTo6z3MOM2kUU5xADYiUro1Ap4zylmD9xZ95vbGOOVNUL840GFKFcUO1XPEDBmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352443;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5NYhs/MVhmsglw2Bpj7QGVtPC8wIRi+AzmD/AgVS7MA=;
	b=P7+1qycSkiZAcQUrwqzooFw/LknoXmNZQY80ZNfvpIBuSoHhEgcGhsEHku40IAgh5AcK
	 l1ZIjbuVXB3W5gruTrH4G6DftErkGNHViRrGt2ao5w4bsqSfjko+ZMrewxinLv6izycvM
	 /IoRA6EHCMboThsFE7Zjha96+m1pa8FXY4Fc+rGpgnxWrPTx0pBItv9CcAIaGbsE33nxG
	 o8zRAdg3tOKrm8dUNTDYhqHUaAF5oRrqC4jIVoNnsXGquc9gZDwpXIEDCtf1Smp2CEOO/
	 8ogYcwwjGk34Tr9Z9OlzHbGR0yk3Vh2xHMlMK0kqmC2e3TpHaPGWdoBlLwn6gxQKoMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=RV9TMize;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.39
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EE606A32A;
	Sun, 22 Nov 2026 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49EE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=RV9TMize
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+vXtQevEApNDz6OX3JveTXsJ+XlpQPGLANNJE/G+4IwWJQNGqNTGbi9ipHuoO7vndqVeH2g7weVdPZUV5yCmixYVeD6WrzWvdyVNZzb81lkuqJj0lxhup2NAj6SBckmRWfPRtjR80s1Fx9GDyc3t9NIC/+839qkYeDrn7/IhN7tiXT0rEXhdcghn1gekfSr37u4VHKexocbY5FIpj7Grca26dO5sqGdnj62o2ltHl1k+5oZRKoAcjG9dzEUroi1OQj4w3/0RqhhQhljs0jSzEoeDYKF0qqwPaQB3L6++oGgnFRj8TB3f1yNpv2NPtf70hZSfWXaGga8eqABzvTlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NYhs/MVhmsglw2Bpj7QGVtPC8wIRi+AzmD/AgVS7MA=;
 b=P9o7bZj9c7Cx/GlXEZQt5b5dV+UN+/AK/TtAL5raHMwJETISndyafSML+kDsSCelzw0/0r9TRQYpvrO0PKx52vYBF6XwQrGQzTIMViay46adcpm2+HlYL41OWQoNj+XistPVK++9LUmBdA9LOonZSM65l9TarslMDHttPIbU71+AwljvKwKCKiMFMiazXsqvwW64iuTraGRTMhcVHXDfZBhZC5e7gAxgCMtNiGu6kb3J7HMrGRDmspY2Daa1fW9qXKWdt73wv7TonPepL/Re/oea5sH2YLVfMtT/mpoo7RYLSf0Ix9pzTrUnAPqtlmbTNXSgO+Z2LKRdxYORywnuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NYhs/MVhmsglw2Bpj7QGVtPC8wIRi+AzmD/AgVS7MA=;
 b=RV9TMizeb+wEJb7ZPLkTtwUFQnRvp1g5DxzryfaCA2AKXV/TN8NSox3sux9nuYjUvjV3r+1gSPK6w47os7cfNn97ps2Pdb/cmfiJ0Wyr2+kKOPicS0QFHtBqF0GZg9UR8+0hEMIXoDckRpMzEaGP5wd09UqDTJmcuMf8Psy3ecAjwQB7uHxBqzwooL/vfwlYNLDAHtrYo4VNT7i84b194QTgKPTBa4ge2qCDxOfvjbL3RFR3BNnCF9b8S8f9mRoT+uZNgvCAoQYeM2nIvg2gatJGhTIA7YImlrhLFaQgfW0I/aa8vQukSJUy6SOtek9XZP8CRVfirpSJH0zMTefEpA==
Received: from IA3PR11MB490611.namprd11.prod.outlook.com
 (2603:10b6:208:61f::20) by SJ0PR11MB6767.namprd11.prod.outlook.com
 (2603:10b6:a03:47e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 13:00:38 +0000
Received: from IA3PR11MB490611.namprd11.prod.outlook.com
 ([fe80::dccb:5763:15c9:53b1]) by IA3PR11MB490611.namprd11.prod.outlook.com
 ([fe80::dccb:5763:15c9:53b1%4]) with mapi id 15.21.0639.010; Sun, 22 Nov 2026
 13:00:37 +0000
From: <Nicolas.Ferre@microchip.com>
To: <liguangshuo@mail.sdu.edu.cn>, <Ludovic.Desroches@microchip.com>,
	<linusw@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: at91: Fix potential use-after-free on manual
 unbind
Thread-Topic: [PATCH] pinctrl: at91: Fix potential use-after-free on manual
 unbind
Thread-Index: AQHdeoF3kzdh3Vtx/UyEgTqLmftAfg==
Date: Sun, 22 Nov 2026 13:00:37 +0000
Message-ID: <a52a58d4-d452-42e1-be3b-db2df2211549@microchip.com>
References: <20261120173530.3924083-1-liguangshuo@mail.sdu.edu.cn>
In-Reply-To: <20261120173530.3924083-1-liguangshuo@mail.sdu.edu.cn>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB490611:EE_|SJ0PR11MB6767:EE_
x-ms-office365-filtering-correlation-id: 3f0463b8-6ccb-439e-cb79-08df48989a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261026121527099003|261022075727099003|261021135927099003|261021121427099003|261102123227099003|38070700021|11063799006|10067099003|56012099006|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 1rCPIyrLHpVqUg8LRnMktqTTTGKtfjOZuAkRHpzMe0xABx/Le8YHv7Fdfq2Ihmy2efI4Srs5m9W2RpsQt2/HnVmcU10jIVUHxfd2voNwti40AxSS5SdktN5nIPlkQ2S/XkS5wwk44kth8wypRl17KXAhmx4DBSsDqAVJCMF5lgmE4xuDDxGSpGNWNa2m7680tQRvrv9VMBmqxShLYqoFzKJs8M6C1bwVLSfTEW0pb0dYWJ9dqHvJLmj2+ADkOakyOFhUDvkSVsO/ONBrKuxLqL43bZ+EUyA1GdbtC7/24dHvhcApwPOnHHrHl3NS7jVdJmBRZdAs9eoyuHXf6gNRzgOdD5JCGvGWkGdUlt3ig9XwHiCY3n5OctBeMCZXyWqYkQXPZ5Qb4+N8knuxYI+NGG2MfOdNmeT7/1WLgujdIT6xu7IapWpx16txr/OI7deYbmu828umWL4Stdmz2Bwp3Hk0w01YZf8gmafBBiRHfV4rzAJ58MCGy/znYRoJzx6Zi9y/j76BkKo2145YMIe3rx8Msld6DAkoF+BAyV85oqK7/u/78jhgg4cGsidrcHhtksL0I3KlbeOJP7B6QXw+ewbzSC/Wlrx8fi6+uGkPo/bjBS2jCvUacHBbEamj6Adxx1Ne7p+zrlfKeo4TMObPS/4BQ3bPUkxpMlGNQq+NUVgvXuyGp2WGb1KxN93fxTXO2vbtj1w7WLwifaUr2ZYQbkYcU+LuzftMmzrASwUtSCQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB490611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261026121527099003)(261022075727099003)(261021135927099003)(261021121427099003)(261102123227099003)(38070700021)(11063799006)(10067099003)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFBUUDRZYjNXVEdoV05QcWRSSjkwMGxFUDdVTUFjR3NNMGEyWGl4OTJPakFk?=
 =?utf-8?B?Qk8rOU1JZW9BdzlKMTduVjhPYXVIUThvRThlaW5ibVBVMTdXbGd6cjg0RkVq?=
 =?utf-8?B?L0x4ME9MTWd6cDVoeFZ0RVFndkpycDh4RDdmMzNCbDU4SFBaRVVrRVQzT2JV?=
 =?utf-8?B?K0dYZVdTVTI5elBNQkprUkE2T2ZBY2NGTXdObjlURlZuVzIycU5GVWpZa3Ev?=
 =?utf-8?B?L3lxNjkxNkNNdGtwWVpjRmRTRWY1MndYYTJaYkxrL3hXUDV0d3FPVlZzMHpF?=
 =?utf-8?B?eExXK0NkOVZKQlYvWlhHbE16Sk5QcTZwVGxGMjhhZSttcGNveCs3dTg5QjFF?=
 =?utf-8?B?RUxnS3BFQ3QweExRWTNGRXF2TTdBdkNoMTRNY3V2bk96ZmUvY2pPMUh4R2NI?=
 =?utf-8?B?V1BlNHZNVUtRWXRyL2szdCszcHhlSVRoQzBBYk1QTVBvbjNaOXhyYk5xbkZJ?=
 =?utf-8?B?OEFQVkFmVVBpejM2eVRoMDNURHFjc2UxcDlYUFREME11Mm8xeTJ6L0szTnJJ?=
 =?utf-8?B?UGtMajZyS0hDY3UrM3NKSThOZ0o4N1FJSzROdVFwRnZYZWJlcTJFemdCOEl6?=
 =?utf-8?B?b3ZnWlcvUWE2d1VObmVuOXg5VTBoYXQ4WldXcGRXaTUwNktZNUlTSlc2TDA2?=
 =?utf-8?B?bkVFMHBaSzNuZVIxaDBRY1Z4bUtNV1ZjbDdGVFdSVWE4MFYvNzVHSnkrcDNL?=
 =?utf-8?B?UFRsbGZiVzBjRGlCSGZ4TjZxY0w0NmRneXdVMmNqOWdNL3R0UUpZZngvR0pk?=
 =?utf-8?B?dTkyU3ZkU0NIQWU3TGNFTFJNbkMwM0hjSFNmU0FmZU9zd0VLUjNoZ0ZVN3Ar?=
 =?utf-8?B?V2w4UW12Yk9mTlZjSkRTUHhIalFBK2tSNW5yMnltNm14WW9IV1lKTk9RRlVC?=
 =?utf-8?B?QkFja0JIeGVqRjIwS3hpR1VMdE5jWlpmNmgvRFIyUFRtVDdsZTE3ZmdMWFJ1?=
 =?utf-8?B?K0M2SUp1RnlwQ0pBdWRjbW53ZFd4N21uK0ZJYzFIdXRKTk0rcktTU1lKRTYr?=
 =?utf-8?B?dFArd3BSUmNjVlEwTUVjd3YvQThQNThtQy85ZkRXNHpLUVpyOFhJMnJ5dXBy?=
 =?utf-8?B?MGl3czd3UThTWFJuR2NaUjVQQXFYa3JCaWNndkZycEwzdXJqdmxrY0d4bkU3?=
 =?utf-8?B?bXNQNys5clNrZkVqaUhkdzc5OXVsaDlQZjNlZSs1V2drcWdDZ2s3eU82bGEv?=
 =?utf-8?B?ak82NHhIVVlLcVFleTdFSkozd2haVUM4aVJLYkxxZTc4OWk2QTZBSTIxb2RM?=
 =?utf-8?B?SXlLTVZYTEd1dU9IK2wveEZ4M2VIZExJNWp5NWtnbjR0dndtVHdqd2g0cGdE?=
 =?utf-8?B?QkVPdSs5Z2pDVGRsSE1uMUtKMEhKUC9GcHl5Uy8rY2orWXZ5N281QWRVTEtl?=
 =?utf-8?B?U1IzVEdCNmxONGdqODNJc2dwVjBsVFV2b1BMaWdPRWtGUXMyVUxHbkxYSFU4?=
 =?utf-8?B?Tkg2bk5FL2lVRFErWlRHUWkyaWFtcHdwb1JXeVZyc2Q5YXR2U25tMXJqeC9i?=
 =?utf-8?B?cndhSDNETzg3OHR5VXJQWERGOTh6WVIzZHNueFpJZHBGUlhMaGZ1d3VhTUVt?=
 =?utf-8?B?N0RsbVFEL2pyRXBwbFdIVm9SdUdMaTVneE9oampRUzBqV2x2dDZWaitOMThR?=
 =?utf-8?B?VERCZkVKRDE1SkhENW9neDhDRUNGNWZPRGxFRXUwdU5FaGNPbkI2WVVDeHlk?=
 =?utf-8?B?RHJQVVluazg1clo1Y0xsU2VkT2h1UVMzTHNMcEszL1RvQisvNlZUVExzYWRl?=
 =?utf-8?B?ZUZlTmtqSDkxeCtuc205UFBkRUtPNWJqdjFUNHZQNUZWMWVYdWJVSWs4NmJk?=
 =?utf-8?B?emFoeUcrRDd1SHZZL0g1dGxabStDZHMyRFBkMkVvdzVWWWppWldKU05XWWRH?=
 =?utf-8?B?aTNrVmZUdG1tRkdheC9Ocm51RFBvd2hFOXI4L2p1dGxmTjZpSjlHbWtKQ3Ey?=
 =?utf-8?B?YkJFdlZ1YzBnVXpWSS84VTJ5L1FrSmlXRVlNUnJHZ0N6NWprdTBUN2tjNzVh?=
 =?utf-8?B?aVFlYlA0Mk85Y3cyUGIxbkZkVGNhNmRxRk0veldrbTZYWVYxam5rUUFjbFRn?=
 =?utf-8?B?Y2I5NjJ4S1NYL21DRDNEano2cVhQZ3JVMHZybmN5c1J1NXYzS0lFb3JjU054?=
 =?utf-8?B?SXhPZ0RrZ1RSWmsrZGJ3UkJ6V2ZtbitFWWtBTFFVZ3I4bExrU3Q1NWU4NHJl?=
 =?utf-8?B?RXZsR3k4RUpKMjFZR0l2cWludFh0bXNtdW4rNGp0ejlXRmE3R0pBZDQraTJ0?=
 =?utf-8?B?SmpJajlNcHd0UTB3YmFTd2FnWjNCUXRaZEJUcy9HQkFVWFNGemhsQ1pXb0gw?=
 =?utf-8?B?eWpZT3N6a2xqZHZ0STBNMFJ3QzR2a3NDVHRBUWxzOEJLek9sbTZDSEQ3VHBj?=
 =?utf-8?Q?gmtK6o8hP6SbFO/4G3OGEBSSF0nLrpbTTLcVuxMpjaLJp?=
x-ms-exchange-antispam-messagedata-1: 8h+KOJZmsLSMiw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E98600AF407C04B860F58D4A2782625@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB490611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0463b8-6ccb-439e-cb79-08df48989a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2026 13:00:37.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATEOkZ9EC6/GYkslcbPGs6SIn9Q+EK3/Xei2LF6fUYLsIuaWhsgFNkbNSmFitRAxHFDKIamLmd0ssA0wkVSoHiUNuticEmC2v0VwfbNjJYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767

T24gMjAvMTEvMjAyNiBhdCAxODozNSwgR3VhbmdzaHVvIExpIHdyb3RlOg0KPiBUaGUgYnVpbHQt
aW4gR1BJTyBhbmQgcGluY3RybCBkcml2ZXJzIHNoYXJlIEdQSU8gcmFuZ2VzIGFuZCBnbG9iYWwg
YmFuaw0KPiBwb2ludGVycyBidXQgcHJvdmlkZSBubyB0ZWFyZG93biBmb3IgdGhvc2UgcmVsYXRp
b25zaGlwcy4gTWFudWFsbHkNCj4gdW5iaW5kaW5nIGEgR1BJTyBiYW5rIGZyZWVzIGl0cyBwcml2
YXRlIGRhdGEgd2hpbGUgcGluY3RybCBzdGlsbCBob2xkcw0KPiBpdHMgZW1iZWRkZWQgcmFuZ2Us
IHdoaWNoIGlzIGFjY2Vzc2VkIGR1cmluZyBwaW5jdHJsIGNsZWFudXAuDQo+IA0KPiBTdXBwcmVz
cyB0aGUgYmluZCBhdHRyaWJ1dGVzIGZvciB0aGVzZSBub24tcmVtb3ZhYmxlIFNvQyBjb250cm9s
bGVycw0KPiBzbyB1c2Vyc3BhY2UgY2Fubm90IHRyaWdnZXIgdGhpcyB1bnN1cHBvcnRlZCB0ZWFy
ZG93bi4NCj4gDQo+IFRoaXMgaXNzdWUgd2FzIGZvdW5kIGJ5IG91ciBzdGF0aWMgYW5hbHlzaXMg
dG9vbCB1bmRlciBkZXZlbG9wbWVudC4NCg0KV2VsbCwgd2hvIHdpbGwgZXZlciB3YW50IHRvIHJl
bW92ZSBncGlvIG9yIHBpbmN0cmwgb24gdGhlc2UgcGxhdGZvcm1zLCANCmtub3dpbmcgdGhhdCBp
dCdzIG9uZSBhbmQgb25seSBJUCBmb3IgdGhlIHR3bz8NCkRvZXMgaXQgaGF2ZSBhIHJlYWwgdXNl
LWNhc2U/DQpJIGRvbid0IHNlZSB0aGUgcG9pbnQuDQoNClJlZ2FyZHMsDQogICBOaWNvbGFzDQoN
Cj4gRml4ZXM6IDY3MzJhZTVjYjQ3YyAoIkFSTTogYXQ5MTogYWRkIHBpbmN0cmwgc3VwcG9ydCIp
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEd1YW5nc2h1
byBMaSA8bGlndWFuZ3NodW9AbWFpbC5zZHUuZWR1LmNuPg0KPiAtLS0NCj4gICBkcml2ZXJzL3Bp
bmN0cmwvcGluY3RybC1hdDkxLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEu
YyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiBpbmRleCAwYTU3ZWQ1MWQ0Yzku
LjgxYjU4YTdhNDRiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5
MS5jDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPiBAQCAtMTkxMSw2
ICsxOTExLDcgQEAgc3RhdGljIERFRklORV9OT0lSUV9ERVZfUE1fT1BTKGF0OTFfZ3Bpb19wbV9v
cHMsIGF0OTFfZ3Bpb19zdXNwZW5kLCBhdDkxX2dwaW9fcmUNCj4gICBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBhdDkxX2dwaW9fZHJpdmVyID0gew0KPiAgICAgICAgICAuZHJpdmVyID0g
ew0KPiAgICAgICAgICAgICAgICAgIC5uYW1lID0gImdwaW8tYXQ5MSIsDQo+ICsgICAgICAgICAg
ICAgICAuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUsDQo+ICAgICAgICAgICAgICAgICAgLm9m
X21hdGNoX3RhYmxlID0gYXQ5MV9ncGlvX29mX21hdGNoLA0KPiAgICAgICAgICAgICAgICAgIC5w
bSA9IHBtX3NsZWVwX3B0cigmYXQ5MV9ncGlvX3BtX29wcyksDQo+ICAgICAgICAgIH0sDQo+IEBA
IC0xOTIwLDYgKzE5MjEsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhdDkxX2dw
aW9fZHJpdmVyID0gew0KPiAgIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGF0OTFfcGlu
Y3RybF9kcml2ZXIgPSB7DQo+ICAgICAgICAgIC5kcml2ZXIgPSB7DQo+ICAgICAgICAgICAgICAg
ICAgLm5hbWUgPSAicGluY3RybC1hdDkxIiwNCj4gKyAgICAgICAgICAgICAgIC5zdXBwcmVzc19i
aW5kX2F0dHJzID0gdHJ1ZSwNCj4gICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBh
dDkxX3BpbmN0cmxfb2ZfbWF0Y2gsDQo+ICAgICAgICAgIH0sDQo+ICAgICAgICAgIC5wcm9iZSA9
IGF0OTFfcGluY3RybF9wcm9iZSwNCj4gDQo+IGJhc2UtY29tbWl0OiA2NjI4ZTdkNGM2YjI1Yzhk
MThmMTM0NWUzYTIwZDIxODI5YWFlN2U0DQoNCg==
