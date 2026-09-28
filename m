Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A94486E7D;
	Mon, 28 Sep 2026 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586609; cv=fail; b=NjoJBiapCJYumUOC1ZtIGrv5f45bpjex7y+gpW9dqpC7m1oNS6w64dcNlOfycvWXMuWcXBW6vJTaPs7N/cl1TPoMimpGsBKyZIVwJrZHD/RyCg8m/cFt69eaJrQCq3PN6H16+pCQduxntCID/Lh4MyuMJTrQp5DC/Tk2kPYlzjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586609; c=relaxed/simple;
	bh=E4eAgh53G0DOmxlvhp5hQEP6ce1lFAA77RRJzZzHLXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lb8CNXEpLhc6IlzKl4qup8K3bH5tzyJjPsXsVLVDapkc6eTjhcLB82NOj5wp89Dppbez5H8cJR2ioZU64LVuAD0pKpKmJdTNHrYh5VB1KNZdRW9o6+LQDHfRTgFZxpcKncIBY/Zcgl+yV9gUEkJ9Nz2toEQe83VVrIs3blkuQwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IsgLFAZf; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IsgLFAZf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHU9fP0tnlgb3AOwGfKiAEtSxRl81Yc48sM/RrMXmE3IMK7pK+F7o900W0syiFzk3uwFuH0LfnUsgHNuYH7lmxm3rDdukVLU7E1QEm8v2GxmiqcwH+RP53Oy9yNwzde9uL4f0pbs9WMPuAZCP6fTITEdReQyGyMUkCGQgj4xwvLVEDSys4Pcl+rQikmB7En6lleSbGVrtYuPBQRC5VOXpjg9pCIDGFpmtIY3H1uqJL8YAXHAF7Ucepr4styNRuyfKahjQa5r2IONGf+0Ok6XsCngw2XHY4RVgOx2mGKfbjO45etjFmrWsr4qXwjaXUHalO/wiUdbQuIh0MyxrHlsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4eAgh53G0DOmxlvhp5hQEP6ce1lFAA77RRJzZzHLXg=;
 b=PrmNHQX4iuRQgA6ir/hSIqjvnE0q+/hFDrd70U2JBebmNaAU8bes8wWjnH7kz3xX2XSMmtmrw4HBCNnUCam7/tgV1+jtQoXggrp2tJsh7JE7vuR/v+ZRYXQqRqpivenDSGfmsYukL0uYaud7kJbIA8ycGdQAkKitHmtoWhmbvO+VGhp+4idbYihNLbFi1hP1kjaid+S0t58QPUlQr7R1DvXpJ/k2xoWsP3VUvFPUU1LZx8/UuaY4yB+TFiINocWx/7CnmUCSgz0n9Nadgo8QaovQm3iWCZ9Tns/6U/hDDQ7M5rzN08ID293b0rH8OgkzLwgcEJroqiOfLoVwZorn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4eAgh53G0DOmxlvhp5hQEP6ce1lFAA77RRJzZzHLXg=;
 b=IsgLFAZfjDF4Q27CumhvOq50rbGnnHNOh+KuCaWnDyjBQe3AVZIJk6C5K3NH4DQAB/f1fpx0PLEcK2OcGHWvRswa3hnH5YR56j7uNBsz2GLv52oGc+82mF2d0gSKsW++F47I497fqF4dt7txZe6gV0fadPNAcYfR6N/s/RL3b9CI8iRSwlm5qLEWRf7Wu7ugxxHMPiFK/HOt9JI2C2LuYFB3sHKLbZi6JN21p1gY/mP5k36mbPtxf/cV0DbNAb1Tld3foGYpJsRwg4AzBSw9xVGaj/kmOLyaXF5Y5wsteXHVeQsHlWdZacjvlV05m72MQ3mGRdxngrFdKrkcPqs6CA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB7802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 09:10:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:10:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "pavel@kernel.org" <pavel@kernel.org>,
	"mike.marciniszyn@gmail.com" <mike.marciniszyn@gmail.com>, "lee@kernel.org"
	<lee@kernel.org>, "kees@kernel.org" <kees@kernel.org>, "kabel@kernel.org"
	<kabel@kernel.org>, "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] leds: trigger: netdev: Fix sysfs_update_group()
 races
Thread-Topic: [PATCH v2 3/4] leds: trigger: netdev: Fix sysfs_update_group()
 races
Thread-Index: AQHdSaw1RSCe9gksgkygjulSheGOU7bjvu+A
Date: Mon, 28 Sep 2026 09:10:01 +0000
Message-ID: <076481c222a8e5016b44a77137e02a6571fd6fe4.camel@siemens.com>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
	 <20260921093249.3481413-4-alexander.sverdlin@siemens.com>
In-Reply-To: <20260921093249.3481413-4-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB7802:EE_
x-ms-office365-filtering-correlation-id: 4545791c-1ccc-48e4-4700-08df1d40473f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 F0s0yVRYk00zXKEtav/MEYhjLUumDMrD6vACsjXBpTdrlInG0cu9C9oc4ea3U0NPFsChPyY9zVMuVtxGrZpOfWkaCUsMZ02rm0taqPJ8kSvomygjsmy9oz7wK92EN9ts3fTE+z9wtNpJZfgtlZ/OvJO/gfdrY5XSNNh05fPG4hzkfT1NQ4rUiA0aZTJyyTo3ZyoDOnkqBkFvD/eohbaBoji1/6nTBis/bOcH0Mr6f55p+nTOAt/+GA2Hp4NIDI4PaT5HepmLwO+4XErCx0F/c0e/4SHP8w8LKJvzhvZJHAgoFc1ZYqpcrLkuO9laT3FkCUDKHa2SzR5lIRo639KGGK0SaNwq1DZV6Gb0y73BZyD9LPKD5z2pOIjHiiAkG6pyKYUtvr08zRbM1+hDP8kb+ENkzvukVoqQQnnQ9Iq7as3yHmegAqt6ryoZT/5gVmqmee8hF5zJGuaykrWKdmH0IXo+/y+16ATsjk/JY0VKzNChTs3zc6WA73RHwXRAsOHm0PFJoHBbxrGfXKhOZXEpll1lo3tvrl7PKP1B94nE/s6sEAVMZsHwrkTzzzM8wwDb+Q/9E2D6+BJ0A04eKxBIuGgyo0XKcmckP91caNFM76vn6/ICSNZLjXw+ihW7SoJhU0ZHMvxZ0in7IShx+oDzb3aFdoWJpZFQnKylIjy1KGY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1VSOTNBTSsrTWhlcGxlSGR1TEdZUmVGOHIzeDREMHUraFovNUlXN05oUkNW?=
 =?utf-8?B?THlSclpHZVZ1UWNZTTRRL2NnMmVDQzJCR0Vud0FsQmNmOUh0bXd6bHh6SlB0?=
 =?utf-8?B?K1prVUJab2RlazFLdWdsUGxUK2NOTjBhUGpMMS9TNFBvQjNPYVUzUUtjT1VN?=
 =?utf-8?B?VUxEOEpJYzU5emRRRGoybk9hbVV2Y1AzOXlNdkZlNVNpa1FpYUJYNDhFN0tZ?=
 =?utf-8?B?dnlhYXlJZDRTQnFDaWpOUlpSdzUzMVF5TDhIQkhyV09abC9zWDNrenNlYVFl?=
 =?utf-8?B?MC9qV2swUHZ1VCs1akswY0xzbU14VEJTVkkyQkdXNHVZNGFkbjh5VmZwZVQw?=
 =?utf-8?B?ZTRBNVU2RmZ2eEtWcTIrYUkzMDBxQ0FFSFVrQkVzNDlYVGdTT2FqRTlYUWVv?=
 =?utf-8?B?UWIrM3FVdG1NdmxkKzNNVXFWRi9scnRIVWVCelM2WittYTAvY1hoaEVJWTdy?=
 =?utf-8?B?R3kxdE9jSnFJc2c0V0xJUmVWRlpXc1JwYXc1VzVYdjZ0U2M2S0xwOVZRamhL?=
 =?utf-8?B?NVNIT0RmYlBjY2ZRTzhmdHY1L2kxSlk4T2pVZUhyRTdVY3dCazVIcW5Vbmsy?=
 =?utf-8?B?YWtqTHkwQWVpcHR2SW5vRnNHOEpZOTdubGJOMGUyaER2QVJmaURZSTVzQ0RX?=
 =?utf-8?B?ckFoMjBhU05DVVdqYlBmRHdYNnB0MkI3TlFKcnFSOG9NRDBESzljc2FOd3BG?=
 =?utf-8?B?ZHlCaEhSbE9Ta1pKVmIrRlppNUxISS9BbkN0dkp1VE56QWF5NDlyckNxQld5?=
 =?utf-8?B?RFFXc3M0eVFhQVJMTFlma1dpTldLLzFaYXVCd3ZRUncxZ1phbkRqbENsZ24w?=
 =?utf-8?B?RFAvY3IveXVubmpKTUN1a1JLWkRpSU5PUTdBWWJUd3pkYUM0b0w4OEwwTXpW?=
 =?utf-8?B?NDBFR0l5YWlZeERKdm8vUWRRUlg0QU8ydjVxY3BETTRuZUhqSzQ2alNXeHF1?=
 =?utf-8?B?Q29xdmVYTG9TdWVocGZxVnRnbndjQ2ttbUFlOGhUN2JobFJBTlRPYklLa1FX?=
 =?utf-8?B?S1loQVhETEZFQXk3YkhmNTJlRnB2czlCRk9ZSFRZRzBJVGU0N1RlOWpvaWlY?=
 =?utf-8?B?YmZCVWF5S0ZDTFMwWS9vaUkvbGpuNmtnaEE0NGNWQU5EeFE0QXc5NkprclV6?=
 =?utf-8?B?alMreXdFUHV6U21QZENRRFJDRzZFSW41ODhHSTB2dTR5NnNKNGlRRFFDYXU1?=
 =?utf-8?B?dGpYSkxZUEthaERPeUJHNXVwaGxxYVJQb0FNNzJUR2JsN0hmYzI1NWU3WDFJ?=
 =?utf-8?B?bzRvUGs1SEdiU3B5M2lLalNsdjgreUI3WWVVZ3lRRTMrQUxnK2VHcnJvUVZz?=
 =?utf-8?B?Q2VrS2trVGs2ODBpd3JiVllNMUFrbmpKZHlpZ3FwVCsxejdpOU1EUXZ5SkJZ?=
 =?utf-8?B?TmxrYlVDUW1JcytCVWVhdEVWQU1YU21heUordWJ1T204VmdjaVZjSm9MRDJ5?=
 =?utf-8?B?c09zMSttYlZLK1U5MTNUQmU1ZXcrRS9VN0RheEd1ViswQkVwRzlwMVU1djlj?=
 =?utf-8?B?aThqNGF2M3BEQkdZUGE1d3c0NUlwRzd4WE1qUXh2TG10cFlWRGsxdW9QZ1Ur?=
 =?utf-8?B?bXJ1OUV6a2xQbVdIakFzdSs1aGc0OHRYYnl6bXFsSENpWmJXby9MMWNJTVRJ?=
 =?utf-8?B?cVlCcW9nRFV5aFN3YlJFZXR6Sm8yQzlHeG9oTUJGUURsbGM3OHdTWWdjUmVW?=
 =?utf-8?B?Wmtwdll3NmJyOXNmZmNiUWFJbC9oZFN1dWU5QmJ1Nng2QjRIYWtleVpuNEN6?=
 =?utf-8?B?WGg0MkprNU5ZRG0xL3NDWHo4RXZUb2VhRlBkMU9IVlluNDVZZEpGY3Y1Uk5t?=
 =?utf-8?B?TzVVQTlLYXcwUUwxb2lvZGhUTy9TeXhybWQ4ZS9IWjVJS1pCd1lETllUa2NI?=
 =?utf-8?B?UDlzZDkrSTlwR2d0aDNjZm9pSGlaNnlKaGhPcG1VWU9ZV3VKenR2Qks1M2VR?=
 =?utf-8?B?aXRSZm8zdDh6S2lGNFh0Y3liVmlHZmI2SUpndHNmcU55VG12eHJueGRadkM0?=
 =?utf-8?B?TTNUcjI4dzNjakgyZ2dBZGlqZWhVckdtbkZjeEVWKzRNWmRpcnUvR0J2enNI?=
 =?utf-8?B?ZitlZVg0SlVacHg4bWs5ZUN2SWplSmZrZXBJeEhYaVAxam82a2lVQ3VuVklB?=
 =?utf-8?B?K2xodEVvY2FqV1IxYVFtWFp3bmJ0d2RWcWZPTDdPcUg1bjAvT0U0UG0rTU5y?=
 =?utf-8?B?d3pxWGtTZENMNm9rWkEwUlM5RVlKOTdyVGdaYkxzeHNnK3Q4Umo3RlFYQnZa?=
 =?utf-8?B?RncwR0phSUswUDdyV3p2Qnhpejd0c25JOVlUOEhESlRkbE91NFFKOTIvU0xG?=
 =?utf-8?B?Z1FZMnRkazFvRHBCdSsxMHAyUVU3S3lKTWZQZ1N0cUtsTkJBVXRWTDU3Rmhj?=
 =?utf-8?Q?GjbEVlQyij3e08e0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79B54FCACA541A4BB700F9F3308A224B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4545791c-1ccc-48e4-4700-08df1d40473f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:10:01.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj5hgVTIfXYS3nFZ6OzqC7SO9rLbvnmn4+wgNN3Td+GM1DElWDnOZUTQO+OfcvnZNyn+73kaogdpniEL7mVRSzwdbFeaf3gbPYIZ1TPit18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7802

SGkgQW5kcmV3LA0KDQpPbiBNb24sIDIwMjYtMDktMjEgYXQgMTE6MzIgKzAyMDAsIEEuIFN2ZXJk
bGluIHdyb3RlOg0KPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxp
bkBzaWVtZW5zLmNvbT4NCj4gDQo+IFRoZSBsaW5rX3NwZWVkIGF0dHJpYnV0ZSBncm91cCB3YXMg
bGlzdGVkIGluIG5ldGRldl9sZWRfdHJpZ2dlci5ncm91cHMsDQo+IHNvIHRoZSBMRUQgY29yZSBj
cmVhdGVzIGFuZCBkZXN0cm95cyBpdCB2aWEgZGV2aWNlX2FkZF9ncm91cHMoKSAvDQo+IGRldmlj
ZV9yZW1vdmVfZ3JvdXBzKCkgaW4gbGVkX3RyaWdnZXJfc2V0KCkgKHVuZGVyIHRyaWdnZXJfbG9j
ayksIHdoaWxlDQo+IHRoZSB0cmlnZ2VyIGFsc28gcmVmcmVzaGVzIGl0IHdpdGggc3lzZnNfdXBk
YXRlX2dyb3VwKCkgZnJvbQ0KPiBuZXRkZXZfdHJpZ19ub3RpZnkoKSBhbmQgZGV2aWNlX25hbWUg
d3JpdGVzLsKgIFdpdGggbm8gc2hhcmVkIGxvY2sgdGhpcyB3YXMNCj4gb2JzZXJ2ZWQgYXMgYSBz
eXNmcyBzcGxhdCB3aGVuIHRoZSB0cmlnZ2VyIGlzIHJlLWFybWVkIGR1cmluZyBQSFkgbGluay11
cDoNCj4gDQo+IMKgIHN5c2ZzOiBjYW5ub3QgY3JlYXRlIGR1cGxpY2F0ZSBmaWxlbmFtZSAnLi4u
Z3JlZW46bGFuL2xpbmtfMTAnDQo+IA0KPiDCoMKgwqAgQ1BVIDAgKGxlZF90cmlnZ2VyX3NldCnC
oMKgwqDCoMKgwqDCoCBDUFUgMSAobGlua3dhdGNoIHdvcmtxdWV1ZSkNCj4gwqDCoMKgIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDCoMKgwqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IMKgwqDCoCBhY3RpdmF0ZSgpOg0KPiDCoMKgwqDCoMKgIHJlZ2lzdGVyX25ldGRldmlj
ZV9ub3RpZmllcigpDQo+IMKgwqDCoCAuwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXRkZXZfdHJpZ19ub3RpZnkoTkVUREVWX0NIQU5H
RSk6DQo+IMKgwqDCoCAuwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzZnNfdXBkYXRlX2dyb3VwKCkgY3JlYXRlcyAibGlua18x
MCINCj4gwqDCoMKgIGRldmljZV9hZGRfZ3JvdXBzKCkNCj4gwqDCoMKgwqDCoCBjcmVhdGVzICJs
aW5rXzEwIsKgIDwtIEVFWElTVCENCj4gDQo+IFRoZSBtaXJyb3IgY2FzZSAoZGV2aWNlX3JlbW92
ZV9ncm91cHMoKSByYWNpbmcgdGhlIG5vdGlmaWVyKSBsZWF2ZXMgYW4NCj4gb3JwaGFuZWQgc3lz
ZnMgZmlsZSBwb2ludGluZyBhdCBmcmVlZCB0cmlnZ2VyX2RhdGEsIGkuZS4gYSBVQUYuDQo+IA0K
PiBNYW5hZ2UgdGhlIGdyb3VwIGluIHRoZSB0cmlnZ2VyOiBkcm9wIGl0IGZyb20gbmV0ZGV2X2xl
ZF90cmlnZ2VyLmdyb3Vwcw0KPiBhbmQgY3JlYXRlL2Rlc3Ryb3kgaXQgaW4gYWN0aXZhdGUoKS9k
ZWFjdGl2YXRlKCksIHNvIHRoZSBMRUQgY29yZSBuZXZlcg0KPiB0b3VjaGVzIGl0LsKgIFRoZSB0
d28gcmVtYWluaW5nIHJlZnJlc2hlcnMsIG5ldGRldl90cmlnX25vdGlmeSgpIGFuZA0KPiBkZXZp
Y2VfbmFtZV9zdG9yZSgpLCBhcmUgc2VyaWFsaXplZCBhZ2FpbnN0IGVhY2ggb3RoZXIgYnkgYSBk
ZWRpY2F0ZWQNCj4gYXR0cl9sb2NrLCBhbmQgdGhlIGlzX3Zpc2libGUgY2FsbGJhY2sgdGFrZXMg
dHJpZ2dlcl9kYXRhLT5sb2NrIGZvciBpdHMNCj4gc3VwcG9ydGVkX2xpbmtfbW9kZXMgcmVhZC7C
oCBzeXNmc191cGRhdGVfZ3JvdXAoKSBpcyBuZXZlciBjYWxsZWQgdW5kZXINCj4gdHJpZ2dlcl9k
YXRhLT5sb2NrLCBzbyBpdCBjYW5ub3QgZGVhZGxvY2sgYWdhaW5zdCBhIGNvbmN1cnJlbnQgbGlu
a18qDQo+IHN0b3JlIHRoYXQgdGFrZXMgdGhhdCBsb2NrLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gRml4ZXM6IDA2Y2RjYTAxNGVjYSAoImxlZHM6IHRyaWdnZXI6IG5ldGRl
djogRGlzcGxheSBvbmx5IHN1cHBvcnRlZCBsaW5rIHNwZWVkIGF0dHJpYnV0ZSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMu
Y29tPg0KPiAtLS0NCj4gQ2hhbmdlbG9nOg0KPiB2MjoNCj4gLSB0aGlzIHBhdGNoIGlzIGEgY29t
YmluZWQgcmV3b3JrIG9mIHBhdGNoZXMgMSYyIGZyb20gdjENCj4gDQo+IMKgZHJpdmVycy9sZWRz
L3RyaWdnZXIvbGVkdHJpZy1uZXRkZXYuYyB8IDQyICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2xlZHMvdHJpZ2dlci9sZWR0cmlnLW5ldGRldi5j
IGIvZHJpdmVycy9sZWRzL3RyaWdnZXIvbGVkdHJpZy1uZXRkZXYuYw0KPiBpbmRleCA4YjgwNzQ1
MWI2NDJkLi41NGM2OTEzZjNhZmUzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2xlZHMvdHJpZ2dl
ci9sZWR0cmlnLW5ldGRldi5jDQo+ICsrKyBiL2RyaXZlcnMvbGVkcy90cmlnZ2VyL2xlZHRyaWct
bmV0ZGV2LmMNCj4gQEAgLTU3LDYgKzU3LDggQEANCj4gwqANCj4gwqBzdHJ1Y3QgbGVkX25ldGRl
dl9kYXRhIHsNCj4gwqAJc3RydWN0IG11dGV4IGxvY2s7DQo+ICsJLyogU2VyaWFsaXplcyBsaW5r
X3NwZWVkIGdyb3VwIHJlZnJlc2hlczsgbmV2ZXIgdGFrZW4gYnkgYXR0ciBzdG9yZXMgKi8NCj4g
KwlzdHJ1Y3QgbXV0ZXggYXR0cl9sb2NrOw0KPiDCoA0KPiDCoAlzdHJ1Y3QgZGVsYXllZF93b3Jr
IHdvcms7DQo+IMKgCXN0cnVjdCBub3RpZmllcl9ibG9jayBub3RpZmllcjsNCj4gQEAgLTMzNiw4
ICszMzgsOSBAQCBzdGF0aWMgc3NpemVfdCBkZXZpY2VfbmFtZV9zdG9yZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IMKgCWlmIChyZXQgPCAwKQ0KPiDCoAkJcmV0dXJuIHJldDsNCj4gwqANCj4gLQkv
KiBSZWZyZXNoIGxpbmtfc3BlZWQgdmlzaWJpbGl0eSAqLw0KPiAtCXN5c2ZzX3VwZGF0ZV9ncm91
cCgmZGV2LT5rb2JqLCAmbmV0ZGV2X3RyaWdfbGlua19zcGVlZF9hdHRyc19ncm91cCk7DQo+ICsJ
LyogU2VyaWFsaXplIHRoZSBsaW5rX3NwZWVkIHZpc2liaWxpdHkgcmVmcmVzaCBhZ2FpbnN0IG5l
dGRldl90cmlnX25vdGlmeSgpICovDQo+ICsJc2NvcGVkX2d1YXJkKG11dGV4LCAmdHJpZ2dlcl9k
YXRhLT5hdHRyX2xvY2spDQo+ICsJCXN5c2ZzX3VwZGF0ZV9ncm91cCgmZGV2LT5rb2JqLCAmbmV0
ZGV2X3RyaWdfbGlua19zcGVlZF9hdHRyc19ncm91cCk7DQo+IMKgDQo+IMKgCXJldHVybiBzaXpl
Ow0KPiDCoH0NCj4gQEAgLTU0Nyw2ICs1NTAsNyBAQCBzdGF0aWMgdW1vZGVfdCBuZXRkZXZfdHJp
Z19saW5rX3NwZWVkX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosDQo+IMKgCSAqIFN0b3Ag
YXQgdGhlIGZpcnN0IG1hdGNoaW5nIGVudHJ5IGFzIHdlIGNhcmUgb25seSB0byBjaGVjayBpZiBh
IHBhcnRpY3VsYXINCj4gwqAJICogc3BlZWQgaXMgc3VwcG9ydGVkIGFuZCBub3QgdGhlIGtpbmQu
DQo+IMKgCSAqLw0KPiArCWd1YXJkKG11dGV4KSgmdHJpZ2dlcl9kYXRhLT5sb2NrKTsNCj4gwqAJ
Zm9yX2VhY2hfc2V0X2JpdChtb2RlLCBzdXBwb3J0ZWRfbGlua19tb2RlcywgX19FVEhUT09MX0xJ
TktfTU9ERV9NQVNLX05CSVRTKSB7DQo+IMKgCQlzdHJ1Y3QgZXRodG9vbF9saW5rX2tzZXR0aW5n
cyBsaW5rX2tzZXR0aW5nczsNCj4gwqANCg0KSSBjYW4gY2hhbmdlIHRoaXMgdG8gc2NvcGVkX2d1
YXJkKCkgYXMgaXQgImlzIGNvbnNpZGVyZWQgbW9yZSByZWFkYWJsZSIgWzFdLA0KYnV0IHN3aXRj
aGluZyB0byBleHBsaWNpdCBtdXRleF91bmxvY2soKSBtYWtlcyB0aGluZ3MgcXVpdGUgdWdseSBi
ZWNhdXNlDQpDSEVDS19MSU5LX01PREVfQVRUUigpIHdvdWxkICBlaXRoZXIgZG8gbXV0ZXhfdW5s
b2NrKCkgKG9mIGEgbG9jayBvdXRzaWRlIG9mDQptYWNybyBzY29wZSkgb3IgYSBnb3RvIChvdXRz
aWRlIG9mIG1hY3JvKS4NCg0KVGhlcmVmb3JlIGF0IGxlYXN0IGEgc2NvcGVkX2d1YXJkKCkgcmVh
bGx5IG1ha2VzIHNlbnNlIGhlcmUgSU1PLg0KDQpbMV0gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9tYWludGFpbmVyLW5ldGRldi5odG1sDQoNCi0tIA0KQWxl
eGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
