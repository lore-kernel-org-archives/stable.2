Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022077.outbound.protection.outlook.com [52.101.126.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF253E9589;
	Tue, 29 Sep 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665202; cv=fail; b=WvQXe7QKa0fU2+HoyjOnUxQJj1QGLTdK+C4P70lNEeWbf5HkdMM41+55+BDqkyjr/4tx84irSThB/dxC73wh1IMNYSAQ0wrRSpAmJs89pu7yXUOXXRxCFCabn0T3w4OhBqKdOguosL+BdBXjee8pwJygSIji4S6VCI54G2rhOA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665202; c=relaxed/simple;
	bh=cGFsvbhtGC2iEBzx1wqlInrMm3zsaGJt+9+seihfvRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kwkRojbGPU0zdZ1QpizkyCQ+pmn/kvE0DaGjh6P9u7lhArR2Vl6weQHqVcdk63DbqKCbR+6E1800OgdUle6uy5ZoqbzmAFSFVMui3Pld81ubzJUcCXRhi4+/2D1eNtwZCkdhsqUmEDWd0/yyk57J+tcACR8GGPg3GXyUxmOJMXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=BCk43GCP; arc=fail smtp.client-ip=52.101.126.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="BCk43GCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auhsrscbhkSWmjxFVAHJOEwOAkQaI26Hycfruui1XMG6LtASbYgO989AhEkAvmCZj01pR3/0XhIp203JxH7QCeriWln27TRvkRJItDYGSMMIRrA2bQXl2JL6GSBbReqZvw2Qp/S/v+M3+XQHeFNt0U8GY+CswH4S/Ik1g4rm1oyIw4/pIjbbTByrWL1ix6lE7RXowREdnFoLYmbTB+7YeoiQqU+DPY/z4GJrPcCuq2zs3s1+O0JqguarXrSHhgiJGryuBjEynBn17p5oYiGDushZ9vKGWgThvPRquFadp3NY+77FYrYWlH8y6Z4pMgixJgMY7+I5ERHoNOhFv37j9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGFsvbhtGC2iEBzx1wqlInrMm3zsaGJt+9+seihfvRY=;
 b=C7BjL47mUUySRJSS96ZxD0w71Zeaoi/1Y5DzSwo1qE/svbShz9QUqnGujALO9Iysli4hvbheOdGlp0iqbl0I0rQ8RZOvffCS3pZCP8Opk3Px+C+822a2HRLn9NDKHrjZGXNPIIwOhGl9OMb8GAVgCNxtekdQc0TFZGkxVCo8GRe6BDvYMI4Dyvq5vMwkwKQg6YPlQqJUzc01NcfSSsQRi58meelH9jkTzQVkgIG+Q8fYO6bFGUyR9yXlGBObX4m6nTwp0wbmXeuWg5WN5yJz3+UmByDpEEdk8/zObu0gbVYHwbTdfnAe3DZVvcwkTGSRDVGBn8Po8Hc4MzzJV0SDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGFsvbhtGC2iEBzx1wqlInrMm3zsaGJt+9+seihfvRY=;
 b=BCk43GCPMWX8XwjMSwwQ8Lw9V1U+N6H0671hSJN+ylzh5vRw3gzhdys1FNrNr549vD1DvgVP5c14gTNPKlCZoZH8laqExM5ig+DAOG0PuRLyfXTAxFNOK6j2h0mRh979CrIKX/Zd6rtE/CiiA2NQHg4ekh1Vq6vwpyePz+y/BLfiPSkeDiW3UlW9IzhSgoEUokMi0ZkndUtl17GlIH+h4DFJEdtJ4tchxN1oSXNunjH4gvAU9C4++7H91TcVIdcxJvBfGKQOhwK5fgx3Q5w7dFVzTtNvLPd+IrpDX+JM10Be9wwe/k4u4AgA+9BwYH0HMFnybpVEfwr1FO+v2To8Dw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by TYSPR06MB6947.apcprd06.prod.outlook.com (2603:1096:400:46c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 06:59:56 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 06:59:56 +0000
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
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 2/9] EDAC/aspeed: Set the DIMM grain
Thread-Topic: [PATCH v3 2/9] EDAC/aspeed: Set the DIMM grain
Thread-Index: AQHdRZyG1WT8/e+F90OdDhdaNM60jrbe1uMAgAZdu7A=
Date: Tue, 29 Sep 2026 06:59:56 +0000
Message-ID:
 <TY2PPF5CB9A1BE65A0A83662656401CDFC7F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260916-edac-v3-2-23e9ed2fbdf9@aspeedtech.com>
 <20260925054522.GDarYKcvFR4mLdAhSe@fat_crate.local>
In-Reply-To: <20260925054522.GDarYKcvFR4mLdAhSe@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|TYSPR06MB6947:EE_
x-ms-office365-filtering-correlation-id: bd7c9563-097e-465c-dc92-08df1df744f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|10067099003|56012099006|6133799003|18002099003|4143699003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 9ls6qeGTVRCTqpHfuEa1gwIHztXCVyANfPnLoLg138ifsHEduoqdsXzWCn9C2y0iadJEUENQnQ7BV5z+mAITiqej0NSuAqYTthpLeEtFhXiwpk9HquHGSkQHLvaNgM50phWyqfTAn6PW8wXq7brPxuuQd+8QS7vzvt5bBMf7qd9oKBi/Ym7pioix7P4HL83upjr68y8pa6zwgAMiqu9CjYYoVyEbakY9G8ER6nw1REPIDYTo67xLt7sjIOzXG98alAN0Gyi7yHWL1EvpU3CarLWvMemjxMlt9Nd1AXLBNAxc1AmkTL+drhrh/XqYpLaKcBgqLKxaXUml5CzHIDo9UCVu4EYJq6p5fGxKGQNyxpa31mRgdepWiJSGLjTI7FSpuCI3yr/2z3xCt/SZMJ955JMqddZPuegc/AXG/Rq5cNQmhtXB0N+V71q0nMNc9OA0ExKnDWK3abTvJirZUiXAUnmhp2YX0NnqImA9oQYwAVJZbgqDgrTKR205xbpStUNYtA2YvXHuzY+IjwsZhGN01/psEI76HeBcQEJ9VHOhM6RPi29thia3d80X9iqwZSywHzBOF1pNy2oIy/WIHopXzyg8FIf6gs7S08chFRzJE6SouHpdZGiy81dcXqBjmJh9lgP2IRI+RRLGhN6r6zwiyXAWx+6jMhmUM53wnmp6tEm5z8VYFBwMchSn6X3BrzGPTPHwF2G5i/KyEAXSnWz6gh43k/hPcRRbmuLAhL9Mrc8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(4143699003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlJqeStZLzNwRENMTHZubUJDdVVGa2FkNWsxaGp1OFJ6NVJvdWVNRzVJUWhU?=
 =?utf-8?B?RG52aEdGTyt6STVyRzRNMFk2UVA1WXNxNWVSeUtHdWRUa3RKMXpIbFd5UE9H?=
 =?utf-8?B?cGxwc3VxUzBNNGx5VmJNWnFxa09TZWZWOUpaeUYwbC9GdUQ1THJKbit2dUQ2?=
 =?utf-8?B?dTluM2lkMFJKWW45K0pKTzN6UURJZ2o3MUJZaG4xZlI3cVd6ZmZ1K05nUU5r?=
 =?utf-8?B?WFNiWHVyR3JBVXZaR0hMaXRVNXMyUTNGdjB4b0RlODdFeE9jdzVYRWhucmli?=
 =?utf-8?B?TXo2VVIydytPalZNV1E2TklJWGg0azNEV3lzOU4wRHArQlZRYnpjWTRPbHBh?=
 =?utf-8?B?QzZnZ1ZRRzdYb29LWExJdWdSNXMwTXF5RC9DZ2V1MEZQcnVkL0ticGdGZisv?=
 =?utf-8?B?aDNBRE5jUkU2OHQ3b3J1cG1id0NmLzY3WUE1Ukx3RTFOTEtVcTRMbnlPK3Rm?=
 =?utf-8?B?MVpNdGJVeDhRWFFqUEhOYzFwU1o0ZHBsQ0xkVXZMMmZlZW52d0ZWcGwwUG0w?=
 =?utf-8?B?L1NaSW9kL3Jyd0k0cy9RdWZ6eU8yRXBnaG92ZTUyL3ZVeUVqWCtkK1pndnJD?=
 =?utf-8?B?SGtMSTJ2RDZ6ZWdHZkJnaU9FbjlSejVPdXBoVWZXVHFQNi9FVmF1TFRXY2p2?=
 =?utf-8?B?N0dHWXlYbG02K0VlU2FwbGh1SG5LRjdrbkZEclFjMEZzeXlaSUhIY3FxNzVr?=
 =?utf-8?B?bUZWM0RmdEpxdjFCR204T2FiQlVCZ3JHdnJNNWxjejBMYzRxbHVPUlpsVjl2?=
 =?utf-8?B?S1JvanYwcW1HQkd2RHVFR003aXBycC9xR25ZTHhuTHZWWUQwUmJSeU0rdTB4?=
 =?utf-8?B?UUdDSGMzeEt0WXQ1aXplZS9CaGo2Yk5EMnJ0REpZZ1FGcmlwNGMybEUzczRa?=
 =?utf-8?B?cUxBNFpUU3dwR0FHNkY0WlRKMzc1Q0p4TDFucWNxUHlEWXhjT1NYRm1rYmZL?=
 =?utf-8?B?aTltSVhURlRPN1N5YjZlRW5qYVkyYzFzNEsyZjJqNFRnSXh4K0tzRTB6c1RD?=
 =?utf-8?B?ZTFHTTI1cEQyNTY3bkVSeForT0tnSmFMUXhWMXg5dTBOaDVnUjNyWVFYQUFx?=
 =?utf-8?B?UGJlNVI2SjVpS0hTbnFjZENhY01hRTMrVEsvdlVGRFpvcUViZFFOM2dlcTJm?=
 =?utf-8?B?cWR3dzR1UWl5QUZENmpTNWZlS0hxMGV5ZnRJOE5MZk14UXpPcTFiclJGbTUv?=
 =?utf-8?B?ZzFaUUNiYUUxbzkvMDk3UVdqcndLZHpLMGdwS1JQWm1Bb3BUOCtiUjZGNjJ6?=
 =?utf-8?B?bXVjQTVtbW9iWVlmaG00MnMyTG9RaktaRllCWUlYWkRnVFE3dERxd1pCdGt1?=
 =?utf-8?B?allNcW1qaGlQdHJOUHM5ZnpyNnRGTndnR1ZobFFLbnJHWWNxeCtraGlUcHJ0?=
 =?utf-8?B?bmVoOFAxVDlzRGZoc1ljdk5IMHBFSkt4K2FPM2ZYWlRYOTFIUVpkYUJmT3Nn?=
 =?utf-8?B?SmdIOURPMHZ2cGFmcU5ob0llL2NnMlZDeGFRN3ppOGxNSHprc2hTeVlrN2Ex?=
 =?utf-8?B?MGtPV0J5T0FFaEZOdUJ1Y20zbkNGUFJSOEVkVmJZSERXUVh4RWVmeEUxNHRJ?=
 =?utf-8?B?eFNSME16TkxvWEIwaktVOG9YcnRLcGxaQms2cnJSSVY5N3l2djAvTUtPWk9n?=
 =?utf-8?B?d0p4ci9oc1JYbWVObkwyOVNPMVVCZ2hjdmU1NzhhbmJlYWQ1RGtMR3BKT0FE?=
 =?utf-8?B?aWVNODlPTXAvYldKLzNobEVLcWF0Z0ZVd05hRlFOUkVmS0x5MEpDSmkrTEhD?=
 =?utf-8?B?U1VSVlJncEVONkVmcHZTQmExUzJIdDN6YUl4QWxVc1cwalNtRzFJUEVKaE5C?=
 =?utf-8?B?V2RkRUlrODNBVnErZ3d6VitZWUJNN052UG5JdG9Jc2h1R2hpMDdiRFMyWi8x?=
 =?utf-8?B?WlcxWXE1ZHRhMU5WMFpLeVl3bTJnbHZrZUMxdE5hMDh6eDF3dlFnRHErS0FR?=
 =?utf-8?B?Mk5ScEF1QWVKL2E0UkJIc2F4N0JadzVHUE5oMlJ4S1dMM0dGSU16M3hLeERW?=
 =?utf-8?B?b0hhL3d0TVlzWHliTkx5alk0VHZGYTRBZmpQZUtWYUpyeHdhTktJZXRHUHNL?=
 =?utf-8?B?U3g3VmFMZHU3UnJ6SHFtNXhDYis0bFhrWm4yT093YjQxRGtQcU9oZEVodWkv?=
 =?utf-8?B?SGdOYkVRMnRPQjd3S1ZIUktaN01xejdHZlFKeDB1V1FKQ1k2VG1JV2JLQ3hQ?=
 =?utf-8?B?ZkJWdzE0MmVhRzU5dHZsbnN3TkJBVldPbUJOMmdoaDVDajBsZzdVaVFkaGZy?=
 =?utf-8?B?aU1oTVNRM1pLRFNqRUpwelU3d09WblVQQklMWVcySWIxeDlnbGE2RXRrZ0Ja?=
 =?utf-8?B?Yk9yRXVOWlVqMy9URGdWaUFtbktVU0dqOWRZRmsrQVo1ZVVKT3pXQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7c9563-097e-465c-dc92-08df1df744f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 06:59:56.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NP0ydxDgYynW+XENRRcGfVWnjK2GB/XhixC2ItQAtDfTQTJ6AT1Iko2l842fZLrfrm8E2nHvgvp2GBsCQGQbHgueXoUrfSmjQtaeXwTdZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6947

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvOV0gRURBQy9hc3BlZWQ6IFNldCB0aGUgRElNTSBn
cmFpbg0KPiANCj4gT24gV2VkLCBTZXAgMTYsIDIwMjYgYXQgMDE6MzA6MzlQTSArMDgwMCwgUnlh
biBDaGVuIHdyb3RlOg0KPiA+IFRoZSBkcml2ZXIgbmV2ZXIgc2V0cyBkaW1tLT5ncmFpbiwgbGVh
dmluZyBpdCB6ZXJvLiBTaW5jZSBjb21taXQNCj4gPiAzNzI0YWNlNTgyZDkgKCJFREFDL21jOiBG
aXggZ3JhaW5fYml0cyBjYWxjdWxhdGlvbiIpDQo+ID4gZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9y
KCkgcnVucyBXQVJOX09OX09OQ0UoIWUtPmdyYWluKSBhbmQgZm9yY2VzDQo+IHRoZQ0KPiA+IGdy
YWluIHRvIDEsIHNvIHRoZSBmaXJzdCBFQ0MgZXJyb3IgcmVwb3J0ZWQgb24gYW55IEFzcGVlZCBC
TUMgU29DDQo+ID4gZW1pdHMgYSB3YXJuaW5nIHNwbGF0LCBlLmcuIG9uIHRoZSBBU1QyNjAwOg0K
PiA+DQo+ID4gICBXQVJOSU5HOiBDUFU6IDAgUElEOiAwIGF0IGRyaXZlcnMvZWRhYy9lZGFjX21j
LmM6OTI0DQo+IGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcisweDRiNC8weDYwNA0KPiA+ICAgLi4u
DQo+ID4gICBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IgZnJvbSBlZGFjX21jX2hhbmRsZV9lcnJv
cisweDM2NC8weDRhOA0KPiA+ICAgZWRhY19tY19oYW5kbGVfZXJyb3IgZnJvbSBjb3VudF9yZWMr
MHhkYy8weDEyNA0KPiA+ICAgY291bnRfcmVjIGZyb20gbWNyX2lzcisweDExMC8weDFlOA0KPiAN
Cj4gQWxsIG9mIHRoYXQgaXMgZmluZSBhbmQgZGFuZHkgYnV0IHlvdSBzaG91bGQgdGFsayBhYm91
dCB3aHkgdGhlIGdyYWluIGlzIGNob3Nlbg0KPiB0byBiZSAxNiBoZXJlLiBUaGUgd2FybmluZyBp
cyBqdXN0IHRvIG1ha2UgeW91IGNob29zZSBhIHByb3BlciBncmFpbiBmb3IgeW91cg0KPiBodyBh
bmQgZG9lc24ndCBuZWVkIHRoYXQgbXVjaCAnc3BsYWluaW4nLg0KDQpHb3QgaXQuDQp2NCB0cmlt
cyB0aGUgd2FybmluZyBkb3duIHRvIGEgc2VudGVuY2UgYW5kIGV4cGxhaW5zIHRoZSB2YWx1ZQ0K
aW5zdGVhZDogdGhlIGNvbnRyb2xsZXIgcmVjb3JkcyB0aGUgYWRkcmVzcyBvZiBhIGZhaWxpbmcg
YWNjZXNzIHdpdGgNCjE2LWJ5dGUgZ3JhbnVsYXJpdHkgLSBNQ1I1OCBhbmQgTUNSNUMgaG9sZCBp
dCBpbiBiaXRzIFszMDo0XSwgd2l0aCB0aGUNCmxvdyBmb3VyIGJpdHMgcmVzZXJ2ZWQuDQoNCj4g
DQo+ID4gRml4ZXM6IDliN2U2MjQyZWU0ZSAoIkVEQUMsIGFzcGVlZDogQWRkIGFuIEFzcGVlZCBB
U1QyNTAwIEVEQUMNCj4gPiBkcml2ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8
cnlhbl9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IA0KPiBJcyB0aGlzIHJlYWxseSBzdGFibGUgbWF0ZXJpYWwgYW5kIGlmIHNvLCB3aHk/DQoN
Ck5vLiBUaGUgZXJyb3IgaXMgc3RpbGwgcmVwb3J0ZWQsIG9ubHkgd2l0aCB0aGUgd3JvbmcgZ3Jh
bnVsYXJpdHkgYW5kIGENCm9uZS1vZmYgd2FybmluZywgc28gaXQgZG9lc24ndCBtZWV0IHRoZSBi
YXIgaW4NCnN0YWJsZS1rZXJuZWwtcnVsZXMucnN0LiBJJ2xsIGRyb3AgdGhlIHRhZyBhbmQga2Vl
cCB0aGUgRml4ZXM6IG9uZS4NCg0KUnlhbg0K
