Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794215141;
	b=v0URo/DRXupM8cOUInbVAsLu22CAQmAzi1SvODGIEcYrQ0z+yJt/zYkdCZrTtc/Hgrk/
	 gA9tte2opp3PBQAGuoYkGqJBdOEYbaAz/985Lhc2E7NyefVQiy8c/Q2Exn7rB5Pe7/ron
	 cO58Pim3dZg0HFqtVeNIgt9UfjG05OGYC0gvmEcLCnjL3/rJ29DLMf8/N/CnvH64swAz2
	 YH5F1ds4mDG7JWsvr2p78ibL1tJvMo0gnnW7bYvb1BJ9nFAfJawBYhE5LbiA3QqtYOE5G
	 YBzdlfrEJCsd2L5jz1eDl1Do0stL//92qitXtlYc5MSlmVBIsc9jSYTuIR/KjfkCi6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
	b=oUufjcUExsKyRdhHFFxKKudk69drBNZtYBnLGTnWxQ3QMvKX+lnZE1LawISqVFA2/DnS
	 NlNndJjAcyvDmS2fai/SkKh5vtK5ApYKbdwgos4YucZbYhuBaYqK1AHSEbLbB9UZKY8vu
	 IQQHgu4H+zelzjJTDdiicmPyQFcEExkqZm8Yrbn+iJ8pQcBEfwcjSaT4rYwBA93/hsmCz
	 5itqR03JNEu1FH2k9ykrwxKVxnujlZ4dVLyEVuTkqTMH6PHY4nX6FeBUluoEQkv9tnYXa
	 c/o5IhBk23HFvhzXDoe6dpc5SY1DPaHdJwq+M/os0/mcSBnIYAWJ+/auSkG7ct32k4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=U7tZ5TcD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.79
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012079.outbound.protection.outlook.com [52.103.11.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B1606A338;
	Mon,  9 Nov 2026 09:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D85B1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=U7tZ5TcD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZ3f9pO0FeTXVM3SiWKxiHZWBLES/6rcD4HK2pqX83+Ftpgfu9vqOjUTNVijjsEw/KiLKIhSwNbA6kPDjwJrPZnyRX1G6OrErdWAjfTelZIrUHV5V0J4N69ASb+sUQsVUfJdKUkfyoADx6JjB2L+WuyLFFi2wdX2sncKfE0pn9ErkOes2vjSUglzILWrtmC9zZZNHTrBs7DHbFGld5LbR2RgbiUD0oyLT1B2yODpTQ4H9m09F++hjjmcsA+ZPPGs0+AFy/ZYpYd70ZCWzlpzKgJO1TS3W0CfXKuj7LVY4zNwAg37E0S7FO4g3fudjM0PZB2CRdvqQHI89jQYApGqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
 b=OCcQeGsIlNJ5EbAQKPni49CRXcHCVklDKALQZEGHl+LBP5pzwe32bZhjIr3fnPlSsR9REZvN9xhNjvkSbDIOeGaY8CzKBlxe6kiaEj3sqgCFaGfh9ijyRM/fW10uV6yS7scK9I0WRBYUMkxxrTHxkiki51MCnI4zSvIVb9DYXN7c042v1X3+8dcBNQHnul0cbQ97JH9MsqZqMffwUTodPcqaS8qae7SLtt1ThjqaLM/qz5nUv83bDoV4MJlG04N8hnLKDaZGGN57O/IGu/+Vsc0e746MkSa514oxIYlplDUpKYk4JHGwsrWIyBMZy4kqDen0sKk8AgozF7V+MHnJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztg/5bmLq4//z0uMVnXVVg1kfKv0mUBJtxsLi/sRiQA=;
 b=U7tZ5TcDJOo2Jz4CNORCfkBPjuqxc+FGTxFbD6ltynnvQN5yTyPEM3Uo+0YXG9Dnoi7JbizX0RRP/62gOL7CAknMeYFqF+2Ht2EpxGt8t+wsaoNsGURZAHdMU4TwZWHIBop4TxZm5Klnz9khu33igauEATgH9PcpDOezQC6tPv3CJaumfkby4xToV4SWwWkaRE/sFL+troFpQcCxCReVermB0bTrviS7MBUlLMo4DYQ36qiDNSwkEKR7BU58IlWxhejuZ9nB47cMYeUCRNoFLbptW7tbG6VMs1MNK7DkVxUrWBIN9Vvtmtod9DyVAnhxSwmE7IquFfBfGHs1C1KdZQ==
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 (2603:10b6:806:39d::17) by IA3PR05MB10668.namprd05.prod.outlook.com
 (2603:10b6:208:536::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:05:39 +0000
Received: from SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d]) by SA3PR05MB10385.namprd05.prod.outlook.com
 ([fe80::e22f:a0f5:fcb0:9b0d%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 09:05:39 +0000
From: Yingjie Wang <x-professor@outlook.com>
To: Song Liu <song@kernel.org>
CC: Yu Kuai <yukuai@fygo.io>, Li Nan <magiclinan@didiglobal.com>, Xiao Ni
	<xiao@kernel.org>, Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/2] md/raid5: roll back failed PPL disk additions
Thread-Topic: [PATCH 1/2] md/raid5: roll back failed PPL disk additions
Thread-Index: AQHdcCl9IvkMDYEfjECQQvtXi6PSig==
Date: Mon, 9 Nov 2026 09:05:39 +0000
Message-ID:
 <534f84fca6a91e139c1c618a47946859d85a68c3.1794215128.git.x-professor@outlook.com>
References: <cover.1794215128.git.x-professor@outlook.com>
In-Reply-To: <cover.1794215128.git.x-professor@outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR05MB10385:EE_|IA3PR05MB10668:EE_
x-ms-office365-filtering-correlation-id: fffcfbc1-e3f1-4959-cf0d-08df3e409fdc
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|38102599003|8062599012|19110799012|22091999003|24121999003|8060799015|15080799012|4140399003|24021099003|25010399006|31061999003|102099032|3412199025|440099028|12091999003|18061999006|40105399003|26121999007;
x-microsoft-antispam-message-info:
 =?utf-8?B?cEprRWg2ZDFBMFdOYi9QeUFONWM5SkhiL3AzM24yMlR3QkZKeGtMcEdOcXZa?=
 =?utf-8?B?aEozY0JzcUZ3LzNpbCs5VXpsZitOZWV6ejdTdFdGdHJiMXh1MTJLS1JGWE9s?=
 =?utf-8?B?NU9NNGJPZjlYVWUvMUlwdTgrNEc3bHpHRkFqMm1ETFFPMTNwZk55SFd3SnZn?=
 =?utf-8?B?MlJQR28yMlA3MWdPbmpCOUJaWHE2WmErNkNDc2c0WGdBRm1EUVhQSXJieXJx?=
 =?utf-8?B?dnBENGZCQ2JiemlHcnJHOGduRklZRUVpSUVNZUJBWGk3SHFRaHdhckIzeE50?=
 =?utf-8?B?YUF1YUdEQjBDQS9LMW1FU2tua3plUTcrU1ozeGdhbGZoOVpZaDJrRlBRK01V?=
 =?utf-8?B?ZTNjbFFwLzl6NWRJRTYwdXQ2cXB1eU5mVFZndzdDQlRHV1RjVXBVTW0wc0ll?=
 =?utf-8?B?MGQ2MkM4NHNtZlJXSGl4eUYzRWtoa3Jhb0ZtanE1YWpWeFJBMkEzTzBxZVE3?=
 =?utf-8?B?THBVMGlnV1RTdmxtd0ZET0dEUC9yTm1KK0pURUtMT2oxTzU2bzVKMWlBYWhn?=
 =?utf-8?B?c00xWFVsQWJzYyttRzdpUk1kU1YvY1BTNCswNG5GMit5WjJoTnFBY05uRFR0?=
 =?utf-8?B?R1UvZVdJZHZHdmxsMzdwRXFka0J0RUYzZzFhaDhMak5sNktzc29FaFFVRDNP?=
 =?utf-8?B?bWxRTkw4MHZONU41dGpoOFhtdi9aU2s5U0lsc1BzTmFIczUrZTk0eFZPbHFH?=
 =?utf-8?B?bGVKU04wUCtnNjRHdEV1b0VndWNOM2ZEYTlFeFEvZWUzanNkeU1QN1QvaU9C?=
 =?utf-8?B?MlBqQjZZV20zZSs2cDJTRVplQWZZcWhBWi90Yis1Vmx2WXZUK2w4Y2JrdlIr?=
 =?utf-8?B?NytOYmE1a0UzNSs2VU45TlgvMm95YXZ4bXVoQnl5L1FJNDZVckErQjN2bW82?=
 =?utf-8?B?WXBKNlhhVUZXNTdGdG1XdGZacHJnZnp2SmRkZllYcHE1NUxrZEUyMkJRRjJl?=
 =?utf-8?B?eStQWXk0cWxwOHV2eXFaYnhRY2cyWnIySVcrVVpCS0ZZdWsxUFNhbVcxZnlS?=
 =?utf-8?B?bC9HZ2FzV2JyTEcrcXpqZ1pZTHBkZ0pXQ01Kait4ZkNXb05QcytlUmV3bklh?=
 =?utf-8?B?VXl6cFNxMzc5VnJzT29DekFNSGpjendVRk1ra3NpTVB2Z3ZLMXlyMmxTbGpT?=
 =?utf-8?B?bzFWN1pES3ByN0EzNTE0bjRXcVN6bng5TEV6djBoazV1L0ttZXhZUi9aTmFZ?=
 =?utf-8?B?dHNmdlFwRjhONWxlUklrbWhxZkdKdXdqdzFIWDA0UzJ3ZXg5TkVweWpaUnB3?=
 =?utf-8?B?NHVqKzNJZmlxcXNqbC9Sam8vaUszSmtmVGFQT0lKcTR2cFNWUWtBTis3dFRP?=
 =?utf-8?B?aE04WGhQTEYwdnhUZGZSTTk4SldCZTZyL1NnSmp3c2wrMlNHMlpOQXFXYU9z?=
 =?utf-8?B?dFRncElacUVDTXJqdllKVEJxMzlTSGEwbFV0Q2ZwdkZ3bmVOV1B5azlwYVlJ?=
 =?utf-8?B?elRQQ1ovdzc0c05EQ0pXTTVoakJxOVVaYUEvN0piL2Q0ZjNId0VWeFlrVlBS?=
 =?utf-8?Q?nHwTk4Fa7NcLRrS+2WLLebtAdOo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDRBQjg4SUR1ZU9SdFpudGhzY1ZqRzBZWEVpcUJxWkZ5NXdXL1ZzSTN6cmgv?=
 =?utf-8?B?cmphSHJqRXJRZC9zbi9meXRJb3pKT0JnTzIxTUQ0eWZjS0tqUUh3SmZlTkEx?=
 =?utf-8?B?SnJ3Ym9xM2tEbEZIckpaTUN5bVhEdjNDdTdwM1ZQaC9XNUtXbm5TN2xkQXM3?=
 =?utf-8?B?UkdkQTRTYlpOWDhXdkpHV2k3UnhwOWlnR2ZLbllKcmlLVERsTHMxRzJmSWhi?=
 =?utf-8?B?azVUbTB6UTBneWx4dU5jWWZ1R2JaYWd5T0tXK2NvUWQ0QmpOY1VKVUdYVHhZ?=
 =?utf-8?B?N0hiNm42azk4enNTcW5HR2V3TitPT1JpK3VaUFAxOGpsZ3J5S0plbDlvQ3kz?=
 =?utf-8?B?R0wvYXVrWFBZdnA2Y0JJa3lQS2ZnbjZBRnZkZk5jb3N0RjJLK0dKWC92YmQw?=
 =?utf-8?B?cVVtU1UxVXVmWkMvRWhoTjFnM3pTZGFaSFdQeXZOMER2NWlxMjJLSG9SZXpi?=
 =?utf-8?B?M0xENGF0UmgyUStuak1pM21STFFsTjVFMmhPWGtWOHVic29wc3M2YU5oUTJw?=
 =?utf-8?B?SmVZbnFac1Y5Y0k0QlBna0trYjIzTmNIODd2UXU5ekNaalZ4eHlPa1RqRGFN?=
 =?utf-8?B?OTYvdnlidWYwTG0waDlSWlhBdXJZNHEwbE9qdk1Ya0tsdGpLa3N2aWVSemlZ?=
 =?utf-8?B?cmlMTnU0RHlIeXF2anFVYVRYZDYzUkV6RStQcUxlRXNvc0w2YTV4YVhRYVpi?=
 =?utf-8?B?UGN0ZE9CbVZIYTR6ZC9YaWV2MWg0b0UwSzdSamI2ZFVEYmoxMmZURytEdytZ?=
 =?utf-8?B?dHhuSE54bGs5dmtoOURHcmxwNXJPM090QmQxbW1QMkppUUNOeWhhVGtHVnpJ?=
 =?utf-8?B?d2duZytzT0V4bnA5ZGxQcnJQUi9KVE80eHZnWEVaekpEd1lYQldTS0hGYmE4?=
 =?utf-8?B?ZWJvK2FkZ2pkWmVCSytvcGVIRDZScyt5a1V1QnF3RzZIOVdiSVJ1cUV1UzBU?=
 =?utf-8?B?eHNWcGlldXlKS3JsaUt2djh6NDJIRjRLUnFoSjdHS2wyb3A0MDY1VG5nT0Er?=
 =?utf-8?B?b1RITHpVb2g5M09aeGNBcTNodkJySW1hYXJQY3lXR1d1MUlxU2lNdERjbHZl?=
 =?utf-8?B?TVNvTUxRVE5kVzN4VGtvUEgvWFA0Rk9rTXN1aWszUkhXdUVJajBNSUd3QWdD?=
 =?utf-8?B?cm9FTmMwWXlEOVJCQWFhTnFSM0MwQXRNL014MjNvdFlyRDZGcExLOXBzOFJ0?=
 =?utf-8?B?eFppTHFnYUlmYVc3Q1M5TVo0RFk4QlFwaUl5dWNlSVNNQURXQW1WL3d4YlFZ?=
 =?utf-8?B?M1ZZWHdwdGtQcWNIMndjSEd6ZzRXQlNUMlpCRFNHaExXeGtJMUprQ0FDTmNl?=
 =?utf-8?B?UlUzMTA2UlNSZ2ZJc2JGVGRrUC9IUHpaU3ZKajN0Y2VZQ2ZvcXBjbnRoWmFZ?=
 =?utf-8?B?cUJNZFpzbmNsTVZQS1hZa0pYOWhtM2JkMDdkcHVWZGRHVW5vZ0cvTDNKREtl?=
 =?utf-8?B?S3hlemFQRm9OZUpEWG0xNnhZYVdZNzB1RDlHMDNxdEkzeGtqWEpWZUhkTDVW?=
 =?utf-8?B?TUcxWXFNRzE2YnRISEIwRWNzRGQvZjZYa2FITWsxUFRRTzZpSTI0MUwxekhp?=
 =?utf-8?B?V2FSY3MzZGY3OFN1aEZVWngzQ2xNbUt1dGhEM0xRMEw4eHpQcFZSU0YvRWdn?=
 =?utf-8?B?a0xDeUkxTS9GRmE2eDZVSDFUM1RSYnVhMWQvQTlWWVJCSXdyM0hMdnREbXla?=
 =?utf-8?B?NzRzVVlvZ0NUMWhzZElJSzZ1b3ZOa29xYUZwcXVQNkVkR3dUU0xVeTlWZHAz?=
 =?utf-8?B?MXZmbG1KUHhFN3RxU3Z3UEVldmdDRzZqQUFFNUxNSHErQkZVcVY1TGVDK0Vx?=
 =?utf-8?B?ZzJaaVQvZEVnWklxaE9tZFNLSVNEcmdjaWtwdXBaWExGaXJyTS9WZXVFaGEy?=
 =?utf-8?Q?UwpbVxUZmbzQX?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR05MB10385.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fffcfbc1-e3f1-4959-cf0d-08df3e409fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 09:05:39.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR05MB10668

cmFpZDVfYWRkX2Rpc2soKSBwdWJsaXNoZXMgYSBuZXcgZGV2aWNlIGluIGNvbmYtPmRpc2tzW10g
YmVmb3JlCnByZXBhcmluZyBpdHMgUFBMIGxvZy4gSWYgUFBMIHZhbGlkYXRpb24gb3IgdGhlIGVt
cHR5LWhlYWRlciB3cml0ZQpmYWlscywgdGhlIGNhbGxlciByZXNldHMgcmRldi0+cmFpZF9kaXNr
LCBidXQgdGhlIFJBSUQ1IHByaXZhdGUgcG9pbnRlcgpyZW1haW5zLiBBIGxhdGVyIHJlbW92YWwg
Y2FuIGZyZWUgdGhlIGRldmljZSB3aGlsZSBSQUlENSBzdGlsbApyZWZlcmVuY2VzIGl0LgoKUHJl
cGFyZSB0aGUgUFBMIGxvZyBiZWZvcmUgcHVibGlzaGluZyB0aGUgUkFJRDUgZGlzayBwb2ludGVy
IGFuZCByZXNldApyZGV2LT5yYWlkX2Rpc2sgdG8gLTEgd2hlbiBwcmVwYXJhdGlvbiBmYWlscy4g
SWYgZW1wdHktaGVhZGVyIHNldHVwCmZhaWxzIGFmdGVyIHRoZSBQUEwgbG9nIHBvaW50ZXIgaXMg
cHVibGlzaGVkLCByZXN0b3JlIHRoZSBwcmV2aW91cyBsb2cKcG9pbnRlciBhbmQgUFBMIHNpemUg
YW5kIGRvIG5vdCBpbml0aWFsaXplIHRoZSBjaGlsZCBsb2cuCgpGaXhlczogNjM1OGMyMzlkODhj
ICgicmFpZDUtcHBsOiBzdXBwb3J0IGRpc2sgaG90IGFkZC9yZW1vdmUgd2l0aCBQUEwiKQpDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBZaW5namllIFdhbmcgPHgtcHJv
ZmVzc29yQG91dGxvb2suY29tPgotLS0KIGRyaXZlcnMvbWQvcmFpZDUtcHBsLmMgfCAxMSArKysr
KysrKysrLQogZHJpdmVycy9tZC9yYWlkNS5jICAgICB8ICA5ICsrKysrKystLQogMiBmaWxlcyBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWQvcmFpZDUtcHBsLmMgYi9kcml2ZXJzL21kL3JhaWQ1LXBwbC5jCmluZGV4IDA1MzA2
MzJmOWQyYS4uMmNlNGUwZTcyMjgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL21kL3JhaWQ1LXBwbC5j
CisrKyBiL2RyaXZlcnMvbWQvcmFpZDUtcHBsLmMKQEAgLTE0NjEsNiArMTQ2MSw4IEBAIGludCBw
cGxfbW9kaWZ5X2xvZyhzdHJ1Y3QgcjVjb25mICpjb25mLCBzdHJ1Y3QgbWRfcmRldiAqcmRldiwg
Ym9vbCBhZGQpCiB7CiAJc3RydWN0IHBwbF9jb25mICpwcGxfY29uZiA9IGNvbmYtPmxvZ19wcml2
YXRlOwogCXN0cnVjdCBwcGxfbG9nICpsb2c7CisJc3RydWN0IG1kX3JkZXYgKm9sZF9yZGV2Owor
CXVuc2lnbmVkIGludCBvbGRfcHBsX3NpemU7CiAJaW50IHJldCA9IDA7CiAKIAlpZiAoIXJkZXYp
CkBAIC0xNDgwLDExICsxNDgyLDE4IEBAIGludCBwcGxfbW9kaWZ5X2xvZyhzdHJ1Y3QgcjVjb25m
ICpjb25mLCBzdHJ1Y3QgbWRfcmRldiAqcmRldiwgYm9vbCBhZGQpCiAKIAltdXRleF9sb2NrKCZs
b2ctPmlvX211dGV4KTsKIAlpZiAoYWRkKSB7CisJCW9sZF9yZGV2ID0gbG9nLT5yZGV2OworCQlv
bGRfcHBsX3NpemUgPSByZGV2LT5wcGwuc2l6ZTsKIAkJcmV0ID0gcHBsX3ZhbGlkYXRlX3JkZXYo
cmRldik7CiAJCWlmICghcmV0KSB7CiAJCQlsb2ctPnJkZXYgPSByZGV2OwogCQkJcmV0ID0gcHBs
X3dyaXRlX2VtcHR5X2hlYWRlcihsb2cpOwotCQkJcHBsX2luaXRfY2hpbGRfbG9nKGxvZywgcmRl
dik7CisJCQlpZiAocmV0KSB7CisJCQkJbG9nLT5yZGV2ID0gb2xkX3JkZXY7CisJCQkJcmRldi0+
cHBsLnNpemUgPSBvbGRfcHBsX3NpemU7CisJCQl9IGVsc2UgeworCQkJCXBwbF9pbml0X2NoaWxk
X2xvZyhsb2csIHJkZXYpOworCQkJfQogCQl9CiAJfSBlbHNlIHsKIAkJbG9nLT5yZGV2ID0gTlVM
TDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvcmFpZDUuYyBiL2RyaXZlcnMvbWQvcmFpZDUuYwpp
bmRleCBlZmI0YjBkMzdjYjAuLjQ1NWUzNmRkY2VlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZC9y
YWlkNS5jCisrKyBiL2RyaXZlcnMvbWQvcmFpZDUuYwpAQCAtODU1MCwxMiArODU1MCwxNyBAQCBz
dGF0aWMgaW50IHJhaWQ1X2FkZF9kaXNrKHN0cnVjdCBtZGRldiAqbWRkZXYsIHN0cnVjdCBtZF9y
ZGV2ICpyZGV2KQogCQlpZiAocC0+cmRldiA9PSBOVUxMKSB7CiAJCQljbGVhcl9iaXQoSW5fc3lu
YywgJnJkZXYtPmZsYWdzKTsKIAkJCXJkZXYtPnJhaWRfZGlzayA9IGRpc2s7CisKKwkJCWVyciA9
IGxvZ19tb2RpZnkoY29uZiwgcmRldiwgdHJ1ZSk7CisJCQlpZiAoZXJyKSB7CisJCQkJcmRldi0+
cmFpZF9kaXNrID0gLTE7CisJCQkJZ290byBvdXQ7CisJCQl9CisKIAkJCWlmIChyZGV2LT5zYXZl
ZF9yYWlkX2Rpc2sgIT0gZGlzaykKIAkJCQljb25mLT5mdWxsc3luYyA9IDE7CiAJCQlXUklURV9P
TkNFKHAtPnJkZXYsIHJkZXYpOwogCi0JCQllcnIgPSBsb2dfbW9kaWZ5KGNvbmYsIHJkZXYsIHRy
dWUpOwotCiAJCQlnb3RvIG91dDsKIAkJfQogCX0KLS0gCjIuNDMuMAoK
