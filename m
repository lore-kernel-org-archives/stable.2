Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021086.outbound.protection.outlook.com [52.101.70.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6842BEA4;
	Tue, 25 Aug 2026 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661579; cv=fail; b=YxtGJPY7uoWahKtPlXDbkfni/USFZoJGABm3HW/fvP+ZMOc83a7tc9I3xE1xGPYv2JhomqbEMwPja5WKDyTGI6mRNox3EV3016FRyXZxJSLbP3FVTOa2whmZaQHUoY3VXpu77DKUgNdiEN5fpZ3c3gNoYnqzdtgW6PNNndk9tHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661579; c=relaxed/simple;
	bh=I4ipyBh1neVmUAEsiFacN35r2qrOOU1Efb8j+f4qXEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEoa/2vSBWVfpX0n2jq4tMwfx++EIqHkKREPV/giZ5srI4Mra7dQ4lx52kvQ6shDW9wAJPJ+N13zE0Rq7/T0YVxVj0uYH6ZdzhSyFKq3ofu4v+AGW4h6ja3+m7Ikrm6tEDzklAwXCEYALDaYdvqpHHuNpSkHVQx2VYQq6TnaNJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=N4/y2pt0; arc=fail smtp.client-ip=52.101.70.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="N4/y2pt0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwVyBo2i4d+V2fYY+7SvtaaVTuNcvpkBD1LgR2j+ty0KtrHQS/YzCXoc7077elzooJvOxjxTt6E9IM8qeekTsu2x/321e7VSyd21MSSUjrK5LfULwJw09zOVSX9J7QFS1dgsewlQPToUi+AChaSwygjn7kzZ4W+dj+Xx6WjjGJ/x5j/anFileCyZ/hic94ILRLjVlInR3ku1qhBFzlcz0/dgdEZFc5na2TprHTBjhk9RgOEdLbkHlABvy0rVGopnCXHw0+1SAp5QBZvN/8+MQYssqwijFLtbOtQ0vmx4vSyeBVZ2g7OvXAcA9bIhXeyevYQNnsO40FIIPEeCfWE8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4ipyBh1neVmUAEsiFacN35r2qrOOU1Efb8j+f4qXEs=;
 b=Ms0ICdKXonjABvMudbFie8QMNivfXldUGDWSBPsyK06vPuiElOh4nIpd+EUd6IszppKl0AmIvxjW2LsG1MWGt4vx+tC0yGHoXsdWb+MYP3nHhHAfM+cU82c07UHme0JYzLDh6yQRYuMK6ayDbx8kajzKYjEE3lcKsaSthweJEzZRQYQakS9dqQ40Jd/kJQxlFSyFxzkldveN82Gi6ceTo5PaG0wgIuD/jgYDx19qyYmEmiTWya84obgA428cHJtmi0j3YIflOI7g+XpZc80gggMK8TS/vA8xhqYY/cjeiEiiVDCCX6b6MUTQY+W55hTn+pgYfD14F6kTZWWbL2hUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ipyBh1neVmUAEsiFacN35r2qrOOU1Efb8j+f4qXEs=;
 b=N4/y2pt0g6yKnGqBNSOdw4/FpKY5NNXAIb0awKpOrss/duWzDRJycTx+X3djCTJX6VJKyovrMd5rOMk7tQOSr/a7R3Tkh87aZlV/ZZsNZfBac9MF8K8lffQKfUOngpuVJHXGGtegmjkPPTJOo2EO+2sBihHmZex7WbS/ZjGlHwUNUZX5Y5N5CKWupFS6rKjeQxuZaWOqkaGpLxzJcrHWZJsYX+Lg2pVirqUIaFnuLvw+GOGTkTDhbp+iO0r6hOpHbFICvbbXotoGg3HS4j5W+Elswf+CMy1qXu0VOAOUicEghDVPel5xzbdDyF4vLpNu/9RL2VF7XEmpBrJ7c6EZFw==
Received: from AMDP195MB976621.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:70a::24) by PR3P195MB1007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:95::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:39:24 +0000
Received: from AMDP195MB976621.EURP195.PROD.OUTLOOK.COM
 ([fe80::9b97:266d:6ac:fc8a]) by AMDP195MB976621.EURP195.PROD.OUTLOOK.COM
 ([fe80::9b97:266d:6ac:fc8a%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 12:39:22 +0000
From: Jan Remmet <j.remmet@phytec.de>
To: Chang Wu <kunjinkao.jp@gmail.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: hd3ss3220: track VBUS enable state per
 consumer
Thread-Topic: [PATCH] usb: typec: hd3ss3220: track VBUS enable state per
 consumer
Thread-Index: AQHdL+5Q9hnBoqgnbUqXRQfvaSVZqLauvaUA
Date: Tue, 25 Aug 2026 12:39:22 +0000
Message-ID: <5459ccff-ee22-4cb1-95e2-ed575d845c9a@phytec.de>
References: <20260819152027.90994-1-kunjinkao.jp@gmail.com>
In-Reply-To: <20260819152027.90994-1-kunjinkao.jp@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMDP195MB976621:EE_|PR3P195MB1007:EE_
x-ms-office365-filtering-correlation-id: bbd23829-8322-4d8b-1ea3-08df02a5e408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 6ajb0NCAV//5Sdgh+1yyM2qSfiqt9s/gEH1lkK++7dV0RWxUk3FQ99KwLVeppyIX5Z8suQpMkM2TL0U9Kh3YJm8Y4BhhIiMmlHqUramZi1oYIXP6cRy7MRCXxFerm/Aoreo+GpwM7OR2Pl/iTRL9g1SZ7bx4nsk1mY54woXyTu2R0uQeD/Tm3iVH/XkE3lXNIuQE/X7tOODgliR6VD3i/lWVYNOcrra7BJc8TpSwtxP5Q1vqz9rg5W9IuR97+EMcgzmN7qWB4yj/vjfjelsCqnDAz9uFYrjHz/s5ompElAbqsKTT5+NSVZ7ClyODikHY7g8mSI+trrfFopJ9K0ri87Tx0UP3aLr8Tbuc17I+2AwZwUqQTy5ZsVUMkXbCQUKRah9e6yzK8+Ts5CljpI5U5Mhgc6fXw6RPug+KBXWNKSCfwF2coFtc6eB5UcGcG7vtWhM3kxLPHbz24nTcBnSUftaIBuejqPe+hitRhQCUInTawDAHAEI9OpJJkwsegxjfFWzlHZQWT12u93VWUiY0vCH8/8eQWubMeJkLJAejFApHp9MVGd7t4PoO4w9XwH6MtDq2zzERohnV0OuSxZrb8kuyjFspB5iXvOZO1e6fqvYYsZ2E8rTiN0gTBqCJ1i6r/A4S5OGeasi9jD76dvEd6mZFZGTCrhYnBrtoAw5XEPOvgAxas2hQ2mDj/HTzuPVZ94xuUCXY0Gfd09IUoR3v1XT7Xquafqw7/GBX/sn1DZk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDP195MB976621.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUNQUjZNc203djJDa2Z6WCtaNVErd3VvdGFUOFM4L0hWZzRlTEJXU1lmRDAx?=
 =?utf-8?B?d1pUNUdzSlJOaVNpUE43bG54YUdnTVJkTDdMdXk0ZGEreGw4SUF6bTdLc1dH?=
 =?utf-8?B?cjR6RGp1Snpsd2VnbGVFeTdma0lDK3M3Y2syeS9WT0pFbXRaVTNGR2NrUUwr?=
 =?utf-8?B?RjZNbTRuVVdYTnphNWJhVnZ6UzJXTVFBbENOTkQzYTlqY0djOGlhcUQwNUIz?=
 =?utf-8?B?c1kwdUMxZFpLU1ArVGZCNXBFWmxjWXUxVU9XR05GR1d5empteVI0Wk1UMm9P?=
 =?utf-8?B?cFdQWVpYYXRTNEliWFFHWXRraFRjYjZHSXNkZUR6b1FzTEtJQVRlQkJKZk5Q?=
 =?utf-8?B?V042amQ5cEZpWnM4TDZqR1gwTEVXbWphaDFZMnRUVnUvTFk0cW5vZ0hYWmZD?=
 =?utf-8?B?b2VKQlFMU2o0RERXdTJYdVo2cStsUmZPV3RJOVlTb2VVWjc1dUpRK21pY3RH?=
 =?utf-8?B?UWl3UWo2WGIwdjFQWGNYZkxTZVJYQ2lxSTgzbEV0T202RGJraXQ5Qm9ZWFhW?=
 =?utf-8?B?QVVRakx3YVZWSVdUbnE0Y1RVNkdEbHdBM1pqSHlVR0VpeDg3Qm1ORmd2R3pp?=
 =?utf-8?B?ZXBoeG9oVnNBYTVXWFhuZlBxbVFxdGdFcGNrQ2JBOWlYMk00Sm9uNGNXNkRQ?=
 =?utf-8?B?cVdrOXF6MFZtYzg1T0Mwb0dXeUdyQklNZ3hwOGZkaiswWmdHSnpkRW9VRzVN?=
 =?utf-8?B?aTlwckx3NXN6QytpNVArR3lrd2p1VHdVanBOcitCL0JUaXUvNnBGTXFhUjBL?=
 =?utf-8?B?K1hLOUhHT0htMkhNNUFveHZiUVkvNlFGYjk5V2UwdVgvWDl2b2duSXVIQUFq?=
 =?utf-8?B?b2Y0M01NckdZeHUzT0JVSXpiUzZiSkFwd2ZieXI2ZlA2TXE0WGZsTTRUR1Nq?=
 =?utf-8?B?VnMxemZTcHNaS2RzbzJ1RGZYYVdIdnhUTEJIZHNGMHpDc0I0cnptemhCZHBC?=
 =?utf-8?B?K09rcGFSYlJQY1djWVdKZm5DblVyTDZ3N1piTGEvVm1VcXIzamhTOUJIU2Yx?=
 =?utf-8?B?L05NZUtnOTN1UW9VbjhDY3pDT1pmMkN0SUlWZldPeWlpenQ3WU9BNnd4dE1t?=
 =?utf-8?B?dGs2akE3c1JwTGNpeEk0NlliVmlvbGNxV05XTXZDU3VWcVN5VUx0ODRNZHNx?=
 =?utf-8?B?MEs5M0NNM0ZZcUYyeUh5c0pCeFAwdlV4K0dGc3hRTWFuTlg3YmRxbmVlcyto?=
 =?utf-8?B?RUp3NkpwVVBSQVZzalBSTEgwcHloYkJWRkFqdGptQXhjWnNUMldVSDZtTzVZ?=
 =?utf-8?B?ZHlBV2o0b1psN3djREtOUytPb0d0eHZNdjNVekxTTzVHM2YzVDdJdXlTbUlI?=
 =?utf-8?B?QVo2VEoxZFNiRUlPOXNiUnlkUWU4YlFLSXNKekMvd0IyN0FKTE45MWxlY0RJ?=
 =?utf-8?B?RHlFK3dhQ01ISFJaYit1Zm1rbkl1Yzh0eDhISkVheE9hNnc1bEhIU0pvQlJo?=
 =?utf-8?B?alBEaEhRZmpGSUVoTlNpQ1dtcFdYTGNSUCtpOWVBM3h3OXFQL0xFUjRuaFNW?=
 =?utf-8?B?U0g0eVlyVFhPSG1uL3JDb0sxQ1BqMDRtOGpURjE2ZExCaDhlRnQzdW9aYTgw?=
 =?utf-8?B?S084TTdraXVsY0w2Q3QxaVkxb2tLTkFSK2hraUVtMUUzRzlGeklqMUJDQ2Ji?=
 =?utf-8?B?dFlqWnFiOEFDQWdQM21nZWNKeDNqS000aUxvbFpzUzJlT1ZFTzBtN0xWRlJG?=
 =?utf-8?B?TDJhVWlWVzBUM0IvVGF4a3hsL2hjZllVWHl4Z0JSZ2lQTFhGR2hnbHpCcWtI?=
 =?utf-8?B?WlMzS0xOSG10YTZiUEdkWEZuNWxSQ04rQlRlZytMUXlKZWJ3T1RmUmw0eWQ1?=
 =?utf-8?B?cnNHd09GalFLVHF5eFN6RXQ2ejA0b3ZMSUIrZkhQOHNPYWkyVWtCVmJ0aVhL?=
 =?utf-8?B?aWFsNVgwbTNpRys5UDZHM2YrbVAyb3kzSGpWSDdMc3l4ZGZsYzV0MjdlRFdZ?=
 =?utf-8?B?YmlUTXlLZ3BaMDdQZ01qM2hyYTJmK3RBdTZuUTVTcEdtQ2VYYUFWRUdVb0ZC?=
 =?utf-8?B?M083RSszYmJpMXRjaTNPR2pwQkJ4YXlkNFYvTHRHOXFwWXlwRmdaUjU0Yi9D?=
 =?utf-8?B?Z2prUW83eHoxck90UWRFNGpZM1U5bWw0dm8yV1V2NnZsemw2cGZNQzJ4YnUw?=
 =?utf-8?B?YW1SWVEydFcwVEM5WEZWRi9kcC92ajVuNzdqa1YvZE5VczdqTGt1ZFhhWXBz?=
 =?utf-8?B?dXgwVmx2WjVqM3BNUzRPZ2V2Z2JYaEo1RUxlMFZ5V200Rnk1ZmdTUEkwWnRI?=
 =?utf-8?B?aDRQUmZZSUVvcVowRktuTVk5UUZPZ1pQNlBPZGdvTnhVVEhzeUtlQm1oV2RR?=
 =?utf-8?B?WjhLak0rN0RPVlNRVURPZ2JqQ0NwV2Ivbko2aFpkTjIyT2JaM1hyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C43EC055887BE4392D09E3755E28E9E@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMDP195MB976621.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd23829-8322-4d8b-1ea3-08df02a5e408
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 12:39:22.8400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ae4XwcX/iqfJOLjevKGYppcEfTNh0bZFNVDDVTHuylpniSHyh3oIu0iJtChD7PNTBaF7Uhb/8Y24D+4LmjTIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1007

QW0gMTkuMDguMjYgdW0gMTc6MjAgc2NocmllYiBDaGFuZyBXdToNCj4gcmVndWxhdG9yX2lzX2Vu
YWJsZWQoKSByZXBvcnRzIHRoZSBhZ2dyZWdhdGUgcmVndWxhdG9yIHN0YXRlLCBub3QNCj4gd2hl
dGhlciB0aGlzIGNvbnN1bWVyIGhvbGRzIGFuIGVuYWJsZSByZWZlcmVuY2UuIElmIGFub3RoZXIg
Y29uc3VtZXINCj4gZW5hYmxlcyBWQlVTIGZpcnN0LCB0aGUgZHJpdmVyIGNhbiBza2lwIGl0cyBv
d24gcmVndWxhdG9yX2VuYWJsZSgpIGNhbGwNCj4gYW5kIGxhdGVyIGF0dGVtcHQgdG8gZHJvcCBh
IHJlZmVyZW5jZSBpdCBuZXZlciBhY3F1aXJlZCwgdHJpZ2dlcmluZyBhbg0KPiB1bmJhbGFuY2Vk
IHJlZ3VsYXRvciBkaXNhYmxlIHdhcm5pbmcuDQo+IA0KPiBUcmFjayBzdWNjZXNzZnVsIGVuYWJs
ZSBhbmQgZGlzYWJsZSBjYWxscyBsb2NhbGx5LiBLZWVwIHRoZSBzdGF0ZQ0KPiB1bmNoYW5nZWQg
d2hlbiBhbiBvcGVyYXRpb24gZmFpbHMgc28gYSBsYXRlciByb2xlIG9yIElEIG5vdGlmaWNhdGlv
bg0KPiByZXRyaWVzIHRoZSBvcGVyYXRpb24gd2hpbGUgdGhpcyBjb25zdW1lciBrZWVwcyBiYWxh
bmNlZCByZWZlcmVuY2VzLg0KPiANCj4gRml4ZXM6IGIzZjlkNmU0OTFmZCAoInVzYjogdHlwZWM6
IGhkM3NzMzIyMDogQ2hlY2sgaWYgcmVndWxhdG9yIG5lZWRzIHRvIGJlIHN3aXRjaGVkIikNCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL3F1
YWxjb21tLWxpbnV4L2tlcm5lbC9pc3N1ZXMvNDcyDQo+IFNpZ25lZC1vZmYtYnk6IENoYW5nIFd1
IDxrdW5qaW5rYW8uanBAZ21haWwuY29tPg0KdGVzdGVkIG9uIG91ciBpLk1YOTUgZGV2Ym9hcmQg
d2l0aCBzd2l0Y2hpbmcgZGV2aWNlIC8gaG9zdCBzY2VuYXJpb3MuDQoNClRlc3RlZC1ieTogSmFu
IFJlbW1ldCA8ai5yZW1tZXRAcGh5dGVjLmRlPg0KPiAtLS0NCj4gVGVzdGluZzoNCj4gLSBzY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3Q6IHBhc3NlZA0KPiAtIFF1YWxjb21tIENJIGNoZWNr
cGF0Y2gsIHNwYXJzZSwgRFQgYW5kIFVBUEkgY2hlY2tzOiBwYXNzZWQNCj4gLSBOb3QgdGVzdGVk
IG9uIGhhcmR3YXJlDQo+IA0KPiAgIGRyaXZlcnMvdXNiL3R5cGVjL2hkM3NzMzIyMC5jIHwgOSAr
KysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3R5cGVjL2hkM3NzMzIyMC5jIGIv
ZHJpdmVycy91c2IvdHlwZWMvaGQzc3MzMjIwLmMNCj4gaW5kZXggZDBkZTVhMjQ4OGY5Li40ZWVj
OTBjODJiYWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL3R5cGVjL2hkM3NzMzIyMC5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL3R5cGVjL2hkM3NzMzIyMC5jDQo+IEBAIC02Miw2ICs2Miw3IEBA
IHN0cnVjdCBoZDNzczMyMjAgew0KPiAgIAlpbnQgaWRfaXJxOw0KPiAgIA0KPiAgIAlzdHJ1Y3Qg
cmVndWxhdG9yICp2YnVzOw0KPiArCWJvb2wgdmJ1c19lbmFibGVkOw0KPiAgIH07DQo+ICAgDQo+
ICAgc3RhdGljIGludCBoZDNzczMyMjBfc2V0X3Bvd2VyX29wbW9kZShzdHJ1Y3QgaGQzc3MzMjIw
ICpoZDNzczMyMjAsIGludCBwb3dlcl9vcG1vZGUpDQo+IEBAIC0yMDgsNyArMjA5LDcgQEAgc3Rh
dGljIHZvaWQgaGQzc3MzMjIwX3JlZ3VsYXRvcl9jb250cm9sKHN0cnVjdCBoZDNzczMyMjAgKmhk
M3NzMzIyMCwgYm9vbCBvbikNCj4gICB7DQo+ICAgCWludCByZXQ7DQo+ICAgDQo+IC0JaWYgKHJl
Z3VsYXRvcl9pc19lbmFibGVkKGhkM3NzMzIyMC0+dmJ1cykgPT0gb24pDQo+ICsJaWYgKGhkM3Nz
MzIyMC0+dmJ1c19lbmFibGVkID09IG9uKQ0KPiAgIAkJcmV0dXJuOw0KPiAgIA0KPiAgIAlpZiAo
b24pDQo+IEBAIC0yMTYsOSArMjE3LDEzIEBAIHN0YXRpYyB2b2lkIGhkM3NzMzIyMF9yZWd1bGF0
b3JfY29udHJvbChzdHJ1Y3QgaGQzc3MzMjIwICpoZDNzczMyMjAsIGJvb2wgb24pDQo+ICAgCWVs
c2UNCj4gICAJCXJldCA9IHJlZ3VsYXRvcl9kaXNhYmxlKGhkM3NzMzIyMC0+dmJ1cyk7DQo+ICAg
DQo+IC0JaWYgKHJldCkNCj4gKwlpZiAocmV0KSB7DQo+ICAgCQlkZXZfZXJyKGhkM3NzMzIyMC0+
ZGV2LA0KPiAgIAkJCSJ2YnVzIHJlZ3VsYXRvciAlcyBmYWlsZWQ6ICVkXG4iLCBvbiA/ICJlbmFi
bGUiIDogImRpc2FibGUiLCByZXQpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJaGQz
c3MzMjIwLT52YnVzX2VuYWJsZWQgPSBvbjsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQg
aGQzc3MzMjIwX3NldF9yb2xlKHN0cnVjdCBoZDNzczMyMjAgKmhkM3NzMzIyMCkNCj4gDQo+IGJh
c2UtY29tbWl0OiBlMWU2ZTU0MWM1YzljZjU0OGU5ZmRjMzVmYzI2ODA4YzgyMDc0NDQwDQo=
