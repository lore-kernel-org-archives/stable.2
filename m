Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C13B058E;
	Tue, 11 Aug 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447526; cv=fail; b=P5qyjU5tQ/I2VP61f9JLWx+JzhycIGbmkANwo7pB1Fz4Ou5ZXNyHY+2ZmOovexmqNS0FExHQS6HMQRK+WJvApn19dMmGelfW4foNcutaJW6h6HYsBPQrqAvjp258sTbmi6mx96GAMYVko96shkxX4tb1QR8rmBziZ/YPEFENwyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447526; c=relaxed/simple;
	bh=3OMlvb5EhLy8ttZ2K6F1N6H3Zk4EnbOfUITKZ087hm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNEnDJl8l27cBZrxhrvM+rZ1K2OBOLaaDy2S5E6f7YR0LOTax4Lx0lTXOibehesxaFqjQ0/Q2xri2zaKcpqkkNGu6Klqohz1z3r3KQOfVc6rnJAcpFr9LCEs08/ULIoAYoPDKJW/5u5ZjC3xN7kERbY6IFRDyYkQlNBrUoaBUTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kmS0uVdK; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kmS0uVdK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPzNOU1FHFTy1t5oHyysAZzXvu3QQQqx9H3gQlZfdnzAqrjvtdDUyJonlXP0rgjX5mO2AFa4z0WAkk4Ey9oHgxkhlu9uQAfSNRCaucuxKD1zAGzkPfsX3UEP+oIk22U7eRzet/71wFM2h2IgXDu6yb/PcnJIvu2SXVlq6C0MSAzfwajYDtBBvrHXi30/sOMG4cC+ZdulJz8hHW932MqL7wiWkqLaLBbSh0fGIxqRnc0zVOpN3Nm4J9MRt0QMjBb7cbMOElabq2D+2cndpuNFBc5zu+vg1fo2/UXs4ka7PeZssI/LnueJqVLPjZAAoLZik6n+/5kCaQ8U6+IjqeaIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OMlvb5EhLy8ttZ2K6F1N6H3Zk4EnbOfUITKZ087hm8=;
 b=mM5+HBmp498zBFx3hXvJ5KG8FcMGQWIf9kjD2dXI81BAba7D6kvLdac997UtHa7Y2MU5h20xxCGmhNJWANPNbbbbLDP2ijQ4OG4C/9nSHv7FNlDaSGI6o3alVBtdhnMGJkZySWbygO1au5NwcZnaSEoFx5EDFg+ZUwIsDb/MqfKRQJubvXz8MInZ+95XUVErufP8leMwTTabQTUAQdiJ2CgjMSup7QMXdFqExEjFduBTvaH9/3NdPByXlX4O9Y0/5aOWYpFil0b7/WRjlBiXSUjxLdnUgSS2v2V0Ci40QcI/6otgOCin8LY+uocdMf+tT3Vis3Z/tcOedRdtEB0NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OMlvb5EhLy8ttZ2K6F1N6H3Zk4EnbOfUITKZ087hm8=;
 b=kmS0uVdKbmOE3Uvp2b1o7UJ4GDyxwTagVO+XhrPfW6EgCDUIHIXd8tA+0dI9ee2c5BvoyzCx4cCoWohfq9ClP+H06eHzpvuoOlWaufgf8jPT0Yak9ahqCUzkPwTuhcZzvxdwb05FP+JIeSY7hKwnJ3PN1gvV/CLqskINCXPDtIaJbfMUOo3zZihjmzJXVSw3i/fQU3mMi0Ntj9B+l4k3SyO1gj9DGNb+M+9HmibHTVawjZ19AeYjM3OE3yQuNQoPKzzXLwvnINHYsdQitJtWdPIoy9GWtCPIpoQRPoRfGgCe7jHATXfSRXhT76ab7C4zoOcgY8636+6JtTUWvxKOdg==
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 by SN7PR11MB8044.namprd11.prod.outlook.com (2603:10b6:806:2ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:25:19 +0000
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5]) by SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:25:19 +0000
From: <Balakrishnan.S@microchip.com>
To: <ehristev@kernel.org>, <mchehab@kernel.org>
CC: <hverkuil@kernel.org>, <sakari.ailus@linux.intel.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] media: microchip-isc: disable histogram and
 flush AWB work on teardown
Thread-Topic: [PATCH v4 04/10] media: microchip-isc: disable histogram and
 flush AWB work on teardown
Thread-Index: AQHdIzHJhyfa46n470m4EZrDgTrOQbaQkoMAgAgvR4A=
Date: Tue, 11 Aug 2026 11:25:19 +0000
Message-ID: <d58256e4-a9c5-413a-bba8-49160b8b738a@microchip.com>
References:
 <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-4-f625d6aa0ae1@microchip.com>
 <9ea7468e-73b4-4064-acae-8f9fcb0df447@kernel.org>
In-Reply-To: <9ea7468e-73b4-4064-acae-8f9fcb0df447@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4910:EE_|SN7PR11MB8044:EE_
x-ms-office365-filtering-correlation-id: 19af37cc-1e64-44e7-29f0-08def79b39ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|56012099006|11063799006|18002099003|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info:
 YFZjVeqFKMKgurXtimEnM/nxHS6Z9l5v2l8vqIh8DzbbPt6MFkJjqGvEnv1birtcx06vuJZEC2fN8ktY0ChKSFP3noROBRIh2dxTOuQiHlxRxT0fTEbnBOUWaSJ34O5yY/er57n19V7dDzAaj6RGx4H2yuiT2aTy9X3w+7E7jMddyM3XHKCgBjDUDkKF5JLA1tSilMU8mKyrp3TbVVlidBlS7Bl/k5zVS6A7zNKHEJJ87ogk/tt8tZXdgP9SBubnlPWZH5CGfOpp3FRar0bvU+dkaPDKyAN9vMCg8/H8QrLGRL7YYHc/mz4mhJwq/Qc7NZ+Bdeqp6A8V7I5frTS8WnHYwPiDaRpNhj0D/QLrEN+uNxySUwOna5Tm5TkMdYuRxl6njzShMwWK968fYVKYw42o5GSx2WdZJVRiijlBAHo08pxyBm3oJyrwkSFaxHt2BNNGAl5k+7rW/LoZ0b/HZgCXLm0Ih/X0kY0UCezfERC+qblCr0WCymJGOdG22wscrE3fCRGS/PaK/wwTYJwoomRZHPpuoDB1JnLkqKp9UFBSn8GsHAhLsZQC25jBHhZDVSQGNpDjW6jPdVrjuKGM84Bgb4iiY/Ax/dpWGP0d6yRAi007R9CxRx3jkkUMHMLi0LpoxGck0kSDq01Y8qIUXzTOR7CeKN+m3AKU2fObpJjgHIl21V0RDLzNz8zhmF5H1VOfs6NwSqj3VkIZzP/xDrVyrEW1brVQiIH+HeMj1y4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4910.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnZ1ZDdZSVVra2Y4OGR1UHZ1V0xJTFZxd0d0cXZGYUVLZTlJblRRR1BIRHZ3?=
 =?utf-8?B?VlJQeUhyd3A3WmR2Y2lFVGt5N2hGRW9lSHNoZmg3bTRxN2J0MUNNZ05uek8r?=
 =?utf-8?B?bWpEcjkzNlJtMWJkSHRtdHk4SVZvaG14QzhXcVJWNzlUWjhXU3hERSt0TGhs?=
 =?utf-8?B?VEw5cmZkd3lmNW9ab3F3M1lSUjJZSjNIOWdhVWErSVNwNTI4MkRqdmJCYy8z?=
 =?utf-8?B?UnZMb3YwREhuRkJoL3lIT2V4a2V1VGxuaytSbXVEc1ZtVkErMW5VN3dhalZW?=
 =?utf-8?B?WU41VS8wbHUzZG5RSEZmOFRSQys2am1BOVlXeERtOGxYenVLN2R1TnMxWjhE?=
 =?utf-8?B?YWFIRWdtbXcvMS9UK1RRVTJtSWwxUkJBNk50bi9vam0wMTFZeEl2RUF3WHVI?=
 =?utf-8?B?R0o0VDF2YTZ2MFdMN0FvOHlXSUZtR0VYTzlhZVlESGtDVGh0YS9GSjErRGVV?=
 =?utf-8?B?S1Uydnd3YW1oYTlrdDF2K3FKYnpUb3lYeWhSN3l0NmVUYW1Ody9QRHFVbjA0?=
 =?utf-8?B?MmZadDBXKy9DajEzSnpQU2VYNEdabEI2U0RqVWx3T1JIOW9OTXpVRWF0RmE4?=
 =?utf-8?B?S2h0Z0h4SWQ4R3Z0ZGhNUUdaR2Q1eEI1dzZiYUN2bmZHVzRVQURnWGdZUHhT?=
 =?utf-8?B?OExacElPUG5ubXRtWFJoRWFXazBrUnh0Q0tZbWFsQUZPK0pFZ2FpUG45YTFl?=
 =?utf-8?B?Si9lVGwwQi9YN290cWxYbzAvNnJvQzQ5dGNZL2laRW9RUXdic09hMDI0YmFp?=
 =?utf-8?B?K2xlZjhyUzFOU0ZjckpFMGFsUlFKOFRsRE9JQXlieUtEc09GTVA1S21leXND?=
 =?utf-8?B?QUw1QWlodmJsWGhKUEpMVnZXS3Q1U01YdXJrY1dVcEdjN2JpS0thUE81eWxi?=
 =?utf-8?B?bTE0Njd6UW1VR3RMVkJocUhpM1RJZ2VoN0s1Wkh2ckpMMWdyaXI2MFk4YU5P?=
 =?utf-8?B?TmhiTG52WDcvTStQOGJPcnR6V0dwWTR6NXpsajFac2tQNXpvUWtFQXpXMmRD?=
 =?utf-8?B?b2FaSHczWURLYkpxY3IxVjhGQ2daQmdCTU04STFKYk5FQUgxMmlBTm1FbkJl?=
 =?utf-8?B?bXhXMkNOR2dLaXc1cEVCMDRMOVFjN0FXSnArNWxWRHBHVklnK0RhNDNvSGhY?=
 =?utf-8?B?dWhpM2pKTG5wbnQrSW81YS83UkhkWXU5aEYrNzUwemhoaHo5MnVwTEpNNlJ1?=
 =?utf-8?B?QmdIcS9IRDl1OVpqSmx6ZFJMcUtYSkVTKytNS2FwN2FKaVFLQmcvcWZNeXVt?=
 =?utf-8?B?RXlvd2tzcmJrR3BVSEluUEZhR1JZUmFBOFlYM0NnQnR1Q0VsNU51K2Vob3BG?=
 =?utf-8?B?ZEJ4d2ErdTNKeDBEL0d3TFBHajkwOFkzako4dEx0QkM2UlZ2ckRJdlVWeE9a?=
 =?utf-8?B?Y0dBMFZEcnUwVFVrby91SW95TFR5REtiMkhwOXMrSWxXWW44dVEza0pQTFV1?=
 =?utf-8?B?QWhIeDR2TkkvNGlPWHEwekVnVlFMMlBqVDJSKzZ4QWJvb0JPTGFSY2xPeFUx?=
 =?utf-8?B?clhQZmRQTzV6ZjF5Nk11bzV4Z3lkc3hjZmgyTWNzQ3JzK05PMjBNZmwyVmJj?=
 =?utf-8?B?ZndrZ3ROa2pLQkQ0VHVhZWpZRzBWOTVRK0hFRitFSzJabzFpcjU0cnpweVY3?=
 =?utf-8?B?NzVkOW5mWFZVOVB6T1RTNjBrZVpQa3VPUGhTMmVpTEMvZmg5WFJHNlNZK1ZD?=
 =?utf-8?B?TGI4S3Q2TVgrZ01VM1N3ci9GQzZ3VmJFZFlaMzVEcjk4WTA2ODBQcUFaS2lP?=
 =?utf-8?B?bUNUVmVIU1FuSU4xU1JabUtxaldEZXV0Mm1CZWk5V1lKZWsyT3lPV0ZkWXow?=
 =?utf-8?B?NndkMFZaTTA3WEFNOWR3Zmg3WUpsOWlkRmRLRTRSL0VyeG52SElzRkdPbU5j?=
 =?utf-8?B?MGVYSTRPVEtGUnVjQTZ4eEkyTTh5VkJlcTZlY1Rzb05uRGE1c2xoY1hrYVE3?=
 =?utf-8?B?eDBka2xzaWlXa3hyY0t6azd4SVZsTS9pbHBtQmFSQnFJb25teityWUtxWUZN?=
 =?utf-8?B?d3RHWWpoSGFCYktKZy9tN2hLOWJDM0lRbDdHTGs2bUlJUGdCd2ZpazVRNDBO?=
 =?utf-8?B?Sy9rcFowUGVMMGw0UUJxWGtDSVhUZ3lHdkRMWWV4WDZiU0VkaFpqZmZpcm9h?=
 =?utf-8?B?alRFVFFPbXd6VE1pQiszcXZtRzErM05PS0JiZmtBeU5KVm9QbSs1U3ExcUR6?=
 =?utf-8?B?UmUrY29KMHlmTzk4WkEzTmpkdGhhNzVNNGZKWHBWdExBVS9DeFl6cjhPTG9S?=
 =?utf-8?B?WTdRUEd3azBJNFZFRG9oaXR6TTI2N0ZkZEF0VmRlZnhVeFVTZHJRRHhVWTI3?=
 =?utf-8?B?amhyNHozU2hTbnZMMlloaE0wMmZJZW5qMlVoUWY5L2RJYnIvZ2VOdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B9B0A20D8E8654C9CD0196529A15E21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4910.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19af37cc-1e64-44e7-29f0-08def79b39ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 11:25:19.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mf6hmISeuKVZF/xnHKZVi9/pMMLC61ELvic2QvgEo0B/Rj2pV8N6ApQsb6IpQ+PUY/kpP5QojwYgyFauNtugfxOIJsDUiISekOZfSuqSmfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8044

SGkgRXVnZW4sDQoNCk9uIDA2LzA4LzI2IDExOjU2IGFtLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDgvMy8yNiAxMzoy
MCwgQmFsYWtyaXNobmFuIFNhbWJhdGggd3JvdGU6DQo+PiBpc2Nfc3RvcF9zdHJlYW1pbmcoKSBh
bmQgdGhlIGlzY19zdGFydF9zdHJlYW1pbmcoKSBlcnJvciBwYXRoIGRyb3BwZWQgdGhlDQo+PiBy
dW50aW1lIFBNIHJlZmVyZW5jZSB3aXRoIHRoZSBoaXN0b2dyYW0gc3RpbGwgZW5hYmxlZC4gQSBI
SVNET05FIGZpcmluZw0KPj4ganVzdCBiZWZvcmUgdGhlIHN0b3AsIG9yIGEgZmFpbGVkIGlzY191
cGRhdGVfcHJvZmlsZSgpIG9uIHRoZSBzdGFydCBwYXRoLA0KPj4gY2FuIHF1ZXVlIGlzY19hd2Jf
d29yaygpLCB3aGljaCByZWFkcyB0aGUgaGlzdG9ncmFtIHJlZ2lzdGVycyBiZWZvcmUNCj4+IHRh
a2luZyBpdHMgb3duIFBNIHJlZmVyZW5jZSBhbmQgZmF1bHRzIG9uIHRoZSB1bmNsb2NrZWQgZGV2
aWNlLg0KPj4NCj4+IERpc2FibGUgdGhlIGhpc3RvZ3JhbSwgc3luY2hyb25pemUgdGhlIElSUSBh
bmQgZmx1c2ggdGhlIHdvcmsgYmVmb3JlDQo+PiBkcm9wcGluZyB0aGUgUE0gcmVmZXJlbmNlIG9u
IGJvdGggcGF0aHMuIHN5bmNocm9uaXplX2lycSgpIG11c3QgY29tZQ0KPj4gYmVmb3JlIGNhbmNl
bF93b3JrX3N5bmMoKSwgc28gYW4gaW4tZmxpZ2h0IGhhbmRsZXIgY2Fubm90IHJlLXF1ZXVlDQo+
PiBhd2Jfd29yayBhZnRlciBpdCBpcyBjYW5jZWxsZWQuDQo+Pg0KPj4gRml4ZXM6IDkzZDRhMjZj
M2RhYiAoIlttZWRpYV0gYXRtZWwtaXNjOiBhZGQgdGhlIGlzYyBwaXBlbGluZSBmdW5jdGlvbiIp
DQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogQmFsYWty
aXNobmFuIFNhbWJhdGggPGJhbGFrcmlzaG5hbi5zQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+
ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1iYXNlLmMg
fCAxMSArKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNy
b2NoaXAtaXNjLWJhc2UuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwL21pY3Jv
Y2hpcC1pc2MtYmFzZS5jDQo+PiBpbmRleCBkZWJiYzM4NzE3ZGUuLjU0ZjMwOTNlMTRmYyAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwL21pY3JvY2hpcC1p
c2MtYmFzZS5jDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNy
b2NoaXAtaXNjLWJhc2UuYw0KPj4gQEAgLTM4Miw2ICszODIsMTMgQEAgc3RhdGljIGludCBpc2Nf
c3RhcnRfc3RyZWFtaW5nKHN0cnVjdCB2YjJfcXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgY291bnQp
DQo+PiAgICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gICBlcnJfY29uZmlndXJlOg0KPj4gKyAgICAg
aXNjX3NldF9oaXN0b2dyYW0oaXNjLCBmYWxzZSk7DQo+IA0KPiBJIGZpbmQgaXQgb2RkIHRoYXQg
YW4gZXJyb3IgcGF0aCB3b3VsZCBjbGVhbiB1cCBzb21ldGhpbmcgdGhhdCB0aGUNCj4gZW5hYmxl
IHBhdGggZGlkIG5vdCBkby4gU28gaWYgdGhlIGhpc3RvZ3JhbSBpcyBlbmFibGVkIGJ5IGNhbGxp
bmcgYQ0KPiBkaWZmZXJlbnQgZnVuY3Rpb24gKGlzY19jb25maWd1cmUoKSkgLCB0aGVuIGlmIGlz
Y19jb25maWd1cmUoKSBmYWlsZWQsDQo+IGlzY19jb25maWd1cmUoKSBzaG91bGQgY2xlYW51cCBh
ZnRlciBpdHNlbGYsIGFuZCB5b3Ugc2hvdWxkIG5vdCBkbyB0aGUNCj4gY2xlYW51cCBoZXJlLg0K
PiANCj4+ICsNCj4+ICsgICAgIC8qIGxldCBhIHJ1bm5pbmcgSVJRIGhhbmRsZXIgZmluaXNoIGJl
Zm9yZSB0aGUgY2xvY2sgaXMgZGlzYWJsZWQgKi8NCj4+ICsgICAgIHN5bmNocm9uaXplX2lycShp
c2MtPmlycSk7DQo+PiArDQo+PiArICAgICBjYW5jZWxfd29ya19zeW5jKCZpc2MtPmF3Yl93b3Jr
KTsNCj4gU2FtZSBoZXJlLCBpZiBzb21ldGhpbmcgZmFpbGVkLCB0aGVyZSBzaG91bGQgbm90IGJl
IGFueSBwZW5kaW5nDQo+IHdvcmtxdWV1ZSBsZWZ0LCBpdCBzaG91bGQgYmUgY2xlYW5lZCBieSB0
aGUgZmFpbGluZyBlbmFibGVyLg0KPiANCj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZyA/DQoNCk5v
cGUsIHlvdSdyZSByaWdodC4gSGlzdG9ncmFtIGlzIGVuYWJsZWQgaW4gaXNjX2NvbmZpZ3VyZSgp
LCBzbyBpdCANCnNob3VsZCBjbGVhbiB1cCB0aGVyZSBvbiB0aGUgaXNjX3VwZGF0ZV9wcm9maWxl
KCkgZmFpbHVyZSwgbm90IGluIHRoZSANCmNhbGxlci4gV2lsbCBtb3ZlIGl0IGluIHY1IGFuZCBk
cm9wIGZyb20gZXJyX2NvbmZpZ3VyZS4NCg0KVGhhbmtzIGZvciB0aGUgY2F0Y2guDQoNCj4gDQo+
PiArDQo+PiAgICAgICAgcG1fcnVudGltZV9wdXRfc3luYyhpc2MtPmRldik7DQo+PiAgIGVycl9w
bV9nZXQ6DQo+PiAgICAgICAgdjRsMl9zdWJkZXZfY2FsbChpc2MtPmN1cnJlbnRfc3ViZGV2LT5z
ZCwgdmlkZW8sIHNfc3RyZWFtLCAwKTsNCj4+IEBAIC00MjUsOSArNDMyLDEzIEBAIHN0YXRpYyB2
b2lkIGlzY19zdG9wX3N0cmVhbWluZyhzdHJ1Y3QgdmIyX3F1ZXVlICp2cSkNCj4+ICAgICAgICAv
KiBEaXNhYmxlIERNQSBpbnRlcnJ1cHQgKi8NCj4+ICAgICAgICByZWdtYXBfd3JpdGUoaXNjLT5y
ZWdtYXAsIElTQ19JTlRESVMsIElTQ19JTlRfRERPTkUpOw0KPj4NCj4+ICsgICAgIGlzY19zZXRf
aGlzdG9ncmFtKGlzYywgZmFsc2UpOw0KPj4gKw0KPj4gICAgICAgIC8qIGxldCBhIHJ1bm5pbmcg
SVJRIGhhbmRsZXIgZmluaXNoIGJlZm9yZSB0aGUgY2xvY2sgaXMgZGlzYWJsZWQgKi8NCj4+ICAg
ICAgICBzeW5jaHJvbml6ZV9pcnEoaXNjLT5pcnEpOw0KPj4NCj4+ICsgICAgIGNhbmNlbF93b3Jr
X3N5bmMoJmlzYy0+YXdiX3dvcmspOw0KPj4gKw0KPj4gICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5
bmMoaXNjLT5kZXYpOw0KPj4NCj4+ICAgICAgICAvKiBEaXNhYmxlIHN0cmVhbSBvbiB0aGUgc3Vi
IGRldmljZSAqLw0KPj4NCj4gDQoNCg==
