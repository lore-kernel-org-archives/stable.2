Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7844E055;
	Fri,  2 Oct 2026 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945413; cv=fail; b=UDCy0BJQHxaYKDFf7kmN0NdeB8VC6b+ouCHVJXsqXwGQDeH5MrI36+stjBpi08+ouP4RIxKc8ThLtsw3Hel37GFx54CqqQ2S0DmpI5G5ek+7BFrQ3niiSeV+Ry2pArYRPmvqlGpx/JkPkzgG6pNrpAXLa9a0Xb4wr9iI8hOr4EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945413; c=relaxed/simple;
	bh=62VTQwp6wMQgEOrzcuHlVv2fYwkq2lN475psjh3WnEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdRcnOikfcx/icKAHSoO3/1CeGuLbkt4tVR/jC7duUlyqLRom7ep4xb/P63+ybgpBme8tFLUw7A55XFyKATCHL9JngpxgDWEWKdLvYZ+nZsqLd2eQjs/ZyRZudgfG2hSicI1BcWkocH9esZ4fVgfJlPAt5F1qSV1xWez6R/szVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=xnz+Ceac; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="xnz+Ceac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkZoYCHfzzyUddjAjwDJTJ9KywHp7VGy+XKL3lE8X7NO3MZbveI9QDa+htmzfyAtBHUK5snjLdwWiU/mQRTQqVH+GZp9Df8b3Vua4MywY2FvfFO5xI0kW0seJw12qIYp3DoScQDnCVVkbuJ3wBG5zXmAoPEqntAQDiIUvPimqRGlZOTYwI2gfgVMHeNrtAtXWzJolEZqD2Q/3QAJVgnVPF/YO/ViGjEcfxYq2vK1kzIUgtT/92IdXYnkbg40/LeD4olj4CMgXJ3CRBH2sWEe9SFyLEgPGDAgbaBHGITiKfVi69u1YsuhEQ5o45145rOPJsY22XA1E3hYz0zJpwzvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62VTQwp6wMQgEOrzcuHlVv2fYwkq2lN475psjh3WnEY=;
 b=CpzohrMgWNjr6wDp8q3HH5x12+kert8/glxsJXWECiKLMTPlnOjqWnByOjPtYJeCzxpf5zgWzvcUnJK9yaU3PkJIBqTZ8GLHIMJUB3vxlxgKsG2MiX03nA/tgFfcGIt5kOcnLRO7P9kOhRWW0oDFtY6Qmii3c0QkwekWlkshs3UBFiQlp+4GHk60epbIDU2VsUMUdC6fzdep3JZWVq8Z/owapSmBtniLKsw3m0FQwdMUmp1vL1YCjJ2uDGuURzMPxrjUphJKLIE/mBmA7MPafGrSbBfp5ZTKAclUzqOfSzeOm1pz96joj1nb+yd+dJQcjWvQfFA5tTKOrcwcdgZjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62VTQwp6wMQgEOrzcuHlVv2fYwkq2lN475psjh3WnEY=;
 b=xnz+CeacxSHiWT5WweMFChZo2pAc34HW0mUq+LsrflhhS9vVHc+bnle51ZEQTjQrW+I15iAL+uYCZZAihkMrtyQt49V0OG362Yc4LUvBC8lq8wBosYzzEDP92PglLDFXFwnBunVLXFkOgGs1TYzNg12xt5FxrUttsG69WWQymzJIF5GgXccQBP8LeYAiZJ+wGY9FHYTi8PzDF+Y689+9zekqblsdGMHY7BE/iUItSYu1t9kR/Tym4xSiY9nd54S6PNWhWzBlEOxQQfR69NAPfs8Wx7cUAjDs26e3xGSFatOU7djxgiycxMj9Z8IvqRklNhtqx4N9LS8fvr3ppayAOQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by GVXP189MB2749.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 12:50:04 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 12:50:04 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: =?utf-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Topic: [PATCH net] tipc: protect received keys from concurrent flush
Thread-Index: AQHdUNL4fDoo4smfgkOZ7OF8xZd6FLbqK6LwgAAJqACAAABNEA==
Date: Fri, 2 Oct 2026 12:50:04 +0000
Message-ID:
 <DU4P189MB375051910F8C241624FD6E93C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DU4P189MB37502D602C60A78B58AFDDA1C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
 <df6d6c550f8e7ed7bad690ae9c581645@oss.cyber.gouv.fr>
In-Reply-To: <df6d6c550f8e7ed7bad690ae9c581645@oss.cyber.gouv.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|GVXP189MB2749:EE_
x-ms-office365-filtering-correlation-id: ed6feb52-4c26-4b39-922c-08df2083ae22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 MKMucnvg+iLkuSli/92lPbl0g7BwZbWRKzqR89AFVX8zQK4n9gX74V7NWB/D7RGanA4kWZt/3cUVwLHnJWIq+ajDixCnyLhEU8OQDyI/UrI7rn4KbjD3nKzK4IntYhavFwOVq1W95xzkgjgFDPdtE2Oz4J8KRo5q9yB1dkO7bUNt9Ueieahx7q7yMLD/KjkljlPBU/2nq68g0HtEh9tBPZ0JtzFkGN2666JyF9L5MLIwGxNRyID/waHcORjUXwqkiBTxf6nsomU3fX26FvXgog2pNQxKNMnG0vj1Y9PUlVTgU7oBE4ArTV7MI3/Nu5Gv7T22/HUcdrdTNAp1SW3DHOUrEoKNGbJK2blpeFLQfsLnGIkxuXVcCpKa/qOW7a9Rbg5FZuSJOp8+884aeXteHXpwhyMEd4UpY2nt29UtyaSbPUtsSMoJzEfdqR6p/im4fCIL6iqv6ZgFy0BP1e/Mn+Jq7KMT9/yG4kQCQcO8uUwnu2SQG5maPyhCWWQYUbyUqCOK3mgRyKc5s8qyo6quaYv2hCzCDKM8wnJ2zZR8QVcyRM7fdp5AdlDd2Tks0bO++UzdgNsY5/RuUQ/Khk42LLH4PbQ4kfnUeHvpUMB4D2pRC1yKTUaE8H3ULpOafIiPxG4hwDQMkL4Cv3EP6uNH8D6BphrzJEhjtFvbUOxdxYZvQOM0SYEQX90fiNhbSJRrSlJMdbW5gBbwS76En+/E0V+eJLtf/wuEaYAUE/CUIBk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXloVFg1cURGVG85SzhjWjBvd0hrS3lkbk1IMU9YNWZXRjcrQlRSNWZRYjk3?=
 =?utf-8?B?UmlMVVVsZDRwMWRqbTczSnVWT2JNOEQ1R0pRWmE2a2lNT0s1WUdBVkhXWWxS?=
 =?utf-8?B?N0xtd2ZteC9LbDNsSytyYjhaaHgxa3N5dVoveGd2NEhXQTExTlp3QjFVVzVG?=
 =?utf-8?B?b21sZ0g3SUFPN0hlby8yeHpCbmR0U3l3WlBBMlNLakUwcE9ZOVRtYi9TNTdn?=
 =?utf-8?B?Wmc5ZU1jV0ZlWnNXSVlYYWlTdDZ2NkxnOXpvR004dXdBRXdsK3dHUDhudkxl?=
 =?utf-8?B?ekh4cmFwVHNJME9zLzJaaTFrOUwzSHdSekIxRjU3SE5wejhvd3ltM1JWWWlQ?=
 =?utf-8?B?Y0M5TDhhTEZ1aFpDRnJyZGdRREpUREtwZm1OaWpYMldTL1JOVHFsSkFJcmNz?=
 =?utf-8?B?YUUyQkNZRFlGYlVPbElVeTEveURwMEtEb3NoZHo5V25zbzlVaFEvUmFHUHNH?=
 =?utf-8?B?S3BVTmtocXRpNDVPTmNjbHJpeU10SXhMcmxhRkJsMWE3Z1d0VHZRQnRnRjUv?=
 =?utf-8?B?SFc2YUxxVDBnSkdSLzdwMVNyOUtpMTV4T01nMzZXbjFqSURjUXNCUGdKdUtT?=
 =?utf-8?B?T2ZiTzNzOWgrZis5cTQvazluWktQMnpKSnN1WmNVeHB3cGg5M2plYWc3RHJK?=
 =?utf-8?B?UWdHV0lrMkU1SXQ3UnptTngxa3Zjb1ZLYjB4NHA0WkYvV292N2ZzakNRVmdC?=
 =?utf-8?B?RWZYM29qdUtCRU83Q1NoRVdodXgxRkNwZURsdnNVVUd3UkxvVkJWTjJEQnJN?=
 =?utf-8?B?YWprZ3gvRG83L3o2SmpmUDhDdmVsM1JMak90NHRSbS9qZWdvVHM1ekoyaHor?=
 =?utf-8?B?R255NnFWVkkwQ0l2SHQyNC81empoVXc0ZFI0UUFGWkRoSjJUcWhyN0NYQVRC?=
 =?utf-8?B?RWJsc2FqRXM3Q3dpa0hPNTdlRm50Sm03U2pKMHlNaDhSbWVLVVlWY3h3UStk?=
 =?utf-8?B?Q3YxeTdBNFVOUDdzcDJGOEkzcjQzbFQ4aEdramh3cUtqS3hFZ25GdGdMTEU3?=
 =?utf-8?B?OUtuZFVuM0V4RVVMcWVkWGpubGtNZnUvcjlxMFFicFRSTGFwUVVXMEI3YmZk?=
 =?utf-8?B?VFl2VHhCWEtZdlpHMVNjSXFhNStDUUlXV1BZZkpMR0dHZDBZTTRJMmd2ZU5z?=
 =?utf-8?B?ZTFtYThvd01iR3BnRTlsamtieHJZMjJ2d0lwRW9STHplbksxUHVyWkpjSVo0?=
 =?utf-8?B?MmdDMFFPcmRzNVlHY1V3a0h5LzhLVmtZVlM0b2VXc2pDSmprSFdra0kwMWZM?=
 =?utf-8?B?U2NFM09MSzlxUGxrdGNXWTlmVTlmdVMyazM3UzFVTnZlNmwvYVRiYytsK1hw?=
 =?utf-8?B?b0tDcGkxKzhOcnAweDgzN0lQU2ordWVPZm04TGsvYWpRSHRacWNnSFUxZG5w?=
 =?utf-8?B?Y2RUTTk4VnN2ZlhWT3NGZ3hLS0tja0U4WVlDbTRyOFQ4ZVBmL0Q3WHZyQW1j?=
 =?utf-8?B?RWRBdkxEVW9XdzQybmo4R2hnLzBOMFM1M001cHpLSDY3eENYQURUdm9Sd3Ny?=
 =?utf-8?B?M0p3czF4S0tmbzloZFZLRXRVRHFGUm5lSFViM1kzWktPNUhVT0VQS2JUellM?=
 =?utf-8?B?eitvZzJiNDg3TWtzbkR2cytscENHcFlGSFQwQ1dJWWFqK0RxVVAyTGY0QWly?=
 =?utf-8?B?dnJXOFpHZk40UlRpc2xQNGs1VVlWN3JqZmVQdTJwdVhJVjJPc1dOdlY2NjFx?=
 =?utf-8?B?WGtnQUsrUWhucEhXeHZja1Z0ajdKTnh4ckdaUFFIRjhGUFErQ2o3SHEwRE9Y?=
 =?utf-8?B?anJlMDRTUFBUVEhkQVRRN2tGUENiOVVyK1dER0lTemtRVjNyU0YyUFhIc1ZV?=
 =?utf-8?B?MDQzbTJnOXZMSktiRklUY1Y4TWd6em9rOUhQMHJOYTM0MEFRZzRzdmtKS3k4?=
 =?utf-8?B?WHhuZHN0V204RnN6R3VQTDI2bFMvYWdzTisxTkxHZGlIbm9zV0Z3ckZEZ3Nl?=
 =?utf-8?B?N0lRWVg1OXBESjltT3N1NmpqUG1nTnF5RjE1aERYWStCWmVpZXFJZ1ZQL0kx?=
 =?utf-8?B?cE54NFZmRVZBWlBRa3Q2eVJWUE5iUElLd0t5VkM5VDBKY21JZHNmQkpNNDFH?=
 =?utf-8?B?eGthVUU4Z2NMZmN3NkRSUTZveVlMczh6akNjY3FPWWlOTEFEbERaV0RRWFZK?=
 =?utf-8?B?dnpHRExiNUZDcWRDSFlHSkYrL1pTOXhKNy9nN3QrLzJTTjJmbGU3U0hacHE0?=
 =?utf-8?B?Q25jTDRFdG5Vb09hU2I4SUtkKzdaMno2bk1vVzM0MW13SHZJaWx4cFpCeUNZ?=
 =?utf-8?B?VC9MT0Z5aFdMUGw0eGpiUzRQd0FpNXZWNmxaVWFNb1JDdzdVUlVZc2FXMjJu?=
 =?utf-8?B?dWVZNUtJUE9ad1VVQmszejd0KzhNQlBOaW9YaGpESU9YVGZ6T1BRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6feb52-4c26-4b39-922c-08df2083ae22
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 12:50:04.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZzoCTvi8CTxekcdGaI1ZQX5mHCZlN+zHy1Lm3cxyZjHA8H8FYnqh3Mo0cAsHSXv0+9504EYF02V1jKpQIUtlp5XBecq2a467DvlNJdmnVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2749

Pj4+ICBbICAgMTIuOTg2MDc3XSBCVUc6IEtBU0FOOiBkb3VibGUtZnJlZSBpbg0KPj4+IHRpcGNf
Y3J5cHRvX2tleV9mbHVzaCsweDQwMS8weDUzMA0KPj4+ICBbICAgMTIuOTg3OTM3XSBGcmVlIG9m
IGFkZHIgZmYxMTAwMDAwMjI2ODA4MCBieSB0YXNrIHBlZXIvMTEyDQo+Pj4gIC4uLg0KPj4+ICBb
ICAgMTIuOTkxOTM4XSAga2ZyZWUrMHgxNjMvMHg0MzANCj4+PiAgLi4uDQo+Pj4gIFsgICAxMi45
OTE5ODNdICB0aXBjX2NyeXB0b19rZXlfZmx1c2grMHg0MDEvMHg1MzANCj4+PiAgLi4uDQo+Pj4g
IFsgICAxMi45OTIxNTJdICB0aXBjX25sX25vZGVfZmx1c2hfa2V5KzB4MTc0LzB4MjEwDQo+Pj4N
Cj4+IFBsZWFzZSB1cGRhdGUgeW91ciBjaGFuZ2Vsb2cgd2l0aCBkZWNvZGVkIHN0YWNrIHRyYWNl
Lg0KPg0KPllvdSBtZWFuIHRoZSBmdWxsIHRyYWNlIGluY2x1ZGluZyB0aGUgcGFydHMgSSBzbmlw
cGVkPw0KDQpBIGZ1bGwgc3RhY2sgdHJhY2Ugd291bGQgaGVscCBtZSB0cmFjayBiYWNrIHRoZSBj
YWxsaW5nIGZsb3cuIE9mIGNvdXJzZSwgeW91ciBuZWVkIHRvIGRlY29kZSAoZS5nLCArMHgxNzQv
MHgyMTAgdG8gbGluZSBudW1iZXIgZXRjLikgdGhlIHN0YWNrIHRyYWNlIHVzaW5nOg0KbGludXgv
c2NyaXB0cy9kZWNvZGVfc3RhY2t0cmFjZS5zaA0KDQo+DQo+PiBEbyB5b3UgaGF2ZSBhIHJlcHJv
ZHVjZXIgPw0KPg0KPlllcywgSSBoYXZlLg0KDQpQbGVhc2Ugc2hhcmUgaXQgdG8gbWUuIEl0IGNv
dWxkIGJlIGdvb2QgdG8gcnVuIGFuZCBvYnNlcnZlIGlmIHRoZXJlIGlzIGFub3RoZXIgc3RhY2sg
dHJhY2UgYmFzZWQgb24gZGlmZmVyZW50IGNvbmRpdGlvbnMgKG90aGVyIGNvbmN1cnJlbmNpZXMg
ZXRjLikNCg0KPg0KPkrDqXLDqW15DQo=
