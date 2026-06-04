Received: from mibc-fr-09-outgoing-02.mailinblack.com (mibc-fr-09-outgoing-02.mailinblack.com [137.74.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAF369D69
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=137.74.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563939; cv=fail; b=rHJznTRep4/iTIcXYdn3rpfQ2xyZLY86pG7cMj1M9iwgOlfmY3Qe2kDThv3mMK1FAj1VDdKOaxX2nHubCHZQdpKdTBDNXmHMQYEFQdkO5QhLIBpPOyBjyFj/wTWdSWze3I/0mMjWbpLcxMQo0HYWdhA5R9H49vR7lEtdepDJhK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563939; c=relaxed/simple;
	bh=k3LzH16OrbyGKEBPpP1DYx4kevuK23l31VNTrZioCfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UyEnVshbMPWuvBPcnsvqR3Wdho0bBhhaSpV4nWH4W1I4coqJEsd07TG/QSSGYdvJDdZhCaIl18WOTmO2pMskM8K3S2fPdX01o45ZuyIP9/1bElIh9fETtXvxg1FIH8oeSPieGO7n5aDUUiaqgb0JoLeBXFIVGuUBiS7A374gEgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com; spf=pass smtp.mailfrom=leroy-agon.com; dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b=1X51EO3Y; arc=fail smtp.client-ip=137.74.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b="1X51EO3Y"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020099.outbound.protection.outlook.com [52.101.167.99])
	by mx-2-mibc-fr-09.mailinblack.com (Postfix) with ESMTPS id 960941F4007B;
	Thu, 04 Jun 2026 11:05:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVtyvmjjRjac5WM0jLNQwP5BJXrHaFAjZRWOfkWxmkk0yZdLH8kGihH0Lc/TqI6J/sau+krI7JZc6lTfE6xjGAJxs8GZ8r3xKP8KN5oWi4qmiXBJNp9f/WoAX7nfH9YVib4YaRojlysSymYJ4ABJWlf5/76+cr+tkFLEPX07KHgiQy70Yr3wa7xBPWYSiH4z5SpAh6fuycXZ99KHP0eO+RR8sHMDTITVoqJS0hnAiHimozrOTNKaMZxP/a70xnxXOlXimUiFiSBPeojA3E5st1nT07+Bui3hrVcHuoHbBwbcSGF3t7/X5niDgPIEUWTdSdUZkrBbDDdYveLzTBoKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3LzH16OrbyGKEBPpP1DYx4kevuK23l31VNTrZioCfg=;
 b=Knj/RTs8lZKPw7ifT5KGEGwTURTdEuM1munlkF+AChaBIF+xptw+Cgu98+1KXfiIweQWftfxZpKtzgRezNAVo8rQpkqumTFhsxt9e7xlSlM6Jhnfv560o/ReavFwkpZ0QPQQjooVbHInPpr1iidOF8KckqYoCYKngnYPPXh5X92RsJjEUxAUhrTCv0g+xjZy+ynoVLv6YK4EVjQv09nCxBrvWwFvEW87++yjWM6vChYHF4lJsket1Yxsnxc4kOOg5M0r/vIoklP0ODtdzjbrMGBH1ksIVlAtkEZQ2jdX8iAxfzoQKkaRFB0BTtCAQyIf8ev2DRMbFplBvTOLx0yLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leroy-agon.com; dmarc=pass action=none
 header.from=leroy-agon.com; dkim=pass header.d=leroy-agon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leroy-agon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3LzH16OrbyGKEBPpP1DYx4kevuK23l31VNTrZioCfg=;
 b=1X51EO3YD4GIGLNpjCJms0BOBqf5awQ2cxqNA4sy96aWmfiOz9SRJQgeFPICjejez2Qu+6XaZx7u5JVJZ3mHDq99N4k/k+mJgIHdWUkwg2pr6o0sE9UCeLX6OnJP5i2NMRKacJP2ewvrqnqMNU9vxLL2ilFbzjPU1mzWsK95F9kCDK/arr+0DE/V71SnYbDfpBX5WnXg6BZS22DcNr/LH35sgpT1nb1iPNPYEUE9RRiyIkRB5htZLs7QyctqRZiINerNvrXDkkRnLTL5Dvo7Onyd7xziJ0ys44zFOrrvl0kPP7oX0zNwJsbh4mQ1SGkX7HrlPcA3gOguWyugTDS6Hw==
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::24)
 by PA3PPFA3BF3FD55.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::678) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:05:30 +0000
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4]) by PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:05:30 +0000
From: =?utf-8?B?Sm/Dq2wgRVNQT05ERQ==?= <joel.esponde@leroy-agon.com>
To: Sasha Levin <sashal@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Topic: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Index: AQHc70+Wp1K41CMp+ka10OJNNdD4ubYs+JEAgAErZIA=
Date: Thu, 4 Jun 2026 09:05:29 +0000
Message-ID: <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
 <20260603105137.lan8814-qsgmii@kernel.org>
In-Reply-To: <20260603105137.lan8814-qsgmii@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leroy-agon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2688:EE_|PA3PPFA3BF3FD55:EE_
x-ms-office365-filtering-correlation-id: 490304c7-5932-47c1-26d4-08dec2186d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3I9BcXUCRcz9PwneqJ74R4G2PQWO2JvtgWPUd23NE+BXoY6g5Ii+2WSuVPJorpzc9/w98BnpOD/O+zB8f+fSRVzSFooxrzSjI1BFGICjAG4lXgWrHwNVOWdz99xH+e+NjvkkwDy/pPqSORMWohG60SH/++KOZUSgHitqWT6ah8eUDgeypt6hC//pXa8qtDX3r8I2zbK48ytgcKglryb9+zQeIY/O3VEbHGSySgX1nWLjEpaFFWcKrwVuHemgaWygmjgOYRB4MURPZ18qKyn/Snuw3kVMP7JrzU9TsBhhxuuGvpeGMt/L9SQxpOEpWnVulHn2vDGHfG0wWTTsnDjSZdfketK8GC+OX+gbeNrZrtV9beKQBU7qkSXlJlP6T1zZblYqfFSnD/d9L11HD6qqkGeJ+aSZcU385/pU+e6Fcp5kvReBe2tQ6d4Hss7WwDVNBfkEsCxo95wEKSH3k4OmTrojxpPUMHg0fF0LAswLUvgrqUlgXN9hAc7wVK69awMkdLkQBVGoarLA1uivcbXh+x8NqGzWMm3TrbD5Dz9J+RE2PF0eDt05uNXbnNZJnc+BufoL/lzi4GuTgjG14F8ltjkOgJKBvSWR/1kkWAgc6ABo54+qKTR4VekVdr1cFjPSKZ7L+aObMXNrKRoQ5gAfnTULHbfR3L27G7wF6GmuloXQklk4itp3MhDulKzlunGCqlyMJZwub6YkzfDbi4Ubc6WShs0DtMZU8wkre8fUek6g8pHWCB7v5UzAb3wHMPFx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rloyd3U1LzQ2RHYvUGl4STlFNGI3emNQc3diRzJiR0tCSkxXaE01Mi9KL1k4?=
 =?utf-8?B?dmFReVpjOEFqMFhseURHODF0ajZyR2VjRFBXMFhETk5iVjRPbXpjRGZNQ1No?=
 =?utf-8?B?S0x1N3ZIc3ZGL1BXd1Vkd3JuZG9XV210Q1ZHSGprR1FubW12NW5Qbm40Nng4?=
 =?utf-8?B?NlJYeXBFcVVqaFQ5KytZcVFIa1BseHh5S1RWbFJGTVZZaGMxTmU5SXlCYTVY?=
 =?utf-8?B?Mjc4WXdNRXFXbktTeDZyc3o4UDd3STRYWjNHUkdZSElEb1FUWUVFQXN2b1NF?=
 =?utf-8?B?SytaNy8rODRORnByTmcxQ05ING54YVFNVDFDaVFYTC9YVW9YZDRscHFOdWFt?=
 =?utf-8?B?RTJJazkwdWkyMU1HS3NwbHh5Wk9KeGRiWVdhQ3BuZVl6aXZEWk01TWZRTk16?=
 =?utf-8?B?QjhSNlJpK0FGSEkrdmJ0ZHJIVUQ1MTEwYVF5V1pOTTlxcjFVdENmcFp1NldK?=
 =?utf-8?B?R1ZxUWQyaTdKSlBYcVlGbmx3NnRnYTFiRGdxODBYVlo5VmVVWEpZYjVFckov?=
 =?utf-8?B?a3JTWTB2ZzArY0FDWVhNWVVCQnlSSzhHSk4rYmRhRDhkVTlyN1NpTFp0RGVs?=
 =?utf-8?B?Y1FycnNZdlpYVWNuWTM4YzRucnFFWXZZK2hyWGlha012WW5kbkZITVgyUm1W?=
 =?utf-8?B?ZCtvVi8rS3lsMDJqTHNvRWR4ZFJObGZjZzdhNUoyaEpDbUVrNTR1MHg1Q2RF?=
 =?utf-8?B?dlpZOGgxblNXT1VXL1h0NWJjcUxtSjJPQittMkxFNC9qZjNhYU1wSlpyTkZv?=
 =?utf-8?B?SExzbDQ1cUo5MlhoR3o2clZ2a0krNHNJbTRrTEN3cXZJUE5HaTZNVHpYVFdm?=
 =?utf-8?B?TFI4MmV4K1NuR3E2M2gxa1c4N0J5Q09LQ3ZZZk9iNXVacCtjZkIyKzZNL2E2?=
 =?utf-8?B?MXRlWm5jT20vTkVQSitIemFnd0IxM1Q2OGlYM0I0cjhlM21uNi9IakJGVWZB?=
 =?utf-8?B?ZVF6bnNZUEdnSUYxSzAxM05Xck0zS1dIN3N3ZitHenRmNjMrOC9PdmZEOHFD?=
 =?utf-8?B?VitHZGljdzB1QU4zd3hKaEVaaFgrMW9IcldSbWxpcE8vMTNIQ2p5Rnl3QXRt?=
 =?utf-8?B?bHlDMUhQS2NQRWxmbmZiUWd3VUVUSGtEZnF2bVVSaVhYYjU1eFA2NTJQWDZ0?=
 =?utf-8?B?S1JzTWRNQm1LRkxVNFNHMVYzd1g0amlPZ0JZaWtJU3k0a295bmdLNjlXeURW?=
 =?utf-8?B?N212NHpPWFJrVG5nenNOZE1LZ1ZFL3I0YjYrWXlJaHhZVkR4MkRYeWJza21l?=
 =?utf-8?B?OXg4dUY3ellMSlpiOFBzR3Q5eVprZkl6d1hTK2Y5YWhkK1hiVFpyR1YwbGdG?=
 =?utf-8?B?TCtKZVNPN1I5eXlJUUlmRkE1SFlWa3hyd2laSGVEbHhjZmc5cmhtbkxkaGpJ?=
 =?utf-8?B?SDBsenFRRStaVkorR2RGSWdBV0FjUUloL3dWeWQzWW8vUzlUMEE4Vk5tbmMz?=
 =?utf-8?B?NkFBUXF4SHdtWFpJa3JXbFRKVytoeE4rd0x4QzNEMW9KcFB4Z3VUYSt4UTBZ?=
 =?utf-8?B?Q2NQZTNWbCtGSlRYVjdXYVN2dzk3SFhzbG1OaitubklRamNURUdJdDU0dWFj?=
 =?utf-8?B?cVQvQmUxSldPOGlEYkVZM04vOUNPVGlMUFZpdkNMSHNvZk01UWk5K3ZkT29B?=
 =?utf-8?B?TzFuOWxxT1pMQXBpZ3c4TWRGc0xNLys3NCtYdkhmTDdLdEg1a0tjcmp5RUFo?=
 =?utf-8?B?eTVDYnhyTHBOeFppSDdvOE5wMEZwV2JBOVBZZ0VUYWRkMWFLKzJMMlRyd2hP?=
 =?utf-8?B?WGZjcDQxVVhhenVmUm1tak5JdXBhRUNpZHpYL0x1MFZzYkMxOE9SSWdOVWVt?=
 =?utf-8?B?M2M0bTRqNW5UVnRSSFJRZGZSVlJNdG5pYUppanJPZGdGcEY0bHRKREZFaUtq?=
 =?utf-8?B?dXFyT1ZIY0FSUkd6U0tmTjdMUXBUbTJzSE03OVNjdWYrZDl0dG1YUUtoZi9Q?=
 =?utf-8?B?SS9ZWEcrRXJvQmN5STRRa2hTMjRNZ3RHK0p5ejViYXFEN3JvOEt3a2l0cmlJ?=
 =?utf-8?B?QWRNRjVmaGZIU3RnRGFGdFY3Y0tZTU9YbStOcndlazlXMUpnM2JvNnBheVhC?=
 =?utf-8?B?SjdKNHVGcDZFRG5TV0NUQlFPcGtZY0ROcW5yc2UxYzVKSHNlOE5aTm5DdDUv?=
 =?utf-8?B?SFF2MkpRMHZacExpei81U2k0QzVKSlNKYWhiVE84SThHL0RtM0Y2N1Y2ZEpw?=
 =?utf-8?B?a1YxUktTNnZzcE1zb0UwVGp4UmJXT0tnYzVZckFaelpQSmZ1V1pwSE40TzZV?=
 =?utf-8?B?T1M4N21sOVgyVFpFMGJieHFUR0tTbHdGQXRib2UyY1RUOStSKzh0WmlxY0FC?=
 =?utf-8?B?N2tTd2VLNTlrSGxEWjk2dk4zU0xDZEw4NnppVVVjbGljWC9ieVJMdkp5ZHJC?=
 =?utf-8?Q?lyYH5YMucmPWUDRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3A5E5F133A41644BA6A55691895DF15@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	d9GvYql/JyQQoG+73nUCA2CvoajqBINIR5fUsItUaQvPUwkAXtGYebgxK93KKjPoATNCeS6Mi3RFMx30ELmZ0kBrxiWQtPUVUr8XQyfw4zzyrEvDxpcwM11i5KWhiCFsvDRz87i9fVhumt852ZRu/MwCQ1fpB3HUrYLJonO43zXEUxIHcX4gzXP+kP52klPVMP3PfhKZNZ1RTN3PpbbdM2d6C00+yHB+BqLlTULvpIsqNjXB7EMuZZMfe/2sKuAGSlj7435FzA4TFaSPU9pldv78pisWTtPtKcy85vBOMWyYHpG0UAaJjgSl+BhltbDZ+qSuzfX3WFMOeYoZQYx7nw==
X-OriginatorOrg: leroy-agon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 490304c7-5932-47c1-26d4-08dec2186d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 09:05:30.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b97cad2-240b-425a-b0cb-987a43def8d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /awY5G0xyzkvvZttwIJ5XAY0V5qYUC9PD+a5A9FWUGbuEufauMLFK+Bs3CfTsommlTUK4XBnsZNG7kpDNtbz+1MFqoly1nCAUE7kCjKDqZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PPFA3BF3FD55

Pj4gW1BBVENIIDYuMTIueV0gbmV0OiBwaHk6IG1pY3JlbDogZml4IExBTjg4MTQgUVNHTUlJIHNv
ZnQgcmVzZXQNCj4+IFsgVXBzdHJlYW0gY29tbWl0IGUwMjdjMjE4YzQ4MmM2YTBhZTE5NDgxMjlj
Y2RhM2IwYTIwMzMzNjggXQ0KPiBUaGFua3MuIFRoaXMgZG9lc24ndCBhcHBseSB0byA2LjEyLnkg
YXMgc3VibWl0dGVkOiB0aGUgaHVuayBkZXBlbmRzIG9uDQo+IGZlYXR1cmUgY29tbWl0IDE5ZjFk
NmM3MjMwYjdkLCB3aGljaCBpc24ndCBwcmVzZW50IGluIDYuMTIueS4NCg0KSGkgU2FzaGEsDQpJ
IHRyaWVkIHRvIGZpbmQgYSByZWZlcmVuY2UgdG8gdGhlIGNvbW1pdCAxOWYxZDZjNzIzMGI3ZCBp
biBteSBwYXRjaCBwcm9wb3NhbCwNCmJ1dCBJIGRpZG4ndCBmaW5kIGFueS4NCk5vdCBzdXJlIHRv
IHNlZSB3aGF0IEkgY291bGQgZG8gdG8gZml4IHRoaXMuDQpJIGFsc28gdHJpZWQgdG8gcGF0Y2gg
YSBwcmlzdGluZSBjaGVja291dCBvZiB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgYnJhbmNoDQo2
LjEyLnkgaW4gbGludXggc3RhYmxlLCBpZSBvbiB0b3Agb2YgYjViMzU2YWY1Yjk4LCB0aGUgcGF0
Y2ggYXBwbGllcyBzdWNjZXNzZnVsbHkgOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9sb2cvP2g9bGludXgtNi4xMi55DQpJ
ZiB5b3UgaGF2ZSBhbnkgb3RoZXIgaWRlYSBvciBwcm9wb3NhbCwgSSdsbCBoYXZlIGEgbG9vayBv
biBpdC4NClJlZ2FyZHMsDQpKb8OrbA0KQ2UgbWVzc2FnZSDDqWxlY3Ryb25pcXVlIGV0IHNlcyBw
acOoY2VzIGpvaW50ZXMgc29udCBjb25maWRlbnRpZWxzLiBJbHMgc29udCBkZXN0aW7DqXMgZXhj
bHVzaXZlbWVudCDDoCBsYSBwZXJzb25uZSBvdSDDoCBsJ2VudGl0w6kgw6AgcXVpIGlscyBzb250
IGFkcmVzc8Opcy4NClNpIHZvdXMgYXZleiByZcOndSBjZSBtZXNzYWdlIHBhciBlcnJldXIsIHZl
dWlsbGV6IGVuIGluZm9ybWVyIGltbcOpZGlhdGVtZW50IGwnZXhww6lkaXRldXIgZXQgbGUgc3Vw
cHJpbWVyIGRlIHZvdHJlIHN5c3TDqG1lLg0KVG91dGUgZGl2dWxnYXRpb24sIGRpc3RyaWJ1dGlv
biBvdSBjb3BpZSBub24gYXV0b3Jpc8OpZSBkZSBjZSBtZXNzYWdlIG91IGRlIHNvbiBjb250ZW51
IGVzdCBpbnRlcmRpdGUuDQpMJ2VudHJlcHJpc2UgZMOpY2xpbmUgdG91dGUgcmVzcG9uc2FiaWxp
dMOpIGVuIGNhcyBkZSB0cmFuc21pc3Npb24gZGUgdmlydXMgb3UgZGUgdG91dGUgYXV0cmUgY29u
dGFtaW5hdGlvbiBsacOpZSDDoCBjZXQgZW1haWwuDQo=

