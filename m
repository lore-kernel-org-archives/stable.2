Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010041.outbound.protection.outlook.com [52.103.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D1399890;
	Fri, 16 Oct 2026 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119663; cv=fail; b=sBszSaxm0hyR1ALvfjKSwEmBhb0m1lf4WSH4uMb/2rlEGI0/7tM8XePzpa1VDrfGgdAV0UJDdGdz/23Kz38KhU84XKe6Dmv9VTlIp5ktPIuOBF9x5XUvslC9ShX3hVxRQkamlwBw3usLi9Sk+mH6aDyFEYp0TKTLM3IQ4j+Us3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119663; c=relaxed/simple;
	bh=jUHeXmA+t3XfymtZYAoCaxeUyJ6jkb8lgOP0smQIGNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZsDXyFMuZ2rDb+XqW2SVzzlYnJl5rQfNRsWMgfI4YWTaWpAdSXm934SI/pmQsQbFmYgPXLbV4DBQtysoxIOf9gTjT51xDV+alOc9s+H0sqleyWkvCKSp1C9h4JJE/mLYPokirREpiWbsqzcuV9m42DvjPxboILuVTUE2K+12Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YujB3vXV; arc=fail smtp.client-ip=52.103.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YujB3vXV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsQJLbFrWFoU/sc0orZEjoyxZa3pVsyLvx5lIDoYgHGJfO2L0h9qbhAzbqJVzd62oeKhpWmCxKYK7u2LTyFsbFzclvhMdaMneZ0T5Ug0Fgi+GpjGFaHUHjoxU7AedAHl7gO4Xq41HZQaoMleHcNpeup9iGgngYg5uvq+dGNwmid6qMCnmahJVRGzTf3zaobvfFLTBErxwBdXMY2Cl5HyXuKUYeP5V40GUl4jmb9nVy3Jr3cYqR63zWB7dHpZabQYzaqg2BDt4G/7qFKFfz5sGONa2jTWsSdhSsv9UgEEjHMtwrAmP1uX6CTs6MEtx38DSDBslhTN/LLIJUFFsTWhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jUHeXmA+t3XfymtZYAoCaxeUyJ6jkb8lgOP0smQIGNs=;
 b=Jtf5Ypra2eOVRDj/w63aLdg9mRRaPNarJdAT+W5VDDyqec+Pulv5kCRjPdzMQWuFEH0Lsw1yIDdAr4VLnO+/Bup4f+NIPeM7dL9TWkv+29+lRLtzNO0n7KSj64+A3fwzGBXgN9gw6pyAV0QuJH15Fez5r0iRvUdJcAcGnFtLYuLdo27R/+wUZmxISpoMmnkuzgrUc1JVfZV0DW35u/m/ouhEfWvTtEaYHy1nv7UGxa5eDTRiT39j7RLczzR7ZHnTCMOU8EWGsaVMwMOK4va5jhoKWL+MYcm4jXfTr9V/1FnkhYcNczUPVxpUmMOTr/CSYlGC5160VDdyB1ypwb82vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUHeXmA+t3XfymtZYAoCaxeUyJ6jkb8lgOP0smQIGNs=;
 b=YujB3vXVQBqtbcGSnbQAzGZvzQoBKVW9VjovAAgFhQTRXcZQHv07pg6ueo1AyD0ttHxNJWSDDo9oGH4wDbOPCCFm6u+JKe6t5qqD7kB02bf0374ii/SBpr8icCtKrKsTHA/zEA6qR8++M0qa1E1B6gt/SXypbIo7sJilQ02FCzE+s4XDrOIx2ipUfe0sjS71LN9XePGaOySyida14aIESKXvYR15OpatOcELYea6oMUXpIiZmgV6YVQondpbqMyXScHFZQactuSKrRKVA38riRSzsYoA32mUHAGHc70rdoDzvxWdwu0AJwf/DaHdn8Prznx89q6DVfZJoTlfsnUKKQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by PH0PR05MB8573.namprd05.prod.outlook.com
 (2603:10b6:510:a7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 03:00:59 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 03:00:59 +0000
From: =?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?546LIOmiluadsA==?= <x-professor@outlook.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/4] nvme: report synchronous passthrough copyback failures
Thread-Topic: [PATCH 2/4] nvme: report synchronous passthrough copyback
 failures
Thread-Index: AQHdXRqSeQ5EpPjphEOFmzg3jeW5yA==
Date: Fri, 16 Oct 2026 03:00:59 +0000
Message-ID:
 <da6955f4e5702e9322cf639f108be66e0ee49863.1792118770.git.x-professor@outlook.com>
References: <cover.1792118770.git.x-professor@outlook.com>
In-Reply-To: <cover.1792118770.git.x-professor@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|PH0PR05MB8573:EE_
x-ms-office365-filtering-correlation-id: d6a4be04-9ca4-4252-f3db-08df2b31b4ea
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpWGTxMtatzpld+Cz2zns/tXa262j7tK3VWl4x1jQ/jvzxLqmtfcZ2a7/MGwu0loleIwMD5VGCvFWNgFkzYImX5T5jZdarw3VyGCQbLExrOXR8bxVqUFXPjMM2m/fyS+OtJSW9RURJ0bKhUudVenve2CvZks6xeLqQzvQkLrC2hAOdUhG4f4R4BhdFQ1Hm4BuiMBaiibFXg6NG9htD6E4ZXVixT9AuNaUn1M7KNzaD4NrnNWguk6BzOP2AnHPvz1GC2b/GGPnsYmqvuMksd3dC0J4rCdSFy2M/xA11B0iUHZYrNeRkiQGtubV1mZuoZOiqWc4+Xr+BEmGqXHdHG1s0Dm8ZHiDKXk9c/wVvyI7XOAtp9gFMO1suDwDCKCrVjWVCKru3jKZ1cmuJd5CnAn54dVTNkcsVAoz1AWNKsAlTdFQ+QuXFG87DI20R3LoEq3gyTHfUYpq0oAKsAI+QhMRGxDEAXevyMKiGFb96XWRzQJZYs/kJP7J1gHOikigPrKns+D/HHxHs4vhpmWYhWuy5L3F55fX/t3S21oof1M0uwkzACq8N0EyTwc9BJsLIWDOtrIJkedfFdIGgEWjj4bmspRmEsp6Gkj/LoJpZfeaR2Z1EeBn57flxsib71/YGksTt6UP3ZTYSKppJVvT79B2FZwAmSICdqGJXM0t3s2jlvcmpFQpICekHWia0fpANuFMpE831MfK7DRoJiUjryaQk5QvChRtFHebQ8qveE6lLoVoj2OYwN1X1To
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|8060799015|19110799012|31061999003|6050399003|41001999006|8062599012|38102599003|51005399006|15080799012|40105399003|12091999003|3430499035|19061999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDNpOVpwcUsrUU9ucG03T08xNTMyZmVzRVZ0ODlWaXRIdHRBWnJ0U0pPVWxR?=
 =?utf-8?B?ZVFVbWZyUFRKU29iaGVzTlp1Y1JXUXhHLzVQc0pQcHBDSnJoRVNHL2lCbUVw?=
 =?utf-8?B?VGRJS0VxNGhZRld0MFpUMFlReDkxU2hsRW5wQUhLbjBEcWlMVFFyaVl2WE9Y?=
 =?utf-8?B?V2VVb09EbkF6UzdiM2xZaEdwbW9tckRpRFdsbEZqbGtTZXVGc25CczZQSXow?=
 =?utf-8?B?YU5pdTZkTmlZSTRWbnlqQ3N2OUNKbXVGd2R1TEkzcU5RYUtxc00xdThZdVdX?=
 =?utf-8?B?ZzFaby9abWQzWkVWdnFLWlduT2VlWHlaU05iK0cvUEpwSFdxNmRRQ1FxeEZK?=
 =?utf-8?B?ck1FSEYyU0N5aU9XSDkzT1pZVHplOXlTYjRkZlBXajlIekdqRGJhVkRZZHps?=
 =?utf-8?B?dHgzL3hNR2tlNlUxbjVkNW1vclhwNTNDc3BwdjZPc2ZSRGhYdFhFaURiTE54?=
 =?utf-8?B?ekhGRGhISEFTY2Y5SHlVaFZtc1RaS3B2SnlBQTErcGRzV3pVbFJneFNaSk9H?=
 =?utf-8?B?dGRtNUxSSm0yUXJJN2k5UUQzOG44S0w3T3FvM0pFdG4xeVlqUUpINjZvL2xT?=
 =?utf-8?B?ckI4NjYwU0svZmIvUHdjUTJyTjdZMmlhcFdkUUQ0NWZlV0FCd3Q4R1VkTU9w?=
 =?utf-8?B?SlJzWURtb3ArTzBpSmxJcE1mNXNzRE85NTRxRnBPMHlHRXhRc0JQNkp2RWJM?=
 =?utf-8?B?TDZ3a1h4NUxWK1hzNUNMOWRtUVkyZWdmaHY0azRlYWs4Q1RJOUpHM1ZKYVIz?=
 =?utf-8?B?MU5LanZ2QllsYmwxTVBjckJhakc2Z3FrenhoTk03MUtLRkFuQkErQzdMRWlu?=
 =?utf-8?B?UkhtUTZvLzhzTklzVjdlRkdOYVk3ay9JY3VmUFd5eitNb2d0bUZ2cmRlaEpk?=
 =?utf-8?B?M0dHdm9jemphaHdIOW5UVm5nVW50Y1FwYTJFZ3VFNnJLYlpNeXFDN2hCM1lz?=
 =?utf-8?B?L2ZmZWFGZk5DemN4Y1U4WGtpU1UrUGM5bEhEdGdGMWhVZDFLYWFoamhLSnJS?=
 =?utf-8?B?OGlreC9xTDNNM1hsN0pqOFF4YTg2NUpJcWw0bW1VSzk2OEl3ZHU3YzVwNU4v?=
 =?utf-8?B?QS9XaWhHKzVmSUUwV3VqM1FTZVU3YVZXaHRZbzVKbWY4RWd0YWFSWXBxdHNN?=
 =?utf-8?B?VEp2T1h6dG5MWm1oTm9TMGd3L1VJblVrRHZqQkl0blNLWWR4OHFJRExZbWgv?=
 =?utf-8?B?R2QvUVgyZ2N0MktVeGkyTXM1WWV1dDlmZG90a2RlUU45VDk4blYyQ1VMQkw5?=
 =?utf-8?B?YmdXekM3NDd0V3o2RmoxY1lkTEsxSVloTWlQVEhzeEx6NTJCZzdnSm55YUtV?=
 =?utf-8?B?cFVsVEFsdGE4MWRkTDkwYjZlRlB5UGxVQmFMelc1SmZXbjJCWkU2eDNxWGlw?=
 =?utf-8?B?MWp0ZnlaYTdINmRGNmFmSDBkQWhaWDFvTXYvWm1Odnc4UHpNRi9uR1dMNytQ?=
 =?utf-8?B?alp1MG1YOXJqYWRxQ1Y4MVFNWWU3RXBUV0orYWx3PT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDd0RGFTL1FSWEh3NTNFQXZtNHVBTnZteVQ3TDNHT293clU3d0YzV1dTdURk?=
 =?utf-8?B?cG0wYmVqdlZaUGdCTklpeWpFMEMvMUZVYkZZRUQveUlNLzZNbnFra0FpQity?=
 =?utf-8?B?Z0dsT1VDUmVja3g4MXEyRW1GUHR6N0N0cGowTVkvT0VQYVhWRmw0SFIvWTJU?=
 =?utf-8?B?OWcvRnYzVnQ3R3BJZ0xWck9WTHdsWTdnWVVHTDJoT3hRWXV0WHhjbnpNOXhV?=
 =?utf-8?B?V21jR1o0S2JhMGNvaXczRDhwTWo2RVJzeHFvRzdldVlwdi9SaXQxMWFJNHZ4?=
 =?utf-8?B?dTd0OVppZFp6cTlENEVpZENFcFZibW03dStvWlJWRzVySjh6eUZLNE9lUmlm?=
 =?utf-8?B?Vm1ZUU5yOU5OSmZWNE82VUV1SjM0QmdxL2N0YVo5VGdaZEs0ek5ESllKWU1i?=
 =?utf-8?B?STNiVkIrSHhZQlNwd2RGcGFVQSs5ME1lRmF6S0dSNjBmREdDckdORXRWUC9j?=
 =?utf-8?B?WUxvVFp0YjJTNVJuT3hVekpURVhiOVQ5NGh6K0ZRRzY2MEdNbFZNNVpMTVho?=
 =?utf-8?B?YzkwMW1RaXFhU3VaNFJxVGx3Q0dTNVJZTmhzSm83M1BpajVYSy9mQUJXQ1cy?=
 =?utf-8?B?eks5WDdIZE9KbmNpN3FIZEMwZVVHS01CMjBiUDVibWkwVXN0UGFPb3cxQTMv?=
 =?utf-8?B?eWJESTNzcjV1dG1ac0tPdUZkeHRuZVZzVVB6M1hkdXh4d2ZWdjhHTkgyQjV2?=
 =?utf-8?B?WklySXVuMzRQRHNUdURoc3VrMlVXQi9XaHd6ZXNNRnBycDBnNUczaEZ6Q1d6?=
 =?utf-8?B?ZXFjeU8wU0VoVFVmNmhUWGdKNlVicVVhUlZlMG9TeDZ4cUNlOEZUQ0ZjTHlV?=
 =?utf-8?B?TytadU1QQW5PNVMvYWp3U201dndrbHFUVGJBdzJ4YzN0OFhCZm43dTdBekZu?=
 =?utf-8?B?eGZaQkgvVnoyRDdjTzdEeHJ0L3JvekNaQ3hMSnJHOEhlWC92bVF3MWF4cmkv?=
 =?utf-8?B?TFNBbGZNY0RlNDhmWTBYenU2Q1psSXZNUVdHMGlkUThVUGtlK3VCZUdVRTZY?=
 =?utf-8?B?S05RTkg0K1dvRUxZR2tXN2dSSjRSTW10QlplbTRNZHNlbWlhUWdYZ2lTS25C?=
 =?utf-8?B?SUVWcE43Nk5aMjlpdEhMOS85c0hKbDNUMXI3VUJUd085cVlSalJuTlM1S1Fy?=
 =?utf-8?B?WlE0MkpFbTBRSjRzdTlOUmg3bGJaeGc2ZTJNM05oRjg0dmxnM2YxeTN3Z0Nz?=
 =?utf-8?B?QW1ubVM3R0R3Kyt4dHU2QTBIREk1OHFEVnBPNFhhK3Z4bzNJQ3o4M29kcXZK?=
 =?utf-8?B?b2VNR1pIZWwxMFRHUWUydjVlV05ZSUZmb09TSzdOaXlTWitWYXdMNDBEcFJN?=
 =?utf-8?B?KzB0d3lkUVF1L1I2UFRlQkJDVTVhOUlWNnpJcGI4TTAxZmFYb2dBaXlkOFJp?=
 =?utf-8?B?Ulhad3A5bWlUR2RmN3QvbS9aak5nVHJIaGJBbTAvdlRTU3AvUGpLKy9JZWpN?=
 =?utf-8?B?akx6TXJyVm43NGUwYkR1YjZHb0JwQTVrZTBER3hTVmlCTXEyby9nM3RWcFFL?=
 =?utf-8?B?OURNYmVXNWZYK2NQa2pENTRQMDFZTlpKaWx1OC9Db2Y0UElwMVo5b1dqdUEr?=
 =?utf-8?B?ejl3emcvRnVocmxhSytXMXZPNXdRZEcvcFZnenJqM01zQTFNbXdST0hxNGp6?=
 =?utf-8?B?RTA3Z0NJa2JpYXdrS0c4U0o3Yjh3NDJpLzFzRHowbDRJaDhCUUdqcU84S0U4?=
 =?utf-8?B?ZExjNGtCRVY0UCtOMTVQUzdqQWFWTzh6NUpNYmc4a0NpWmRBUjA5dWwrcWY2?=
 =?utf-8?B?dWNsUW9PQUdGNVNnRmVvUkxkL25tankybzBmbFQ2d3VCbmt2T0dZbnhjUFZj?=
 =?utf-8?B?bEI3bDFxblgvaEZPTmFKL1NjME9yR0VaTitsc0RtSTNBOGZ1aG5nUzFlYzBJ?=
 =?utf-8?Q?A1LH+nlJB8u7V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a4be04-9ca4-4252-f3db-08df2b31b4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 03:00:59.8013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8573

bnZtZV9zdWJtaXRfdXNlcl9jbWQoKSBkaXNjYXJkcyB0aGUgcmV0dXJuIGZyb20gYmxrX3JxX3Vu
bWFwX3VzZXIoKS4KRm9yIGEgc3VjY2Vzc2Z1bCB1bmFsaWduZWQgUkVBRCwgYSBmYWlsZWQgYm91
bmNlLWJ1ZmZlciBjb3B5IGNhbgp0aGVyZWZvcmUgbGVhdmUgdGhlIGRlc3RpbmF0aW9uIHVuY2hh
bmdlZCB3aGlsZSB0aGUgaW9jdGwgc3RpbGwgcmVwb3J0cwpzdWNjZXNzLgoKS2VlcCB0aGUgcmVh
bCBjb250cm9sbGVyIHN0YXR1cyBmb3IgbnZtZV9wYXNzdGhydV9lbmQoKSwgdGhlbiByZXR1cm4g
dGhlCmNvcHliYWNrIGVycm9yIG9ubHkgd2hlbiB0aGUgY29tbWFuZCBpdHNlbGYgc3VjY2VlZGVk
LgoKQSBvbmUtYmxvY2sgUkVBRCBpbnRvIGFuIHVuYWxpZ25lZCBQUk9UX05PTkUgZGVzdGluYXRp
b24gcmV0dXJuZWQgZmFsc2UKc3VjY2VzcyBpbiAyMC8yMCBydW5zIGJlZm9yZSB0aGlzIGNoYW5n
ZS4gIEl0IHJldHVybmVkIC1FRkFVTFQgaW4gMjAvMjAKcnVucyBhZnRlcndhcmQsIHdoaWxlIHdy
aXRhYmxlIGNvbnRyb2xzIGNvbnRpbnVlZCB0byBzdWNjZWVkLgoKRml4ZXM6IGQyOWVjODI0MWMx
MCAoIm52bWU6IHN1Ym1pdCBpbnRlcm5hbCBjb21tYW5kcyB0aHJvdWdoIHRoZSBibG9jayBsYXll
ciIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkFzc2lzdGVkLWJ5OiBMTE0KU2lnbmVkLW9m
Zi1ieTogWWluZ2ppZSBXYW5nIDx4LXByb2Zlc3NvckBvdXRsb29rLmNvbT4KLS0tCiBkcml2ZXJz
L252bWUvaG9zdC9pb2N0bC5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaW9j
dGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMKaW5kZXggZTQ1NTcyYmM4N2QuLjliODMw
NjQxYTViIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCisrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2lvY3RsLmMKQEAgLTIwMCw3ICsyMDAsNyBAQCBzdGF0aWMgaW50IG52bWVf
c3VibWl0X3VzZXJfY21kKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLAogCXN0cnVjdCByZXF1ZXN0
ICpyZXE7CiAJc3RydWN0IGJpbyAqYmlvOwogCXUzMiBlZmZlY3RzOwotCWludCByZXQ7CisJaW50
IHJldCwgdW5tYXBfcmV0ID0gMDsKIAogCXJlcSA9IG52bWVfYWxsb2NfdXNlcl9yZXF1ZXN0KHEs
IGNtZCwgMCwgMCk7CiAJaWYgKElTX0VSUihyZXEpKQpAQCAtMjI2LDcgKzIyNiw5IEBAIHN0YXRp
YyBpbnQgbnZtZV9zdWJtaXRfdXNlcl9jbWQoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCiAJaWYg
KGVmZmVjdHMpCiAJCW52bWVfcGFzc3RocnVfZW5kKGN0cmwsIG5zLCBlZmZlY3RzLCBjbWQsIHJl
dCk7CiAJaWYgKGJpbykKLQkJYmxrX3JxX3VubWFwX3VzZXIoYmlvKTsKKwkJdW5tYXBfcmV0ID0g
YmxrX3JxX3VubWFwX3VzZXIoYmlvKTsKKwlpZiAoIXJldCkKKwkJcmV0ID0gdW5tYXBfcmV0Owog
CXJldHVybiByZXQ7CiAKIG91dF9mcmVlX3JlcToKLS0gCjIuNDMuMAoK
