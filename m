Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022128.outbound.protection.outlook.com [52.101.126.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B872F7EE9;
	Tue, 29 Sep 2026 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790659740; cv=fail; b=JherwUDgMGIzg5yVyO1GfA9E8AEFFA0W1NzCjY8JpFU/oAwS7pcnePuCrkWp+ttIIlRXQMqd6Oo0njbtnd1S/7btd8ysXgDu6fj/bppny6W0TFo2cz98HigLXm0yY2/xkAqtnl04huUpIf/j9HV6pO+UH196SWy6F4W+zU61V44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790659740; c=relaxed/simple;
	bh=Dco8DV2L8oxJr3LpupYwj1cTD0/GQqkMk7TpVPl/bOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnfsFEPueLWKVm2vJof5ckbw5P/jedvj489slWs+5wIbqjvJayxGJ9muYwNWznmgyV/ineWfUZMkIW47cDL32rHSWZyDM3bpAXP/bcoBlUcZ3osCaco+WzfOVT1ng/o6cNqtX9raO9B+eb9gbWVRgRNxxWWAAFzfnrOBVak+BGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Mtf7L68q; arc=fail smtp.client-ip=52.101.126.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Mtf7L68q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7HcGHj54tKlB0iWUwLp7fW/GwA0yxguI6hUGvBqlHTvN3TQP0+L2sL4GIOq1fJSDt+7a1gFDXoM/oOHm7NKptiCjM/pb2MaDOaYX9t4XvmwiW5KoMTz9ZGXvLlLnjTA8o7xEZ+RIM7aPcgcuEGMkDwkfjnAfapL8xkLdRU/WjtN983xWsqXyZ71BPHIYIeBZAMu6x4+Mrxy5NDhRQI7m0e8UH8b06DD0OPuqpG1TrAkHU8L5bNIiTrKvR9CE6fgAFnZEN60+OtXuf1scP0IS9X3s6AHMu5pIgfnww6uMAiqwPm5p5KZ1qAFjkq49ldcZn8wAj4emjAxhLVqLfCc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dco8DV2L8oxJr3LpupYwj1cTD0/GQqkMk7TpVPl/bOs=;
 b=VdkT8tlbHQR/Jcj4VmBvahe9HzrmYXoB3nQEK93nFYZEZS+U1/l9uR+V2W7bM3h8NLlhMYGJAeItY9gk3qaSNo4gkWxJYOwppnF9m4Yz7xCSPHl80Bz5Nu9jmm/LCnANEDNsHKZRdxEqzPFMBhWz6xfkPdYMS40DYFXthN568hUW0dKb3yjnRKG0H9Lu/1yyBTG1tYCtErETLguMWgHPpcDI1qZkEJfs3azGyVW8cNDSguJyMSNQAWmGSyZGDY5xhKkCIfoOjBWYVBVfwJTtwV9gIRUPtrrfDoeSY9/JJLukImOvJXzoQWFZqd8Ai7nGihZkBkScxM452Z6V9Dmk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dco8DV2L8oxJr3LpupYwj1cTD0/GQqkMk7TpVPl/bOs=;
 b=Mtf7L68qgRfYUfZNbjDjb0A6cFONTo8nX10nmlPfE95v85WN5RFqZTOSqeImupDhJExBnARsIT1jYZa8Ch2HepyWfDgiMsImZbf+xSIv/73/PS2xybUFPYjGF0zroWfWxWV3mZ0uzplINRXXdEIY5PwkRdqBEdi5lXRFTXsIV+j+J1NTXOLiWaLxIXWxNt+Wt10PX+sppv/ndUFIllmrfgWrYvU8FgC3K1Kw3ESltKxK0xXgVOIGnCn1BUQ62q5ZVN6OaJC2Lb2MvC20EkwTZ9/vy5rksw/hMRYu1llR/k4wgJfLGjKlKZufeMRbqsm9ynPwr1VMU16QI1on+1xq2g==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KUYPR06MB8483.apcprd06.prod.outlook.com (2603:1096:d10:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:28:52 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 05:28:52 +0000
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
Thread-Index: AQHdRZyFCcJDuw2op0azvEk4NXStz7be1rUAgAYimjCAAAF1gIAAIFXA
Date: Tue, 29 Sep 2026 05:28:52 +0000
Message-ID:
 <TY2PPF5CB9A1BE6F0A5E179BB9CF53015A0F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
 <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <20260929033121.GDarsxCR4uIpLB69P0@fat_crate.local>
In-Reply-To: <20260929033121.GDarsxCR4uIpLB69P0@fat_crate.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KUYPR06MB8483:EE_
x-ms-office365-filtering-correlation-id: 522230c4-3592-438a-7d54-08df1dea8c47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|6133799003|3023799007|10067099003|4143699003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 uqR20WY57FaExJNUPHBB2z/YcUuiZuvzAiYlCCLVFx0GFuztZ/rsVlPcAQp1hWJin2SJfImuQMaNrI/RDsh2i2ewiCXnIna9o3I1KiNtk9rlIbeTgHT66vHvntlZH1PTVJClA+eFfCyiIQWGs8P6jyku2CX7UwC4NzIeDmfGzqQqlE1ikVp4hXZSpgjoB311vfee2pnu8DRxVpCmS+fEwPlJ5rZJ0Gpx80o4V5t/8LCnUqRgV/jNvG1swT6Z0r8W0+fpxFBe1I34cDyzc2PYdkS90mhhqOW0/OB9tYHR8FUIUtup5upGSQWsJoZRLtKxe1qZQA3AbVXF8pLPR2lon/7Yu4iBMn9cfK1v5qBepbEzqL3MLdoHW44+zajy7hw5Ifzxf5odSK2deed6oFfNs3+4/jsRC+FX5ZeKluLCkox9g9ivkupWHEGW/1rDXXr9/erDuynFt79/2KHLgQz4XV0iCKEYp2xiflzVgSgFXi7p4rhRdwV+fynaMZMlaQsdt2kf9BkkESG+fZe1AANVX7E7IyHDUT0B5iYIAQq4fkdQzH8EI3TrxdfxRnx4Uov1smnayND4A3OSdtQD0aCytmf0hyb0XZzFi8iMvYF9/LibRPwBXXugTs0MswghvcW3Nk6zTN3YWnUJjMY3cZUoJ7cp9ov7UoLH0isWzBKi+JmasKRyexERHZZSSigIiFe5jP17yrCToA0Q4EO1+KQoYI/Jq1/U4jTMQ4l8tf9gwdw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW42WGxFOWg3bnROd0h4N3BuYWxZYjlBNXFrVm1sd1FkN1NKVFQvRXNxcG12?=
 =?utf-8?B?L0Zxb1ljSGlRbFNvOFpQaUhpRmNLWmF0VCs0ZUxOUTNVT0tTT2cydzkwU2xW?=
 =?utf-8?B?d1pOMVZFZjdWY1VPZEdNNjNJbFhWT0FWYkg0S2ZyYVZIOW1pTGR1ZnBBV204?=
 =?utf-8?B?RHdza1BjV1NSVDlpb2puUWJhemJ1aWtraGF5a1c1dXhLbi96UGxuU1dMa2Fx?=
 =?utf-8?B?cFJHNStPOFpteTd5UVBLSWhLRkc1ckJnWmJKeTJLSWNQZnJadExaMm1HejZn?=
 =?utf-8?B?TWduaUowYVRQQ2ZSLzFhTHZQU0ZsNGxFdjN2NlIyNk9JK0ZsTDNmTm1NcElD?=
 =?utf-8?B?RU9FdSs4bytrZXYzaDc3aGxtdVBRN3lHRmFVUW1OUzF3NmpCQW1tTENsT241?=
 =?utf-8?B?QzUrTk1zWDBsVTVGMzhyVlkvbm5iYTlqN1JINllLT2ZsRHFwTC9YR0h4YmJ5?=
 =?utf-8?B?RUhIVVlibnNNNHI4MlhoUlptVDl1OHRZNmhwMHQvbGpWMmYrTjExWG8ybzZW?=
 =?utf-8?B?ditiTFhlMlB1RmtlM0srVXkwcHlJalBKRkh3M2ROQXVVdW8zenlhbkFnNnh1?=
 =?utf-8?B?SjdzZFpNeHRFUHBVcUduR2Q0L05RNnovUGxpTjNYS3JaeHhJWWcwWUd6VWZZ?=
 =?utf-8?B?WnB5d3ZpMzRVaEhzUzNPbkxTUkpnTEtpSnVaN1VmdVEvSEl2dmlzK29UaG81?=
 =?utf-8?B?bG5PZVZOMVQxWTcrM1cwQVVCUW9oSUZGcTR4VVdUQzBycjEvZXJkc2xlRjUr?=
 =?utf-8?B?dHd0ZVVDeXpIc2EvVmZlZytiR2tiMkc0L3ZqSzdyS1JwMVFhVWVZazlyVUNV?=
 =?utf-8?B?ODJTRkVwM1R6Z0hIK01iZ0wrYk45bGZaWDI4WE1YNDdPZHdpSGFsR1UrcDE3?=
 =?utf-8?B?Z01VU2ZKNFRRbUFFZUFZRUVKQzErclRJdVY3bnFEQ0IzTXBZRE5GUWVoUzBP?=
 =?utf-8?B?d2JPUjZPaGwrTFFQNGdPQ1hCNTg3V2l4enhxNkxNVXk1cVRoa2hmKzFydS9O?=
 =?utf-8?B?NWlhUVhDVGZhUFY1d3I5eEgyaTFVNytJVlNJekpObjZKVFEwaVRBQ1ZSaEFx?=
 =?utf-8?B?bGFOTG40ZVpqRDl0dXpKTmJFMWxrTVNyOUlXMjRKaUoyb0lwc0hicmpXSmo0?=
 =?utf-8?B?NzRSY0Y5b0ZuRkVmcjBIaFltSHNlRnZHMi9iVDdvdStzV1ZuME8xZ3dickNY?=
 =?utf-8?B?cUJEa0lRZ2FFQ1hiWXl3WGRpc0pXL1dLZEFpbDZTMUl3cUhpZkNSbWpYaHBJ?=
 =?utf-8?B?SG4rZFluM2M4WnNkbi96a3BoK2pJb1p4YnZubGgyTHpOSStwL25RSDl0SnRL?=
 =?utf-8?B?T1VIcEFJSFlHRHpTMm5zeUNMMllTSGppeGp2ZTRUWkhoenRFeHl4Ukd4aHlL?=
 =?utf-8?B?TnJzYlNYOXdjUTRpcFpxd1Q4djBhdVdsbHhVa2s5cjJjM0ptY2EyczhnZWgz?=
 =?utf-8?B?SlI4Ukx1R1VQOEtncXdGM1ZoUEd5ZkEwNWZLYUZJR2RtRnY4S3Ftb0lqbmtD?=
 =?utf-8?B?QUZ5UkdPTUNVakxXZCtqWlljRGpLcXdlWXhNMWRiM2tNSkhDK081UWQ1MC9F?=
 =?utf-8?B?em8vYWF4d2hsYW5NR0FoUmQ1dCtFbmZFRm5xd1RRQTAwVEkzSTl1cEdTdldK?=
 =?utf-8?B?MDlYTUhwWHcyejE2MGNmVyszbVdTZ3NMWEg0ZmZOMW9Ub20xRndFZkNRckpD?=
 =?utf-8?B?RTFQMXo1UUJHNWhiT0RkOUdnQ1BHOXAzZWsycFR1L1BCVDNDeHhLamx5bGtW?=
 =?utf-8?B?QUNMR3ExMm04ZUJoT2lnTUZSc3hWNW04a2dQT2RJb0p5UEg5Y2JPbHhSeFQ0?=
 =?utf-8?B?WHlkek50Y3pxVVp6QUNtUlgxMDdUMEFqQ1A2cWExVjFoT1o5ODAxbkowaHdF?=
 =?utf-8?B?NXBzOW1taGlFdGpwRGVwdFpVVFdjY1FGWjMwcVE3cnZLU2lTUkR2dnQvdnFx?=
 =?utf-8?B?emdXZm9nMzhuWUNsWVlHc2RmUFJ0U045cnZJTTlnbEJ2V3J0V3cwL0gzUUg2?=
 =?utf-8?B?R3NvcnVIWEZ3UzNESVM0aWFhUlNaOW1EL091R3BwelUzc0M5VEpMN3FFSERL?=
 =?utf-8?B?dkZBSzFRcGQ4UTZLa0Z0WDg1Qm1VN3p6VUVJY0lLbVlLK0wrb0VJTVFGTmth?=
 =?utf-8?B?dzQwTGFnY1NRemdMSHpBUFVidVFzOFE1NlVsZFlHaFR3c0IwQ1F6a1pwRFFr?=
 =?utf-8?B?Z2NDSFhzZVc0b3FPUTN4VnBOdlU4STI0L1N4SkZFUUpRTUJyWlFCVGxTWUNu?=
 =?utf-8?B?VUd5ZU5OcmZOVXNRM3Z6MTRFclRkWE1HVHhjS3NiaXRXUDdCS3RCS0lZb3cx?=
 =?utf-8?B?dm16ZGdMY3lCZEFCY1V5Y2x5b3ZWT1I2cFM3TDByNnFqNDJMT0k3QT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 522230c4-3592-438a-7d54-08df1dea8c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 05:28:52.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qpqa0UiHJwGMMNa6DBUptO44KfDnXzW6P7ot5WuqKre1QKxCctvXMt4caz98ahyWGf9zY2pebIFCLiUF5IpAyynNC1wytZf7ghxwgN7bz4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8483

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvOV0gQWRkIEFzcGVlZCBBU1QyNzAwIFNEUkFNIEVE
QUMgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBTZXAgMjksIDIwMjYgYXQgMDM6MjY6NDJBTSArMDAw
MCwgUnlhbiBDaGVuIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzldIEFk
ZCBBc3BlZWQgQVNUMjcwMCBTRFJBTSBFREFDIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IFNlcCAxNiwgMjAyNiBhdCAwMTozMDozN1BNICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4g
PiA+IEFkZCBFQ0MgZXJyb3IgcmVwb3J0aW5nIGZvciB0aGUgQXNwZWVkIEFTVDI3MDAgU29DIHRv
IHRoZSBleGlzdGluZw0KPiA+ID4gPiBhc3BlZWRfZWRhYyBkcml2ZXIuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoZSBBU1QyNzAwIG1lbW9yeSBjb250cm9sbGVyIGtlZXBzIHRoZSBzYW1lIG92ZXJhbGwg
RURBQw0KPiA+ID4gPiBwcm9ncmFtbWluZyBtb2RlbCBhcyB0aGUgZWFybGllciBBc3BlZWQgQk1D
IFNvQ3MsIGJ1dCB1c2VzIGENCj4gPiA+ID4gZGlmZmVyZW50IHJlZ2lzdGVyIGxheW91dCwgYSBz
cGxpdCBpbnRlcnJ1cHQgc3RhdHVzL2NsZWFyL21hc2sgc2NoZW1lIGFuZA0KPiBERFI0L0REUjUg
bWVtb3J5Lg0KPiA+ID4gPiBSYXRoZXIgdGhhbiBmb3JrIHRoZSBkcml2ZXIsIHRoZSBleGlzdGlu
ZyBjb2RlIGlzIGZpcnN0IHRpZGllZCBhbmQNCj4gPiA+ID4gZ2VuZXJhbGlzZWQsIHRoZW4gdGhl
IEFTVDI3MDAgaXMgYWRkZWQgYXMgb25lIG1vcmUgcGVyLVNvQyB2YXJpYW50Lg0KPiA+ID4gPg0K
PiA+ID4gPiBQYXRjaGVzIDItNSBhcmUgYnVnIGZpeGVzIGFuZCBjbGVhbnVwcyB0byB0aGUgZXhp
c3RpbmcgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IFlvdSBhbHdheXMgcHV0IHRoZSBidWcgZml4ZXMg
Zmlyc3QgaW4gYSBzZXQuIFNvIGl0IHNob3VsZCBiZSAxLTQNCj4gPiA+IGJ1Z2ZpeGVzLCByZXN0
IG5ldyBmZWF0dXJlcy4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+IFRoYW5rcyB5b3VyIHJldmlldy4N
Cj4gDQo+IE5vdCBkb25lIHlldCBidXQgeW91IGNhbiBzZW5kIGEgbmV3IHZlcnNpb24gaWYgeW91
IGZlZWwgbGlrZSBpdC4gRm9yIGl0LCB5b3UgY291bGQNCj4gYWxzbyBwaWNrIHVwIFN0ZWZhbidz
IHBhdGNoIGFuZCBtZXJnZSBpdCB3aXRoIHlvdXIgbGFzdCBvbmUgc28gdGhhdCB0aGUgZHJpdmVy
DQo+IGRvZXNuJ3QgYmVjb21lIG9ycGhhbi4NCg0KDQpXaWxsIGRvLiA5LzkgYmVjb21lcyBvbmUg
cGF0Y2ggdGhhdCBkcm9wcyBTdGVmYW4ncyBNOiBsaW5lIGFuZCBhZGRzDQptaW5lIGFzIFI6LCBj
YXJyeWluZyBoaXMgU2lnbmVkLW9mZi1ieSBhbmQgYSBMaW5rOiB0bw0KDQogIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3IvMjAyNjA5MjAyMjU4NDYuNDAzOTAxNy0xLXNzY2hhZWNrQGNpc2NvLmNv
bQ0KDQpUaGF0IGxlYXZlcyB0aGUgZW50cnkgd2l0aCBhIHJldmlld2VyIGFuZCBTOiBTdXBwb3J0
ZWQsIHRoZSBzYW1lIHNoYXBlDQphcyBFREFDLUZTTF9ERFIuDQoNCj4gDQo+IEFsc28sIHRoaW5r
IGhhcmQgYmVmb3JlIHlvdSBtYXJrIGZpeGVzIGFzIENDOnN0YWJsZSBiZWNhdXNlIHN0YWJsZSBm
aXhlcyB0cmlnZ2VyDQo+IGEgbG90IG9mIHdvcmsgZG93bnN0cmVhbTogc3RhYmxlIHRyZWVzLCBk
aXN0cm9zIGV0Yy4gU28gY29uc3VsdDoNCj4gDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFi
bGUta2VybmVsLXJ1bGVzLnJzdA0KPiANClRoYW5rcyB0aGUgaW5zdHJ1Y3Rpb24uDQoNClRoZSBn
cmFpbiBvbmUgaXMgYSBzaW5nbGUgV0FSTl9PTl9PTkNFIGFuZCB0aGUgZXJyb3IgaXMgc3RpbGwg
cmVwb3J0ZWQNCmFmdGVyd2FyZHMsIGFuZCB0aGUgdXNlLWFmdGVyLWZyZWUgbmVlZHMgcm1tb2Qg
dG8gcmFjZSBhbiBFQ0MgaW50ZXJydXB0LA0Kd2hpY2ggaXMgdGhlIGtpbmQgb2YgdGhlb3JldGlj
YWwgcmFjZSB0aGUgcnVsZXMgZXhjbHVkZS4gSSdsbCBkcm9wIGJvdGgNCkNjOiBzdGFibGUgdGFn
cyBhbmQga2VlcCB0aGUgRml4ZXM6IG9uZXMuDQoNClRoZSByZW9yZGVyaW5nIGZvciB2NDoNCg0K
ICAxICBFREFDL2FzcGVlZDogU2V0IHRoZSBESU1NIGdyYWluDQogIDIgIEVEQUMvYXNwZWVkOiBG
cmVlIHRoZSBpbnRlcnJ1cHQgYmVmb3JlIHRoZSBtZW1fY3RsX2luZm8gb24gcmVtb3ZlDQogIDMg
IEVEQUMvYXNwZWVkOiBDbGVhbiB1cCB3aGl0ZXNwYWNlIGFuZCBpbmNsdWRlIG9yZGVyaW5nDQog
IDQgIEVEQUMvYXNwZWVkOiBGcmVlIHRoZSBtZW1fY3RsX2luZm8gdW5jb25kaXRpb25hbGx5IG9u
IHJlbW92ZQ0KICA1ICBkdC1iaW5kaW5nczogZWRhYzogYXNwZWVkOiBBZGQgQVNUMjcwMCBTRFJB
TSBFREFDDQogIDYgIEVEQUMvYXNwZWVkOiBSZXBsYWNlIHJlZ21hcCB3aXRoIGRpcmVjdCByZWdp
c3RlciBhY2Nlc3MNCiAgNyAgRURBQy9hc3BlZWQ6IEFic3RyYWN0IFNvQyBkaWZmZXJlbmNlcyBi
ZWhpbmQgY2hpcCBkYXRhDQogIDggIEVEQUMvYXNwZWVkOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQog
IDkgIE1BSU5UQUlORVJTOiBBZGQgYSByZXZpZXdlciBmb3IgdGhlIEFzcGVlZCBFREFDIGRyaXZl
cg0KDQpSeWFuDQo=
