Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854236;
	b=OYLyCuuv5H9YcT0JBJkNt6BFJUzXc0VwJi7WOJpSSesWWBVURYUHjO7OSg99JdV38OVj
	 Xo+mGPmh1hfpyFLweoWgZlnlSFBR055/zwhKFaE0qXKZBvIYear9IHoHasCtq1HT4rZT6
	 xcpT0jk9Nxg1FsiLGSA26xORLLPRhh8DgPvUL1doiUeV+sSwWuRnKcVBR7JfXcmND7A7X
	 4rWUTFYm6qvOZ1PaL6WCo2wMKC636I8D/5BhfnlMM86LlUWe7kluGP9XHyQovnPRKlBU6
	 FJIrsZ7//4DCh89oWwJ6JqyfuWmZEPboA4SXakAPxPWN/G03DmTPfFfEHMmJn4T99Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lP45kK8KmwzX2A72pfgAgpMZDpdO9Mk/ZPG5CZAGUfg=;
	b=BzbHAO0dzFzdGKTvffjJNpIf9YZHfrY8x3Xlnh99+H2NXVFNLe+7E5Ku1uDuyDcPeVLT
	 y2JRvGD59JUa+vkAc2/1RUlvnrD7YTdbubDBE4lfBOVeYHShKMcgsDuxgrEHb/YeiAxQu
	 UXP8Ac3/bsfU5NNIfVaKYcC+Fx/dZKBIuc4rLT1wiI57Nls8JDDDJ7cwxVKw6X1Np1X0T
	 AwMcbibv0dYiva3dlxUVbzUnerrvJAbL4mJvNTJi7LVEbGxWJW+eimgtv3HEgeRGg9GcW
	 KX5cUlvpcsvOP9K/L6Gmj/EzM7dghQCZxcu49YxihpGAYMWmNktXQRIU3jDkGBAoUtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=sDVGNHKn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.123
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020123.outbound.protection.outlook.com [52.101.191.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64A606A31C;
	Mon, 16 Nov 2026 18:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F64A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=sDVGNHKn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icTxdVCYAyrRvqmI4qEUrkdK6T2qW8zfe4NWiWaSVLATnx5l4HQDA8OVyhvrKndAIhh6il3Yz5+7JzqkRKBXPNJVG0YBGOhzgOTECTG1t2fyDvIADaIjKLefOL3UzgBtmOfvoQiV1X2q2Aycnj8ZYJeEt2NdfjawmhrFKpLFxkj+KHyAswwfnF5ZMUlJePgDsK+BNb3D+WaU997xq9CIFyB+1dH+QjSpGvt40y75Z/w2ldMcRVwVUZPfpraqjpUlPjWutvgFPdRQHHuglVC/MBz/XssFuTC0fBJ8Qvw3casubATfwlw4zn0b4Agj9SEvD4/59erIfFNuw74mk/5L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP45kK8KmwzX2A72pfgAgpMZDpdO9Mk/ZPG5CZAGUfg=;
 b=RJPvsVABmLYMRGgQNXqUS0H4i1d5wJ6SaObkg8UawEaouSRVvselPRtDZQQjRBMBJYhFrMxuu+e6coIrHQ97M/yaXyztpMqSRTgwwOU4wRanaHFNSY3i/q12Pa/KZ9vnhQAIvqN1KVglnK5t2PGJ/MkPk194S58tB6AEhzPQIUn0OgksxlGsEAxmI/gZLxFEUi507Q410FuKD+XenG2YJ6AOoxTWevYn0/aPn58RGpe3hVHQkybAxLrViVTmqLm+cj6VOXytQqOKS2BOyNdQduK/IoWnzyBA/rxEgopLcSsFPeT0hYAGau+QHWRHL3Tee7HQSr3n9ao3Pxu88T/3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP45kK8KmwzX2A72pfgAgpMZDpdO9Mk/ZPG5CZAGUfg=;
 b=sDVGNHKnA6QJQ783SCMzCuXPKh+DkMxQ+tZEkO96IR3vOwt5BxLWPwVLEZA+VuBd7SnkHhbKHM6nZ+iR7yapCnPNAz6n9rj529jacgPJ9ZwX8BFfsZsx1M0vh3QCPVXY/cJh2gfFIvngxbKolxD1Kp4SgHbQ+hlHd+xATPGS1/iQrKh2G3y7GsAibhGN12XECGFJlz7ptxEuFJOXNxZhmdW7ZPAVKHiEDfCyPCf4w5QY1WmOOnm72ozodUcHVmfITUPRqT52eQdDx6rv5LoNYaN1cwL3zAq01fgC78DAUbrvZ3TYLF2j4bcBXX+RWdfPdUeNgphE+NI8Ut7XsW6z6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB9831.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:37:10 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 18:37:10 +0000
Message-ID: <de727dc6-cd11-4a7e-a853-aecd895685a9@efficios.com>
Date: Mon, 16 Nov 2026 13:37:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] locking/rtmutex: Initialize the ww_mutex context
 of a waiter
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>
 <20261116135857.5t9HGji5@linutronix.de>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261116135857.5t9HGji5@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 45407c15-f873-478c-d9a3-08df4410a024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|261009223027099003|56012099006|10067099003|4143699003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	X47vK34U2SnLJ0YdV0LeFP5A+uoPbeb+m3NGUwsbyD6OlSAq9TUgoSx5U0NP06nWJEb+b8mKG6Ps4mE5NcMMG36tQyE8Eny3Gx0ULOWTfTV69ggjb6ch3EOFGLy5d3cWcq+IFL3i16jpG3aAK6g1ecotEjqGMKYiv14a9KNJ34WH06p4SjTYHgy4i9rfEmwa5SGr3vAfY7GE6XnlDjuMi0iviiafyg+zxHB+CgvB96z5vtrGZt8Z9DjRprkFs827LRWvPuko7q3c+KJFXRQKjALVoOpWe0uvvqfLpPDf9hpiNKPhe9bW4dToobWFnYTbS88iYFeeJXwgn8+HmYqFW3S91s1FgnOhsDaTlr8JRUITSGC4Y5zYGjVfBs0qGvqovTI5FzUrXgQyc8SRrkqRCVN4ikAiyazGtCIZtWvsHszX2x5W4tLrIfJSCb++gDywyDaPHx2TUsWvLAx2U9Kh7dw1bmTYeCOnD38dRXbn2ghrA+seBfe8nTGWu20rX9SmSgZg8pDzsJAoe0C+mhldhR6blL0GtURoPB74h2d5agEeny+bdfTdD5KPgIpN/LycG75uJ5pMhhaFTZVh8r9tM3kkJzeMZzXbmF/XYDxYzQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(56012099006)(10067099003)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGhjSjVYWUhvU3Z1bnVZTU40RU1zb1pWUHlRTUoxV295dm1QcnF5cGxHQmto?=
 =?utf-8?B?di9Ydk8vamlQeWZzRDk0QmFRSTlaeThKaFJCRThYZiswS2YrRGhGdXhWK2Js?=
 =?utf-8?B?d3QzWnoyTW9PcW5NUW1GNHBER1o0L21qa1BmS0hQVDYya0JqZjl0MXE2cmhK?=
 =?utf-8?B?SzVMcUs3OGljL2VIcERzZEVGUE9EMFhBOG9lUkptTmViOU5WZlF0WWpvbUtC?=
 =?utf-8?B?bTcrWEIzakFvZG4vRHRvbkNxVDBEMnhBNkdsL3NmQnBaVGd6MkFWaUx1Z1Zm?=
 =?utf-8?B?U2owUjhrSFllcFBVRjRzZGVvL3lTUnRUMGpkMUtaSk1uRW00cUh4WVU1ZWdy?=
 =?utf-8?B?bkNrWk5yRzRZMkRmdkRYU09ybU5jK1huY0F3VWJjU2NKT3dta0ErRXFvWDJP?=
 =?utf-8?B?NzZEYU9GNGNRMldNZ2sraHVUMkVqcU5WR2t6dU1vcUlKeitZUkNlQlVjRjRn?=
 =?utf-8?B?amViYXZ1TnpjS09yMmprWVIrc0RPZnBkUzNTc21PZkwwUHZnS3poUFh0d3pV?=
 =?utf-8?B?TS9nREVGWlRHL1JhdEFRTTY4S3pqVjF2R0g5dW5uZDFPR3JSNmRuWGdlVjBP?=
 =?utf-8?B?cWxmdW43S01CMnNueU0rRXEybHRyTFc1NVcyc1QvaTNEOU5TeVlpMUF2MjBY?=
 =?utf-8?B?TG9YVnN2cWJDUWxTTDJKWGhadnBteWNpcnFrT1hGT1A3SW1oV1JtdlNwU2sr?=
 =?utf-8?B?K3dYaXp0THFOMWM4dVpBcG9IMXdiMFgvU3RDdlM2eWQxRnZBYmNQSU1WYXFB?=
 =?utf-8?B?WEhvNHVUZWZ4QjJhWGFrYXYyR2pnTHhLWkpTS2JlRUhJOWNid3J1ellnblhE?=
 =?utf-8?B?VjN6OWxKSXNwYlA5ZC8vWXZGY3hXZStodis5cjFFVExTZ3NVZmFSSThRTWk2?=
 =?utf-8?B?aFFiVEU5ZVhoRnRZTFRoeW9oQ0dpODlhSStid2V6K1JrTkNVckxudHViZnZG?=
 =?utf-8?B?dmRDSFBWNWJsaThyZXhEQ2pvaksvMFNwWlBxeW1ybFJXdkVFbWZaYUZSZEhm?=
 =?utf-8?B?RlYvQzlISE9vRU9sbjQrQ0hmckF3N2lqdWFyVVhIREYvemhUMGFyeFQ0UzFV?=
 =?utf-8?B?WVN1VVNDRkk4ZGtrREVqaGZ3ZS82MzNTOGc1aWVHSmV1U09ab25XdHBROHgy?=
 =?utf-8?B?U1pVOStxYWpVTkZSMnZ6MzZLeVZDU1gxV3EwZGRKS0ZDelFUN3ZHUWlrNjVN?=
 =?utf-8?B?aGEyOHlFcTRRQXYzZGxxdERjRUJtaWptVCtXYlpJMlB4UERMaExBdFJwRFR4?=
 =?utf-8?B?UUoyL0lTYURQakwxZHA0bnRza1FFYWZPRjA0LzNYM0dqMEV0eFBlZVYxclln?=
 =?utf-8?B?TnNJVGxGU0kwdjZ1QVFNTEV4V0E2N3AxK005Q0RQVFZteW43NlVzUEwyZ2dC?=
 =?utf-8?B?Slord2Npa1k1ZnNHVHhORnp4VkRQWlFGRENtUHlYQ3pRaDJJOFJXOE1hd1JF?=
 =?utf-8?B?VVkyRnc0N0dleHhUYk0vdm9Ma1k1SzFmMlZHL2JzeU4yMkE1NnU5U2JXa2tK?=
 =?utf-8?B?cndhaFl5QTZkQmtLQkZwb1JOdjlraVZpUmhaa29BYjFrdWFBdVAxM2hWQ2xz?=
 =?utf-8?B?ZmpLMUlMWCtNZjZub05YdmhGaEpvM3gxM1dsT3IrWFdBWjh4bnQ0ZkFYVTRk?=
 =?utf-8?B?ZFhWZFEyQm5nM00zdnJ2VFhsM2dacmJ2bFhjdFlrU3E5aUcvcFN2MWNxNWhL?=
 =?utf-8?B?cWdaY2JQQVRvVEpneXVBY0NTbnlMR2ozbnR6SktqcGl6Wk1iOHp5bUw5dTJ1?=
 =?utf-8?B?SHhvZ01TdXlVNmpDNWtSK1R6cysyRy9LZXBTK2MvTlVFZkN3ZGtJbEdydWxC?=
 =?utf-8?B?SXBRL1gwL1FGeExlc2dmSXJyUEc5bVkxdmRodXRGTFgwUTlsQjAyVlJ5QWc5?=
 =?utf-8?B?RUFyMkNENkVuM3FLVzRoQ2dJcWFGT1lGa1hRelUrZXpObWdzOGRPSDBKbzdx?=
 =?utf-8?B?QVIya0tLcS9oUk9uS0tBdzk1RzZBYlJMN3RSblFvU1Qvc09iRGc4M0JsZ2Ex?=
 =?utf-8?B?R3g5b3M1MmowNGkyM2VWMndlUWJlNVJGakhrS1dIVzlVcUZlK0xNY2ozNWlT?=
 =?utf-8?B?VmpZdWdPTjJWcG4vT1Q3bDRFdW11MVloNyszME1QY2VSL2VSbEd3dEtLZ3NB?=
 =?utf-8?B?cmJmYWdNVnZUNkcxTjMzTkxOMGRnMk5VQkRVL2tVY2lKdjVBYUYzejRJRis1?=
 =?utf-8?B?MFNJeXhDcE9HaERjY2J2Q0sxaFdYU3dYWnp5U0pQQmZUdUFsZm5ZNHgxTU9H?=
 =?utf-8?B?WkVZK0tpTTVYd0FLQzRjTmQzbWJ2alJnTExJTjg2djZBdTBhL1dXeHYrNElv?=
 =?utf-8?B?Rm40REFIRTdIdmQ4cThIbVlCVmgvbExsdHhuZEVUZG9SaEtRZ3RnUDZwUS8r?=
 =?utf-8?Q?Jxxj3iSi2wcdvz9I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45407c15-f873-478c-d9a3-08df4410a024
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:37:10.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luYLTJ3zCJ+AocrxEsArGWZM/9ITVTer4JAyvd/XzpMV5xh2u8pJCp70bEZt/MpGNJujtNKJ00p7yZe/firbJnsv+B2vcC09KdxHQRi2R88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9831

Hi Sebastian,

> I *think* this is unrelated because the futex caller shouldn't end up
> here. The __rt_mutex_slowlock() -> rt_mutex_handle_deadlock() should be
> different for the futex and ww_mutex case.

The futex caller does not go through __rt_mutex_slowlock(). It gets to
the chain walk through the proxy lock:

   futex_lock_pi()
     rt_mutex_init_waiter(&rt_waiter)
     __rt_mutex_start_proxy_lock()
       task_blocks_on_rt_mutex(..., RT_MUTEX_FULL_CHAINWALK)
         rt_mutex_adjust_prio_chain()

rt_mutex_adjust_prio_chain() reads waiter->ww_ctx in two places:

	if (IS_ENABLED(CONFIG_PREEMPT_RT) && waiter->ww_ctx && detect_deadlock)
		detect_deadlock = false;
	[...]
		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
			ret = 0;

Both tests are under IS_ENABLED(CONFIG_PREEMPT_RT), not under
build_ww_mutex(). So the futex build of the chain walk has them too.

> Is this really the case?
> You have a lock chain where the ww_mutex and a regular rtmutex interact?

No ww_mutex is needed. Two PI futexes are enough. Both waiters come from
rt_mutex_init_waiter() in futex_lock_pi(), so both hold the 0x11 poison
in ww_ctx with CONFIG_DEBUG_RT_MUTEXES. The chain walk takes them for
ww_mutex waiters.

The deadlock case of futex_lock_pi_inherit (patch 4) is that ABBA. With
PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, it fails without this patch: the
second FUTEX_LOCK_PI blocks. It passes with it.

> I would argue that the full-chainwalk depends now
> on a random stack value _and_ __waiter_less() might access the random
> value if ww_mutex is enqueued and a regular mutex exists in the lock
> chain.

Yes, those are the two effects. I reproduced the first one only. The
second one is from reading the code, which is why the changelog says
"would dereference".

You are right that the changelog is confusing. It starts with the futex
symptom, and only then says where the value is read. In the planned next
version, I would put the mechanism first, with the call path above. Does
this read better?

     rt_mutex_init_waiter() does not set waiter->ww_ctx. Only
     __rt_mutex_slowlock_locked() sets it. So the waiters of PI futexes
     and rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES. Without
     that option, they keep what was on the stack, unless the compiler
     zeroes it.

     With PREEMPT_RT, ww_mutexes are built on rtmutexes. They can create
     a cycle in the lock graph legitimately, and the wound/die logic
     resolves it. So rt_mutex_adjust_prio_chain() turns deadlock
     detection off when it finds a waiter with a ww_ctx. It also drops
     the -EDEADLK of a walk that started from such a waiter. Both tests
     are under IS_ENABLED(CONFIG_PREEMPT_RT), so every build of the chain
     walk has them.

     FUTEX_LOCK_PI gets there with no ww_mutex in the chain:

       futex_lock_pi()
         rt_mutex_init_waiter()
         __rt_mutex_start_proxy_lock()
           task_blocks_on_rt_mutex()
             rt_mutex_adjust_prio_chain()

     The chain walk takes its waiters for ww_mutex waiters. With
     PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, FUTEX_LOCK_PI then reports
     no deadlock. Two threads that each block on a PI futex the other
     holds sleep forever. Without PREEMPT_RT, the second one gets
     EDEADLK. FUTEX_LOCK_PI also blocks on a chain deeper than
     max_lock_depth, instead of returning EDEADLK.

     The ww_mutex build of the chain walk can also requeue such waiters.
     On two of them with equal priority, __waiter_less() would
     dereference the poison.

     Fix this by clearing waiter->ww_ctx in rt_mutex_init_waiter().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
