Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7F396D03;
	Mon, 20 Jul 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543234; cv=fail; b=IoUBk19VGlKhnbMQ0FTGaud//XbcJ8vk5rCuMPwLHWNC8aIMwNrg/Y2/nTZZNA/jE3VNOxNnMWAVIFQ+zMsjLM95w27y/GyBqBKGjsv8ICUthoZqq62FiI45PTBD2tOnkGa5vWef5LQCAqcCJqhiNJTErkU07OWmssbw01YBeqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543234; c=relaxed/simple;
	bh=25tirTAbRZ9YTvora8hRcmlG6E/PL+7ahm9oAVpIP20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OzdFdkORsozQHplqv8NnmKFaF62+9VfQNmbZ52CUJGl09WV7tti0AlRD3K1Fxl488LbHzDyOVskc0gvjMo2PBRGJIFKznPHgxTVAkIHLQgCVmPsFoyZmje/hFKIrXSaSbes8zBBhEPOuME+Mgrq1WyFyPpBoYTH6GTYNmWOIpLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pVG5gVSI; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pVG5gVSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiOVqUoBeU9CrGPT74har5XAyidK285BINfsaFt/5r2Spyulwk9tS6sqVyhCq8WOqPapueptWvOxPtp9DwOnYkXJKnD0omXUM5TxicDxTMYUbgYpVM80DRH9O7ko4s7BHX/N80He0AKua3lLcAYZ7u7oGQKBNIiXqezCQblvOjab4h5KzuDjVWTpyQ5bI+e4o4XlS2c77iWF5rt+PjqQI26ZdYEmp7i4Gko7cgR5hJvnBfDLmNiPgGqSMlBWn4BrOTUqYV/p9HJqRP7Xb56/6xJnqCQRGZW1zVRWRzEk0dquXEf1xdwBRI9IxPqsK4s/YIg2vgiO1lOx9xg4plpR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25tirTAbRZ9YTvora8hRcmlG6E/PL+7ahm9oAVpIP20=;
 b=ZqweHOSwyI2GuWDLUOO/YEvuW1eFW7Sx3/bY1W/OKmLZ+dRlS2N08UH0B1q7gTQ3r5WqagKZ1njdBR5AXujTG/ZOxnFlhkBFlerxrMmvB0PFg0IJHRXOlu5eQzRS6Xc8Qo3dJvwFUSfZmO4lnE4ZpRreuZ5Q60agH5Hbw5Ad7AjYbddu6c17rI2hjiQCDfTTkCYQ+wWxXxooxYU9rQtivMHyd9GWJOY6+zeOq+Z8c3zdR8eNE6tY3CS68AMv666MJGZ+cFR5fmuwuucH60+RorQmT7YMAor1MtcEHzXE05DeCa9eevkyb9dBJNvwsQtFihbTamkiov8v2LNLtM4LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25tirTAbRZ9YTvora8hRcmlG6E/PL+7ahm9oAVpIP20=;
 b=pVG5gVSIs50XkZbP4saBYUws+D88qx+j3zdA/zx4Z6Siboh531QbQAZRcL888wP5jR9QmvFtrrGpNuQRz1CnWX2Jv5LSFe7f9J5tSA59Ys3UXwJWcvB38KUcbsk/vK32dAghEJSaiv8lpZ7BDcdbMqRV8TiusgVczPX7RczWnitn9WrGq/hy37wT85XrPBBI0uaKOdPO9i1/1Gblf6Q1Y2wjDWG0ajorqBKvOSmH72oQGyA0cRpEhLlQTBvrqtG6IeRcTqXqZyOQQEzAQ/Sy8fhQD1T6eZ/dtvRGKFcwg57JIhhlVUFQGY+0thj4EY4miJBkqLofHePTcanKBVW5oQ==
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:27:08 +0000
Received: from SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5]) by SJ0PR11MB4910.namprd11.prod.outlook.com
 ([fe80::7af:4219:9135:f1a5%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 10:27:08 +0000
From: <Balakrishnan.S@microchip.com>
To: <ehristev@kernel.org>, <mchehab@kernel.org>
CC: <hverkuil@kernel.org>, <sakari.ailus@linux.intel.com>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
Thread-Topic: [PATCH v2 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
Thread-Index: AQHdB7fe1hE93amFqUWi/QdVnssKvLZxSwqAgAUKKAA=
Date: Mon, 20 Jul 2026 10:27:08 +0000
Message-ID: <1bbde1e1-ccbf-4b59-b442-644d417c6c05@microchip.com>
References:
 <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
 <20260629-balki-isc-prefix-fixes-v1-v2-10-3b120cc3742f@microchip.com>
 <058e077d-acdb-4b86-8499-82b824759f08@kernel.org>
In-Reply-To: <058e077d-acdb-4b86-8499-82b824759f08@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4910:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: b1629057-9bca-45be-5d55-08dee64973f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 O8m+6CbC/BXQJpL3gaUugd6Uo2BFPYt/9qG7glcy4nca8epqqoxSdFFVN37OJgDn1d4obZFzSh3UPUD5i+jtEVojhHcyzvWtLANh/N2DmWsghNaPbtmEQUB2pfY9ycjvcQ9AJT3jevEZCmuzGjeIBOvQcJibuIEO1xDaLBFM1YyWx4SYiLdC88i+dc0r6jAwFfBghMQ23JVOuPw8A+juXkA0Ro6t922Z0PsyWm8A6avLCiUMJ8Pw4hnUTovy4CNRnV7NYUyv/ynElwj3d2GFGATOHR/qnVdb1Y4GWXEL2BUS7l2LjqPXsmaKSgpJBwv7Lrw+GHrTs0mkHoST8NqLjLeeQwHJP09hQKvmfxwyl/KfE5+CYkjv6URN5YpzIy4yy79ZoB2EktGFTVQPjJNUJguem3PFcHhxbyTMuxCoq2Zmf2bc0imcIGTI4aYDGHQMRloTctaeWrN+VIUyEGqFauZrxv33EaFTVlMREiIXNAqC6vhEBucdWwPKuxu+y72aP8s74bMu2taB6EUVEvG8r02UNEUv7BwqeuozIxYtnh2tegYYr+I3VU8D66J6kur1bTXm7RrqzLMONDfAFkFOBq6H7jEpLeDvxKPZEJXzXpNgrFdFW73Z9bDeINXbIeH5HnyLgW8grBxO7I1aUWk2nhTEvKCFhlxNzQQxcP5twOvzrzzEvCNlYcMLVHh8OiQflqv9jmsYA0L2RKJEREbWBcJauMnQgCeUkUqhSMfXS3s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4910.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUpmcXFhMzNzMXR5dEdPLzhIV0drazVPUytKTElHNVZyby8vNWFMT1h1cUtR?=
 =?utf-8?B?TWxEdXkvcEYyaCtqNmZWUE1uUzM2YjdMNGwrZzBoT1JwaUxyVEtHcndWTzVU?=
 =?utf-8?B?S3FkQ0QyemkxZDlLcGpibmVKWUt0aVN4dHhaZjhHRXNmakdzUXpML3Y5b3ll?=
 =?utf-8?B?WUVnelA3RFBhQjNBSEU1eG1ZZldZb3VXTjlzUzBhMkEzZ1ZZSnZpZVl1T2lo?=
 =?utf-8?B?eG1yaGJWSnB0Q25MTTk4aUk1UGtiNmQ3NTc1SGNHSHNYU0lNUlhpanYwRFI2?=
 =?utf-8?B?UXFUSWZmMDI0VkRMSjkxeHZpU2N6VE9QUjJaa3d5WTdrbXBtR2pYQWF6enRO?=
 =?utf-8?B?VU02MS9nZU8vNVlxcG4zQSt6SjBaQ3N5MWJ0cHVGUVl0WkowNXQvWlcxSHdk?=
 =?utf-8?B?N1I3MTBLVmhvV1lLRHRFUHVXOUNaWVdNUUpYb2lNdzFlcklyOEh6SjZGRjh2?=
 =?utf-8?B?OWdsYy9Xcm1TdnBjTC9wZTJaTy9HYlVybTNrUElYZEtlMlRXZEp5UnlCY01L?=
 =?utf-8?B?dE1tcWlydzNTdDZNTzhsZlkrQ1N6ZTFLdFEzNzAzd3ljZk0zNjVzWlFnbnpM?=
 =?utf-8?B?V2d2MkFoVTRqQVdzK3B0TGt4YURYSnlESWpyMXNWNkFqb2RJaHpXNkVRaG4w?=
 =?utf-8?B?Q0syNzNrOSs0dXJ0Nm1lZ0ZuNnVHajhOd0I0S3FUdjd0ZXpXemZoRysyTzhj?=
 =?utf-8?B?YnNWTTJqK2IrS0p6VkhKeEg0Qk80eDdwa1kvOHBzWFQ2Ui8rdjBnb2MrUlZE?=
 =?utf-8?B?MDk1ZHdlcUNNVjNWei9JbDFJVE9qNTNHa01TK3dBaFJ4ZUwrcnQvMGY4U2Z6?=
 =?utf-8?B?R1Rmd2VISmVCcG91WnRHb3c5eVlNN3liTFBkUEpjKzRBNlF6clQ2T3FLRGVj?=
 =?utf-8?B?c2dBNjUxeC9GamhGa0MxS0JXcUVWNmZxd3dsdW5JTlBTL2V2TGxlSTZIT2c0?=
 =?utf-8?B?NFZxaVRZMi90aHBFWXJuaENQbUxRUTFGbnNFQXgrNnl6Q082QWtmeU1EWVI5?=
 =?utf-8?B?VkZtenlUenJFU2t5RnB0ancydmpPeitMeXprVlJ4aHNWR1E3VFljejRjdjRJ?=
 =?utf-8?B?NE9lZXZUNk1FR1Boc1ZOc1Vra25OUUU0M2RPUWVpYXovOStodXhaRWxKUFMw?=
 =?utf-8?B?NlpLODR0VENSSGxUNjRLdHNodjcxNC9BbFB2UDFDMHBLWnVRRGI3bENrS1NY?=
 =?utf-8?B?eVdvMGN4YS9PYkpvMGdWVStHVkgyaHlCQk5ydDhtR05CZzN1dGNXYnpFTHZq?=
 =?utf-8?B?cmw0N291WjRMVEZHT0JGa2xKYmRnTlJMNFJEZXdjdGlPVDBxQ3Ewbk42Ni9U?=
 =?utf-8?B?cGxlTVY4THlycHFUVUk1TnY1VFB1V2lNSzMwYjlPMEZuS0V5ME96ZGFkSDh5?=
 =?utf-8?B?SURFRjlMZElvUXk4NXdLZXU0UkVkUFBGMDVGaG43bjk4b2xNdWRzL3liUWVq?=
 =?utf-8?B?MzJhL0RncXhVdlIxQUpmU0Z1ejRVZWhBcnZmS3lXOW5MLzBDZGZWY1oxS0g0?=
 =?utf-8?B?WWRuQ0p2QVZ5MjRuN0kzSlk1R0VFK0lVYmRMcHpxcStGMVBvWkxxamtvaE9q?=
 =?utf-8?B?RFd5TnVDNDNpWms3SXRsdnBYMDRWRno0UjEwTlJnYTUrMnNvZnVFQTR5akVh?=
 =?utf-8?B?TVRqcVhWaFBYUEtpeWd1QTBaK0Y3NmtBYkVzOHVPclg3cm5Ja25ZcHcvMkRR?=
 =?utf-8?B?TytSakRDWi9GdCt3aXU0dFJqUUM3L1dlbTNvQzdFMkpHcVB5Z1RTWFYybzRt?=
 =?utf-8?B?L2hwc1FNRzl5WEJMajNldVV6UnV3RFpaUklXM1QzTVNjcllMait4ZEVCT1hy?=
 =?utf-8?B?QVVvRGNYMHM1MklUZjNOejhmMjF4QlVDRjBqYXJDK1VFZGRzbCthTkRzN2d3?=
 =?utf-8?B?SXhZczd3cFYvVHVHeUVSN0s3RFN3b1BSYm42WXRxZDJFNmRMOUR4ODhVdDlB?=
 =?utf-8?B?RHpYVDA3WTM5T1RZVTVWdmp2RVppa3JCTW1mUTdpUjJ1VWlFRW5iYWZLVUhK?=
 =?utf-8?B?aVJZVEhZaUZHNmxVdUdmcVV0NHJ0TzNvbHJIM1FRUUR4TEphL2dtcGVKWk0x?=
 =?utf-8?B?WklHcGdSaitBN0lQdktHUkpFWGV6RGJUZzd4TnNKNytVMzR5blFHQmFNZWRk?=
 =?utf-8?B?a0RDcm9UZUpQOXg1ZUxEMjFBbmhNMjVMM1RKVlNSajVDRE1TaWJqV1U0M2hQ?=
 =?utf-8?B?SEd5U1RuTEFtVmVobGhSNkNub3QvSDJtbkh0eEQxVlliTTJmdGJNcjZvdEQx?=
 =?utf-8?B?Q2QzRDFLczJVMjJaRU4zK3o5aFlqc01hQzdJVDYvVjN2YllrbUkyNmJSaEZv?=
 =?utf-8?B?R2NySGUvYVJkdHhFY2ZVK2lnYkFCVVFOWXhoQnJmM2tzUGhRT3Q3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA1E3941C139E44FBB0190994DF6B210@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1629057-9bca-45be-5d55-08dee64973f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:27:08.5421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06bWrVEzzFZmzKMmuob6HLI+/y3ZJZKjNekhsawk+5FZkVRx3ixgiR3f9FYiekwu9f8e7gio3mSJ2WxeyuodPdMdr41pIn2ybgygAzeC694=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132

SGkgRXVnZW4sDQoNCk9uIDE3LzA3LzI2IDEwOjU5IGFtLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDYvMjkvMjYgMTQ6
MDksIEJhbGFrcmlzaG5hbiBTYW1iYXRoIHdyb3RlOg0KPj4gSVNDX1dCX09fKiBhbmQgSVNDX1dC
X0dfKiBwYWNrIHR3byAxMy1iaXQgZmllbGRzIHBlciByZWdpc3Rlci4gU2lnbg0KPj4gZXh0ZW5z
aW9uIGZyb20gbmVnYXRpdmUgb2Zmc2V0cyBjb3JydXB0cyB0aGUgdXBwZXIgZmllbGQuIE1hc2sg
Ym90aA0KPj4gZmllbGRzIHRvIDEzIGJpdHMgYmVmb3JlIHBhY2tpbmcuDQo+Pg0KPj4gRml4ZXM6
IDkxYjRlNDg3YjBjNiAoIm1lZGlhOiBtaWNyb2NoaXA6IGFkZCBJU0MgZHJpdmVyIGFzIE1pY3Jv
Y2hpcCBJU0MiKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYt
Ynk6IEJhbGFrcmlzaG5hbiBTYW1iYXRoIDxiYWxha3Jpc2huYW4uc0BtaWNyb2NoaXAuY29tPg0K
Pj4gLS0tDQo+PiAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1i
YXNlLmMgIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1iYXNlLmMgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNyb2NoaXAtaXNjLWJhc2UuYw0KPj4gaW5k
ZXggMWE5Yjk3ZWRmYTMyLi43OWE1OGVmYjYzMzMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21pY3JvY2hpcC9taWNyb2NoaXAtaXNjLWJhc2UuYw0KPj4gKysrIGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAvbWljcm9jaGlwLWlzYy1iYXNlLmMNCj4+IEBA
IC02MiwxOCArNjIsMjQgQEAgc3RhdGljIGlubGluZSB2b2lkIGlzY191cGRhdGVfYXdiX2N0cmxz
KHN0cnVjdCBpc2NfZGV2aWNlICppc2MpDQo+Pg0KPj4gICAgICAgIC8qIEluIGhlcmUgd2Ugc2V0
IG91ciBhY3R1YWwgaHcgcGlwZWxpbmUgY29uZmlnICovDQo+Pg0KPj4gKyAgICAgLyoNCj4+ICsg
ICAgICAqIE9mZnNldHMgYXJlIDEzLWJpdCBzaWduZWQgZmllbGRzIFsxMjowXSBhbmQgWzI4OjE2
XS4gQ2FzdCB0bw0KPj4gKyAgICAgICogdTMyIGFuZCBtYXNrIHRvIDEzIGJpdHMgc28gc2lnbiBl
eHRlbnNpb24gb2YgYSBuZWdhdGl2ZSB2YWx1ZQ0KPj4gKyAgICAgICogY2Fubm90IGNvcnJ1cHQg
dGhlIGFkamFjZW50IGZpZWxkLg0KPj4gKyAgICAgICovDQo+PiAgICAgICAgcmVnbWFwX3dyaXRl
KGlzYy0+cmVnbWFwLCBJU0NfV0JfT19SR1IsDQo+PiAtICAgICAgICAgICAgICAgICAgKChjdHJs
cy0+b2Zmc2V0W0lTQ19ISVNfQ0ZHX01PREVfUl0pKSB8DQo+PiAtICAgICAgICAgICAgICAgICAg
KChjdHJscy0+b2Zmc2V0W0lTQ19ISVNfQ0ZHX01PREVfR1JdKSA8PCAxNikpOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICgodTMyKWN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9SXSAmIEdF
Tk1BU0soMTIsIDApKSB8DQo+PiArICAgICAgICAgICAgICAgICAgKCgodTMyKWN0cmxzLT5vZmZz
ZXRbSVNDX0hJU19DRkdfTU9ERV9HUl0gJiBHRU5NQVNLKDEyLCAwKSkgPDwgMTYpKTsNCj4+ICAg
ICAgICByZWdtYXBfd3JpdGUoaXNjLT5yZWdtYXAsIElTQ19XQl9PX0JHQiwNCj4+IC0gICAgICAg
ICAgICAgICAgICAoKGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9CXSkpIHwNCj4+IC0g
ICAgICAgICAgICAgICAgICAoKGN0cmxzLT5vZmZzZXRbSVNDX0hJU19DRkdfTU9ERV9HQl0pIDw8
IDE2KSk7DQo+PiArICAgICAgICAgICAgICAgICAgKCh1MzIpY3RybHMtPm9mZnNldFtJU0NfSElT
X0NGR19NT0RFX0JdICYgR0VOTUFTSygxMiwgMCkpIHwNCj4+ICsgICAgICAgICAgICAgICAgICAo
KCh1MzIpY3RybHMtPm9mZnNldFtJU0NfSElTX0NGR19NT0RFX0dCXSAmIEdFTk1BU0soMTIsIDAp
KSA8PCAxNikpOw0KPj4gKyAgICAgLyogR2FpbnMgYXJlIDEzLWJpdCB1bnNpZ25lZCBmaWVsZHMg
WzEyOjBdIGFuZCBbMjg6MTZdICovDQo+PiAgICAgICAgcmVnbWFwX3dyaXRlKGlzYy0+cmVnbWFw
LCBJU0NfV0JfR19SR1IsDQo+PiAtICAgICAgICAgICAgICAgICAgY3RybHMtPmdhaW5bSVNDX0hJ
U19DRkdfTU9ERV9SXSB8DQo+PiAtICAgICAgICAgICAgICAgICAgKGN0cmxzLT5nYWluW0lTQ19I
SVNfQ0ZHX01PREVfR1JdIDw8IDE2KSk7DQo+PiArICAgICAgICAgICAgICAgICAgKGN0cmxzLT5n
YWluW0lTQ19ISVNfQ0ZHX01PREVfUl0gJiBHRU5NQVNLKDEyLCAwKSkgfA0KPj4gKyAgICAgICAg
ICAgICAgICAgICgoY3RybHMtPmdhaW5bSVNDX0hJU19DRkdfTU9ERV9HUl0gJiBHRU5NQVNLKDEy
LCAwKSkgPDwgMTYpKTsNCj4+ICAgICAgICByZWdtYXBfd3JpdGUoaXNjLT5yZWdtYXAsIElTQ19X
Ql9HX0JHQiwNCj4+IC0gICAgICAgICAgICAgICAgICBjdHJscy0+Z2FpbltJU0NfSElTX0NGR19N
T0RFX0JdIHwNCj4+IC0gICAgICAgICAgICAgICAgICAoY3RybHMtPmdhaW5bSVNDX0hJU19DRkdf
TU9ERV9HQl0gPDwgMTYpKTsNCj4+ICsgICAgICAgICAgICAgICAgICAoY3RybHMtPmdhaW5bSVND
X0hJU19DRkdfTU9ERV9CXSAmIEdFTk1BU0soMTIsIDApKSB8DQo+PiArICAgICAgICAgICAgICAg
ICAgKChjdHJscy0+Z2FpbltJU0NfSElTX0NGR19NT0RFX0dCXSAmIEdFTk1BU0soMTIsIDApKSA8
PCAxNikpOw0KPj4gICB9DQo+Pg0KPiANCj4gRG8geW91IHRoaW5rIHlvdSBjYW4gcmV3cml0ZSB0
aGVzZSB1c2luZyBGSUVMRF9QUkVQID8gSXQncyBnZXR0aW5nIGENCj4gbGl0dGxlIGNvbXBsaWNh
dGVkIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBiZWluZyB3cml0dGVuIGhlcmUuDQoNCk1ha2VzIHNl
bnNlLCB0aGUgV0Igb2Zmc2V0L2dhaW4gd3JpdGVzIHJlYWQgbXVjaCBiZXR0ZXIgdGhhdCB3YXku
DQpXaWxsIHJld3JpdGUgdGhlbSB3aXRoIEZJRUxEX1BSRVAgaW4gdjMuDQoNClRoYW5rcywNCkJh
bGFrcmlzaG5hbg0KDQo+IA0KPiANCj4+ICAgc3RhdGljIGlubGluZSB2b2lkIGlzY19yZXNldF9h
d2JfY3RybHMoc3RydWN0IGlzY19kZXZpY2UgKmlzYykNCj4+DQo+IA0KDQo=
