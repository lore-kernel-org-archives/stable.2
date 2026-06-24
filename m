Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC0346AE3;
	Wed, 24 Jun 2026 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289272; cv=fail; b=JtjpHh9lVZJ0UJPZPubozfsbQ3eeeu8G3jyeTQ58u8i33VIswtCOe7ySuQzg8Wu+ZNo+6nCjgDcX1C4JbU9cLGIMBRnoEVt+qlKrLCcNFS/SW1PYLddRwsdPEA0ggy/ikuUdca1U/h4Z9ci5srY4RVCziHbziF8c2xeikxOEsZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289272; c=relaxed/simple;
	bh=QQeRAaIVz7yNf91X9QkLKskiKcJi9kHDSsKKZ3BamBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZL1dxx6VgDEYAsfEdXRdM3O8Ssp3GYZin5f56sOIT3dp2WexIzhO6aI0sz+JXKlYn/KL4qtjCFgMkS86sFoKXjd+k0TLGfOkXQDy90cbmM3nJ5ZVH59NuD5HwWOo9uyync1qXn4z3zS4xeK69RWBMNFoG6Z94T54G3Umk/phlTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=nOOFYzch; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="nOOFYzch"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5sYd01210251;
	Wed, 24 Jun 2026 08:20:44 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010018.outbound.protection.outlook.com [52.101.169.18])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4ewh7wuavt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:20:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQPZksQdurCeS6Lrh9ZrXfK+mjYqan5As7uMLk8vHOdgGrK7e27J4c7ZmT7SUd3WHSAGqsnrzdyBcqKsylbfzT1alxcLxKU3wgeh7KzIi4I0gbZRGpFyKT7AoHzDBOvAF8swH8Ld/4W4rhASqpBqXXyMPE55urc5UOzhYINMfjEjX2qVKPPb2K7oGGbU1cD8D2kJB+hkd8EffDPl14723RxFSEC25ZatjAFjJxN0kW0pB+ndff2ZevWfvVIAe+PEwbTcz4NcE9kYDN1MGuLPpKt4ChcNJWoznh/EFmXbcRHt9nJvNi7OrcWttj6rgU0/PAWS2iZCLD/80/C8uk1jQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQeRAaIVz7yNf91X9QkLKskiKcJi9kHDSsKKZ3BamBI=;
 b=LB/R0QIBLuztVZNnv9QO56jKMKBO0TFF8QwOOVZwwDqPu+WA55gBNBQh0QgSZ1HC3iF2rS0SU0t+RWUhkYYQ/UvnPy1/ORwdIYjAQEt7TTj5Mxv6JXehmX6NNwtmzZKXGInlRMf7HFIsl15qzcEv94k02nFn2gPBwAYjk+8fm0yH/zZh62ngbE/8ZkZSSkJGMdqBvsnFwePC+ve4QOeOulIA5majShZR73dGOZknGVZa5lAKAvHI3aipZ//BewFtxnNXbxWQsIbGUmxz3VB+xW23Kt8X5EsZJt8NBC5+ICU0ieZOtjgyX075Qa3GVS52OE00k//S9CLpvyT5iNtBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQeRAaIVz7yNf91X9QkLKskiKcJi9kHDSsKKZ3BamBI=;
 b=nOOFYzch320PgG9bac+1fxrBxc9epCUJPN00/3SxxvnJ/MwZkdcAgd9B7HtARcDYakm6+lfg9r5JjiNO8hWD5i0dkqrT7GxQ/i2BhnKfq4TkS8w+/Q8/GGgkwPZ/Ip5BmCfybNZ2bg+a6a/5H/g9k81bJLXz70wFdEFI3GAqxTykqdprvLdLFPVzMQ4NchRN6cH8XeIPs/pmAceMw2vlS3JRKOB2TKqLBliINqmdh5blVv8FYn699O+fMfha9NSOLjIHjlBsrj3wlHV/oUawei+pQR5SGyMJsb+RypjnqwzUG+k6yHp90PzgHzjLTKAa1ug4NpxIjRkXkljrl5UZWA==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BE1PPF2E9547059.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 08:20:33 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 08:20:33 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix timestamping by limiting FIFO
 reading
Thread-Topic: [PATCH] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Thread-Index: AQHdAy+bNO1rsnhiOU6vevO2PVIaG7ZMleOAgADHf6g=
Date: Wed, 24 Jun 2026 08:20:32 +0000
Message-ID:
 <BE1P281MB1426F3DAB61B6794A3B1600ACEED2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260623-inv-icm42600-fix-watermark-fifo-reading-v1-1-f3f5694a818a@tdk.com>
 <ajrrN9yPzr2yxqef@ashevche-desk.local>
In-Reply-To: <ajrrN9yPzr2yxqef@ashevche-desk.local>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BE1PPF2E9547059:EE_
x-ms-office365-filtering-correlation-id: acd8188c-e33a-45be-e01f-08ded1c975c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|10070799003|38070700021|3613699012|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 T3C7YNV8tixlRA4kgvYLwGI/x4L6/NqhKLzVFf7Y6FeRNpKShhxXu2Xh0hOMWg7jnTN8M9FHreMvZr8hev4aIdlf3ZA4izVi/QRHw5whuJ1Y715dtEz6rJR1hFgAwULL6kB9N+duG6vveUugNmMDcQ3wdzOGJOF+PJwTLgbe8NnxGdAuXR1dj06SYqxioA/fpdX6oGf5IIJKV57uzIUfCFHD/JU/Bnz/Xdl8iHqpzf2lcGCHlYFRzgOKJfHb4OTS3QrIchOJCLqqvFL13c8jkRMIObsb6x48uQX0f4HBU3sLqstZwRiU6EwimKoQeclIG3thuXgWg2rPozP+UpgKEi3fRJvdBELBi4BgkbY7crJKgPNTe9j63cFvG4+AIj5uZmmeAOSiycA/haNcHSGfBdYNjm5WFtke/qZNca25dwS2SqFt9XevmWhHZLsj6lJPH0kdDBaMqxp4lidcV0qAIyJUrUaznkC9pBWRod+9VefwOzvCbqKwG188mXnxQDsftMcSM/CpjUZ7wRaMq2IANW8k190ffbl2GjurRo91tKlv04DNAldrZB2t5phiPRahYPtL3bP43fJCsYsUVkIg5MQ7ub5FpH9UIUPs/FEEHqLZ0OwmIHNBIbpA8Adq7130L2NpJ+EYWVgsoGjmmUYOfra1tA4WAMEDp2dW69WTJs5/5y+RlBc8cqU+PqV+1l0Trh1Aroqv7CyklrxpDpcHeHZ2zpDTxTpUO8ZDBy9oXIeXzGah0ra3SsDVOfvIbRwV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(10070799003)(38070700021)(3613699012)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlUrVGViRG9Hd1M1WnFSSEZYUFY4ZEl2VGQ1ZTVPRnE4QTZ1QTB3dFE0cVVo?=
 =?utf-8?B?SUpJU3Jmd2czZU9MN01QQiswamtra3I2S1ZZK0FiTmtqa1cwT09KUHRiU1ZC?=
 =?utf-8?B?cG5PRHc2YXh4NlltbXlVV2Y3d3dZbU5LS3ROSWd3N1JYMUxxYm85VHZIRklP?=
 =?utf-8?B?aExoWFlsai9DOGJkSzFIazJUdVoxaHFqZ05DL2lCV0lTYk55MWU1MExLejdC?=
 =?utf-8?B?aHhzcXJzdGgwYUQ2YkZlcE1RVlpqTG1kNDlMV21PUkxXUm9WS243MGhTWkpt?=
 =?utf-8?B?amJqL3Izc2w0NkQ0dW14YjlLb0pyd2l1c3p4QjBaU2szMERzdk0yN0hVWmNx?=
 =?utf-8?B?VXpTSktpR0d6TWNGUlQ0cmtjNHlaUmNBOHBkUEU4OGpjV1pBMlpMWFlsSVQ0?=
 =?utf-8?B?eGhmOWM3WHNVTHU5K09HR1ZyZUQ4VWFpTDJNanhHUTRPQWtid1Q1YlBJc2NS?=
 =?utf-8?B?UGpHblhWaGtDejNBRmk4UlFDVUZJemwvVDFiVDBzRHllU1lhMGFOaW9zaEFW?=
 =?utf-8?B?RFMyVFpUbmtnb3c4YjBPWjU1R1FMTmZaR1U5RzBlNWJuWDYzWlU0S1lHS0JR?=
 =?utf-8?B?UTNVWmpkdFdna2dLdU9xNVJLVm5wdUNyUkxtMzJBUzFoN0p0ZmRmSVhqQytD?=
 =?utf-8?B?Yk53aG1yb1QvUFV6MTVtYnB6NlhJRXpTRElQTkF3RUNLZnpGVElXdWhDQTlG?=
 =?utf-8?B?a3hxRlo3aVM0dVNxd0g2SUhGdlVWVmtXRlF1ZlE3Mk5uK1JBRlBhenFUL0Vi?=
 =?utf-8?B?NHBQSDY5VHgrcDBra3hSTE4wOS9ab1M0VW04bDZSeEFZQnFGN3VtNVpneTNB?=
 =?utf-8?B?c0dRNTZ3NnFZRmhCU090Z2RhaVNPNTU4OE9QUUNoZFVMbEI5cUxmaUZKN1VJ?=
 =?utf-8?B?WEpPWDRybWIzb3JYb2RhZ1ZnWTVKNWhVWnlidGJxaWVqcWZaQ3c3RXJkVWZP?=
 =?utf-8?B?WTJBajJXUUpSMFBibkNYWVlqY1FXWThPS1p6NUtDK0pEVFBYaWplVW51cm1p?=
 =?utf-8?B?dC82c2tLOVpEUXkzQ1RqYU5tdVdnQlF6Yi90UWpyUmNhbzZVVlhtL1hPTm5X?=
 =?utf-8?B?NUFiYklMWGFYOVVlbTk4cWlSUEdnZ3FYRE1lNXo4a2ptd1E1TmF3TGtJQjZM?=
 =?utf-8?B?ajBWS3ZqeUxLRXhCcW5Dd0t2WTZEdEZnVGF1OTVtM1pRS1dLZ2l0cmwyY2d2?=
 =?utf-8?B?NmhrbEpoTDV5YUdNOTZOUHR6V2dCbXRxak5lSjVoTURHYlJZaXhRUG1tb0tP?=
 =?utf-8?B?SDRaVG9FTGdMT3VWU1o2NDZ6YWtYQXpwcGNmdVlhSXdMZmp5d1hsUEJjcHBi?=
 =?utf-8?B?VVY3MGZxeHFlSlVLODM3cEk4eXQ2Q2dEai9ramNWVisrYXRtYVg4MytSWE8x?=
 =?utf-8?B?MjI3bjNqb3IrM1JCeXM3OG0yaklOUTVUMG5Zdk1lZmxSbE0vd0hxNkFpSUJj?=
 =?utf-8?B?WDRqZXdBaEtualQ1MWFaU0pQc25rc1Y3Zkc4bWtudnREOEdZcXNtR0ErM1hT?=
 =?utf-8?B?Nms1VndYNU16eWQwL0Vpa2hFZXlZRFUwY2hjK2RjTnJrall6N1JOaDEydURk?=
 =?utf-8?B?enM1akFlcUtxd3MwbWJhV2NldTA4d2NRTlFRdC9KZERabFZqUS90byt6WEpI?=
 =?utf-8?B?eXJqeERWM2QzVjJTMEZqcTRRVW1WYWhnRnM5RDNxbEEwQ0x5YkpKcXI4cGhu?=
 =?utf-8?B?bmpMMGhSb0cyQ3lzemNPcitFSm12cm92NTZqaDVsbC9lWEtuL0FpZW1ZTEdm?=
 =?utf-8?B?K1RCZEZlb3NveVpINld3T3JVdDNPZDhtWUZCeHhVNWZHNWIvYVQyeW11ZzZV?=
 =?utf-8?B?V3g2bHlwMmN2OGoxS3NoOFRrV3RZekNjUzhGbDY2aTNKb3k3aWJwc0M2WGtw?=
 =?utf-8?B?T0wxaFZLYTdrK01IVmR4YktPWmJ4Z0p3ZzlZRzhjZW5mZm9vdk5xc2kzbzF2?=
 =?utf-8?B?RWdtcUN2OE1OM3ExWnBQc2JxUWV4dytUVDNmalhxMFA2SDVYbjh1dDRLclU4?=
 =?utf-8?B?V1YwNmNPTnVLSC9wWnNlODI4NXVDaERTbDNid21iUitWZlZCRWMzTFd1azJW?=
 =?utf-8?B?SkpvUTRrRzJTU2J2Yk9YaUJlUklkWUF0MXc5b1BPaSsveFlkL1VWVTN3ek1u?=
 =?utf-8?B?Q1dTaHB0aGZaYnB2aytYaEN0cTlZRDRESWZLZWpIN1dDcjR2TC92UVhhTlpZ?=
 =?utf-8?B?SmhtZTBWVHpVNnlTNFhoQVNlNXpFZjlFb1lPOWVHR3ZieTdBc2ErY2Q2L3h3?=
 =?utf-8?B?ajZibEFVa3IyRkNtU01TZHFaUFUzV3pGWGtTcERrR25JQXNKcFBpTDdVcVox?=
 =?utf-8?B?Z2xEcWtMRFpsbDR0ZWpVMTgxbGFMdk1Pc3RPelZHdVEzWTNlUGhkWWk5UFBj?=
 =?utf-8?Q?V/mDSInjWL396b5XO03nOPs5flv7vhsF7NqVtcuyAJeJ0?=
x-ms-exchange-antispam-messagedata-1: F/+0AzMMXiBm7w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AKGgcha86vikWFJWLSuh2qOQWelM9dux037deAlg1Uc3RsAv5261D2e/pRXZ2eOUpVKbUzeGL2RdXGU/F5/0AuFOyOjCa2cnlEwekNKjMAMPbrHK9Y5y86E4Twmb8YauESIxuMIKRzi9m6msFXjC93dQK9RdOGiA2a170y80F1XgiK4F9qWGMX3nsm3hfdSQVkMAVLoaQAz4iu3gcVqjFLkxlUCpWyHheyxAHJJObCzntEO16UARPkeX0VWMUNhT6WIsuTWDCp5WBeZBpqKzA/giA0GAPaAhAjYVyZx2WqR+yL2DJE4XJl1jLiugOIcOV1yPKmeudMrJKI8oiVKsfw==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: acd8188c-e33a-45be-e01f-08ded1c975c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 08:20:32.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iAcykThHp5avn2uQGNYLGwyWAh75h9cYAnZPuwHquQ8orMQ+YKmaIoPfiiMUT3obzFGzZsTK/sTjd9AixSmALFw8WGha963p7gdUdA0TmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF2E9547059
X-Authority-Analysis: v=2.4 cv=U4uiy+ru c=1 sm=1 tr=0 ts=6a3b935c cx=c_pps
 a=DrmkRt+gHoKVCYJ+ot1EwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=_hq8h6B2wwqjqNc0nG4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0h7l6xTvlaVbcPS7z9x0Q9e8sEzW6vT2
X-Proofpoint-ORIG-GUID: 0h7l6xTvlaVbcPS7z9x0Q9e8sEzW6vT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2OCBTYWx0ZWRfX+ZPRmzurW8FY
 6erORLHgo7HO/8NXND3Phm3K+THLgfgq+Uu51/jpGV1NdDbgsquo+ZjDTfxQX6mUaz9RLbq3BRf
 onA17aCMidswamcYsCAUpoBeJXWOPkd+KPZqxb1gb/Hfuz5gTbIXahQFq3cb+4Jm2Gs6X1dqHT9
 IGfCQrUfVaAw43Zg5GBK2M743hJkApSLidxOBFcdewi9Mb6sClF/M9KFXgM/pa1ig4LmYeKCjL1
 SqpVPGCZVVX6TGwImxPwUrNSYc7LDsO+YyabbZr+0o54poaU/Xv0pWREa8oaGLekDgAH4/Pv55Y
 mazYEIrnHJ0gI0XevvIyJ1KrAQodU3T5ePEqflJHXhhaJ5hug0agkBbk1wyKwVzxlLEbj9Q0Inj
 a7D1HeFmSJWC8uQ9gN5WISGTX1abmq5nNDMXnx/E5nxkY3bl6GsVr4FWSZxDUbaJE7cnnFZgxES
 pe6qICCuRydLJo2X1cQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2OCBTYWx0ZWRfXyvYvxUc1qC1U
 kTIc31nbJbztLp2inxGLloHbS2Yw/hM6f6OeS5q27SjC81UojlbdBaLibyLw0zhHpZNflu/DwT8
 Km0Db5oIoZ3TmaOnRglgss9odRI5TOLlmsj8cZSn6jrlU4/39BcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240068

PkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPgo+U2Vu
dDogVHVlc2RheSwgSnVuZSAyMywgMjAyNiAyMjoyMwo+VG86IEplYW4tQmFwdGlzdGUgTWFuZXly
b2wKPkNjOiBKb25hdGhhbiBDYW1lcm9uOyBEYXZpZCBMZWNobmVyOyBOdW5vIFPDoTsgQW5keSBT
aGV2Y2hlbmtvOyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sOyBsaW51eC1paW9Admdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3Jn
Cj5TdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGltdTogaW52X2ljbTQyNjAwOiBmaXggdGltZXN0
YW1waW5nIGJ5IGxpbWl0aW5nIEZJRk8gcmVhZGluZwo+Cj5PbiBUdWUsIEp1biAyMywgMjAyNiBh
dCAwNjrigIo0NDrigIoyMlBNICswMjAwLCBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBS
ZWxheSB3cm90ZTogPiBUaW1lc3RhbXBzIGFyZSBtYWRlIGJ5IG1lYXN1cmluZyB0aGUgY2hpcCBj
bG9jayB1c2luZyB0aGUgd2F0ZXJtYXJrID4gaW50ZXJydXB0cy4gSWYgd2UgcmVhZCBtb3JlIHRo
YW4gd2F0ZXJtYXJrIHNhbXBsZXMgYXMgZG9uZSB0b2RheSwgd2UgPiBhcmUKPlpqUWNtUVJZRnBm
cHRCYW5uZXJTdGFydAo+VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyCj5U
aGlzIG1lc3NhZ2UgY2FtZSBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uCj4KPlpqUWNt
UVJZRnBmcHRCYW5uZXJFbmQKPgo+T24gVHVlLCBKdW4gMjMsIDIwMjYgYXQgMDY6NDQ6MjJQTSAr
MDIwMCwgSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4KPj4gVGlt
ZXN0YW1wcyBhcmUgbWFkZSBieSBtZWFzdXJpbmcgdGhlIGNoaXAgY2xvY2sgdXNpbmcgdGhlIHdh
dGVybWFyawo+PiBpbnRlcnJ1cHRzLiBJZiB3ZSByZWFkIG1vcmUgdGhhbiB3YXRlcm1hcmsgc2Ft
cGxlcyBhcyBkb25lIHRvZGF5LCB3ZQo+PiBhcmUgcmVkdWNpbmcgdGhlIHBlcmlvZCBiZXR3ZWVu
IGludGVycnVwdHMgYW5kIGRpc3RvcnQgdGhlIHBlcmlvZAo+PiBtZWFzdXJlbWVudC4gRml4IHRo
YXQgYnkgcmVhZGluZyBvbmx5IHdhdGVybWFyayBzYW1wbGVzIGluIHRoZQo+PiBpbnRlcnJ1cHQg
Y2FzZS4KPj4KPj4gQmV0dGVyIHdhdGVybWFyayBjb21wdXRhdGlvbiB1c2luZyBnY2QgYW5kIHN0
b3JlIHdhdGVybWFyayB2YWx1ZSBmb3IKPj4gRklGTyByZWFkaW5nLgo+Cj4uLi4KPgo+PiArICAg
ICAgICAgICAgIC8qIHVzZSB0aGUgc2hvcnRlc3QgcGVyaW9kIGFuZCB0aGUgZ2NkIG9mIHRoZSBs
YXRlbmNpZXMgKi8KPj4gKyAgICAgICAgICAgICBwZXJpb2QgPSBtaW4ocGVyaW9kX2d5cm8sIHBl
cmlvZF9hY2NlbCk7Cj4+ICsgICAgICAgICAgICAgbGF0ZW5jeSA9IGdjZChsYXRlbmN5X2d5cm8s
IGxhdGVuY3lfYWNjZWwpOwo+Cj5JZiBneXJvIGlzIDUgYW5kIGFjY2VsIGlzIDcgdGhlIGdjZCgp
IHdpbGwgZ2l2ZSAxLiBJIGRvbid0IHRoaW5rIGl0J3Mgd2hhdCB5b3UKPndhbnQuCj4KPkRpZCB5
b3UgdGhpbmsgb2YgbGNtKCk/Cj4KCkhlbGxvIEFuZHksCgp5b3UncmUgcmlnaHQsIEkgY29tcGxl
dGVseSBtZXNzZWQgdGhhdCB1cC4KSXQgaXMgaW4gZmFjdCBldmVuIG1vcmUgY29tcGxleCB0aGFu
IGp1c3QgdXNpbmcgZ2NkIG9yIGxjbS4KCkkgd2lsbCByZXdvcmsgdGhhdCwgdGhhbmtzIGZvciB5
b3VyIHJldmlldy4KClRoYW5rcywKSkIKCj4uLi4KPgo+PiArICAgICAvKiB1cGRhdGUgZWZmZWN0
aXZlIHdhdGVtYXJrcyAqLwo+PiArICAgICBzdC0+Zmlmby53YXRlcm1hcmsudmFsdWUgPSBtYXgo
bGF0ZW5jeSAvIHBlcmlvZCwgMSk7Cj4+ICsgICAgIGlmICh3bV9neXJvKQo+PiArICAgICAgICAg
ICAgIHN0LT5maWZvLndhdGVybWFyay5lZmZfZ3lybyA9IG1heChsYXRlbmN5IC8gcGVyaW9kX2d5
cm8sIDEpOwo+PiArICAgICBpZiAod21fYWNjZWwpCj4+ICsgICAgICAgICAgICAgc3QtPmZpZm8u
d2F0ZXJtYXJrLmVmZl9hY2NlbCA9IG1heChsYXRlbmN5IC8gcGVyaW9kX2FjY2VsLCAxKTsKPgo+
SW4gbXkgZXhhbXBsZSB0aGlzIGVuZHMgdXAgd2l0aCAxIGluIGJvdGggY2FzZXMuCj4KPi0tCj5X
aXRoIEJlc3QgUmVnYXJkcywKPkFuZHkgU2hldmNoZW5rbwo+
