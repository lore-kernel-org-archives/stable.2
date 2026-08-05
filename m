Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505516A395
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897799; cv=fail; b=Ua1oZzIMzWES8Fom0gD4wX0oFUY7I9JJB2yX4jyQxWJAlqhhtfpU8fnEy03mvOCgq6aHhlCOhiYCrzm4DFzTckSvC02weN9s+Yf/RCkh79W4wb5WObkmKGQHAQd5VnhQtYJ/ad7C5JLqV/F/taZVTE5tShk7dmlYseZsJMjbPVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897799; c=relaxed/simple;
	bh=1iFTX2TWA72YWdI2ylAQPtpVR+8AdVXlkOPbyGPymKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mQlr/2fPkZkie1rpqyctKSkrd7eufilTHrNm+Xm8/xvanzn9Q7ixhTY9+eFScRgs5HIPPyJseRqV/RMpck+NFxVvf+XHfGN/iOJApiFQdS1zQQk4mZf/OP2BQRJuC4cVwlTSVpN9wiu9+7Ds1wSF//DlfIPbeUy6RmEOg/H3bwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aRLmLxvF; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aRLmLxvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRycrGWLl3svj40r4kujPrQZOe0Dz9q+LsSJzJb4aAzG3/kA9qlKnCGmBlEY1GE2etsdbOBQ/iPd8f4+Hk/jQ5nNyJWKXMxvMFFHPdo3PuzKPaPZfmv3LDHkHJQVsYBl7meKf3OisxLQO/upf6cTOkQIGX07ClLUGClzZt0XKNThafYJbzuboLPVRWa1j/J/FUNecEbwSBGv7ulKg/QpHSxeSbX4iMe5Qp6Z+LXvU2frMOF4yCrnhsFb3c9O+36Fur90lbVibJOr8fl7muxYAHR72NH1fg+/QW/ZJODS+eNtcu5WQ9S981hkCWMw+El2reoSRSkAsaGYe+/OIGGqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iFTX2TWA72YWdI2ylAQPtpVR+8AdVXlkOPbyGPymKE=;
 b=haXaa4pEhbyIu2gDHUaSNrczNMGAC8eGQVPPuBpyS9hqRBFvf6Mkvg5eBdIE416mI6PKY+bm7KKUI2g7mHA7Av4JO8PpCK4Q/FVkSBVTBL8qxtmV0Ly6TGST966rrQAT0fslz78oidnbUP2MSOofE+DGBmdpmMM7UM5zr3iEYjqmk41p7yPYsltI3LTmBJ40lvOoHfyPU85G8a/YBIYTe267eiWmJ7rferjrMgVZWwT+bwoBujzYRuCNHyVPkXb9u79mlgs094cCsrQcvXA7w6IOpHI2m/CIQhnTJMznw88Da2TBn81fek6EfqF4zxX2dHQb129j2YIxSVBtgiDB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iFTX2TWA72YWdI2ylAQPtpVR+8AdVXlkOPbyGPymKE=;
 b=aRLmLxvFSiVz3hLq5/1BrBzx+gHNTWMbmJLk9terFLyjmekbeVPgmUz7qWy2LN6Dl53v2ZBA7SnnUyHSqc8ZgPhTT5+a4uEw7rE/vTkVYWHyZDUCiC8BibQPt32IiL6/QEIklaZbxKk9SG6tTxswrE9J0GsEShtkVIG1aImxmxJnIRQqiWd6l4p8oLEXZKqMJfpXXFDVK47egxDnOnkdeEpg85XyezVxw/jHyiWKkaM5Up0bEswUxknt4ezAzm58f3OsaBTqa3iAi2v/xFtO2Wp+KKGO7glwbLqg/iBxkN57tcLuONRSUx2Lu5VMfRB7TvAbPDaCFAV4sB+UNIKnBw==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV9PR03MB8438.namprd03.prod.outlook.com (2603:10b6:408:376::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 02:43:13 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 02:43:13 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y v2] firmware: stratix10-svc: fix memory leaks and
 list corruption bugs
Thread-Topic: [PATCH 5.15.y v2] firmware: stratix10-svc: fix memory leaks and
 list corruption bugs
Thread-Index: AQHdJALGwPZdMJ6sJUiuqUWKkN1U6LaOpzyAgAAZDYA=
Date: Wed, 5 Aug 2026 02:43:12 +0000
Message-ID: <0e069c96-02bd-4fca-87fb-8d561ef92e50@altera.com>
References: <2026072955-anatomist-verdict-df3a@gregkh>
 <3136c976de3cf030e1d9d96b38fb68fde3e0e5cf.1785842041.git.tze.yee.ng@altera.com>
 <20260805011008.stable-0009@kernel.org>
In-Reply-To: <20260805011008.stable-0009@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|LV9PR03MB8438:EE_
x-ms-office365-filtering-correlation-id: bee0df4a-3272-4264-99d6-08def29b4b46
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|10067099003|4143699003|56012099006|18002099003|55112099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 u1BLZYbrCd+AGQrPe9wnDBMeC2xVTWlOeIippGg7LxPN1C9Za39EjD1hbERlfkVU/k1gubacDSQsqI7J9UvepO+uBElsPqs5/1Dz0yersbM7eEfNo607Wi7fFf67tQ8bdgGntBOU1aXVEOgE5eSGvNGxKeybUUqCcH7OTVHVV9NO8BnjoYtnr4m5WBstmEb/hDJdnTvh9xq0HTVmWwW15UrezCuvLLckqIVaeAOYnyTy8nl4977S7qiEt3VoCn4hUi6NSZGSoaUbhqCpAl6HzmUCv10hzfjWwBehIDz1tI3BeKFEA+E86epYXsD6FldNcgkmiLdjWcb8QKfsgI3zPxp71zty2UazTN9as7lTSITCdp63yDeG8cZ7Ngebu2s4t9EU24oUd9HMCDX+nvL2TB83W9rW8OuiegtrU4e39i1/o2Fh7Z22LTIPLZVJ5kumEq/e3TSEJ+/PXBEW9jI0mVJk/FWpIKil3Qbo2HW7udbk1KZl/N0yFt/CY3js12kcE18kasq4S09lNMrSWt6nV6AOk7tx4MewTjiO3XdeKDvhepSWgfHyMjs9WSBfxuPp+1+er+t6zdXY0/ebFl0FSwZ/TyliLvQNrvDJiRu8VLsxp0M7qL6G9fyS40eI133RPaighIJ1rgRwJgiscvDDTt2skyvW/DnSzZLLf8W+NLcHmBlxos52cRiFRxrexh2ZMXl69EgP2QedA3XDzxKPf69/iyvZENWT8mIC5rkwaGY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(55112099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNvTC9YRVJ5Tyt1QWVyNWU0eWxTL0gzMjFWb0N5aWNyTXJaQ2VTdWxVUGUz?=
 =?utf-8?B?czZqaFhFckhZajhVNXZhZE9aano4YlVjaWp5U2pKUUIvbGc1THphdEpVSFJ4?=
 =?utf-8?B?MmxXOUpKc3h0Z1k5VG9oV1JWdEVhK3pnME9Dd0NMYW44Szg3c1hLRTFoRmwz?=
 =?utf-8?B?Tm1qQ1JRMERLWkRZdzltaGtETGVERnZESTYySy9meTdUbk55S3RSYVd5dk5l?=
 =?utf-8?B?azBnUTVaaDE2ZkR5am1MaC82S2VWQjd4dUc3SmxpeVh3OEQrNkhsNk5idjRq?=
 =?utf-8?B?dzZTY3ZSUDdWSDFNRmpydWtMWGZadVlTa0NTZ3lHYXRlWlU5SDBrOElGN2Qw?=
 =?utf-8?B?SWVDcThnK2cxK0xXZVIwbEJ6Z3RSVURNNHNReldjRjUrYkhPeTk2eENjKzlB?=
 =?utf-8?B?TnEralZJQndkcUsya2dFM1ZOTkx0N2Z5OXRIcFc3c1ZJVlVHM1JlYW9jaXBz?=
 =?utf-8?B?UElERDgrdWRlQXRHcnB1bDQ4QXRHMjFTM1JDRnFZeEpQTXVNOWJiMllrek9t?=
 =?utf-8?B?emt4SFBJdzByNHMvWkRPYWwzbHh4MEt4TWdrb0ZkLzhRL1NlVXQ0ejVocG44?=
 =?utf-8?B?ajdJZzdlNzc1SjFrVmJCeUJHdEV0MGpUczZLcmJyRkpmZUNuK25aT01QZ0R0?=
 =?utf-8?B?eElXeUJCZDZ3WUhpOVRXMCswQS94NGNsWkVhcW9CVlUwRFk0QURGTTExN2ZN?=
 =?utf-8?B?TjA1N1dobFpHRzVTUzBnS2N1bmh6cGcybTRtRHpHWmF1K2pGOHJDNGJSWWE2?=
 =?utf-8?B?R1Y4MkZSUkZHVytkdGFORWxzNXl2dzFjaEppeDhmQi92cGJoM1Q1dm5WMTdS?=
 =?utf-8?B?M3c5aFkvM0hFUkhwTzNFNitndTJyQnIxOHdyc05hV2JUMWhHdTA5RG9zZlh5?=
 =?utf-8?B?TnlzT2FacEVra3VhUmdRMjdJMkxrWFNsdk83YXB5ZUdoVU8vRGNNbUVCNUt6?=
 =?utf-8?B?c0FSRk84elE4SjYyU1RKZ1BQdjNxWm54L3hVYzhNZ2Myc3FiNWk4ZXpzNEVx?=
 =?utf-8?B?UlNjY1BoTEQvOTNGMUFZWGEvQng4YVFZNWJvakdiY1gvV0JSY2d2RG5sK04z?=
 =?utf-8?B?QnFUUEloMHZHMG5iN0FmYlp3NUlpSVQwOFd4dHhBOFg0cTJPSW5sY3g0Q3FP?=
 =?utf-8?B?Z2RLYlZZTXBPSFo2TytRU3ozUE45bGVUbGNoaDdKNzZoK1BESVRVa2NKd240?=
 =?utf-8?B?WXlsWXBTOU9ScjlyZ0xRcmZubFlmMWtiSHR4ZHM3MzRIc01Cb0RHclJiL3p5?=
 =?utf-8?B?amJ4eWV5Ym1VK2ZCMXIyekFsOVJlcjNoM0czcVEzcHNBaStXRVBLSFZ2SGMx?=
 =?utf-8?B?ZWRoN0p4T056NU5RVzY1UDQ3SmJCYS9BTzQ0QURYSjhTK3RjaFJjZWdvYm5h?=
 =?utf-8?B?N053ejhMQkhTaGl2UlB1NUZLVHVsOUlHNlNGTzFrVTlUajBlTENrWko5b0g5?=
 =?utf-8?B?cXdZK20vMXZTRE5sWHhQU1RYZmNsazByd2txUTg4K2JHTUNpRWZ2d25JbFlT?=
 =?utf-8?B?MHZ4V3BHQ0hqcGtuMjdiVVBqTUp0dGtmZGw5c1NuRFVBdGtGUWg0MDJvRS8y?=
 =?utf-8?B?b0FLMVFKdzVTeFRVWTJjam1UVHhKa2lsZWN0MC9NUHJyYUxtMlk5RzE5WVl1?=
 =?utf-8?B?dW1odzVUNUJsc2JkTldReTJnR0VzcWZBa1NFQ0pWMDI5SHd3SThGdTV4a2pu?=
 =?utf-8?B?VVRPQlNnQm1xKzB5Nm9NRGdpT3BPbThFbEtHNGppdlJQMEYxdjB2eVJOZVN4?=
 =?utf-8?B?OWpTMDJ1WnhFMG9WVjlTb2tEa0JUZTBETk45OUl6MXVzVjdDQjBwSGJMQlNQ?=
 =?utf-8?B?emwwRHRoM1p5Y09OOGUwQml0VUhlbmtNVTBTUkJZYzhSTUViejhGY3UxWHZG?=
 =?utf-8?B?SFhqWC81cGdhdTJWSXUxM256S0oxNUlHN2RjQWFabnRHZ21TK0hGd25yRXZJ?=
 =?utf-8?B?WU9JVno1UWNjN1NRVnZSNGdsM2hYK0xmS2FhcGVZcGorQ04ybjllTkZpZUFs?=
 =?utf-8?B?NkR6VUFCajBxT2sybFFGWWtySTM0ZTNGbHE2RUhHMklpcmN4dmVJSDlSZGkv?=
 =?utf-8?B?QnhkeE5zYUU3SXRHMlNqYXdJQWNtSkZoMG9GR0JJVHJiRjIxYk5LUnl5Ung4?=
 =?utf-8?B?WEZOd1c0ZERMaWlPK3ZEWmRxZE5qemtsUjI0RmNwZVB4YUIyZmo5QmV5bSs1?=
 =?utf-8?B?QzRiUHhOYzRwQUdyTU5SMWNKLzR5RE1Ibm9TQk9pQlJPTjM5ek5wcXR5V05Y?=
 =?utf-8?B?N1dRZSs4QkN3bmkyQTdtYlVlTEZiUTYwWkFwMmtSQ2lvYmYxY3doNm9hRXJI?=
 =?utf-8?B?c1IweVVZWUJQYkZ5SkNkV0o4VXdPMzRUZ1hFOEt3Y0J0MlJ1ZkZsVVZVNUd2?=
 =?utf-8?Q?/71EiETbzS+LroPY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EDA17B6E0903E4A851AB23C2ED98F7B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee0df4a-3272-4264-99d6-08def29b4b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 02:43:12.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LYqAv1TyuTuLF5k4w4exM6TrSUGPl07w/7PS/aRs3gc+5BHUKLRcpIcTczjf2iTFgUoVdQfL/HYFUbMIzu05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8438

T24gNS84LzIwMjYgOToxMyBhbSwgU2FzaGEgTGV2aW4gd3JvdGU6DQo+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gc2FzaGFsQGtlcm5lbC5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGlt
cG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24g
XQ0KPiANCj4gT24gVHVlLCBBdWcgMDQsIDIwMjYgYXQgMDQ6MTc6MDBBTSAtMDcwMCwgVHplIFll
ZSBOZyB3cm90ZToNCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIFJlcGxhY2VkIGt6YWxsb2Nfb2Jq
KCkgd2l0aCBremFsbG9jKHNpemVvZigqcG1lbSksIEdGUF9LRVJORUwpLg0KPj4gLSBEcm9wcGVk
IHRoZSBzdHJheSBndWFyZChtdXRleCkoJnN2Y19tZW1fbG9jaykgd2hpY2ggaXMgYWRkZWQNCj4+
ICAgIGFjY2lkZW50YWxseSB3aGVuIHJlYmFzZS4NCj4gDQo+IFRoaXMgbG9va3MgZ29vZCwgYnV0
IHdlIG5lZWQgaXQgaW4gNi42IGFuZCA2LjEgZmlyc3QuIEkgaGF2ZW4ndCBzZWVuIGJhY2twb3J0
cw0KPiBmb3IgdGhvc2UuDQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IFNhc2hhDQoNCkhpIFNhc2hh
LA0KDQpUaGFua3MgZm9yIHJldmlldy4NCg0KSGkgR3JlZywNCg0KSSBzZWUgeW91IGhlbHBlZCB0
byBiYWNrcG9ydCB0aGUgcGF0Y2ggdG8gNS4xMCwgNS4xNSwgNi4xMiwgNi4xOCBhbmQgDQo3LjEu
IFNob3VsZCBJIGZvbGxvdyB0aGUgc2FtZSBzdGVwcyBzaGFyZWQgYnkgeW91IHRvIHN1Ym1pdCB0
aGUgcGF0Y2ggdG8gDQo2LjEgYW5kIDYuNiBtZW50aW9uZWQgYnkgU2FzaGE/DQoNClRoYW5rcywN
ClR6ZSBZZWUNCg==
