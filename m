Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022939;
	b=28z7vachfQROaXD86LEPO9aM837+l13qyyWCJEcQcEdcU+e2ZXCGtg/XAhAg2XYwk/QI
	 8tW12/niD0b5CIOPsTsCvEW00kDwWLd8xFlz9fSG58wwD4fkeLl49EwBgXygT1bg6aohC
	 jRFgwbEKvFlYNjoAPoB7Iz6wGy61xGQyrIYKTTwH4/k6BLokBxzXdbEbc+NXCEYxXEoRu
	 EZ5XMZoKJxtZlgcsM8FpmZjs+iEth4MZ7MFZx7/tLMFdnVIF5fO4Ssiy35Q0aS/0a2qwe
	 fDhv3i9kZC+UqFcb5jbGbA3FdhIeey7eod2UELXnW9JxBsmXIw2vIElwsIqqfuguhow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022939;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
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
	bh=+DQ8aAOaT1e4797l0pR7y1UhDFG7T+52rTxHTz5e+f0=;
	b=txvSGwwAaxIh3w39x+5xyqkPTfcrQPe9FaHpl6PXayEB7VC/2onDsA1ilWmpVnvGGt3a
	 lozjGwQZPdYZfGnYMenxc2tKpbGEnl9nZlCrvYbJrs7CHoNYk2sYt1wUm/0oIYOF+08wD
	 WJiKnwkuHM041ZLMxCjOBaKKF9c+RolwvtBjGY89JZCIfDkvUpmPyeI2iZp6nCtHum7VG
	 i+ctInMYhrZH5b3e1VMRR5893IQwuZY8M+JqYEy0SwOsp4y6ScRaBMAOjSUKdFO2C00Kp
	 mh+hhBpdTARNg0TaqCd2AGwjiKTIDiHpUmlBNqYvGYkr98ph8hgHsAxmWAc7JEDOt9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Vgf9b+Ki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.133
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022133.outbound.protection.outlook.com [40.107.193.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF95606A772;
	Wed, 18 Nov 2026 17:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF95606A772
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Vgf9b+Ki
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMaKmOgg2dgVtQiBpglnXa4rR0gwVtYV9dzSIcTlLqVAcSvZ+ZbxR6gFePzkKLNkQ5mZ+FFBfi0Kh/M8i7LhE9GmR0dVVSCecbTDxaaP/VqyT2fWnj/zbxuVFG66qXwf8ndbHlwWnRFbrWNVfIaFEKP3T1KWArpw1aR4AX6SAMFQtcbGSdKx1UgD28RlFIA/dpS4jd8IuspOMjV4AmrIub0jWYmLUp4FsCyQxLOyoGKyzd7i2mX9r99bTvnTs7xMDsF5t6thmDFuQwQpywJmnqxt+kyL/bdFOgOpN9Mngjf9NZg5wt1xNGWDbNco43FxnbCCm2Qu4TOYoVAQmUqGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DQ8aAOaT1e4797l0pR7y1UhDFG7T+52rTxHTz5e+f0=;
 b=qCAwXQjf4a/6M71x9CDVHuSA46OZKVF4F+00BR4In34Zzkopk/55QCcKaqRGlrTcmN136UVwHOzHCnPDE/V27qanZsy6haSkjoLk58Q4mGMNkrAZ0MthIX5m6yNiOKp6bQH7CusaIGlqWt5Csu3GXj/d8QJEj1a42LJDsvRvJ/h915VRqSzGbiHCHnK0rA5N0fIX28aUcW3odmMGmoaXw10/r0KVcSeEhffXuGP1lBUxAC5l14NNAxxyLur1Q2IF2i0LXxk/ILfU0bm+WCLJ0OuRXQ19DhWUlVlVMciD3O/mwU1TEIDMuW/L8DdPfyB1VR8kUVIITtSecNsGOoqTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DQ8aAOaT1e4797l0pR7y1UhDFG7T+52rTxHTz5e+f0=;
 b=Vgf9b+KinQFaO+tYpkzhaKpqjJpW+eqfj7yJlKd0aMZVgYiLRxQk/IbkvCf7dbzF3x5ZcpGlf70y13SfC5H4FhNvmUcRv/yw+ujEW9mKdx7A/9P0iGaMFbXpbTs+7vmt8I5oFi1Co2Z6ULnqFS43FCCw3x4d6nyWIZke+fYVXIJCareLp/Tjz0+aZOMmrqN6yGw/NEmzaeaBQ6Bu4a/hfBRpkjlY2TU5iDQ/nsg2NsQ/Zj0GiFFkWLyQfmEOMuPFsgdBkgDdMi90YpvQc0Ftd/+ZhAotE+XbgBcscTDpBlcuUo4TrcmOJNYC5ko7jngkUrtcCNNF0Owb/FEktxpSzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB11553.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:154::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:28:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:28:55 +0000
Message-ID: <56ded99b-9390-46c1-9466-0be0cbb9ee95@efficios.com>
Date: Wed, 18 Nov 2026 12:28:54 -0500
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
 <de727dc6-cd11-4a7e-a853-aecd895685a9@efficios.com>
 <20261118144006.ms1fvDv1@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261118144006.ms1fvDv1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::19) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB11553:EE_
X-MS-Office365-Filtering-Correlation-Id: a866b2ba-8cd1-4509-b0e5-08df45996c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|261026140227099003|4143699003|56012099006|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CnEnof9BD/PPLaXKYbMA/7V1A0EwgnbmRMRXtOE1AF6EzxMU1zrhlVi5Pv30q3ZewbyjLCAPuXmMfQNE9GYUafPctMObcZcmRGIoO41flagTjymUhLGFlFZCg1y9QLkczDaHvFLmGtCB9xJQBF1OUQQARrPbVyEd9m1vVMcCifXGxNJuPnhlJhIeeJJphJAm9n0cXPlyZJM65hUl9kO0LHX6SzneuXyzLwZPfBJcLtrA4ZTEUHRVYND9I2zkB3q/QBuDLqnGa1zlO4kDMWWajGq9Bat2CYHBUjOm8jd08PE3JF1fI5KIPWfkUbhLcXbO7ORb0++ebgqYfD8VGzThicS3fP6bWVT9liqjzHnBJOD9uZZmwwYXA9NBoV1gU33dwvtI7C8psdLLGSQmWO/bOSfpbtt2ths+zZmu+k8OdaSC5LIAJI4p7Tg6XNcNV7yXT/6sT9SjLX16yjBi7tOY8JqqrjqePY7L0UF6vhxpmMI6a0nD9+Jbkeh0+Tv+cPN9sV+4SSxRCE3fdazUQeGhHpq48DBqVdfktt4Vg/Dh+UkNRpnwE62b1E/YFnhhTUTZPlCNDBiGuNKHmDfuxdIW9DFzRu8N//KhKYiqTgJTemo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFFPSkltRkZCbnZkd3hXYjNNWmZVZ0l2VGI2dG00b3d6ZExBOWZDTmREQjZu?=
 =?utf-8?B?bE56dThRakJwdG9za09nQ01WZCtuYWFkUHhqV3I5YzFlMFJJOG9WdXU0ekZ5?=
 =?utf-8?B?MDhvOWlkTFJ5Qy95YXEvZS9DU0RUVmhyS2RSMFBuUmVrTmtqRDVMTi9VMUta?=
 =?utf-8?B?cUhQRXhiTWVIb1hVaVFNUVhSSDVNOVBRYW05c2grcC9GY2M0cis3K2lBL2lE?=
 =?utf-8?B?Z0xwSDVBS1ZlOTJtZlpNaWZKOVFXNTVNdFlZbm1uSzlxaUNKcnVicnZVMGxY?=
 =?utf-8?B?TzZlNWkvK2krSG44SVNLVzZFNithaFRuaDJ6NmZvUDhjZCtYRHBWWHRQOVJy?=
 =?utf-8?B?MFlwcE9PRzBRd1poaUhDSzUwSHdodzVwdzZGSVdOQk9JQTcvM0I5QVRpVkRL?=
 =?utf-8?B?Q2FHVmRXTnM5dTJTVTQ2YnhxaVVNU1ltM2M3T1lBemtXdDJQeVJPQ3BTN1FY?=
 =?utf-8?B?ZkdjYjFkVXRRaXFhbS9kcjZVRlN6b1dqMnBoSmFlOFREakVnWmhVSldJa0Ux?=
 =?utf-8?B?TkJ2Nm54Skdlbm1SVE12RlpCbHhQMXlVaFdEeFJYd2FreHlVYmRyN1RlSkxu?=
 =?utf-8?B?Z0xPcTZYMExuTFJNTjdhNGZPanVOWi9lYUpmVndjTjdUcXk2SjNaUnVYUlBC?=
 =?utf-8?B?N0wya1AwQ1FpV1RGNEtzbHdWREYvUk9YZnJpL29WY0VwTFV3VjZWY0gxWlA4?=
 =?utf-8?B?OU8rS292TVlyTjVtOEd1WFRjNzZmeUxpN0l3K2FrQng4Q29GaS9OUW5rYkVr?=
 =?utf-8?B?b3NHWTZmanltMWdvbjRIQ0F1RitVeC9XZHNwNjhNNXRjYlJVejNVYjBlWWRx?=
 =?utf-8?B?YmFkczcvNGl3MHpBd1lKN2hGSEFhZCtaK3BERmYrYzBqQS9xWkhOT3p6YXpB?=
 =?utf-8?B?NUo1Nnc4aWU2VTBGS01XUmFvU2diNUQybEx1S0pYUWUvTTJ5MFM5RDVvOXh4?=
 =?utf-8?B?blBrQU5EbThudDlKVU9QUHVHME01U0FZR0p3SUxQU0N4dFdwUjk2d1RWYkxF?=
 =?utf-8?B?M0k4VkR3Y2FNWlFhOFRlazhCMXVVYllEZUlscUdGZDlGSmVjcmJSWFdtdW1v?=
 =?utf-8?B?WTg0NU9NTlpVaEIzSmltQW0xdkJFVWE5RUxNRWliN3FuVEdCOFhkTXRMSEtU?=
 =?utf-8?B?TExvMkh6THA5V3c1MWN2bm04aE9HOXVmSnJpWVR4VGYvY2dQOFF0ZW9nM0NR?=
 =?utf-8?B?Q0dsQlhxWmRPV2ljc2dNYUZqeXFnVWhQWmZtdWRXMlR3N2ZDamw0ZDdEa09s?=
 =?utf-8?B?UEJSNjlicEttRHdtTS9xRzFtb1hBelJGZzlYMVJYenBFb0RHY1N2dnNVeDFH?=
 =?utf-8?B?TkxVSmlET3F6aTlWbW5UZ0phZUUwKzFuOHZXMjlncWtmem1FQnk2cm83azB4?=
 =?utf-8?B?ajVWcisyc2RXM1AzOHFjeXljYzZmWW5pbExwRTRTLzA4Tm5OVE9SYnpOMXFD?=
 =?utf-8?B?ejlCTy92Ukp6Wml3ZzZLQ0lwRE1LRmdzU1BYdTg3WWs3MGl6ZmZnTEdMejdO?=
 =?utf-8?B?NU1EZStKdzJHUlJqaDhLUjc2bjlQMmFRWDZIYWJWRUY4T291OTNUOUJIUGhu?=
 =?utf-8?B?WTdVbWtseTcwWGx6QnI0eGJaNWN0cllzdHJXSDJaMTcvdjhsZmxGUjRzMFIx?=
 =?utf-8?B?MmNsd0dDUE1LdjhaQ2VBUEJoL3R6LzVYdDN1REI3d0sydDZ3RUQxbkdrWlBl?=
 =?utf-8?B?Vi9Ya0pQTkVORmJITE5neGRmd2V0U25oWWRlRWRMd0hHZGJ4WFc1Wm8wZW1q?=
 =?utf-8?B?bEYvWkFiUCtYRnVJdnUwVUs0cXM3ckN2MEpSODh1KzRMMWluWW4wWnE2QVQz?=
 =?utf-8?B?a1ppY0lYMHdpcXZNL0VDbTh6NEt4YzQwaTBEdEJGQmtMSWVJQXFRQXJmaGlL?=
 =?utf-8?B?c1k0OGcxcEgyVUFhbEZ0WmI0d1ZuUHl2Y3dqM2xCRXdiR2pWSHFGbDcvQ0tO?=
 =?utf-8?B?aXpEeXVaK2NZQnNGcm1hVnFEWTF6NEliTVlGU2JsRDdTQ01RaDZiZWxpQnhp?=
 =?utf-8?B?WldPZ0tGSE5KempXdEJUTDJPSDFoZmVrWXg1NGtWTE9WLzMzTy9QS3dPcTZW?=
 =?utf-8?B?YzIwTFFFRlFFZ0t6bUNHcmh0eGVrTXV4dXpsakFkalUzOEpGYXFPTVdid2Ja?=
 =?utf-8?B?WUdkSVFid0ViaTFiQTM1eGRUeTVSRVJFRkYyczcwRGV5NVRucmEwOVdFVDht?=
 =?utf-8?B?K0ErTEo1SzlBSmJ2ZEdkVGhqZ05UMlEwWnNFSEllK210Z2F3MERKNVNPemlm?=
 =?utf-8?B?MmQ1QmwvOFlYM1pkT3h4ZmE4b0dUTVVBN3hTQzREc1UxV3hrSUJZUjdNMDZl?=
 =?utf-8?B?dWdmcFVlaGRyQmVTc0k5RzNYOFZ3aWZQWG1HTFF3NU4wRXVZMFZ4Sk4yVFVo?=
 =?utf-8?Q?nGkWfAH1NhPu/71GHtGyw+4COSnJsh6qzdIi5?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a866b2ba-8cd1-4509-b0e5-08df45996c1c
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:28:55.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r+oi5y687loAWwrU+vs1DGHsbzE45n0ESJakHSDRH+qlvR86CoMv/+MrTH1xoMT1kbZqHbCgkJM2tf+flP9HXjOwhoJT0qJraCGl8mOkJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11553

Hi Sebastian,

> The deference _shouldn't_ happen because those two a different. However,
> we could have a mix of those two and which point it becomes relevant.

Agreed. It needs a chain that mixes both. I dropped that paragraph.

> I would strip that paragraph because *I* think it is more important to
> mention the FUTEX case which no longer does proper chainwalk regardless
> of PREEMPT_RT.

One point. The two tests of ww_ctx in rt_mutex_adjust_prio_chain() are
under IS_ENABLED(CONFIG_PREEMPT_RT). Without PREEMPT_RT,
futex_lock_pi_inherit gets EDEADLK in both cases, with or without this
patch. So I kept the PREEMPT_RT condition in the message. Did you have
another path in mind?

With your changes, the message reads:

    rt_mutex_init_waiter() does not set rt_mutex_waiter::ww_ctx. Only
    __rt_mutex_slowlock_locked() sets it. So the waiters of PI futexes
    and rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES, or
    random garbage without that option.

    The futex code for FUTEX_LOCK_PI performs a RT_MUTEX_FULL_CHAINWALK
    during locking:

      futex_lock_pi()
        rt_mutex_init_waiter()
        __rt_mutex_start_proxy_lock()
          task_blocks_on_rt_mutex()
            rt_mutex_adjust_prio_chain()

    With PREEMPT_RT, rt_mutex_adjust_prio_chain() then wrongly assumes
    that it is a ww_mutex, due to the garbage in rt_mutex_waiter::ww_ctx.
    It does not report a deadlock, but expects the caller to handle it.
    Two threads that each block on a PI futex the other holds then sleep
    forever. Without PREEMPT_RT, the second one gets EDEADLK.
    FUTEX_LOCK_PI also blocks on a chain deeper than max_lock_depth,
    instead of returning EDEADLK.

    Fix this by clearing rt_mutex_waiter::ww_ctx in
    rt_mutex_init_waiter().

    With this patch, FUTEX_LOCK_PI returns EDEADLK in both cases. The
    futex_lock_pi_inherit selftest added later in this series found
    this, with PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES. Its deadlock and
    max_lock_depth cases cover it.

> This, Fixes: and
>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
