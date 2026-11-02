Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793599941;
	b=pKSLqlaRdaTDp3+OmqztbzP3xkfNtWkr9bS1oCKMegwCzhtkALTBl4rBdIy2JmPIlz2s
	 HEbUuk/IES/flZEc4v03Zdn4mojfxPkFNGtjs5GVcNQZFbk8AhwaV0I+nqXL8q/cADUuq
	 Kljt1InogEP4GLFxvjeDqucvb+tIIT3IGnTy8UD7CGWFCBWAaQXVOfU0fylr7p9f0hZF0
	 d6tlsKDpcxJWLtY2RINpeCc9yzfCkqKxbwW5betUpfjblMpxKg77hO9LGm4BBOm0luhc5
	 84X1ouaExgyafcX9SaYXYpneISgFAwaHbaAe9DF1cKMjBRnBvM95E3nFYMW5IArFflA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599941;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eHavJIa6EPuRE+lRIJZD2yk8Nhc5kxtQY9U/UbWZuvk=;
	b=zqcrHCv3feVZn93brSlZ83+aitzBqlnedvgK53bK+4LFoGGdLvuvZlFFpSBSMbMixWp2
	 EFbbumAAmIU6rNN2CalHPkbyN8FO+sAgTjA+XL/z5bab5FAhNa52fdYIZXMXRr5qil7wB
	 dxE+NFPBPObmHEScnvgo2ZGzTHc7nR7ROujVGTSZFHOlzfDc3wOSlXGwPdBK6Tto+0Yl/
	 mfR6PT3XdVbqVQV7jIldokj1fTgUozZqtucH0O3QQ8Nx895JW8hOCMKtiv8+uB6P/D3nx
	 TpVmGyUad6wOo3txIjeQtXVmbXlh5CDZcFp8+L/CJIxHLzyaNLjP3T9MQUD65+mAb8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Ek4oQEu1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.39
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012039.outbound.protection.outlook.com [52.103.23.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0C606A324;
	Mon,  2 Nov 2026 06:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C0C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Ek4oQEu1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLOSOqXGb6WRctEu0l4PYF56GljYo/84zl2VDvKtAqWkwfeZFiS1qqQGUcGc7J5HU9GGrdnVBmLF/YjJ4GB4nSDk4hsJu2x9VMksZjEzVdAWv/3gdOzF1v3PSBXxriiXWN6J/vkheZHUPpbWMJsHV9Qj7APs9QrpZaf67vhVbKT/9xV2m+hyP1TeiAgyvD7ltSMaYB+NV87UgkiS8ET5Lsc5Coln+lSdIqk8iwOdljiguOPoHXJ5dGKEZv3LrdVrTfZ3vjWeU9DcoNgqoa5CmAeiSP494wczih82NhVYWSBmy9HaRH3eTFplJMc6a4UINzGwbQ2lrZPT33OnjlHMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eHavJIa6EPuRE+lRIJZD2yk8Nhc5kxtQY9U/UbWZuvk=;
 b=zJlDGZjzxt2FZJnaP/FpyP4eQ9i+g6w4CesYrItt3pKbPKR8OehKwXLPAcDurk4gnpLfo3CfkeIDfiK9SzEaGMsCktyQL5w7Bqc8NypNso2W0zHLZHQAwjHcOKMv19vu2k+jazjo3ZZt5nCqycxzPtzMRT8FV3kk09yOWlmQ41CxKfOGjDvjm04BiyqxUnQpU2GtH0xaq/qSuZc18RM5Yvo88a4oiU8ysuJqi8N/gKcpm7HdNBXAo7wVH0uiUKQLGM0NGXMzqZIqKduR3oNoRINc3mrSlaCNV67QImu/hNhYcwU1v5BRbSkGLBe150ks+qiwH1m57zBNBigagvHD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHavJIa6EPuRE+lRIJZD2yk8Nhc5kxtQY9U/UbWZuvk=;
 b=Ek4oQEu1efCD8Nrf4JZ/UfFOb0gJ2eSVLt6BaSOYpI+Hi+McY12QLJHcMqrb09yCAxNK5BzimjuG+ji4m+nK8AJKDfcPHGkf5RMx0JFQALnYCPli7Ki3rd421v6xvTavN3NFh4rAS18r40q1Mk0xV1RKHz4QET7yt9zU+tj7LFpVfI+P5azO7CeanGfRjZ4iv1Ug7N5uK3gmWGwQhEj51zNg200OLTtx6S5Qo1/iXSsGYclmk1kN1bvg0UUtR796CybhSuzODVfYwd6OmsNesfmo36uR/NMQK4ShAZwDDQ/X95QLXbl/szI43RXIEY2X95kKBkD44nsJSDfFCzVWOw==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by SA3PR05MB660978.namprd05.prod.outlook.com
 (2603:10b6:806:531::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 06:12:18 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 06:12:18 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net] tcp: ipv6: keep request pktopts alive until request
 destruction
Thread-Topic: [PATCH net] tcp: ipv6: keep request pktopts alive until request
 destruction
Thread-Index: AQHdapEdg9xE6W9q5UeOl25gPUd6/g==
Date: Mon, 2 Nov 2026 06:12:18 +0000
Message-ID:
 <82c31e4d5043f3dbd11b44177cfba779d335aae3.1793599929.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|SA3PR05MB660978:EE_
x-ms-office365-filtering-correlation-id: 421883bb-5130-418d-cdaa-08df38a83fa2
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|22091999003|24121999003|38102599003|15080799012|5062599005|24021099003|41001999006|19110799012|10092599007|8060799015|8062599012|25010399006|4140399003|3412199025|440099028|102099032|12091999003|26121999007|52005399003|40105399003|30101999006;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmR2WlBGWkVpUnJLRS9BdVJXVkx2UGo5KzJBb2t2L0VXOXp6T00raXlISERR?=
 =?utf-8?B?OHZpTHRBRVJRMnlFNG1PdVIxZWFQWUZTTlRXU1FGSnE2SkVPTVkyS2Fpa1kz?=
 =?utf-8?B?Q3RweHZaRWIrZkN3cy81T0Y5MERPK2s4akM4eXBqUlVhVDEwWE5BbGdlMHZ2?=
 =?utf-8?B?NWQ0c2NId2ZPMlA0TktxUnJSZmEvQkFteXoyamF1em9qeHlDdjc1Q1lyb1VQ?=
 =?utf-8?B?RUNkTjVBQURlSGJMcnZtQm9DTnBrdXM5Rm5QTmlwWWJQaWY4TWNTeDdRTFpM?=
 =?utf-8?B?aittNVR5SVlnaWFHcW1EY0UrT1ZDR0UrVXVJVEloMjRmc05SNmR0clp3ckY1?=
 =?utf-8?B?TVZSeDRJdi9VT0pIQ0UrK0VRYTBPdkZUMm0vK21QN2hBU2d1ZkF0ZC9laVBN?=
 =?utf-8?B?YmhTZks4dFYxdkFhWm04dU5VQXhDYjl1cEpYK2dRWkc1UUFidmlyZTA2UFA1?=
 =?utf-8?B?bkVOd1dZdWxiSzh5aWhkckp6dkZPUjFSdFRhZmN4YTFvZWl0TktaR0lDazNN?=
 =?utf-8?B?UVAyMVdMTVdJTWRIMjVRWnlpblo2S3lmZEtJRitsRTkrT0xWaW8wTkwvSEhK?=
 =?utf-8?B?dXBLVXdJcStkd2VVUkxhY01QUFM3alBTTWpNZlRJaEdTMU5vVGdJU2NISity?=
 =?utf-8?B?S1FzMC9xd2hiaDNSeVQ3TGJMR09FczNsT0RsODl6cHp6MXdaZjdMekdjcVpa?=
 =?utf-8?B?ejkyZnBoVCtvMVJKdkkzVEZ2bmFQYWJ0SGFsNjlTSjlvVWR2akZ3VUpkVURp?=
 =?utf-8?B?S0V6NVRyall0RmNlOEM4VXQrSHgzUXNoeDdoMlJyMUFGamF5aDZtSUxQc0Rn?=
 =?utf-8?B?MmppNUdnTHM5QkY1QVprcXluUll4NHptcmRDbml4RlRyc0R2bjhCYnhjT25x?=
 =?utf-8?B?bDNkdGR5VDcvUVNMSEtpZC85dDZMYWt2R3NVNGRZVjV5N0FCNy9od0t0Nmsr?=
 =?utf-8?B?bHF6MTVGcWxpTTAwOENPV2xkYkp4UW9IUlVpZ21yTUlUMEpqOHRkaXU3a2E2?=
 =?utf-8?B?Sm9nNHFoRkVsVXdIR0VEUDYrckJlQ3gvS2JsOGlqcXV5MWUza1dDYlBicVly?=
 =?utf-8?B?RGg1WENSWVJrR2ZkdENzME5PNXdkMUNnaUM1eFgvVUpGQVpuc0tjMGd6NHZW?=
 =?utf-8?B?Rk81a2VmM2VnT3ZzLzkzcklZMmlSNmc1Nzd6QTJLZVZRUmZyMjRpTnNpMG9v?=
 =?utf-8?B?aUFXVE1XMXNKbFpKNExSck5IRXh0YUZadmh5TDJGNnp2d0x3WmRGM0s1MzhI?=
 =?utf-8?B?aVIxa0J2VTBITnFWeXJTbVJDTWJ4K2ZUVGQ4dXZHak9weTA0WlNvOWpVVGpj?=
 =?utf-8?B?KzNuMURRMnlCd3VNUmhvbE84ai9pclBhUWFweDJoQXB0aklKVldidUZQeGZm?=
 =?utf-8?B?Smw4dWJoaXpZYURDTFF5RFhxdlRtbFM1eVd2azNkVy9FMkNGTTl1RWw0QnIy?=
 =?utf-8?B?MUFNcHl5eWNYK1BnY1J3RHFONGJZZ2FiWTNSZk9SNEpFamkyUkV2cmtGQjNl?=
 =?utf-8?B?RGFMZlljUjlLcDJURzhWWEwxdGFlWmtJQUhLTjhiWlQzWklBaEk4TThwaEQ3?=
 =?utf-8?B?UERkZGltc1VWd2pyOHoza2w3WjNEODlXbHFaRU1sMjNxMWowekhPbUxSTnVi?=
 =?utf-8?B?b1BFcm1lbW9HRkl0bjRsWHFIcmhSZFE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHovb3A5VUVJYXJhcGwxVVNSVENxdlg2TTJDaG1iKzFzSWlBTldnN3RiYkg1?=
 =?utf-8?B?bHVVOTh3K05mZGJCVnAvSkxQbU1yVHNrU2JDdDQwb2s0ODhVWEt1ekdqTTc1?=
 =?utf-8?B?eFk1azlhNkFrTkpvbEd3SnBEbmNqM2JheC9YUmNOTittcG4rTzExZmRITlFr?=
 =?utf-8?B?d3R2SkNYRVVqdnczVWlobkp4QWg1TW1CYUtkWVFSN1FiWWVjYUI5VlR1TG9l?=
 =?utf-8?B?UlpEUXFFYnRsZFpTKzgra2hmdUppY095czBuNGpHU1lYZUQxUk85Vi84aTVz?=
 =?utf-8?B?c3R1NFByMXpXcEVGbHFuemd4MC9VWGx5a3hyczFWM25ZZGc3M3ZBa3lGaHFy?=
 =?utf-8?B?TlFoc1U0TmF0cy9odjY4NUJsZVJybVBwZ3JmWGs0Vm44dU9wcFdFcHhzQzdl?=
 =?utf-8?B?ODdwejI4N1RhL2pORlVuNFVWWHE4WW5jQWt4WC9kQmlFN1VIWEpDMGNGcDk3?=
 =?utf-8?B?SVVqZEZRTGI5MEZ5ejJWMTVVd00yc2I4QklkNnJFQmV6T2dTK3FVVWt4dlc4?=
 =?utf-8?B?RE5QVS9tZkE3d29yWHNNRDhkMUlQcXBVTk14dWVrdElPY0g3QmxSL1pkSW8w?=
 =?utf-8?B?ZFZvcTgwSVZQeTZlaVNxVnJvaGFWVVh3ZW1IS3lnZ1ZCWFZsWFRNQytObDNY?=
 =?utf-8?B?cHZESHUrUHhBSHVmbGFKczBnbDFoNE42a253Ulc5QktEN3lZODZaa2J4djMy?=
 =?utf-8?B?Z2J2Uy82RmMwMENrTDBFeXFnTnhsdnVvR0JibitIQ3BrSGNLM0pJclJKN1FG?=
 =?utf-8?B?WGJBYmFKMStwNUVQWTdhZDZHMW1TaDRlOU12WCtKVFB3Z0pXQ1pZdU01eG53?=
 =?utf-8?B?cjNBaGo3aXd5eDkwZFpWNkVpcU9KSm1PdkY4UWpEUUNVYXpzMHphd3Y2VGxj?=
 =?utf-8?B?UDVURHZzVTkvYWFlck11RTZnc3BacEVmNFVBYnRqNjhmOFpUUFFKa2RqdmY3?=
 =?utf-8?B?b1JqdWFQTmRrZ2FrVnRXTWlsVUZHQ0FGL1E0QlgwWklGaHZ6WmpSbjh1TkRJ?=
 =?utf-8?B?bUpNSDduTjZxV1gzWnp4VkxmbGNuSEliMTFzbFNoTUppRGRRR0ZxLzdNaXUr?=
 =?utf-8?B?NFIwTVczZjBnV3Z2eGhxVnhmckFWU1ZzN2NQQWMyanNiT1VOcDlsMmR0M1Nq?=
 =?utf-8?B?aWhsaDljVi85bVZ3eTZibkxKRnd5aW1ydTRZM3JmZ1BsQzFBTEduMEltMjZP?=
 =?utf-8?B?c0VKVWJYWm5vZWtOWHdaVmJrRW9kSG1aQkh4YlAxWG5PS1ZHNU1jdDVWVXVn?=
 =?utf-8?B?MnkwWExpZEJidy96Q3l0TXJtLzBjSTFPK0ZISHhKa0FUZDZOMGwyVndCSnBG?=
 =?utf-8?B?Ty9uOGVNZXlCSlRmbmpsWmRzK3k0RDZOWHJXMnowSmRXS2JvblgxKzliTS9h?=
 =?utf-8?B?RUJGV0hDZi84Mm5Ub2ZsUGxlZkNrUFhyUjh5WEc2cUtSTTNuNWtMZ3NuZ25r?=
 =?utf-8?B?OXB3QlBIZVFJeHgxUTRFMERFckszN0p2WC85N1JTWHJQNWI3TWcyc05sSnpz?=
 =?utf-8?B?ejErUGdTdlRDaW5Tb1NrTE9GODNpcmtVd3BMNjVobDdxL25XcEFPMXFxYWJE?=
 =?utf-8?B?OUJmUWdUYWpFY2RudlV3elNwTWRBK210dU1mdkY3a0hLZHBJK211SzRMRXFD?=
 =?utf-8?B?V0xZWWViS3N4RCtGMWpFUm51NXQzL2Z3VGt5NGdYSEphL3FQdnFGR2ZEem5E?=
 =?utf-8?B?MkIrZ0ZmZURuRHRZeTdiN0tDSzlESzRnZEZSYXk0LzZyTXg2aU9yMGpnSG01?=
 =?utf-8?B?Qk1tMGhqb2ZwRTBiZURHVXpGSEV5L1hLYmxpMVcwbWErcitCb01kZ2pyVG4v?=
 =?utf-8?B?UHJpWXM0VzJkdjREcGhwUkY1VWltNTBqMUkxc3dGNHl2am9tQ3dxRjZDR3Nj?=
 =?utf-8?Q?04pxVitfBLCLP?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 421883bb-5130-418d-cdaa-08df38a83fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 06:12:18.2565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB660978

V2hlbiBJUHY2IGZsb3cgbGFiZWwgcmVmbGVjdGlvbiBpcyBlbmFibGVkLCB0Y3BfdjZfc2VuZF9z
eW5hY2soKSByZWFkcwppcmVxLT5wa3RvcHRzIHRvIGNvcHkgdGhlIGZsb3cgbGFiZWwgZnJvbSB0
aGUgaW5pdGlhbCBTWU4uCgpSZXF1ZXN0IHNvY2tldHMgY2FuIGJlIHByb2Nlc3NlZCB3aXRob3V0
IHRoZSBsaXN0ZW5lciBsb2NrLiBBCnJldHJhbnNtaXR0ZWQgU1lOIGNhbiB0aGVyZWZvcmUgcnVu
IHRjcF92Nl9zZW5kX3N5bmFjaygpIHdoaWxlIGEKY29uY3VycmVudCBmaW5hbCBBQ0sgY3JlYXRl
cyB0aGUgY2hpbGQgaW4gdGNwX3Y2X3N5bl9yZWN2X3NvY2soKS4gVGhlCmxhdHRlciBjbG9uZXMg
aXJlcS0+cGt0b3B0cyBmb3IgdGhlIGNoaWxkIGFuZCBpbW1lZGlhdGVseSBjb25zdW1lcyB0aGUK
cmVxdWVzdCdzIHJlZmVyZW5jZS4gVGhpcyBjYW4gZnJlZSB0aGUgc2tiIHdoaWxlIHRoZSByZXRy
YW5zbWl0IHBhdGggaXMKc3RpbGwgcmVhZGluZyBpdHMgSVB2NiBoZWFkZXIsIGNhdXNpbmcgYSB1
c2UtYWZ0ZXItZnJlZS4KClJlcXVlc3QgbWlncmF0aW9uIGhhcyB0aGUgc2FtZSBvd25lcnNoaXAg
cHJvYmxlbS4gaW5ldF9yZXFza19jbG9uZSgpCmNvcGllcyBwa3RvcHRzIHdpdGhvdXQgdGFraW5n
IGFuIHNrYiByZWZlcmVuY2UsIGFuZCByZXFza19taWdyYXRlX3Jlc2V0KCkKdGhlbiBjbGVhcnMg
dGhlIG9sZCByZXF1ZXN0J3MgcG9pbnRlci4gQSBDUFUgaG9sZGluZyB0aGUgb2xkIHJlcXVlc3Qg
Y2FuCnN0aWxsIGJlIHNlbmRpbmcgYSBTWU5BQ0sgd2hlbiB0aGUgY2xvbmVkIHJlcXVlc3QgcmVs
ZWFzZXMgdGhlIG9ubHkgc2tiCnJlZmVyZW5jZS4KCkRvIG5vdCBjb25zdW1lIHBrdG9wdHMgd2hp
bGUgY3JlYXRpbmcgdGhlIGNoaWxkLiBHaXZlIGVhY2ggY2xvbmVkIHJlcXVlc3QKaXRzIG93biBz
a2IgcmVmZXJlbmNlIGFuZCBsZXQgZXZlcnkgcmVxdWVzdCByZWxlYXNlIGl0cyByZWZlcmVuY2Ug
ZnJvbQp0Y3BfdjZfcmVxc2tfZGVzdHJ1Y3RvcigpLgoKSSBmb3VuZCB0aGlzIHdoaWxlIHRlc3Rp
bmcgSVB2NiBUQ1AgcmVxdWVzdC1zb2NrZXQgbGlmZXRpbWUgaGFuZGxpbmcuIFRoZQpyZXByb2R1
Y2VyIHJlcXVpcmVkIG5vIHNvdXJjZSBjaGFuZ2VzLCBhcnRpZmljaWFsIGRlbGF5LCBvciBmYXVs
dAppbmplY3Rpb24gYmV5b25kIGVuYWJsaW5nIEtBU0FOLiBJdCB0cmlnZ2VyZWQgdGhlIHVzZS1h
ZnRlci1mcmVlIGJlZm9yZQp0aGlzIGNoYW5nZS4gV2l0aCB0aGlzIGNoYW5nZSwgYSAyMDAwLXJv
dW5kIHJ1biBjb21wbGV0ZWQgd2l0aG91dCBhIEtBU0FOCnJlcG9ydC4gQSBzZXBhcmF0ZSAxMC1y
b3VuZCB0ZXN0IHJlY29yZGVkIGZvdXIgc3VjY2Vzc2Z1bCByZXF1ZXN0Cm1pZ3JhdGlvbnMgYW5k
IG5vIEtBU0FOIHJlcG9ydC4gTmV0d29ya2luZyBzZWxmdGVzdHMgd2VyZSBub3QgcnVuIGJlY2F1
c2UKbm9uZSBkaXJlY3RseSBleGVyY2lzZXMgdGhpcyByYWNlLgoKRml4ZXM6IGU5OTRiMmYwZmI5
MiAoInRjcDogZG8gbm90IGxvY2sgbGlzdGVuZXIgdG8gcHJvY2VzcyBTWU4gcGFja2V0cyIpCkZp
eGVzOiAwNzkwOTZmMTAzZmEgKCJ0Y3AvZGNjcDogaW5zdGFsbCBzeW5fcmVjdiByZXF1ZXN0cyBp
bnRvIGVoYXNoIHRhYmxlIikKRml4ZXM6IGM5MDVkZWU2MjIzMiAoInRjcDogTWlncmF0ZSBUQ1Bf
TkVXX1NZTl9SRUNWIHJlcXVlc3RzIGF0IHJldHJhbnNtaXR0aW5nIFNZTitBQ0tzLiIpCkNjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFlpbmdqaWUgV2FuZyA8eC1wcm9m
ZXNzb3JAb3V0bG9vay5jb20+Ci0tLQogbmV0L2lwdjQvaW5ldF9jb25uZWN0aW9uX3NvY2suYyB8
IDYgKysrKystCiBuZXQvaXB2Ni90Y3BfaXB2Ni5jICAgICAgICAgICAgIHwgNyArKysrLS0tCiAy
IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9uZXQvaXB2NC9pbmV0X2Nvbm5lY3Rpb25fc29jay5jIGIvbmV0L2lwdjQvaW5ldF9jb25u
ZWN0aW9uX3NvY2suYwppbmRleCA5M2IzMDZkOTFiNmQuLjY2ZjhjZTI1YWEzOCAxMDA2NDQKLS0t
IGEvbmV0L2lwdjQvaW5ldF9jb25uZWN0aW9uX3NvY2suYworKysgYi9uZXQvaXB2NC9pbmV0X2Nv
bm5lY3Rpb25fc29jay5jCkBAIC05MzYsNiArOTM2LDExIEBAIHN0YXRpYyBzdHJ1Y3QgcmVxdWVz
dF9zb2NrICppbmV0X3JlcXNrX2Nsb25lKHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwKIAkJICAg
ICAgcmVxLT5yc2tfb3BzLT5vYmpfc2l6ZSAtIG9mZnNldG9mKHN0cnVjdCBzb2NrLCBza19kb250
Y29weV9lbmQpLAogCQkgICAgICAvKiBhbGxvYyBpcyBsYXJnZXIgdGhhbiBzdHJ1Y3QsIHNlZSBh
Ym92ZSAqLyk7CiAKKyNpZiBJU19FTkFCTEVEKENPTkZJR19JUFY2KQorCWlmIChpbmV0X3Jzayhu
cmVxKS0+cGt0b3B0cykKKwkJc2tiX2dldChpbmV0X3JzayhucmVxKS0+cGt0b3B0cyk7CisjZW5k
aWYKKwogCXNrX25vZGVfaW5pdCgmbnJlcV9zay0+c2tfbm9kZSk7CiAJbnJlcV9zay0+c2tfdHhf
cXVldWVfbWFwcGluZyA9IHJlcV9zay0+c2tfdHhfcXVldWVfbWFwcGluZzsKICNpZmRlZiBDT05G
SUdfU09DS19SWF9RVUVVRV9NQVBQSU5HCkBAIC05ODIsNyArOTg3LDYgQEAgc3RhdGljIHZvaWQg
cmVxc2tfbWlncmF0ZV9yZXNldChzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEpCiAJcmVxLT5zYXZl
ZF9zeW4gPSBOVUxMOwogI2lmIElTX0VOQUJMRUQoQ09ORklHX0lQVjYpCiAJaW5ldF9yc2socmVx
KS0+aXB2Nl9vcHQgPSBOVUxMOwotCWluZXRfcnNrKHJlcSktPnBrdG9wdHMgPSBOVUxMOwogI2Vs
c2UKIAlpbmV0X3JzayhyZXEpLT5pcmVxX29wdCA9IE5VTEw7CiAjZW5kaWYKZGlmZiAtLWdpdCBh
L25ldC9pcHY2L3RjcF9pcHY2LmMgYi9uZXQvaXB2Ni90Y3BfaXB2Ni5jCmluZGV4IGUwMDZhMzAz
NjBlYS4uMGI1MWNiNGFkOTYwIDEwMDY0NAotLS0gYS9uZXQvaXB2Ni90Y3BfaXB2Ni5jCisrKyBi
L25ldC9pcHY2L3RjcF9pcHY2LmMKQEAgLTE1MjIsMTEgKzE1MjIsMTIgQEAgc3RhdGljIHN0cnVj
dCBzb2NrICp0Y3BfdjZfc3luX3JlY3Zfc29jayhjb25zdCBzdHJ1Y3Qgc29jayAqc2ssIHN0cnVj
dCBza19idWZmICoKIAlpZiAoKm93bl9yZXEpIHsKIAkJdGNwX21vdmVfc3luKG5ld3RwLCByZXEp
OwogCi0JCS8qIENsb25lIHBrdG9wdGlvbnMgcmVjZWl2ZWQgd2l0aCBTWU4sIGlmIHdlIG93biB0
aGUgcmVxICovCisJCS8qIENsb25lIHBrdG9wdGlvbnMgcmVjZWl2ZWQgd2l0aCBTWU4uIEtlZXAg
dGhlIHJlcXVlc3QncworCQkgKiByZWZlcmVuY2UgdW50aWwgdGhlIHJlcXVlc3QgaXMgZGVzdHJv
eWVkLCBhcyBhIGNvbmN1cnJlbnQKKwkJICogU1lOIHJldHJhbnNtaXQgbWF5IHN0aWxsIHJlYWQg
aXQuCisJCSAqLwogCQlpZiAoaXJlcS0+cGt0b3B0cykgewogCQkJbmV3bnAtPnBrdG9wdGlvbnMg
PSBza2JfY2xvbmVfYW5kX2NoYXJnZV9yKGlyZXEtPnBrdG9wdHMsIG5ld3NrKTsKLQkJCWNvbnN1
bWVfc2tiKGlyZXEtPnBrdG9wdHMpOwotCQkJaXJlcS0+cGt0b3B0cyA9IE5VTEw7CiAJCQlpZiAo
bmV3bnAtPnBrdG9wdGlvbnMpCiAJCQkJdGNwX3Y2X3Jlc3RvcmVfY2IobmV3bnAtPnBrdG9wdGlv
bnMpOwogCQl9CgpiYXNlLWNvbW1pdDogY2IyODQ5MTRlNzQ5Mzg4ZWVmNDAyOTM4YmRiMzExNWZl
MWY2ZDMzNwotLSAKMi40My4wCgo=
