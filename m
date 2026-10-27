Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793080509;
	b=kizrpN1cNMTjnBXb3awIqAj3cdRSdGxu9xHqYMHEf288FeFHRsEdO45uWSFm/jPjnWbu
	 4TIxgmWRDGUZnY4Y1+1HSm2c/qlSMPtbnv6JXpeQNYhQWGYdePbhk22HzdpiSW/Ua5Bv7
	 nZBmR8bg7GsolI66kj/2klLZXuTChceoRrOktuvBh+5OHrQG+zoeKTVYzBFUdh4nkMHgW
	 HCLHRiGIh6GGqpRpTVXbVPfmQZECc3R5aVs4gWYmUoNnskAQ8UIVQ2AXX4K5lys7VkPJo
	 5pH1FY7O63pAhXFBLj8Fgc73s4JfFSgGBOeYfCfV39sbGdMsUVzLUdjnjcElg6bVZLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080509;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=334TRyvFrA9jLIb951BudRQWLkM28Ec7w6L89rqqMvU=;
	b=hgb2xCeUz4eE2mTn8JY3khYKLcyY1B2HDfsl2MU3j4r9rtL3BP1AN4TecqP8eAxduykW
	 j/Nee1eEYFIfcgCqEFd1BX8vNvG9mRbgFQOaCiVyJk9yXgai5zmWjPJmptoYtf8g4kQN7
	 nupOQS3YxQaCWnIHGgg+0ot29ecSlzvE2OqrN6tLfDPnx7gqIudQLpSonskGAhIRi44LI
	 swGwf65e9BQrVsL2Jtio+DYGN2nzS0XJdh7yorbTxEBK0X7ibySVCmORDtBNqGIRKm0Q4
	 OBz+eTRCON8lRc656sdSO/eP3u88M6fTBl+oUQHjzKZRZahsphZxHZRaQRNQ9g5+5pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=uW3EJHn+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6A606A31A;
	Tue, 27 Oct 2026 05:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C6A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=uW3EJHn+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYi23cMAlQj/AZfoxgFSpcK8FHxjg00Urv23zyJGO66/s9Qc0tMX+IFDNH6PI2VEW8flCRgQnIJZpB41iEbixwd57DdEmxqiGH0Cwl92+LSTL1YWzRzcZlXOn5Z3v9eSPRbzfxVIa8RHrWFaTFK9tt/NCG9QZ2WPZL5/urNyrBHF264u0ld9VWOX+XS5cF0K9ae2ZuZjBkJVaaNI3bzWlz7C8eldX8XJNPqTfeuzs3b4oLr1ltXpaU0Bpn7B5DjywIJI/CBnHt/b67HmW0u7U4aNz8OchSvmfhOa/h3vou1W2OH1dMox72bWINTBeX2sLwsZgSUyzcg0Czpob4pVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=334TRyvFrA9jLIb951BudRQWLkM28Ec7w6L89rqqMvU=;
 b=B3i/zOAdcmlgsIabgZrIP3ht/fo0zISb9nSvlWTP8g0Yl32jtvpMcsxZ3/xVbVFb8wqGcBe4eTGevqjcTm4tPI8ChPzT7ybr3yqS8z87xm2KUDAjjA/v3qN5i1YppACJioR/0WOYTdfXSNepJByp8mbQ3SPzp6o0gOB8y7TfI/IAfuWXBGyiNmRUaZLWph9yaRgrIkJi66kuP+Bk1wineDS+xZwmITC5hVXZ0FC6iFffnIT1GQY2Jmxc0wONgxtovONsIW0KfmtOTvdwJOZazAG70sO+NVnqZ2SptyESrHDNt7wtFnHxAd0u8AUdyCqwHcRA1m/iezFoZHE62JIc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=334TRyvFrA9jLIb951BudRQWLkM28Ec7w6L89rqqMvU=;
 b=uW3EJHn+DlquZHg9d1FjMIlYCvhMJlYBkFsse1Zcp4J5yK1OoMcqZtQc+dRNzdPHfslkLcMFH4+zKcWUtJw3EvSbYXZIjZ0XshtKedjV7e2C9YVppxHNbfYGHJ3PnYa1cWGeumlTWzgZZuXTok3IL6gDlwkt8UyfA/DD2WHFkzzRQEQDtA9RqlDibG1hCrex6LcyKwyqH3LoM3dA9ALJgnuynTESYaYuuF/NERM2CiIlr0fEoNCGaF96UTccAE0nnRTAH9J9wL69UqFeSKDpYxCU3fQytGO3pFtPv2YE+B0lVcPmRdGll453RqENs/UoxwQcv3yrtn6TkblN4+Xoig==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 IA0PR02MB9855.namprd02.prod.outlook.com (2603:10b6:208:491::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 05:55:07 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 05:55:07 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: "netdev-bot+sinfo@kernel.org" <netdev-bot+sinfo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
Thread-Topic: [PATCH net v2] mctp i2c: fix double free of midev on netdev
 register failure
Thread-Index: AQHdZdVCHj7bYODww0an4KePwzs6t7cQ4AEAgAADeDA=
Date: Tue, 27 Oct 2026 05:55:06 +0000
Message-ID:
 <DM8PR02MB80871A5074EA3DF67603D9868E602@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261027053715.1623087-1-kenny_hsieh@jabil.com>
 <179307969867.3327.8394430717039407023@kernel.org>
In-Reply-To: <179307969867.3327.8394430717039407023@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|IA0PR02MB9855:EE_
x-ms-office365-filtering-correlation-id: 3a766f89-e2f2-491e-cc22-08df33eeda7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|261026121527099003|38070700021|11063799006|4143699003|56012099006|261022105027099003|10067099003|22082099003|18002099003|261026140227099003;
x-microsoft-antispam-message-info:
 8auO2Kkn197OVMxRNTG6lGEL6JAqKUH/bb9Sh19mvWmAKR5gwmSWX0QREJ3PyoED8JqYSJL1LRo9OZsY7rQtXOejF6mnQzZUvjZfelA9Yhj/HHgbvMpGQbblNyB2BBQh/E6CivIuOUmPK03nvpgFQY/XDaoXIXUvpkZIJxuAQ8pVyLwM2MnDcu7ENrawhgP165kRCn883yTMRul7LMJPMXrTe7fRjKNVMQ/UcZ0P7ANqqpHMBaeEuAyiWd0N0j/tS6uM9Bv6AQOMw83rCpFZv8laFb14Y1kLTeO7A5LbMI0NWNfsYb8NhZ9veP3GZchLAOyWwgBdUqcwO4KKqkxpBli3fUTfeoMdqaNM1iHc6nJuKnzgUuLUzGb+s6buDt7/qK+6x5hu5R9HbQ/rKcoIxK2o1nH1ss/Cs6opCVH7OC5GqfYrXxeywCR9G/+MzU+2DIbdBQxYSGSwyKv38wwT8g+a+i0ck5zVNsVambp5v6L9CYL1x62ACS023nGMa17JFHgsz0dvOoCWwMXrm2JCcZXZROeb15v/GbKRFetTqNFuYOkA8ZBFUwIqNugLU5PRH8TIGRwO/Z8/iZUXjtpmBKPx5WfFW9GtLtcxzN8w1yUoM+yGUnxfcY3QDIZovBziGlp6MpAyPOFD+uwrqLm0SosBtgNqoEE8bkZPfO8U8mMTi3JK4EPtRWdwalZU3HCHyO8WXl8QF3eKigzN+UsLegOuy/fInV4KBPB4UX+WaAY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(261026121527099003)(38070700021)(11063799006)(4143699003)(56012099006)(261022105027099003)(10067099003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vlg0MzRPMnZWQ01MSUprM2xRWnhBUzVuVFZjRm9VdnFLM1grNFlWbFV3cWlQ?=
 =?utf-8?B?SDlOSitDc2Q1c3BaVENjcDF1MmJEVFZUL3F3a0Z4djFyS3FwSDAyYmF4d25k?=
 =?utf-8?B?REpzNTAyUkM5NlUvaStIN2dTZ2srNno5RXhEVXBTbUN1ais0aGptMmxZMHhY?=
 =?utf-8?B?MUF2ZWVJUkw2RmtvMWRUNW4vR0tZWXRER3ZPZHRYWHE3ZDdPL2s0NGRCeGhv?=
 =?utf-8?B?MGV6encxNk1GR21TelFnUkxpbDE0djJXdHFFUHlHT2FTMDYyNnhrUHNqVDRx?=
 =?utf-8?B?YkZxeUJQb1A3UWVlZmhKYWhBUGpNdVltY1drYWxYeWt2TTZpaVh6ZTNGcndX?=
 =?utf-8?B?UFNzWTBtOVNoNXp2RXRLVVR3Qmx6emVIemRWdWZSU1AvVTArTmwyMm03SHk5?=
 =?utf-8?B?c0xyczlJMHNEZHNER3BQWUlyQWdMVEdheGpENkhaK2RNdzhBL1RuR3JNSE5q?=
 =?utf-8?B?aGlBV0FWUXpzWjFlUjNaZndFWjN2UjI2cWduRkNFVTZsRXdQMkN0ajRzQ0Jw?=
 =?utf-8?B?ZVFRaEx3Si83MkVzMU9VeUNLQ2V1Uk5vL1RwdjM3MTlJL2wvNTF5VzA0a1lZ?=
 =?utf-8?B?VWQ4Uk9vUkV4TzFOLzg4SFM5ZGJZd3hVSlJPMytleEJKYnJqYVJNYzlmYm9R?=
 =?utf-8?B?ekc3OWZpWU9naXMwNzNTYnV1eGNUUTRyM0NNeDg2SHQvcVYrWE9rblJlMkhF?=
 =?utf-8?B?aFZDNWNodTBYck5JeW5ZOFA1SExqQ3Z3UDlJUm1saEt0YVdUeFhPVzFPUGRW?=
 =?utf-8?B?eHd6ZlFPZnVMR0VpOHFzV3N3N3Y0cGNibWo5RytPQWVoNVlqTnBzN1k4Q3g1?=
 =?utf-8?B?M2s3QnBOTms4bzJMNzdza3NWWTRDa2JMT01kb0FMa1pQME9PRWJjSThRWUxu?=
 =?utf-8?B?V0I3aHJZSGsrZUxLWUV2UTU4WHdRNUtJT2JqNEdWMW9ScXVwK2xGL1p0YWdX?=
 =?utf-8?B?TTR2b1k5eUZsUHpZTEw0c1d5cCtLMG1WMnB2U2pzMUVHQjQwbEdoUUxJbGZn?=
 =?utf-8?B?aGE0MHBUVFZQakhqRDdtUVN2cm16eHhialZSTVNzdzd2WTRhdktvY1hVT3pv?=
 =?utf-8?B?SDl2VUJ1dFRnMFJ6dm5YUXVJRnZWZ1psU0htbjkzSzlyRnJ6eUtZN2c0RUdq?=
 =?utf-8?B?SlFRdkpIVTVhc1JtN1BOOFRkKzZvdi83NWkxY1JVS0FTS29qeWVXN2xYVVdX?=
 =?utf-8?B?SyszQjkyQm5TRlRkWVliYW9EZ0hZamV2RjlsM25Rd1htNTBhV0hJY1NTWCt2?=
 =?utf-8?B?UzYrRHdiWEh2ZDE0L1JlOTdMYWNhMklVQUw2QWlnWjgvVTNBZFUweTFmZWtE?=
 =?utf-8?B?SUt4UXpiN3kzaWhmQUEzU1J3d3d0TER1K2NGTHJWVm1xQXcwM2JyYWU2NnJi?=
 =?utf-8?B?OHV3elZYNnVrSTRuVmRDWkVnMnlyK3N6RHk2TGxmeE9oN041Z2YyN2VnbmIy?=
 =?utf-8?B?a2JPQUt0aTJFUG1qQ1prcG9YaFlMRnVXTk9YLzN5U2lRSXp6TGw2RnE0Yk9p?=
 =?utf-8?B?U1FsRTNjMWUrTTBnK3d3OVhnSEJrYmlVb0Z1SzhEWGVoeGVTdTFvOFgxdE1w?=
 =?utf-8?B?MWlFTXRLMEhGcDhoUk1JRTZzQXo3aEJGam0vb0Zmc0I0Z290amVjQUM0K0U5?=
 =?utf-8?B?Q3pTbWhMeC9uV21sNW5GQUliM0FFcDV6aUpUSFpKQUR6aVlyYmRSNGN0Zkh2?=
 =?utf-8?B?eDBWQ29VMFlhY1JWdFVhKy8xeXd0TXc5MElDYWxVd3RTQUN0Qm9hTmV0N2kw?=
 =?utf-8?B?NGNmcmJwN0YxQlE0VVdsbmYveVE2bVY4UjlPdmt5ZWNnTy9MaklMTUZ1NStN?=
 =?utf-8?B?Q0dYbVNGeGYrbzViS3plQlNBU1lUbEZqK21OaFNINCtLNWJGbmRvaFpIalFJ?=
 =?utf-8?B?WVRSR2sxOEJ6VVdXOWhzcU5KczNqcENVWVVjQVhkRHZGcnlPWGFVcDBnejNy?=
 =?utf-8?B?eGNwSEs1bHM4MXdhbEZoZURaQTR3UHpsUEQzUEJNNmZ3MWhicy9sUThVRndM?=
 =?utf-8?B?V0tpRnZNY2hnN2N4MmZtbDMxSEl5UFp6SDE3bUVlTGhVR280NSs1cEhQOE1m?=
 =?utf-8?B?Um9Yc3hIUDJNL3Qxa29uNzBxTmFZUG9Vc0xNc2pHVk1lTXBvUTN6UlhKSGdu?=
 =?utf-8?B?Q3ZzVFAvM2F6d1hicjBQOTdqcm80QTlhZGdPWFRNaEVjRGNmT1lFV05TWFFt?=
 =?utf-8?B?eU9HWlpsMldMamlqSVp2Q1U3b1pIWVFKWjlobW9iTXB3WXp3ejI1NEg4OUpo?=
 =?utf-8?B?QWNGY0lOOU1hY1Nld1YvNTNWejBScGl3QjBZU0JqbWc1c3hZd2locWVUYXNK?=
 =?utf-8?B?YkZGODdFK2ZNWXBhcFJibFc2bUo5SDJ2WGk2a2tyRi8vakJRSUZEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a766f89-e2f2-491e-cc22-08df33eeda7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 05:55:07.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TtH6btcqtrCQAyXDjC/AG8bjki1FH1gTxDC5gs4uSjFmdvRv3qwiw/xaKF2xcPe3QoL0nJU1iajaRXY8ltgGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9855

VGhlIGRvdWJsZSBmcmVlIGlzIGZyb20gY29kZSBpbnNwZWN0aW9uLiANClNhc2hpa28gZmxhZ2dl
ZCBpdCB3aGlsZSByZXZpZXdpbmcgYW5vdGhlciBtY3RwLWkyYyBwYXRjaCwgYW5kIEkgY2hlY2tl
ZCBpdCBhZ2FpbnN0IHRoZSByZWdpc3Rlcl9uZXRkZXZpY2UoKSBlcnJvciBwYXRocy4gDQpUaGUg
bGF0ZSBmYWlsdXJlcyBuZWVkIGFuIGludGVybmFsIGFsbG9jYXRpb24gb3Igbm90aWZpZXIgZXJy
b3IsIHNvIEkgaGF2ZW4ndCBoaXQgaXQgb24gaGFyZHdhcmUuDQo=
