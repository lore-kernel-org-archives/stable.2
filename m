Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B61D9A5F;
	Fri,  3 Jul 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095301; cv=fail; b=PmFJO1Q2xURAOxmL+6ByyNbXsIJGUhuoDtzVDESGZ9zshLyM1pczuAC7IUqqNZxQkCthbiCCBIiC9IpjppHGAzDPFsq/jhrhZpvFzDeSbZUq9dUzTMLOFjnPJ2Ui7MTSd5TDXD+kRHyUpT0IkVe1BN4IGsX0fMkRLYOGhmdA2mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095301; c=relaxed/simple;
	bh=DRXhgveCXytIkCZhpIM+NPAj4FzvTyDNJlAA8DzpX7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahH1nuCPBImvF+QT+dDxyplTNbE0opiQYRILlRaWPbfm/NtKWCq8vw9VzgQ/5CyCP1bCZWMSH/MpMzeCtHbC2eBIqa0+TtO91O0FbW8M1aPlqMo5WrGQuD8Z8+VQ1yv6A1a/mbDhKQLYVV26jPkyXtEo3J2HKkYt64aXiedwbzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=JN4yJnfe; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="JN4yJnfe"
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Fg3uF040458;
	Fri, 3 Jul 2026 15:42:03 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012035.outbound.protection.outlook.com [40.107.149.35])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4f27vgnqnx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 15:42:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOp+tOdOfBQwBhlJ3bfZOPWT7uPJcBFrwvR8JvrW/v8eNgBwVcGIXmnpWHKDPGtLvOg7EYfEQIzoS6xIPM5A2GzEdGkSZq6VFGNW1N0H0XFJFbwRPF0HZvi8OsObJzsaHiO1mhK9K5K9PJmaFetRkZ42IYcOojoaK7gduNwBLO82jR60i9t6ZhQYlQoHOiPkUa7HMydFDTXy3YVrJBfPv7RK7dDlqwwdCB3qdYruwidOTSPuv/lde0pGimsOoT7Y5Aq7vmkK7pj8YgNpDxkQglNaZNXsPJ1wapbXmL1W5S0crb6V2ooOL6KTtfa8VpDp3hdrMLecuM/SP13wNlyCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRXhgveCXytIkCZhpIM+NPAj4FzvTyDNJlAA8DzpX7s=;
 b=WCzsgjz1J4/o+lxXs50Oo3lh5mogr0ELdAJDw5NJ2nEXfW8PZmIgco/DTa7qB3Odr7soHaD0xK1995t0cmX4ADaVzyBxzYDpqvCHCOeJo756DDr28d56JYbIcSB4tV3bHIE/FqG5YR9Lbm3RzvDcrbvI0hlP2UhH81FotxPLDvOL1K+imb/+Rl4JsJIxm/MEnGE7WjjkCBHcRxfdh56kmymDqWMQ1S1LPs8f5FidUAyWG/umhotasQeqXNi695TDD8jR2tzDZ2fvlUzzJq8y9weN33mIqP8YOzt/o/QmwtsI8z1voZM3huQw/N47a1yttPaPUjY5Dh3vpanVk5Rbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRXhgveCXytIkCZhpIM+NPAj4FzvTyDNJlAA8DzpX7s=;
 b=JN4yJnfeBIW+Zk8yaBMK9I2TKJ53kPRUoIz3Dm5zo8G6cyqfAW6FKBxGrMc0m/kAGnd+MFJ1YvYm6M78E14+k7L1Nrw5ATqaCygRwLvUwvmxnhyW8eyQgtMd6R63QVkcePeNVzO/MbjBPdCmPD9DLG4NeLOGeJ5uULW7OD6kr3nqfmQFZB1nErh5Kk1JKZNuTDF4HT1WTYychYt5VXZ8n/TTvdryZB2uA00p8gwyM+prdfeBm/4aNd+Ffj7C4N0SnFWQgXrzTm+QreMZ8A1maVcSw07AK6zx2KQk+k8LRvfhuRuUE3B9lFgCgitT4C03/JpXYH0d4uZBezHL6l7B2w==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BEZP281MB3381.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:41:55 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:41:55 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Jean-Baptiste Maneyrol
	<Jean-Baptiste.Maneyrol@tdk.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix timestamp clock period by
 using lower value
Thread-Index: AQHdAxu+cE2mHNJ2kEmDUcLwMYfkDrZb/PPs
Date: Fri, 3 Jul 2026 15:41:55 +0000
Message-ID:
 <BE1P281MB14269CFEE52E559DD3323BBACEF42@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
In-Reply-To:
 <20260623-inv-icm42600-fix-timestamp-clock-period-v1-1-82184d2429f4@tdk.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BEZP281MB3381:EE_
x-ms-office365-filtering-correlation-id: 8f5c5cc9-5917-4df4-7fb2-08ded9199c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|19092799006|10070799003|1800799024|366016|6133799003|18002099003|22082099003|38070700021|3613699012|5023799004|56012099006|11063799006;
x-microsoft-antispam-message-info:
 CVPns85XXl0Hv3I7nvvCOxsYEFcWcmyLnf2xZ5mIPRAgEQ3u8c9ACvieA81h93hpW8fQzgdHXcu9ukqgJ1YzepwUL5FlL4uTQvqtCxu7WvhoWq/TNIf2oB2qvyLuzdiaq44DxKWXaAPY9Wkcy0tPWQzg7q6MQcBq2EaXRFOLovRNUKt6q5TVhE8m6iygs4qSoyK4qyPkOHtZ5mxEEULrW9gSTnL8nfMUJZVE+U+B55M/OavD6XlRz3CjQyz8QaHoDPTJrJktTRARoC54u9Rbpadye7bUPrEdg42yFr1uB2RWL8b7kxUHn/fGxAZp9wESOWKoar0gVo5wov19arvZtYcAqfpFaa1raQ/vYbEcoTFuQiGETs7Y33OaVFkZWSO3gFSXTCl3G0Do4zi22j5PebWGgMBkGXnNfmqTG6Z7kPnsBXlwPim3EJ+9aoijq1vMZ0zRuCyaEEZmGOCaSKgCULqxL5S4uWIfsnqw/8Tw1abSZcIvUwV4HD/7cM1AyKj+/52/UAyx51mM7IZBGgWJhO+POcR0udnlueiQz4PdT6DhBZhQftWmp1m3mz+CXIt8dUMlPtJlN2IMu4peQjItcZuv0sC+7H/rm7WTOL//WmN/O7nRz3TvV/IZyWVqPbrFe+8hBSJ9fdr3N9SaVLZ7sMxm108fqmTDha9uWwfPaVbepLR9ELzrs6FTkSUkplk3Mbv7siw3EmVDOEK8/sT1spcQRhmi3/jvuEttK7O4ssCMhH0iaYqIoc8lQtLdI6nz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(10070799003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(3613699012)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUl3Nk85blhkMzF5NWZoUE82MHZMeGN4QVVvOFZPcStlRGNIdi8rc1RCWEh1?=
 =?utf-8?B?NTdERERRTUZBVXNuYVJENmw0SHNFelZzam5DaTdnaEhYMjQ0cEpCTXNyU2FJ?=
 =?utf-8?B?TFNITS9HenlpUE83MUE3R1RWaHN4QmJLZUVrUjZ0RWNBa2tOQjZuNTdmblh1?=
 =?utf-8?B?eXg2TlFEeUFrN0NIS0w0M3RjdG4yS0wzSmxRdncxWlcwenFvRE9nNU05aHE5?=
 =?utf-8?B?TlE5VVEzM0VvcTBFN3Q0TlB5UGRMaDM5cWpxUTlSb3NrTkJ6ZERKQmpJdDRh?=
 =?utf-8?B?S2JrWllIWWo2QTdlN1RqWWFzQUJPMHhmRWtIcWJpWmUrcVRwSkxrNDdIa04w?=
 =?utf-8?B?RlNscVRNVGdjRmV4SkpoOFIxa0VzN3JkZGNnRHVuUlduS2l3VnI1eGtIanhh?=
 =?utf-8?B?VnNtWTZDaHlFTDluS2J1b0NIRUtuZUhZWVc4YmlxanNPRVh2M0s2a0dtRU82?=
 =?utf-8?B?aEZ4NnBBUnpGSWs5Y3N6aEtEN3VIdVQrSWd6b3F0b3ZNM2VsenhVOEhPelk4?=
 =?utf-8?B?dFdjd0VCRzFIMThnbVlOYkxWTFpJR0JyaHd6N2FURUswenEwaVQ3K2ZQWnFO?=
 =?utf-8?B?b2hnNUxTMU5ac1FXdmNJRkc4WHhpSHJCYmtiMCtDYU1CUWxEQXVNaDlvVHFa?=
 =?utf-8?B?aytWdHpIU2FuVkpXdHByaldLWTRDc0JyTi81dGQrWEJKdHZETFVEL0tZUkRv?=
 =?utf-8?B?Q1BwNXBOc0MzZUFYYzJ1NWxvZzhUNVluc0c0SFoveG1weTRCcDNlMHUwTGxT?=
 =?utf-8?B?MDdubkRmYkI1MFdrWDlaM3JEM0k4d09sQnRBcTduM0U0Qng0dHJuSTFJR0tE?=
 =?utf-8?B?VmtRR0tFYWIrdm1nTDE3cGtWRlc1NGthR3VqN2FEVXppSTBtcVl3dVlPck5Q?=
 =?utf-8?B?ZHgxWjNJWTVXZ1BQSEp4U2hJbThTU0Z3MndzZGROaHE1dkVCdlRtSzhsVHFy?=
 =?utf-8?B?Y1BZTVA1T2c1UGcyODgwZElpdDRFdTNHbkF0K1NRWEFSTHpsRlA2dVJyakFQ?=
 =?utf-8?B?Z1ZUTVNuR1dBVk80RzlaMU11MzZDdHo4RERvT2hUNlNkQXBKM0JJeTBBVFox?=
 =?utf-8?B?a1BqWW52a0xETHN2NjFaTXltVDZnQW1rU0R4azVTMjFQNVArYzcvbW1TaUor?=
 =?utf-8?B?RklBU3dhYVFURnRMTnNISGJRbi9XcDhoZ1dUOFhNRzYzaDlxVGZQTWRyY3RH?=
 =?utf-8?B?SURncEU1bXdnK0VhZ1Z6NFlISGd4YS9DYjNpekhaNXhkcHZqdno3RlBSZG1H?=
 =?utf-8?B?bkZ1ZXRlYUNmK2xoc1FlZGY5ZkFzdnl6Q2ZrUGgwUG1pTVdMaWVHaHAwR0Vs?=
 =?utf-8?B?V0JrK1JPM054Y2ZWWW5iNEI4cElDSkNDbGFjc3JSWHR6TE5nUmpMcDdoeTJY?=
 =?utf-8?B?cTlsS2FVcVZ6dTNwNTM0Ly8vclNSc29La2ZuZnlIdmhSK08vZmMvaTg3QXhh?=
 =?utf-8?B?R0x1elFKQUtORXpnZlFmRDhnNndiMkdONXFVTW1vbkJySEFhdXlnWGhxbC9M?=
 =?utf-8?B?UmVpaUVCM2x2M2R2WVZvOU9CbHJVaVlIUUl1TERLR2d5d0JTYkxJeXVIS3BC?=
 =?utf-8?B?LzZ3dnZVQlh6UG9MdFlqd25ham5US2N0UUFYdk53WDBiaGtUamtLdUdQUGFS?=
 =?utf-8?B?SlVUQW5sTEdKYTJMbW5ZMmhzVHZtVklxbTFtUzlrcFFJVEE1YllFaVBJRTlW?=
 =?utf-8?B?dE1TS3FDb3J0d2lLMHV4U3B2bmZDZCtrK2M0VVkwa1c2aW56NmFJTDFCQklW?=
 =?utf-8?B?OWFYNHRDUVhFRE1zNGIyZHZpZ1lyZktUckhRS2IxSE5URFlLNlNYNG1GeU4y?=
 =?utf-8?B?NFQwSFhmT2tjSDNpUU5oNFgrc3hJdUZCeEVBaEJLaXlod1J3SmhuZVFRS25K?=
 =?utf-8?B?SUUrVDBESEFSYW1XN2RJSXQ4RnZ4aHlqWlJkbDQzNzRrMXJndEREWC9zMWFB?=
 =?utf-8?B?UnhPdzZpZ1lXdG5JRHJnV1Y3dWkzK2c4MU1SdHhmclBDWUp2UGtubWw1bHFl?=
 =?utf-8?B?K0h1anNVWVA4NUpUUG5jbFhxTnhuUjdtVGpDYVl5S2pmOVpSV1BSdVVKb0FN?=
 =?utf-8?B?bkcybks5SldHSEVsaDdXNVlWcTh6dmswb2lpd0hVT0xkd0FYZ0JxbFdDeDhm?=
 =?utf-8?B?dDBjS1hzY0IwZVNEUjhjWERrRFBUT0w5dC83akZYQ2hDcUxTamVhMU1udHY3?=
 =?utf-8?B?UnZqM3diWlFZZFVVUDNqQmZteFBDWGVBaW04NUorUGlRODhQQTBScWZ3azVN?=
 =?utf-8?B?ZTBiUWdyeDNNV3RMZ2xzRW1SeHZ6RlRaaFNpdE9haE9DUDdPYzg3Z01kdjZF?=
 =?utf-8?B?TGRRbGwxRWdxdEtyR3BZYklZRE1SUUI5WVdmcm5vRnJEK0svUE1NL1dTa1Rr?=
 =?utf-8?Q?UKgAfcaf16v7Vyty04xnjI2mgZzxG0AZNb7YSQPNn5+Lg?=
x-ms-exchange-antispam-messagedata-1: pkiB2iPQQ8tq3A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eHI055hClbxw2wCVTd6kLIVmjBrnjr0QbEN8wUr294AuxR+5q0dIR/AdvtNlCY5y4enAiKJgj9fLpErqAe+9rRNpPgLD4zei90BObTmqmgxjB8rUqgKBrkC+X48gfhzR+SsGc7kjRBtZB1URQe8TQt8mXQy9MY5QPRNw5TQHv0XDxeUh4iU3T+kS0bOEQZeDuNc+odyTc3M9cCEoDpaef3AX5T8o32mqynRN6N0raQWuxLIDpiDhjwEcRzlp/fvjTC9hCgNdsqfPRdUIf7HJ8MiX+i2Pad0EOzdb/IZ0yZU/5nF8KSBwmGHpR7IefOdyPGcE6T3ip0qhL2wwwj5yqw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5c5cc9-5917-4df4-7fb2-08ded9199c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 15:41:55.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEbGowoaFUXx3XYt6B/a47iSbez6ckAwOpvunkhgufEZIET38+FkNMR90PRXipMgynXW9DRQzdNK2PXolqVNmS7S4xBLXdHHHt8iRJCIS4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3381
X-Proofpoint-ORIG-GUID: B5m9DXY0xLuLIkaOUpaZkZBxld8CE2VO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1NSBTYWx0ZWRfX+ipkKNYnms/k
 kvMW2PA+QV1CEdx1Er9tlBmgUxEIpHBlN1JQqjHf+psKtYzZnHMpvCS1IK2vpcMvZgqnN8xgQi7
 Oy3wb4HrYIMkcmqghohSxGNcjJHZIDUbwzN9xEdavcaR6QtJFpzEESeLNlQa7yPRGPHQfHGyfU9
 p7tb8dnoxPD6QVkZ7d0yoLx6/sQwOjs097J3BRcSfAUckJ1glUcN9iDGTNlK4UgGL2X/xbYmCrh
 LW3CYX1zI9b8qzJj8VExUxtFHY09jv7GAXKYy6LYDGXqRv4uGUnYgeLPt/lSM7GLBaPJrYDzxZS
 gXUsC6QZmGc+iv36Su6lyFzw+aIOt/WVWKLNGcwwURsnPLiS6EjALTrj0V727u1aWFCk8BtIrMP
 QePPB2ZxFbge5tm60EISuF9yWQUtNnNFLyD/LjSu3JxCxNX9xQ23A8iAiR0HotBiAzNqQ4Lw3rZ
 3Ba+KGHgUoElWo8N3zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1NSBTYWx0ZWRfX7USyAYnOGcsz
 Bo58A6GxQir+8TaOIcWYLlsPf3MFnhERd4bQ/LpbONKxYPz3rV86LZRYa/u0RkaB4RabNtoWsDi
 bJ2EnfhUsQ4ny+KmeRdPBm7G3kLw1yKkPPPnx4U0mLbceTQMJGzI
X-Authority-Analysis: v=2.4 cv=I8RVgtgg c=1 sm=1 tr=0 ts=6a47d84a cx=c_pps
 a=/XU0EaMXzvVpd7Nc14VS2A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=NpUDEC63da1vOGE9rZHW:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=4-y-BRCywwWH8eZLqKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B5m9DXY0xLuLIkaOUpaZkZBxld8CE2VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030155

PkZyb206IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5IDxkZXZudWxsK2plYW4t
YmFwdGlzdGUubWFuZXlyb2wudGRrLmNvbUBrZXJuZWwub3JnPgo+U2VudDogVHVlc2RheSwgSnVu
ZSAyMywgMjAyNiAxNjoyMgo+VG86IEpvbmF0aGFuIENhbWVyb247IERhdmlkIExlY2huZXI7IE51
bm8gU8OhOyBBbmR5IFNoZXZjaGVua28KPkNjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKb25hdGhhbiBDYW1lcm9uOyBzdGFibGVAdmdl
ci5rZXJuZWwub3JnOyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sCj5TdWJqZWN0OiBbUEFUQ0hdIGlp
bzogaW11OiBpbnZfaWNtNDI2MDA6IGZpeCB0aW1lc3RhbXAgY2xvY2sgcGVyaW9kIGJ5IHVzaW5n
IGxvd2VyIHZhbHVlCj4KPkZyb206IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlz
dGUu4oCKbWFuZXlyb2xA4oCKdGRrLuKAimNvbT4gQ2xvY2sgcGVyaW9kIHZhbHVlIGlzIHVzZWQg
Zm9yIGNvbXB1dGluZyBwZXJpb2RzIG9mIHNhbXBsaW5nLiBUaGVyZSBpcyBubyBuZWVkIGZvciBp
dCB0byBiZSBoaWdoZXIgdGhhbiB0aGUgbWF4aW11bSBvZHIsIG90aGVyd2lzZSB3ZSBhcmUgbG9z
aW5nIHByZWNpc2lvbiBpbiB0aGUgY29tcHV0YXRpb24KPlpqUWNtUVJZRnBmcHRCYW5uZXJTdGFy
dAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5UaGlzIG1lc3NhZ2Ug
Y2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4KPlpqUWNtUVJZRnBmcHRCYW5u
ZXJFbmQKPgo+RnJvbTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5l
eXJvbEB0ZGsuY29tPgo+Cj5DbG9jayBwZXJpb2QgdmFsdWUgaXMgdXNlZCBmb3IgY29tcHV0aW5n
IHBlcmlvZHMgb2Ygc2FtcGxpbmcuIFRoZXJlIGlzCj5ubyBuZWVkIGZvciBpdCB0byBiZSBoaWdo
ZXIgdGhhbiB0aGUgbWF4aW11bSBvZHIsIG90aGVyd2lzZSB3ZSBhcmUKPmxvc2luZyBwcmVjaXNp
b24gaW4gdGhlIGNvbXB1dGF0aW9uIGZvciBub3RoaW5nLgo+Cj5Td2l0Y2ggY2xvY2sgcGVyaW9k
IHZhbHVlIHRvIG1heGltdW0gb2RyIHBlcmlvZCAoOGtIeikuCj4KPkZpeGVzOiAwZWNjMzYzY2Nl
YTcgKCJpaW86IG1ha2UgaW52ZW5zZW5zZSB0aW1lc3RhbXAgbW9kdWxlIGdlbmVyaWMiKQo+Q2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPlNpZ25lZC1vZmYtYnk6IEplYW4tQmFwdGlzdGUgTWFu
ZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4KPi0tLQo+IGRyaXZlcnMvaWlv
L2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2FjY2VsLmMgfCA0ICsrLS0KPiBkcml2ZXJz
L2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9neXJvLmMgIHwgNCArKy0tCj4gMiBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jIGIv
ZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYWNjZWwuYwo+aW5kZXgg
NTMyZDVmZGZmYWY4Li43ZGY5MjBlZjNjZjAgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jCj4rKysgYi9kcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jCj5AQCAtMTE3MCwxMCArMTE3MCwxMCBA
QCBzdHJ1Y3QgaWlvX2RldiAqaW52X2ljbTQyNjAwX2FjY2VsX2luaXQoc3RydWN0IGludl9pY200
MjYwMF9zdGF0ZSAqc3QpCj4gICAgICAgIGFjY2VsX3N0LT5maWx0ZXIgPSBJTlZfSUNNNDI2MDBf
RklMVEVSX0FWR18xNlg7Cj4KPiAgICAgICAgLyoKPi0gICAgICAgICogY2xvY2sgcGVyaW9kIGlz
IDMya0h6ICgzMTI1MG5zKQo+KyAgICAgICAgKiBjbG9jayBwZXJpb2QgaXMgOGtIeiAoMTI1MDAw
bnMpCj4gICAgICAgICAqIGppdHRlciBpcyArLy0gMiUgKDIwIHBlciBtaWxsZSkKPiAgICAgICAg
ICovCj4tICAgICAgIHRzX2NoaXAuY2xvY2tfcGVyaW9kID0gMzEyNTA7Cj4rICAgICAgIHRzX2No
aXAuY2xvY2tfcGVyaW9kID0gMTI1MDAwOwo+ICAgICAgICB0c19jaGlwLmppdHRlciA9IDIwOwo+
ICAgICAgICB0c19jaGlwLmluaXRfcGVyaW9kID0gaW52X2ljbTQyNjAwX29kcl90b19wZXJpb2Qo
c3QtPmNvbmYuYWNjZWwub2RyKTsKPiAgICAgICAgaW52X3NlbnNvcnNfdGltZXN0YW1wX2luaXQo
JmFjY2VsX3N0LT50cywgJnRzX2NoaXApOwo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9p
bnZfaWNtNDI2MDAvaW52X2ljbTQyNjAwX2d5cm8uYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNt
NDI2MDAvaW52X2ljbTQyNjAwX2d5cm8uYwo+aW5kZXggMTEzMzlkZGYxZGEzLi5hMThkY2FjOTM5
MjkgMTAwNjQ0Cj4tLS0gYS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYw
MF9neXJvLmMKPisrKyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfaWNtNDI2MDAvaW52X2ljbTQyNjAw
X2d5cm8uYwo+QEAgLTc1NSwxMCArNzU1LDEwIEBAIHN0cnVjdCBpaW9fZGV2ICppbnZfaWNtNDI2
MDBfZ3lyb19pbml0KHN0cnVjdCBpbnZfaWNtNDI2MDBfc3RhdGUgKnN0KQo+ICAgICAgICB9Cj4K
PiAgICAgICAgLyoKPi0gICAgICAgICogY2xvY2sgcGVyaW9kIGlzIDMya0h6ICgzMTI1MG5zKQo+
KyAgICAgICAgKiBjbG9jayBwZXJpb2QgaXMgOGtIeiAoMTI1MDAwbnMpCj4gICAgICAgICAqIGpp
dHRlciBpcyArLy0gMiUgKDIwIHBlciBtaWxsZSkKPiAgICAgICAgICovCj4tICAgICAgIHRzX2No
aXAuY2xvY2tfcGVyaW9kID0gMzEyNTA7Cj4rICAgICAgIHRzX2NoaXAuY2xvY2tfcGVyaW9kID0g
MTI1MDAwOwo+ICAgICAgICB0c19jaGlwLmppdHRlciA9IDIwOwo+ICAgICAgICB0c19jaGlwLmlu
aXRfcGVyaW9kID0gaW52X2ljbTQyNjAwX29kcl90b19wZXJpb2Qoc3QtPmNvbmYuYWNjZWwub2Ry
KTsKPiAgICAgICAgaW52X3NlbnNvcnNfdGltZXN0YW1wX2luaXQoJmd5cm9fc3QtPnRzLCAmdHNf
Y2hpcCk7Cj4KPi0tLQo+YmFzZS1jb21taXQ6IGNjNzQ2Mjk3YjIzZTg5YmQ1ZGY5ZjkxZjNhMGNh
MjA5ZTg5OTE3NjMKPmNoYW5nZS1pZDogMjAyNjA2MjMtaW52LWljbTQyNjAwLWZpeC10aW1lc3Rh
bXAtY2xvY2stcGVyaW9kLTkzMTMzOGE4NDhjMwo+Cj5CZXN0IHJlZ2FyZHMsCj4tLQo+SmVhbi1C
YXB0aXN0ZSBNYW5leXJvbCA8amVhbi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgo+Cj4KCkhl
bGxvIEpvbmF0aGFuLAoKYW55IHVwZGF0ZSBhYm91dCB0aGlzIHBhdGNoPwoKVGhhbmtzLApKQg==
