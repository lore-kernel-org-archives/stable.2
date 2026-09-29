Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022085.outbound.protection.outlook.com [52.101.126.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E903EF0D3;
	Tue, 29 Sep 2026 03:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652409; cv=fail; b=C7wTqt3QZQ0+mdPDdkUEmlujJ3n8CnIXqyCLhIGaSN/ggND7C1PgkBgPjeCPfmBoQbU/offigv3gJhdQ2mH/MiK3lmo4t1MuH5Vo3TS1NTwkDcq5Mumb5CO4lYa9DzWlVkq5IO9hZmDHCA3I5rpohSesmDfZmZPV2/+5a9wLFEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652409; c=relaxed/simple;
	bh=tbPpjIgRCEQ6NfiDWPqvdplS7Uxz7Ynr7zV1HVEmFy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tHjQrcj3z7I9Tc8fq6Ug/Wx5CapN7RwHVZKNeYSkCi68zekqQ3IVhKfDPJfVBrppngNmGaDXvrVMof9ZI/ewe0vDFAXOp2M/CXGi1FYfpmYdEfuNgyUgK29CCwPwufbnauS/Oyzd/7zsa1EN1DbePfw33rJ9wBu05uWfxLUybeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=EXROSext; arc=fail smtp.client-ip=52.101.126.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EXROSext"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygg+K6HIhnI6X6mdVPj1teZKSfZJn2P2bB+Ev0pIfQVNQGU+zezXsi5VactZaxo6+3IsDyV0KAASDQGBXN7N9epCtRsGuVeVg/WnyeR0+6L9fE2XTBWr+P6gJpbZVT/0D5c5AUBYRTXRfJQ64P8o87yaRUs8tZ+6pGuBantnlLTpHmOPsZXJCIxEpzzB5v1aBd6HoZvpMxFfX2op+hG+G+KxSEH6XwpJCIRRlFCZvA1uy50dRNgxbqfQSKIJczRwhQ/leXGomalYwn4HtNiP6C7W/0/EtOJtvJ/z8gD1VEAYM4R4wg9Laan4zNNF63qjwJoav69NuE8PrD0ewYl04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbPpjIgRCEQ6NfiDWPqvdplS7Uxz7Ynr7zV1HVEmFy4=;
 b=XwI7nbZzC6LXuCCtmKhvGAfd0de5/sW9F0WLRQ9uPqL/XVb3uHjd1spX2RZKIRUKCjZ4H2K4jcGLy5Iy9zcCZ43h59VB62pv+ijpTPuxvY48ULVnRF45w54H5oz44JcI7ws5U+pl+o/JeovNs04vjAakQjj+f7u1XUXCpmh/7lJz0TYwGayxVj1H8xEBV3SDRJOkgjDqhT/kuoP57ThgpPq+IXT5VgHpWtYSAHTKTkdHKKPsrZIsD29dCNyp/4JawBNAjXD7CT3Qwe1WfU6EhaeuSw9kPFyjHkx4s51lCJ6DK+ksSdbE96yyKVTtk1Qry1b0JlyT5VbdOlE2SVGlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbPpjIgRCEQ6NfiDWPqvdplS7Uxz7Ynr7zV1HVEmFy4=;
 b=EXROSextef+k6tP+n4y47G5jx/GCGbRENJBZ7Y8pE2nih1UauVC885opVup7k7sq0ForeDBmBU7EfDS73HCImyu5o1au6f+uByPE9uiM9eBMl/rhNXO0MswOPg6MDT4z3qNBIu0F7QRU/xrfPZUPRnpTewS/kBB3dVJEfLPw7Cn6/wPSPtAS/VnJ+P6EIejueeNnlBadFGB2LhCgzFL8ScOHb/auTWi7FaxppVBGddkLPQNXa31JzZ9EeB6c8PPN52JYZKGWjy8L8mSCc4MYeP8uUTDe7LRqaTwNW3rcPeL92L0O2aG9x5dzI/DAHLXYFP36YIoeJPSyyNV5sogiaA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYNPR06MB8999.apcprd06.prod.outlook.com (2603:1096:405:3c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:26:43 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 03:26:43 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Borislav Petkov <bp@alien8.de>
CC: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdRZyFCcJDuw2op0azvEk4NXStz7be1rUAgAYimjA=
Date: Tue, 29 Sep 2026 03:26:42 +0000
Message-ID:
 <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
In-Reply-To: <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYNPR06MB8999:EE_
x-ms-office365-filtering-correlation-id: c72ec4b5-eba7-4ebe-1e0d-08df1dd97bb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|38070700021|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qW2Wwdcl6S5ZE7jhp21B+xcq+k80mnE7QxALxzj6ZjYoYmF6qVvS+9EIfxN23N9PpMdnj1diFjTQltVdsLqzSNHP+MHVRndqX7V40Aa/jFTSeqxy6V/9GQmmn0isny3ZhyCv8jxlpLWusPBAZZGhva84+u+B7Je+AvbBCfLlan/SAOU/mqtB3RmaPU5RTgUmmXnXhX9znHVgzCAFTzD9AneYYOhSDpSYDdS5VFTIa9aNXwn6P/i94C36oJJLac7fNAhXu2Q5cLnj/Dq/bgslCLBtdsQoRTKUXQ4ke5ZU+aSUsDGtnWYinW1SC5oextKc9CctAaNoB9IVUc0AqxOK1TMaOH2llCzc5mqyA+cyM0auvyDdQxqty15UZd/6FtNQ9Dz3iKB8UQRVfW8IvyMK+njF3T1JRZp0pDTQuAGKiRXHnghhlIy44BMm2ZNOsW0wZqQ3hs7FJ9nWaPMylas6jY07aTMOwnjGVTGncRu/9zKl3r0sPuMOCzzpB9ZY/LzGjCqgceuu3aBZ3SZ+X7N+C8hdcCt2mmnBSm3LMYpP6qxXTDDc6dEr5sTWJa9rv60Opos3fUCzxK8+MNRYrEGmoFHAnfUAfmafTSaca5Lsa6qSOWjx8uOH1AdjiVFCbp+V9w6jKsWLY4XZo51Jw0IgZ5858qos+u9HEqZylGlVVmZ0Rh8zwl0JdJOlm9Tn2m7s823hei8U/r6CtwP/bY9yLVwdkNXDhbAC8w0aPw7ubtw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(38070700021)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTlVdWVsOE5jZXpwNm43UFMvaWZxekZsUms0RlFFc3l5WGhPZGYrT1lzN0c5?=
 =?utf-8?B?NXJETEhiME5keWkxVjJuQ2p3SG41ak9oeThZMW9zUFBYYUZmTkpWZFV1VjR5?=
 =?utf-8?B?NDJveEs3SHJUTEI2eHQ1R1VCZ0kwY2l3a1VvcHNmZjZnZFJocHdSNituOUZY?=
 =?utf-8?B?Sk5Tck5rVGtSK3dteVYrZkFEZnk5cEJLK3RzUUJlYkN5bGFRQUl6bEdmdnZn?=
 =?utf-8?B?RGRjUUdDajRYL3lUYUFPcWxGalRXSUhKVzV2M3ppdVhzbEwxRnRaMFJjMXBT?=
 =?utf-8?B?d0VtKzRzNHN5OFo1UzA1NDBCTjJicFU1U0w3R3ZYTHF4MlFmekVHd2ttN0Fm?=
 =?utf-8?B?T25wQzdwZWxlRUlHRFVnUlhGR3lvcW5VZjFlZGNGSzFPWHdWdVNBVWVGeERN?=
 =?utf-8?B?VlJnRDBpaUtIY0l3Q3ZRdTU4Y0NJMDNGY0JaaEVEWDRibW1LREtyZ2d5SDMy?=
 =?utf-8?B?YmE0d0pNSW9oRElxMS9rZ0cxRS96YlRzbG43cWUweldEQ0JTMUxpZUlMVWNX?=
 =?utf-8?B?T0FwVmJmNTVqSEUyTHFhcGZIcVhPSmxlSFdMS0JHRkRjVnF5a2p4MkluNVBB?=
 =?utf-8?B?UkNvbkQ5V1lmZGJoamIxOFY3NlN3U0hrazNiWkpMc2l6ZEc2QzVuaFQ2UE9S?=
 =?utf-8?B?dXpCR2Y0TlJ5d28zL0NyTWNRYUlvU003enh6RlFERmNEMmJxNTBXcWpaTTZT?=
 =?utf-8?B?RFgydTJHem1WNlhnMy9CTnA1dDdpNjZNSGpiUDk0Wi9MMHM2cWVjaWwzSHdN?=
 =?utf-8?B?VWtwdXRVQnFHRDdyVDFLZEluV1Q4SVg3b1Z0TFVZZERNeFo5UWZkYTdJYzFB?=
 =?utf-8?B?S2hybDBBa29DbXFLN3dNVDhxQ2dmQXNJZkNQYTVaZ0lRNUVHSWFJOXVNUkZj?=
 =?utf-8?B?TGVmcjhkenB0RW5qeW9IdEV6NHJoVlg5NEZaUDk1R3IxSlJoTWp6RThGYUJE?=
 =?utf-8?B?WjVnYzV2Z1B2QW5BWmJoc2YvMi9BbzUzSGIxQ2Q3QnFZK05hQXBzNzcwVGRw?=
 =?utf-8?B?eGpFbVpWZ2RBT2w3aWVUQngwSW5ydGltb2htY1RrUDZKWGkybXg0T1kwN1Zw?=
 =?utf-8?B?WmorMTlRaGMwWXZjN1FUbGdjVDZTNVpDRDZyRUljTVYyNVlPNlF2d1NOWjl1?=
 =?utf-8?B?VHpPVU12am9JUWdkZkpGblJZTy9lQmdaRGpvZUJUbnlndnpiQXMrZjZuK005?=
 =?utf-8?B?dzRzVzAwY0EvUEJDMWpLTG9pRFlNS0dCSFZ4ZE5GMVFHSE12NlE4K2xSSWRB?=
 =?utf-8?B?V0NsTmlDWmlla041eDNpUSsvTjFpaVFoQUt3ajBmMlFJbGhhalNYc1phUVZu?=
 =?utf-8?B?WXpVMUkra3U3ZTMvb21pbE5UVG92YUR4RHplUFFVdVpQWGhTOS9JZjA3V3g2?=
 =?utf-8?B?UEV5cVRDUzN0Zm9nUzdSMFhDbVZnR1N0SXA3R25ycEtkQXJ1OGUyTWMyekVW?=
 =?utf-8?B?WGZnbHh1YW00cVlpWWNvODRXS3gzQ3lZWWVnSHViVS9pbUZuUDJLSTBWUnZ5?=
 =?utf-8?B?WlNCb0VKVEQ3WWUvdG5IcTRFUmJwUENjNGE3bHdqZWFjdmo5eFROZU9Mckty?=
 =?utf-8?B?SjlIcG1CbTZtVmZkTWF5SThZaTRTZCtBQW5WcXk5MElETG5xTXcyQUt6OExo?=
 =?utf-8?B?NjdibWZBdW9QMVRqYlBPeG5EUmRsYUM0MmoxTnM1aWtabFIyQ3h2SUFpOFh6?=
 =?utf-8?B?OUF3TDQ0UFJkZzkzck5GaDViRTlBeE03WCtsSzhTUFZLNjdCeUdoMFpxZDFr?=
 =?utf-8?B?U1c3ay9xY3l6TGIrN2JDYUg2S0NnOHlSYWtlVmo3OUNLUE5QTFg2MzBIQUMr?=
 =?utf-8?B?T1VYcEQyRTk3N2M1Q0tMZ0FkWWJoQ3JLMThWK29QenF4cXlPcTNzV2NURWlx?=
 =?utf-8?B?ampCUmU0Q21oMFRuUjQ4cUREdXRXK3c3WDRYSWlnTHdnc3ljeDZjVk5XbUNx?=
 =?utf-8?B?ekFSSm41ZGh6dGF4eWlpc2lWTGxOMXQ3ZkF5aW91U09aTEQxRGF4NUZ6M3Qz?=
 =?utf-8?B?Ny9iTEsrY0tKME10VC9DYjVTS0M2RWJSdERtS04wQkxJMVl4R01vWlNQOUlZ?=
 =?utf-8?B?YmFsSnZGQVFOL2ppWU96VFZxNDlWZmRIR2swVGFIenZLVy9COFREcjBYZDhs?=
 =?utf-8?B?SmRvS2dJVzJvdSt0cGpFMDlyUnFzYTlHQkRtamVVdENVazJyZCtsbXhZQ2NT?=
 =?utf-8?B?OWdzWW1xdG8vLzRQRXM4N2tOWFdWbEsrVnMyM0R1TWRjNU1JNjhMelR4aHFh?=
 =?utf-8?B?RkwxeFhxdTJvMlJHTS92V2pscVZKT2EwSlhqZDhDZS9BcndwSmVHVWc4ODkr?=
 =?utf-8?B?Tzd0V2Y1MGs5dEl2Q2xEV2F6SU5wcUhjSmEzNStUTUMybitwb0tEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72ec4b5-eba7-4ebe-1e0d-08df1dd97bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 03:26:42.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8epU82AFNkKzIuNRXhIQy1wNheUY1tNkX/cC5axbYvQc8z1wLKL/jnAx+p0GHc6R5flvdamBzugPZAriRWXUDbxj9Sw95rG/zZCsb/zshhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8999

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvOV0gQWRkIEFzcGVlZCBBU1QyNzAwIFNEUkFNIEVE
QUMgc3VwcG9ydA0KPiANCj4gT24gV2VkLCBTZXAgMTYsIDIwMjYgYXQgMDE6MzA6MzdQTSArMDgw
MCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+IEFkZCBFQ0MgZXJyb3IgcmVwb3J0aW5nIGZvciB0aGUg
QXNwZWVkIEFTVDI3MDAgU29DIHRvIHRoZSBleGlzdGluZw0KPiA+IGFzcGVlZF9lZGFjIGRyaXZl
ci4NCj4gPg0KPiA+IFRoZSBBU1QyNzAwIG1lbW9yeSBjb250cm9sbGVyIGtlZXBzIHRoZSBzYW1l
IG92ZXJhbGwgRURBQyBwcm9ncmFtbWluZw0KPiA+IG1vZGVsIGFzIHRoZSBlYXJsaWVyIEFzcGVl
ZCBCTUMgU29DcywgYnV0IHVzZXMgYSBkaWZmZXJlbnQgcmVnaXN0ZXINCj4gPiBsYXlvdXQsIGEg
c3BsaXQgaW50ZXJydXB0IHN0YXR1cy9jbGVhci9tYXNrIHNjaGVtZSBhbmQgRERSNC9ERFI1IG1l
bW9yeS4NCj4gPiBSYXRoZXIgdGhhbiBmb3JrIHRoZSBkcml2ZXIsIHRoZSBleGlzdGluZyBjb2Rl
IGlzIGZpcnN0IHRpZGllZCBhbmQNCj4gPiBnZW5lcmFsaXNlZCwgdGhlbiB0aGUgQVNUMjcwMCBp
cyBhZGRlZCBhcyBvbmUgbW9yZSBwZXItU29DIHZhcmlhbnQuDQo+ID4NCj4gPiBQYXRjaGVzIDIt
NSBhcmUgYnVnIGZpeGVzIGFuZCBjbGVhbnVwcyB0byB0aGUgZXhpc3RpbmcgZHJpdmVyLg0KPiAN
Cj4gWW91IGFsd2F5cyBwdXQgdGhlIGJ1ZyBmaXhlcyBmaXJzdCBpbiBhIHNldC4gU28gaXQgc2hv
dWxkIGJlIDEtNCBidWdmaXhlcywgcmVzdCBuZXcNCj4gZmVhdHVyZXMuDQo+IA0KPiAtLQ0KVGhh
bmtzIHlvdXIgcmV2aWV3Lg0KDQpJJ2xsIHJlb3JkZXIgZm9yIHY0Og0KDQogIDEgIEVEQUMvYXNw
ZWVkOiBTZXQgdGhlIERJTU0gZ3JhaW4NCiAgMiAgRURBQy9hc3BlZWQ6IEZyZWUgdGhlIGludGVy
cnVwdCBiZWZvcmUgdGhlIG1lbV9jdGxfaW5mbyBvbiByZW1vdmUNCiAgMyAgRURBQy9hc3BlZWQ6
IENsZWFuIHVwIHdoaXRlc3BhY2UgYW5kIGluY2x1ZGUgb3JkZXJpbmcNCiAgNCAgRURBQy9hc3Bl
ZWQ6IEZyZWUgdGhlIG1lbV9jdGxfaW5mbyB1bmNvbmRpdGlvbmFsbHkgb24gcmVtb3ZlDQogIDUg
IGR0LWJpbmRpbmdzOiBlZGFjOiBhc3BlZWQ6IEFkZCBBU1QyNzAwIFNEUkFNIEVEQUMNCiAgNiAg
RURBQy9hc3BlZWQ6IFJlcGxhY2UgcmVnbWFwIHdpdGggZGlyZWN0IHJlZ2lzdGVyIGFjY2Vzcw0K
ICA3ICBFREFDL2FzcGVlZDogQWJzdHJhY3QgU29DIGRpZmZlcmVuY2VzIGJlaGluZCBjaGlwIGRh
dGENCiAgOCAgRURBQy9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCiAgOSAgTUFJTlRBSU5F
UlM6IEFkZCBhIHJldmlld2VyIGZvciB0aGUgQXNwZWVkIEVEQUMgZHJpdmVyDQoNCjEgYW5kIDIg
Y2FycnkgdGhlIEZpeGVzOiB0YWdzLCAzIGFuZCA0IGFyZSB0aGUgY2xlYW51cHMsIGFuZCA1IG9u
d2FyZHMNCmlzIHRoZSBBU1QyNzAwIHdvcmsuDQoNClJ5YW4NCg==
